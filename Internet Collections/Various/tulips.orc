sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2
          
; TULIPS

          instr 1
itablesize =        12        
kindex    phasor    p5*p6                    ; VARIES PHASE OF LFO VS BEAT
                                             ; THUS CREATING MELODIC PATTERNS

plantatulip:
kenv      linen     1,.001,1/p5,1/p5*.9
ipitch    table     i(kindex)*itablesize,2
          timout    0,1/p5,pluckatulip
          reinit    plantatulip
               
pluckatulip:
a1        pluck    ampdb(p4)*kenv,cpspch(ipitch+p7),p8,0,1
          outs      a1,a1
          endin

