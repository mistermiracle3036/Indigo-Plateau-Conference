"""Roxie/Piers OW conversion, attempt 3 — reviewed row selection.

Approach that failed twice before, and why this differs:
  1.1.19/20: uniform 24->16 vertical squeeze  -> mush (rows blended).
  1.1.21:    keep first 8 rows + 8 body rows  -> cut faces mid-feature.
Here: crop to content, PROTECT the face band (hand-identified per
character), then greedily drop the rows most similar to their upper
neighbour until 16 remain. Transition rows (silhouette edges) survive
because they differ from neighbours; hair/torso filler goes first.
The stand frame's row map is reused verbatim on its step frame so the
walk cycle doesn't jitter between different row selections.

Output: 16x96 L, greys 0/85/170/255, frame order down/up/side/
down-step/up-step/side-step (side faces LEFT, engine mirrors right).
"""
from PIL import Image
import os, sys

D = r'C:\Users\dwitt\gen1recomp-work\Indigo-Plateau-Conference\docs\sprite-sources'
OUT = os.path.dirname(os.path.abspath(__file__))

def native(path, scale):
    im = Image.open(path).convert('RGBA')
    return im.resize((im.size[0]//scale, im.size[1]//scale), Image.NEAREST)

# ---- quantization ------------------------------------------------------
def q_roxie(px):
    # Gen 2 style is FLAT: hair/skin one light tone with black features,
    # clothes one mid tone. Saturation separates "colored clothing"
    # (navy dress, pink bow -> 85) from "white-hair shading" (low-sat
    # blue-greys -> flatten into 170) so the head reads clean.
    r, g, b, a = px
    if a < 128: return 255
    L = 0.299*r + 0.587*g + 0.114*b
    sat = max(r, g, b) - min(r, g, b)
    if L < 38: return 0                     # outlines, eyes
    if sat > 45 and L < 190: return 85      # dress, bow, iris
    if L < 120: return 85                   # genuinely dark greys
    return 170                              # hair, skin, light shading

PIERS_MAP = {}
def q_piers(px):
    r, g, b, a = px
    if a < 128: return 255
    key = (r, g, b)
    if key in PIERS_MAP: return PIERS_MAP[key]
    L = 0.299*r + 0.587*g + 0.114*b
    return 0 if L < 30 else (85 if L < 190 else 170)

# explicit table for the 14 known colors
for c in [(0,0,0), (11,17,20)]:
    PIERS_MAP[c] = 0
for c in [(246,246,249), (236,220,204), (224,200,180), (199,167,147)]:
    PIERS_MAP[c] = 170
for c in [(43,41,49), (172,171,175), (100,99,102), (122,94,94), (123,0,84),
          (202,2,126), (40,56,64), (72,88,96)]:
    PIERS_MAP[c] = 85

def quant(frame, fn):
    o = Image.new('L', frame.size, 255)
    for y in range(frame.size[1]):
        for x in range(frame.size[0]):
            o.putpixel((x, y), fn(frame.getpixel((x, y))))
    return o

# ---- row selection -----------------------------------------------------
def rows_of(img):
    w, h = img.size
    return [tuple(img.getpixel((x, y)) for x in range(w)) for y in range(h)]

def content_span(rws):
    idx = [i for i, r in enumerate(rws) if any(p != 255 for p in r)]
    return (idx[0], idx[-1]) if idx else (0, len(rws)-1)

def choose_rows(stand_q, protect, keep=16):
    """Return list of source row indices to keep, using the stand frame."""
    rws = rows_of(stand_q)
    top, bot = content_span(rws)
    cand = list(range(top, bot+1))
    while len(cand) > keep:
        # drop the non-protected row most similar to its predecessor
        best, best_d = None, None
        for i, ri in enumerate(cand[1:], 1):
            if ri in protect: continue
            d = sum(1 for a, b in zip(rws[ri], rws[cand[i-1]]) if a != b)
            if best_d is None or d < best_d:
                best, best_d = i, d
        if best is None:
            raise SystemExit("protect band too large")
        cand.pop(best)
    while len(cand) < keep:                    # sprite shorter than 16
        cand.insert(0, max(cand[0]-1, 0))
    return cand

def build_frame(frame_q, rowlist):
    o = Image.new('L', (16, 16), 255)
    for dy, sy in enumerate(rowlist):
        for x in range(16):
            o.putpixel((x, dy), frame_q.getpixel((x, sy)))
    return o

# ---- assemble ----------------------------------------------------------
def convert(name, sheet, fn, rowmap, face, mirror_side=False):
    """rowmap: {'down':srcRow,'up':srcRow,'side':srcRow} in the 4x4 grid."""
    F = {r: {c: sheet.crop((c*16, r*24, c*16+16, r*24+24)) for c in (0, 1)}
         for r in range(4)}
    out = Image.new('L', (16, 96), 255)
    order = ['down', 'up', 'side', 'down', 'up', 'side']
    col   = [0, 0, 0, 1, 1, 1]
    maps = {}
    for slot, (facing, c) in enumerate(zip(order, col)):
        src = F[rowmap[facing]][c]
        q = quant(src, fn)
        if mirror_side and facing == 'side':
            q = q.transpose(Image.FLIP_LEFT_RIGHT)
        if facing not in maps:
            maps[facing] = choose_rows(quant(F[rowmap[facing]][0], fn)
                                       if not (mirror_side and facing=='side')
                                       else quant(F[rowmap[facing]][0], fn).transpose(Image.FLIP_LEFT_RIGHT),
                                       protect=face[facing])
        out.paste(build_frame(q, maps[facing]), (0, slot*16))
    for facing in maps:
        print(f"  {name} {facing}: kept rows {maps[facing]}")
    return out

if __name__ == '__main__':
    rox_sheet = native(D + r'\roxie_gen3_overworld_by_ulithiumdragon_dbj7tlr.png', 2)
    pi_sheet  = native(D + r'\piers_overworld_by_cyberstryke7.png', 4)

    # source grids: row0=down, row1=side A, row2=side B, row3=up
    # (verified visually; side row chosen/mirrored per SIDE_* below)
    ROX = dict(rowmap={'down':0, 'side':int(os.environ.get('ROX_SIDE','2')), 'up':3},
               face={'down':set(range(9,15)), 'side':set(range(9,15)), 'up':set()})
    PIE = dict(rowmap={'down':0, 'side':int(os.environ.get('PIE_SIDE','2')), 'up':3},
               face={'down':set(range(8,15)), 'side':set(range(8,15)), 'up':set()})

    rox = convert('roxie', rox_sheet, q_roxie, ROX['rowmap'], ROX['face'],
                  mirror_side=os.environ.get('ROX_MIRROR','0')=='1')
    pie = convert('piers', pi_sheet, q_piers, PIE['rowmap'], PIE['face'],
                  mirror_side=os.environ.get('PIE_MIRROR','0')=='1')
    rox.save(os.path.join(OUT, 'roxie_new.png'))
    pie.save(os.path.join(OUT, 'piers_new.png'))

    # comparison strip: bea | roxie_new | roxie_old | piers_new | piers_old
    A = r'C:\Users\dwitt\gen1recomp-work\Indigo-Plateau-Conference\assets'
    Z = 6
    cols = [Image.open(A + r'\bea.png'), rox,
            Image.open(A + r'\roxie.png'), pie, Image.open(A + r'\piers.png')]
    strip = Image.new('L', (len(cols)*(16*Z+8), 96*Z), 128)
    for i, im in enumerate(cols):
        strip.paste(im.resize((16*Z, 96*Z), Image.NEAREST), (i*(16*Z+8), 0))
    strip.save(os.path.join(OUT, 'ow_compare.png'))
    print('saved ow_compare.png  (bea | roxie NEW | roxie old | piers NEW | piers old)')
