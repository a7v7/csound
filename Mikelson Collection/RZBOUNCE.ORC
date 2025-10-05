sr        =         44100                    ; THESE INSTRUMENTS REQUIRE sr=kr
kr        =         4410
ksmps     =         10
nchnls    =         2

;-------------------------------------------------------------------------
; SAW-RAMP TRANSFORM REZZY SYNTH
;-------------------------------------------------------------------------
          instr 1   
                                             
idur      init      p3
iamp      init      p4
ifqc      init      cpspch(p5)               ; CONVERT TO CYCLES/SECOND
irez      init      p7 
aynm1     init      0                        ; INITIALIZE Yn-1
aynm2     init      0                        ; & Yn-2 TO ZERO.
kx        init      -p4
kdx       init      p4*4*ifqc/sr
kmax      init      p4

klfo      oscil     .9,1,1                   ; LOW FREQUENCY OSCILLATOR
klfo      =         klfo+1                   ; FOR TRIANGLE RAMP TRANSFORM.
kdx1      =         4*p4*ifqc/sr/klfo
kdx2      =         2*p4*ifqc/(sr-sr/2*klfo)

;-------------------------------------------------------------------------
kaenv     linseg    0,.01,1,p3-.02,1,.01,0   ; AMPLITUDE ENVELOPE
kfco      expseg    10,.2*p3,p6,.4*p3,.5*p6,.4*p3,.1*p6 ; FREQUENCY SWEEP

;-------------------------------------------------------------------------
ka1       =         100/irez/sqrt(kfco)-1    ; ADJUST Q AND Fco FOR
ka2       =         1000/kfco                ; COEFFICIENTS A1 & A2.

;-------------------------------------------------------------------------

; BOUNCING BALL ALGORITHM-A BALL BOUNCING BETWEEN TWO PARALLEL WALLS IE:PONG
;-------------------------------------------------------------------------
knewx     =         kx+kdx                   ; FIND NEXT POSITION 
                                             
          if        (knewx<=kmax)  goto next1     ; IF NEXT IS BEYOND THE TOP WALL
knewx     =         kmax-kdx2*(kdx1-kmax+kx)/kdx1; THEN FIND THE BOUNCE POSITION
kdx       =         -kdx2                    ; AND DOWNWARD SLOPE.
                                             
next1:
          if        (knewx>=-kmax)      goto next2     ; IF NEXT IS BEYOND THE BOTTOM WALL
knewx     =         -kmax+kdx1*(kdx2-kmax-kx)/kdx2     ; THEN FIND THE BOUNCE POSITION
kdx       =         kdx1                      ; AND UPWARD SLOPE.

next2:
kx        =         knewx

axn       =         kx

;-------------------------------------------------------------------------
ayn       =         ((ka1+2*ka2)*aynm1-ka2*aynm2+axn)/(1+ka1+ka2) ; DIFFERENCE EQ. APP.
aynm2     =         aynm1                    ; OF DIFFERENTIAL EQ.
aynm1     =         ayn                      ; SAVE Yn-1 & Yn-2.

;-------------------------------------------------------------------------
aout      =         ayn*kaenv                ; SCALE AND OUTPUT
          outs      aout,axn

          endin


;-------------------------------------------------------------------------
; OSCILLATOR SYNC REZZY SYNTH
;-------------------------------------------------------------------------
       instr 2   
          
idur      init      p3
iamp      init      p4
ifqc      init      cpspch(p5)                   ; CONVERT TO CYCLES/SECOND
ifqcs     init      cpspch(p5)*p8
irez      init      p7 
aynm1     init      0                        ; INITIALIZE Yn-1
aynm2     init      0                   ; & Yn-2 TO ZERO.
kxn       init      -p4
kdx       init      p4*8*ifqc/sr
kmax      init      p4
ksyncm    init      -1
ksyncs    init      -1
          
;-------------------------------------------------------------------------
kaenv     linseg    0,.001,1,p3-.002,1,.001,0  ; AMPLITUDE ENVELOPE
kfco      expseg    10,.2*p3,p6,.4*p3,.5*p6,.4*p3,.1*p6  ; FREQUENCY SWEEP

;-------------------------------------------------------------------------
ka1       =         100/irez/sqrt(kfco)-1    ; ADJUST Q AND Fco FOR
ka2       =         1000/kfco           ; COEFFICIENTS A1 & A2.

;-------------------------------------------------------------------------
kxn            =    kxn+kdx             ; FIND NEXT POSITION 

ksmprev   =         ksyncm              ; WATCH MASTER FOR TRANSITION
ksyncm    oscil     1,ifqc,2            ; FROM -1 TO 1 THEN RESET axn.
kxn  =              ((ksmprev=-1)&&(ksyncm=1) ? -kmax : kxn)

kssprev =           ksyncs              ; WATCH SLAVE FOR TRANSITION
ksyncs  oscil       1,ifqcs,2           ; FROM -1 TO 1 THEN RESET axn.
kxn  =              ((kssprev=-1)&&(ksyncs=1) ? -kmax : kxn)

axn       =         kxn
;-------------------------------------------------------------------------
ayn       =         ((ka1+2*ka2)*aynm1-ka2*aynm2+axn)/(1+ka1+ka2) ; DIFFERENCE EQ. APP.
aynm2     =         aynm1               ; OF DIFFERENTIAL EQ.
aynm1     =         ayn                 ; SAVE Yn-1 & Yn-2.

;-------------------------------------------------------------------------
aout      =         ayn*kaenv           ; SCALE AND OUTPUT
          outs      aout,axn

          endin
