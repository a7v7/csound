sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

zakinit 30, 30

;---------------------------------------------------------------------------
; SOUND SOURCE

; SIMPLE SIN WAVE GENERATOR
          instr     1

iamp      init      p4
ifqc      init      p5
izout     init      p6
kamp      linseg    0, .002, p4, p3-.004, p4, .002, 0

asin1     oscil     kamp, ifqc, 1
          zawm      asin1, izout

          endin

;---------------------------------------------------------------------------
; PLUCK PHYSICAL MODEL
;---------------------------------------------------------------------------
          instr     2

iamp      =         p4         ; AMPLITUDE
ifqc      =         p5         ; CONVERT TO FREQUENCY
itab1     =         p6         ; INITIAL TABLE
imeth     =         p7         ; DECAY METHOD
ioutch    =         p8         ; OUTPUT CHANNEL

kamp      linseg    0, .002, iamp, p3-.004, iamp, .002, 0   ; DECLICK

aplk      pluck     kamp, ifqc, ifqc, itab1, imeth          ; PLUCK WAVEGUIDE MODEL
          zawm      aplk, ioutch                            ; WRITE TO OUTPUT
gifqc     =         ifqc
          endin

          instr     10

imnfqc    init      p4
imxtim    init      1/p4
imxfqc    init      p5
imntim    init      1/p5
izin      init      p6
izout     init      p7
klkmax    init      3
klkmin    init      .8
klooklow  init      1    
klookhi   init      0
kt2       init      imntim
kt1       init      imxtim
gkfqc     init      1/imxtim
kosc1     init      0

asig      zar       izin

kosc2     =         kosc1
kosc1     oscil     1, imnfqc, 4

kdtime    =         kosc1*imxtim+imntim

adel1     delayr    imxtim+imntim
adel2     deltapi   kdtime
          delayw    asig

adel3     =         adel1-adel2
krms1     rms       adel3, 1/imntim/16
krms2     rms       adel3, 1/imxtim/16
kfind     =         krms1/(krms2+1)

if        (klooklow!=1) goto cont1
if        (kfind>=klkmin) goto cont1
kt2       =         kt1
kt1       =         kdtime
if        (kosc2<kosc1) goto cont3
gkfqc     =         .5/(kt2>kt1 ? kt2-kt1 : kt1-kt2)
cont3:
klooklow  =         0
klookhi   =         1
goto      cont2

cont1:
if (klookhi!=1) goto cont2
if (kfind<=klkmax) goto cont2
    klooklow=1
    klookhi =0

cont2:

aout      =         kfind*10000
;aout     =         krms1
;aout     =         100*gkfqc
;aout     =         10/kt1

          zaw       aout, izout

          endin

          instr     20

izout     init      p4

;  kamp linseg 0,   .002, p4, p3-.004, p4, .002, 0

asin1     oscil     20000, gkfqc, 1
          zaw       asin1, izout

          endin


; MIXER SECTION
;---------------------------------------------------------------------------
;    STA DUR  CH1  GAIN  PAN  CH2  GAIN  PAN  CH3  GAIN  PAN  CH4  GAIN  PAN

; MIXER
          instr     100
asig1     zar       p4
igl1      init      p5*p6
igr1      init      p5*(1-p6)
asig2     zar       p7
igl2      init      p8*p9
igr2      init      p8*(1-p9)
asig3     zar       p10
igl3      init      p11*p12
igr3      init      p11*(1-p12)
asig4     zar       p13
igl4      init      p14*p15
igr4      init      p14*(1-p15)

asigl     =         asig1*igl1 + asig2*igl2 + asig3*igl3 + asig4*igl4
asigr     =         asig1*igr1 + asig2*igr2 + asig3*igr3 + asig4*igr4

          outs      asigl, asigr
          zacl      0, 30

          endin
