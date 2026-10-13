"""Bani 92x98 commission sheet -> IPC trueColor walker (16x96) + front (56x56).

Recipe recovered from Mr Nobody (IPC 1.1.63): walker = sheet (1,1)-(17,97),
six 16x16 frames in sheet order; front = sheet (35,41)-(91,97). Colours are
kept as drawn (trueColor art); white reachable from a cell's edge becomes
transparent (255,255,255,0); enclosed white (eyes, blades) stays opaque.

  python convert_bani.py verify            -> must reproduce Mr Nobody exactly
  python convert_bani.py <sheet> <out_walker> <out_front>
"""
import sys
from PIL import Image

WHITE = (255, 255, 255, 255)
CLEAR = (255, 255, 255, 0)


def clear_edge_white(img):
    img = img.copy()
    w, h = img.size
    p = img.load()
    stack = [(x, y) for x in range(w) for y in (0, h - 1)] + \
            [(x, y) for y in range(h) for x in (0, w - 1)]
    seen = set()
    while stack:
        x, y = stack.pop()
        if (x, y) in seen or not (0 <= x < w and 0 <= y < h):
            continue
        seen.add((x, y))
        if p[x, y] != WHITE:
            continue
        p[x, y] = CLEAR
        stack += [(x + 1, y), (x - 1, y), (x, y + 1), (x, y - 1)]
    return img


def convert(sheet_path):
    sheet = Image.open(sheet_path).convert("RGBA")
    assert sheet.size == (92, 98), sheet.size
    walker = Image.new("RGBA", (16, 96), CLEAR)
    for i in range(6):
        cell = sheet.crop((1, 1 + 16 * i, 17, 17 + 16 * i))
        walker.paste(clear_edge_white(cell), (0, 16 * i))
    front = clear_edge_white(sheet.crop((35, 41, 91, 97)))
    return walker, front


def same(a, b):
    a, b = a.convert("RGBA"), b.convert("RGBA")
    if a.size != b.size:
        return False
    pa, pb = a.load(), b.load()
    diff = 0
    for y in range(a.height):
        for x in range(a.width):
            u, v = pa[x, y], pb[x, y]
            if u[3] == 0 and v[3] == 0:
                continue
            if u != v:
                diff += 1
    return diff


if __name__ == "__main__":
    if sys.argv[1] == "verify":
        src = r"C:\Users\dwitt\Desktop\sprites for IPC\Bani - commissions\Mr Nobody - Bani c.png"
        ipc = r"C:\Users\dwitt\gen1recomp-work\Indigo-Plateau-Conference\assets"
        w, f = convert(src)
        print("walker differing px:", same(w, Image.open(ipc + r"\mr_nobody_bani.png")))
        print("front differing px:", same(f, Image.open(ipc + r"\mr_nobody_bani_front.png")))
    else:
        w, f = convert(sys.argv[1])
        w.save(sys.argv[2])
        f.save(sys.argv[3])
        print("wrote", sys.argv[2], sys.argv[3])
