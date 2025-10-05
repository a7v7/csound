sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

;----------------------------------------------------------------------------------
; YOUR BASIC GRANULAR SYNTHESIS
;----------------------------------------------------------------------------------
          instr      1

idur      =          p3
iamp      =          p4
ifqc      =          cpspch(p5)
igrtab    =          p6
iwintab   =          p7
ifrng     =          p8
idens     =          p9
ifade     =          p10
igdur     =          .2

kamp      linseg     0, ifade, 1, idur-2*ifade, 1, ifade, 0

;                   AMP  FQC   DENSE  AMPOFF PITCHOFF    GRDUR  GRTABLE   WINTABLE  MAXGRDUR
aoutl     grain     p4,  ifqc, idens, 100,   ifqc*ifrng, igdur, igrtab,   iwintab,  5
aoutr     grain     p4,  ifqc, idens, 100,   ifqc*ifrng, igdur, igrtab,   iwintab,  5

          outs      aoutl*kamp, aoutr*kamp

          endin

;----------------------------------------------------------------------------------
; GRANULAR SYNTHESIS V. 2
;----------------------------------------------------------------------------------
          instr      2

idur      =         p3
iamp      =         p4
ifqc      =         cpspch(p5)
igrtab    =         p6
iwintab   =         p7
ifrngtab  =         p8
idens     =         p9
ifade     =         p10
ibndtab   =         p11
igdur     =         .2

kamp      linseg    0, ifade, 1, idur-2*ifade, 1, ifade, 0
kbend     oscil     1, 1/idur, ibndtab
kfrng     oscil     1, 1/idur, ifrngtab

;                   AMP  FQC         DENSE  AMPOFF PITCHOFF    GRDUR  GRTABLE   WINTABLE  MAXGRDUR
aoutl     grain     p4,  ifqc*kbend, idens, 100,   ifqc*kfrng, igdur, igrtab,   iwintab,  5
aoutr     grain     p4,  ifqc*kbend, idens, 100,   ifqc*kfrng, igdur, igrtab,   iwintab,  5

          outs      aoutl*kamp, aoutr*kamp

          endin

;----------------------------------------------------------------------------------
; YOUR BASIC GRANULAR SYNTHESIS
;----------------------------------------------------------------------------------
          instr      3

idur      =          p3
iamp      =          p4
ifqc      =          cpspch(p5)
igrtab    =          p6
iwintab   =          p7
ifrng     =          p8
idens     =          p9
ifade     =          p10
igdur     =          p11

kamp      linseg     0, ifade, 1, idur-2*ifade, 1, ifade, 0

;                   AMP  FQC   DENSE  AMPOFF PITCHOFF    GRDUR  GRTABLE   WINTABLE  MAXGRDUR
aoutl     grain     p4,  ifqc, idens, 100,   ifqc*ifrng, igdur, igrtab,   iwintab,  5
aoutr     grain     p4,  ifqc, idens, 100,   ifqc*ifrng, igdur, igrtab,   iwintab,  5

          outs      aoutl*kamp, aoutr*kamp

          endin

;----------------------------------------------------------------------------------
; BASIC GRANULAR SAMPLER SYNTHESIS
;----------------------------------------------------------------------------------
          instr      4

idur      =          p3
iamp      =          p4
ifqc      =          p5
igrtab    =          p6
iwintab   =          p7
ifrng     =          p8
idens     =          p9
ifade     =          p10
igdur     =          p11
iamprng   =          p12

kamp      linseg     0, ifade, 1, idur-2*ifade, 1, ifade, 0

;                   AMP  FQC   DENSE  AMPOFF       PITCHOFF    GRDUR  GRTABLE   WINTABLE  MAXGRDUR
aoutl     grain     p4,  ifqc, idens, 100*iamprng, ifqc*ifrng, igdur, igrtab,   iwintab,  5
aoutr     grain     p4,  ifqc, idens, 100*iamprng, ifqc*ifrng, igdur, igrtab,   iwintab,  5

          outs      aoutl*kamp, aoutr*kamp

          endin
