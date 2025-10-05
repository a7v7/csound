sr             =         44100
kr             =         4410
ksmps          =         10
nchnls         =         2


;=====================================
; REVERB INITIALIZATION
;=====================================

garvbsig       init      0


;=================================================
; INSTRUMENT 2 --- A NOISE BAND GLISSANDO
;=================================================

               instr     2

ipanfrq        =         p6
kfreq          =         p5
irandfrq       =         p7
irandamp       =         p8                                         
kramp          linseg    0,p3*.8,p4,p3*.2,0            ; THIS CONTROLS THE AMP OF RANDI
kenv1          linen     p4,0, p3,10                   ; THIS CONTROLS THE FRQ OF RANDI
krndmod        randh     irandamp,irandfrq
an             randi     kramp,kenv1
ao             oscil     an,kfreq,11                   ; ANOISE IS FED TO THE A INPUT OF AOSC
kpan           oscil     1,.09*ipanfrq,1
aosc2          reson     ao,kpan+100+krndmod,100,2     ; KPAN+100 IS OFFSET FOR FILTER SWEEP INPUT
               outs      aosc2*kpan,aosc2*(1-kpan)
garvbsig       =         garvbsig+(aosc2*.2)
               endin
          
;===================
; GLOBAL REVERB
;===================

               instr     99

a1             reverb2   garvbsig, p4, p5
               outs      a1,a1

garvbsig       =         0

               endin
