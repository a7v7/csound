sr        =         44100
kr        =         22050
ksmps     =         2
nchnls    =         2
                              
; HARMONIC DISTORTION
          instr     2

iamp      =         p4
ifqc      =         cpspch(p5)
itabf     =         p6
itab1     =         p7
itab2     =         p8
itab3     =         p9
itab4     =         p10
ifrms     =         40

kamp      linseg    0, .1*p3, iamp, .7*p3, iamp/2, .2*p3, 0

aoscf     oscil     kamp, ifqc, 1
aosc1     oscil     kamp, ifqc*2, 1
aosc2     oscil     kamp, ifqc*3, 1
aosc3     oscil     kamp, ifqc*4, 1
aosc4     oscil     kamp, ifqc*5, 1


krms      rms       aosc1, ifrms
kndx      =         krms/16000

ksclf     tablei    kndx, itabf, 1
kscl1     tablei    kndx, itab1, 1
kscl2     tablei    kndx, itab2, 1
kscl3     tablei    kndx, itab3, 1
kscl4     tablei    kndx, itab4, 1
aoutl     =         aoscf*ksclf+aosc1*kscl1+aosc2*kscl2+aosc3*kscl3+aosc4*kscl4
aoutr     =         aoscf*ksclf+aosc1*kscl1+aosc2*kscl2+aosc3*kscl3+aosc4*kscl4

          outs      aoutl, aoutr

          endin
