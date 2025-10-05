; Josep M Comajuncosas

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

          instr 1             ; MOOG 24 dB (4 POLE) LPF WITH RESONANCE !!
; based on papers by Stilson & Smith
; coded in C by (?)
; ported to Csound by Josep M Comajuncosas
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

kout0     init      0
kout4     init      0

kap1      init      0
kap2      init      0
kap3      init      0
kap4      init      0

kin1      init      0
kin2      init      0
kin3      init      0
kin4      init      0

; SOUND SOURCE: PUT HERE WHAT YOU WANT
kinput    rand      10000

; kfcon / kresin BETWEEN 0 AND 1
; WORKS BEST BETWEEN 0 ~ sr/4 Hz (OR sr/6...)

ilimres   =         10000                    ; AN EMPYRICAL VALUE TO PLAY WITH
kfco      linseg    100, p3/2, 5000, p3/2, 1000 ; FILTER CUTOFF FREQUENCY (SUGGESTED 0 TO sr/4)
kresin    linseg    .25, p3/2, .5, p3/2, .99 ; RESONANCE AMOUNT (0 TO 1 -OSCILLATION)

kfcon     =         2*kfco/sr                ; NORMALIZED FREQ. 0 TO NYQUIST

kreso     =         1 - kfcon                ; EMPYRICAL TUNING
kreso     =         1 + 3.5 * kreso * kreso
kreso     =         kreso * kresin

kfcon     =         kfcon * 2.0 - 1.0;

kreso     =         kreso * kout4;

; LIMIT RESONANCE (JUST SIMPLE CLIPPING...)
kreso     =         ( kreso >  ilimres  ?  ilimres : kreso)
kreso     =         ( kreso < -ilimres ? -ilimres : kreso)

kout0     =         kinput - kreso           ; FEEDBACK!
                                             
; LOWPASS 1
kap1      =         (kout0 - kap1) * kfcon + kin1 ; ALLPASS SECTION
kin1      =         kout0;
kout1     =         (kout0 + kap1) * 0.5     ; COMBINE WITH KINPUT

; LOWPASS 2
kap2      =         (kout1 - kap2) * kfcon + kin2;
kin2      =         kout1;
kout2     =         (kout1 + kap2) * 0.5;

; LOWPASS 3
kap3      =         (kout2 - kap3) * kfcon + kin3;
kin3      =         kout2;
kout3     =         (kout2 + kap3) * 0.5;

; LOWPASS 4
kap4      =         (kout3 - kap4) * kfcon + kin4;
kin4      =         kout3;
kout4     =         (kout3 + kap4) * 0.5

          aout      upsamp kout4;
          out       aout

          endin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

          instr 4             ; 24 dB LPF WITH RESONANCE. CAN SELF-OSCILLATE !
; loosely based on some papers by Stilson & Smith (CCRMA)
; coded by Josep M Comajuncosas / jan498
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

aout      init      0
iamp      =         10000                    ; INTENDED MAXIMUM AMPLITUDE
kfreq     =         100
ifco      =         p4                       ; KEEP IT WELL BELOW sr/4 OR LESS


kenv      linen     1, .05, p3, p3-.25
kres      =         kenv*3.9                 ; RESONANCE (0,4)
; 4 FOR SELF-OSCILLATION, BUT BE CAREFUL
kfco      =         kfreq + ifco*kenv        ; FILTER CUTOFF FREQUENCY

kfcn      =         kfco/sr                  ; FREQUENCY NORMALIZED (0, 1/4)
kcorr     =         1-4*kfcn                 ; SOME EMPYRICAL TUNING...
kres      =         kres/kcorr               ; MORE FEEDBACK FOR HIGHER FREQUENCIES
; THIS IS TO COMPENSATE FOR THE WORSE EFFICIENCY OF THE FILTER AT HIGH kfco
; (PHASE RESP. AT kfco GOES FROM pi/4 AT ~ 0 Hz TO 0 AT sr/4 FOR A 1st ORDER IIR LPF)
; THIS ALSO MAKES IMPOSSIBLE TO USE FREQUENCIES ABOVE sr/4

asig      buzz      1,kfreq,sr/(2*kfreq),1   ; SOUND SOURCE, WHAT YOU WANT

arez      =         asig - kres*aout         ; INVERTED FEEDBACK TO THE FILTER
; AS PH. RESP. OF A 4 STAGE LPF AT kfco IS 180=BA BUT  AT DC & sr/2 =  0==BA
; INVERTING IT IN THE FEEDBACK LOOP CAUSES THE FILTER TO EMPHASIZE kfco("CORNER PEAKING")
alpf      tone      arez, kfco               ; 4 CASCADED 1st ORDER IIR LPF
alpf      tone      alpf, kfco
alpf      tone      alpf, kfco
aout      tone      alpf, kfco
                                        
          out       aout*iamp*kcorr*20       ; A MINIMUM EQUALISATION
; 20 IS EMPYRICAL, YOU MAY HAVE TO REMOVE IT FOR OTHER SOUND SOURCES
; BUT EVEN THUS THE AMPLITUDE OBVIOUSLY INCREASES WITH kfco.
          endin
