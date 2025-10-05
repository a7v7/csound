sr             =         44100
kr             =         4410
ksmps          =         10
nchnls         =         2

               instr     1

idur           =         p3
iamp           =         p4
km1            =         p5
km2            =         p6
ksep           =         p7
ix             =         p8
iy             =         p9
iz             =         p10
ivx            =         p11
ivy            =         p12
ivz            =         p13
ih             =         p14
ifric          =         p15

kamp           linseg    0, .002, iamp, idur-.004, iamp, .002, 0

ax, ay, az planet km1, km2, ksep, ix, iy, iz, ivx, ivy, ivz, ih, ifric

               outs      ax*kamp, ay*kamp

               endin
