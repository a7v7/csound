
<CsoundSynthesizer>

<CsOptions>
;***** command line flags ******
;-W -osine.wav
</CsOptions>


<CsInstruments>

;**** COMPARATION OF DIFFERENT TYPES OF INTERPOLATIONS ****

sr        =         44100  
kr        =         4410
ksmps     =         10
nchnls    =         2    

          instr     1
a1        oscil3    20000,p4,p5

a2        oscili    20000,p4,p6
          outs      a1,a2      
          endin


</CsInstruments>


<CsScore>

f1 0 4 10 1       ;sine of four points to view interpolation quality.
f2 0 2 9 1 1 90   ;sine of two points to view interpolation quality.

; FOUR CICLES OF TWO-POINT SINE WITH CUBIC INTERPOLATION
f3 0 8192 8 0 512 1 1024 -1 1024 1 1024 -1 1024 1 1024 -1 1024 1 1024 -1 512 0

; FOUR CICLES OF TWO-POINT SINE WITH CUBIC SPLINE INTERPOLATION
f4 0 8192 8 0 512 1 1024 -1 1024 1 1024 -1 1024 1 1024 -1 1024 1 1024 -1 512 0 

i1 0   1 440 1 1
i1 1.5 1 440 2 2
i1 3   1 30 2 3


e

</CsScore>


</CsoundSynthesizer>



























