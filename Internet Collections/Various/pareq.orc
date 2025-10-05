
; ORCHESTRA:
;----------------------------------------------------------------
; PARAMETRIC EQUALIZER OPCODE
;----------------------------------------------------------------

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2
          instr     15

ifc       =         p4            ; CENTER / SHELF
iq        =         p5            ; QUALITY FACTOR SQRT(.5) IS NO RESONANCE
iv        =         ampdb(p6)     ; VOLUME BOOST/CUT
imode     =         p7            ; MODE 0=PEAKING EQ, 1=LOW SHELF, 2=HIGH SHELF

kfc       linseg    ifc*2, p3, ifc/2

asig      rand      5000                          ; RANDOM NUMBER SOURCE FOR TESTING
aout      pareq     asig, kfc, iv, iq, imode      ; PARMETRIC EQUALIZATION
          outs      aout, aout                    ; OUTPUT THE RESULTS

          endin
