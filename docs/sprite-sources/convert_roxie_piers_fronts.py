"""Roxie + Piers 56x56 battle fronts.

Roxie: Piacarrot's sheet carries a pure 2x of a NATIVE 56x56 GSC sprite.
Descale, normalize 49 stray pixels onto the 4 target colors, done. No
resampling of any kind.

Piers: Drawnamu's lineup figure (73x89). 1.1.21 shipped an upper-body
crop with hot pink as the only dark hue -- his grey jacket and mane had
nowhere to land but pink-or-white, hence the speckle the device test
rejected. Here the dark hue is a grey-purple that absorbs jacket mids,
hair shading AND the pink accents, and the full figure (mic stand
included) is fitted at 5/8 scale with area-weighted majority vote on
already-quantized colors, black-outline priority. Fallback if mushy:
native-scale upper-body crop, same palette.
"""
from PIL import Image
from collections import Counter, defaultdict
import os

D = r'C:\Users\dwitt\gen1recomp-work\Indigo-Plateau-Conference\docs\sprite-sources'
OUT = os.path.dirname(os.path.abspath(__file__))

W, K = (255, 255, 255), (0, 0, 0)

# ---------------- Roxie ----------------
ROX_L, ROX_D = (255, 197, 168), (163, 67, 143)
def roxie():
    im = Image.open(D + r'\roxie_gsc_style_by_piacarrot_d59kzez.png').convert('RGB')
    big = im.crop((31, 105, 143, 217))
    n = big.resize((56, 56), Image.NEAREST)
    tgt = [K, ROX_D, ROX_L, W]
    def snap(c):
        if c == (248, 248, 248): return W
        if c in tgt: return c
        return min(tgt, key=lambda t: sum((a-b)**2 for a, b in zip(c, t)))
    o = Image.new('RGB', (56, 56))
    o.putdata([snap(p) for p in n.get_flattened_data()])
    return o

# ---------------- Piers ----------------
PIE_L, PIE_D = (224, 200, 180), (96, 80, 112)
PIE_TABLE = {
    (0,0,0): K, (11,17,20): K, (43,41,49): K,
    (246,246,249): W, (159,145,186): W,
    (236,220,204): PIE_L,
    (224,200,180): PIE_L, (203,168,141): PIE_L, (199,167,147): PIE_L,
    (172,171,175): PIE_D, (100,99,102): PIE_D, (122,94,94): PIE_D,
    (123,0,84): PIE_D, (202,2,126): PIE_D,
    (40,56,64): PIE_D, (72,88,96): PIE_D,
}
def pie_q(px):
    r, g, b, a = px
    if a < 128: return W
    c = (r, g, b)
    if c in PIE_TABLE: return PIE_TABLE[c]
    L = 0.299*r + 0.587*g + 0.114*b
    if L < 40: return K
    if L > 200: return W
    return PIE_L if (r > g > b and r - b > 30) else PIE_D

def piers_full():
    im = Image.open(D + r'\gym_leaders_portraits_by_drawnamu.png').convert('RGBA')
    fig = im.crop((505, 0, 578, 121))
    ys = [y for y in range(121) if any(fig.getpixel((x, y))[3] >= 128 for x in range(73))]
    fig = fig.crop((0, ys[0], 73, ys[-1] + 1))          # 73x89
    q = [[pie_q(fig.getpixel((x, y))) for x in range(fig.size[0])]
         for y in range(fig.size[1])]
    sh, sw = fig.size[1], fig.size[0]
    th = 56
    scale = sh / th                                     # 89/56 ~ 1.59
    tw = round(sw / scale)                              # ~46
    o = Image.new('RGB', (56, 56), W)
    x0 = (56 - tw) // 2
    for ty in range(th):
        for tx in range(tw):
            ys_, ye = ty*scale, (ty+1)*scale
            xs_, xe = tx*scale, (tx+1)*scale
            votes = defaultdict(float)
            y = int(ys_)
            while y < ye and y < sh:
                x = int(xs_)
                wy = min(ye, y+1) - max(ys_, y)
                while x < xe and x < sw:
                    wx = min(xe, x+1) - max(xs_, x)
                    c = q[y][x]
                    wgt = wx * wy
                    if c == K: wgt *= 1.6               # outline priority
                    votes[c] += wgt
                    x += 1
                y += 1
            o.putpixel((x0+tx, ty), max(votes, key=votes.get))
    return o

def piers_crop():
    im = Image.open(D + r'\gym_leaders_portraits_by_drawnamu.png').convert('RGBA')
    fig = im.crop((505, 0, 578, 121))
    ys = [y for y in range(121) if any(fig.getpixel((x, y))[3] >= 128 for x in range(73))]
    fig = fig.crop((0, ys[0], 73, ys[-1] + 1))
    win = fig.crop((10, 0, 66, 56))                     # head/torso/mic, native
    o = Image.new('RGB', (56, 56), W)
    o.putdata([pie_q(p) for p in win.get_flattened_data()])
    return o

if __name__ == '__main__':
    rx = roxie(); rx.save(os.path.join(OUT, 'roxie_front_new.png'))
    pf = piers_full(); pf.save(os.path.join(OUT, 'piers_front_full.png'))
    pc = piers_crop(); pc.save(os.path.join(OUT, 'piers_front_crop.png'))
    for n, im in (('roxie_front_new', rx), ('piers_front_full', pf), ('piers_front_crop', pc)):
        print(n, 'colors:', sorted(set(im.get_flattened_data())))
    Z = 5
    A = r'C:\Users\dwitt\gen1recomp-work\Indigo-Plateau-Conference\assets'
    cur = Image.open(A + r'\piers_front.png').convert('RGB')
    strip = Image.new('RGB', (4*(56*Z+10)+10, 56*Z+16), (140, 140, 140))
    for i, im in enumerate((rx, pf, pc, cur)):
        strip.paste(im.resize((56*Z,)*2, Image.NEAREST), (10+i*(56*Z+10), 8))
    strip.save(os.path.join(OUT, 'fronts_compare.png'))
    print('saved fronts_compare.png (roxie NEW | piers full | piers crop | piers CURRENT)')
