"""Hand edits, device round 3: frame the faces.

The developer's read matches vanilla convention (granny.png — also
white-haired): the face field is flat light, but it is FRAMED in black
and the eyes are bold single-row 2px marks. Our conversions inherited
faces whose features float in an unbroken light field.

This pass is deliberate per-pixel editing, applied AFTER conversion so
the conversion scripts stay pure. Coordinates are in-frame (x, y),
frames indexed 0..5 = down/up/side/down-step/up-step/side-step.

Also rebuilds the Piers battle portrait as a 2x head close-up: Drawnamu
gives the face ~9 native pixels; GSC portraits give faces ~20. Doubling
the head region is lossless for pixel art and lands the face in GSC
proportions.
"""
from PIL import Image
import os

S = os.path.dirname(os.path.abspath(__file__))
D = r'C:\Users\dwitt\gen1recomp-work\Indigo-Plateau-Conference\docs\sprite-sources'

K, M, L, T = 0, 85, 170, 255

def edit(sheet, frame, clears, pixels):
    f = sheet.crop((0, frame*16, 16, frame*16+16))
    for (x0, y0, x1, y1, v) in clears:
        for y in range(y0, y1+1):
            for x in range(x0, x1+1):
                f.putpixel((x, y), v)
    for (x, y, v) in pixels:
        f.putpixel((x, y), v)
    sheet.paste(f, (0, frame*16))

def frame_face(sheet, frame, box, eyes, mouth=None, sides=True, brow=None):
    """box=(x0,y0,x1,y1) face field; eyes=[(x,y),...] each 2px wide."""
    x0, y0, x1, y1 = box
    edit(sheet, frame, [(x0, y0, x1, y1, L)], [])
    px = []
    if sides:
        for y in range(y0, y1+1):
            px += [(x0-1, y, K), (x1+1, y, K)]
    if brow is not None:
        for x in range(x0, x1+1):
            px.append((x, brow, K))
    for (ex, ey) in eyes:
        px += [(ex, ey, K), (ex+1, ey, K)]
    if mouth:
        px.append((mouth[0], mouth[1], M))
    edit(sheet, frame, [], px)

# ---------------- Roxie OW ----------------
rx = Image.open(S + r'\roxie_new.png')
# down + down-step: face field rows 5-9, cols 4-11 (granny geometry)
for fr in (0, 3):
    frame_face(rx, fr, (4, 5, 11, 9), eyes=[(5, 7), (9, 7)], mouth=(7, 9), brow=4)
# side + side-step: she faces LEFT; face cols 1-5, rows 6-9; hair behind
for fr in (2, 5):
    frame_face(rx, fr, (1, 6, 5, 9), eyes=[(2, 7)], sides=False, brow=5)
    edit(rx, fr, [], [(6, y, K) for y in range(6, 10)])   # hair boundary
rx.save(S + r'\roxie_new.png')

# ---------------- Piers OW ----------------
pi = Image.open(S + r'\piers_new.png')
# down + down-step: face field rows 6-9, cols 5-10; mane already dark left
for fr in (0, 3):
    frame_face(pi, fr, (5, 6, 10, 9), eyes=[(6, 7), (9, 7)], sides=True, brow=5)
# side + side-step: face cols 1-5 rows 6-9
for fr in (2, 5):
    frame_face(pi, fr, (1, 6, 5, 9), eyes=[(2, 7)], sides=False, brow=5)
    edit(pi, fr, [], [(6, y, K) for y in range(6, 10)])
pi.save(S + r'\piers_new.png')

# ---------------- Piers battle portrait ----------------
# Three candidates were compared (native upper-body crop, 3/4-scale
# full figure, 2x head close-up). The NATIVE CROP wins: Drawnamu's face
# is ~9px and survives no rescale in either direction -- the 3/4 scale
# shrinks it further and the 2x head amplifies the hair-over-face
# fragmentation into abstraction. The 1.1.21 crop was rejected wearing
# the broken pink-speckle palette; the composition itself was never the
# problem. Window (10,0)-(66,56): head, torso, raised mic hand, stand.
import convert_fronts as CF
CF.piers_crop().save(S + r'\\piers_front_new.png')
print('face edits + portrait rebuilt')
