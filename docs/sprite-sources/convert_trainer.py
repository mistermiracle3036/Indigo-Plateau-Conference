"""General trainer sprite converter for IPC — later-gen to Gen 2.

Repeatable process for adding a new trainer:
  1. Save the source sprite sheet to docs/sprite-sources/
  2. Probe the image to find frame bounding boxes:
       python convert_trainer.py probe <source_file>
  3. Add a CONFIG entry below with the frame coordinates
  4. Run: python convert_trainer.py <name>
  5. Copy output from docs/sprite-sources/ to assets/
  6. Review on device, fine-tune face_rows / quantization if needed

Output per character:
  <name>.png            16x96 mode L overworld (0/85/170/255)
  <name>_front.png      56x56 RGB battle portrait (true-color)
  <name>_ow_compare.png 6x zoom strip for desktop review

Frame order in the 16x96 strip:
  down-stand, up-stand, side-stand, down-step, up-step, side-step
  (side faces LEFT; the engine mirrors it for rightward facing)
"""
from PIL import Image
import os, sys

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
ASSETS = os.path.join(os.path.dirname(SCRIPT_DIR), 'assets')

# ---- Configurations -------------------------------------------------
# frame boxes are (left, top, right, bottom) in the source PNG.
# mirror_side: True when the source side frame faces right.
# face_rows: row indices (in the fitted 16-wide frame) to protect
#   during height compression.  Tune these after device review.
# portrait_box: region of source to use for the 56x56 battle front.

CONFIGS = {
    'nemona': {
        'source': 'nemona_by_mid117.png',
        'frames': {
            'down_stand': (183, 199, 201, 229),
            'down_step':  (214, 200, 232, 228),
            'side_stand': (183, 234, 206, 261),
            'side_step':  (214, 235, 235, 261),
            'back_stand': (178, 267, 203, 294),
            'back_step':  (211, 268, 234, 294),
        },
        'mirror_side': True,
        'face_rows': {
            'down': set(range(2, 11)),
            'side': set(range(2, 11)),
            'back': set(),
        },
        'portrait_box': (72, 223, 109, 302),
    },
}

# ---- Quantization ----------------------------------------------------

def quantize_pixel(px, dark=50, mid=120, light=200):
    r, g, b, a = px
    if a < 128:
        return 255
    L = 0.299 * r + 0.587 * g + 0.114 * b
    if L < dark:
        return 0
    if L < mid:
        return 85
    if L < light:
        return 170
    return 255


def quantize_frame(frame):
    out = Image.new('L', frame.size, 255)
    for y in range(frame.size[1]):
        for x in range(frame.size[0]):
            out.putpixel((x, y), quantize_pixel(frame.getpixel((x, y))))
    return out


# ---- Width fitting ---------------------------------------------------

def fit_width(frame, target=16):
    w, h = frame.size
    out = Image.new('RGBA', (target, h), (0, 0, 0, 0))
    if w <= target:
        out.paste(frame, ((target - w) // 2, 0))
    else:
        left = (w - target) // 2
        out.paste(frame.crop((left, 0, left + target, h)), (0, 0))
    return out


# ---- Row selection (proven in convert_roxie_piers_ow.py) -------------

def rows_of(img):
    w, h = img.size
    return [tuple(img.getpixel((x, y)) for x in range(w)) for y in range(h)]


def content_span(rws):
    idx = [i for i, r in enumerate(rws) if any(p != 255 for p in r)]
    return (idx[0], idx[-1]) if idx else (0, len(rws) - 1)


def choose_rows(stand_q, protect, keep=16):
    rws = rows_of(stand_q)
    top, bot = content_span(rws)
    cand = list(range(top, bot + 1))
    while len(cand) > keep:
        best, best_d = None, None
        for i, ri in enumerate(cand[1:], 1):
            if ri in protect:
                continue
            d = sum(1 for a, b in zip(rws[ri], rws[cand[i - 1]]) if a != b)
            if best_d is None or d < best_d:
                best, best_d = i, d
        if best is None:
            cand.pop(-1)
        else:
            cand.pop(best)
    while len(cand) < keep:
        cand.insert(0, max(cand[0] - 1, 0))
    return cand


def build_frame_16(frame_q, rowlist):
    out = Image.new('L', (16, 16), 255)
    for dy, sy in enumerate(rowlist):
        for x in range(16):
            out.putpixel((x, dy), frame_q.getpixel((x, sy)))
    return out


# ---- Portrait --------------------------------------------------------

def make_portrait(img, crop_box, size=56):
    region = img.crop(crop_box)
    bg = Image.new('RGBA', region.size, (255, 255, 255, 255))
    bg.paste(region, mask=region.split()[3])
    rgb = bg.convert('RGB')
    w, h = rgb.size
    scale = size / w
    new_w = size
    new_h = round(h * scale)
    scaled = rgb.resize((new_w, new_h), Image.NEAREST)
    if new_h > size:
        scaled = scaled.crop((0, 0, size, size))
    elif new_h < size:
        out = Image.new('RGB', (size, size), (255, 255, 255))
        out.paste(scaled, (0, (size - new_h) // 2))
        return out
    return scaled


# ---- Probe tool ------------------------------------------------------

def probe(source_path):
    img = Image.open(source_path).convert('RGBA')
    w, h = img.size
    print(f"Image: {w}x{h}")
    pixels = img.load()
    visited = set()
    sprites = []

    def flood(sx, sy):
        stack = [(sx, sy)]
        mn_x, mn_y, mx_x, mx_y = sx, sy, sx, sy
        count = 0
        while stack:
            x, y = stack.pop()
            if (x, y) in visited:
                continue
            if x < 0 or x >= w or y < 0 or y >= h:
                continue
            if pixels[x, y][3] < 128:
                continue
            visited.add((x, y))
            count += 1
            mn_x, mn_y = min(mn_x, x), min(mn_y, y)
            mx_x, mx_y = max(mx_x, x), max(mx_y, y)
            for dx, dy in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                nx, ny = x + dx, y + dy
                if (nx, ny) not in visited:
                    stack.append((nx, ny))
        return (mn_x, mn_y, mx_x + 1, mx_y + 1, count)

    for y in range(h):
        for x in range(w):
            if (x, y) not in visited and pixels[x, y][3] > 128:
                bbox = flood(x, y)
                bw = bbox[2] - bbox[0]
                bh = bbox[3] - bbox[1]
                if bbox[4] > 30 and bw > 8 and bh > 8:
                    sprites.append(bbox)

    print(f"\nFound {len(sprites)} sprite regions (>30px, >8x8):")
    for i, (x1, y1, x2, y2, count) in enumerate(sprites):
        print(f"  #{i}: ({x1},{y1},{x2},{y2}) = {x2-x1}x{y2-y1}  ({count}px)")


# ---- Main pipeline ---------------------------------------------------

def convert(name, cfg):
    source_path = os.path.join(SCRIPT_DIR, cfg['source'])
    src = Image.open(source_path).convert('RGBA')

    frame_order = [
        ('down_stand', 'down'),
        ('back_stand', 'back'),
        ('side_stand', 'side'),
        ('down_step', 'down'),
        ('back_step', 'back'),
        ('side_step', 'side'),
    ]

    out = Image.new('L', (16, 96), 255)
    row_maps = {}

    for slot, (fkey, facing) in enumerate(frame_order):
        box = cfg['frames'][fkey]
        frame = src.crop(box)
        frame = fit_width(frame, 16)
        q = quantize_frame(frame)
        if cfg.get('mirror_side') and facing == 'side':
            q = q.transpose(Image.FLIP_LEFT_RIGHT)

        if facing not in row_maps:
            stand_key = facing + '_stand'
            stand = src.crop(cfg['frames'][stand_key])
            stand = fit_width(stand, 16)
            sq = quantize_frame(stand)
            if cfg.get('mirror_side') and facing == 'side':
                sq = sq.transpose(Image.FLIP_LEFT_RIGHT)
            protect = cfg.get('face_rows', {}).get(facing, set())
            row_maps[facing] = choose_rows(sq, protect)
            print(f"  {name} {facing}: kept rows {row_maps[facing]}")

        out.paste(build_frame_16(q, row_maps[facing]), (0, slot * 16))

    ow_path = os.path.join(SCRIPT_DIR, f'{name}.png')
    out.save(ow_path)
    print(f"  Saved overworld: {ow_path}")

    if 'portrait_box' in cfg:
        portrait = make_portrait(src, cfg['portrait_box'])
        fp_path = os.path.join(SCRIPT_DIR, f'{name}_front.png')
        portrait.save(fp_path)
        print(f"  Saved portrait:  {fp_path}")

    Z = 6
    strip = Image.new('L', (16 * Z, 96 * Z), 128)
    strip.paste(out.resize((16 * Z, 96 * Z), Image.NEAREST), (0, 0))
    cmp_path = os.path.join(SCRIPT_DIR, f'{name}_ow_compare.png')
    strip.save(cmp_path)
    print(f"  Saved compare:   {cmp_path}")

    return out


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print(f"Usage: python {sys.argv[0]} <name>")
        print(f"       python {sys.argv[0]} probe <source_file>")
        print(f"Available configs: {', '.join(CONFIGS.keys())}")
        sys.exit(1)

    if sys.argv[1] == 'probe':
        if len(sys.argv) < 3:
            print("Usage: python convert_trainer.py probe <source_file>")
            sys.exit(1)
        probe(sys.argv[2])
    else:
        name = sys.argv[1]
        if name not in CONFIGS:
            print(f"Unknown '{name}'. Available: {', '.join(CONFIGS.keys())}")
            sys.exit(1)
        convert(name, CONFIGS[name])
