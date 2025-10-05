
sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1


          instr     1
isc       =         .6   ; SCALAR CHOSEN TO MATCH WHITE NOISE AMPLITUDE

ksw       expseg    30, p3, 18000 ; SWEEP FILTER FROM 30Hz TO 18000Hz

a1        init      0
a2        init      0
a3        init      0
a4        init      0
a5        init      0
a6        init      0
anz       trirand   30000      ; WHITE NOISE
a1        =         .997 * a1 + isc * .029591 * anz
a2        =         .985 * a2 + isc * .032534 * anz
a3        =         .950 * a3 + isc * .048056 * anz
a4        =         .850 * a4 + isc * .090579 * anz
a5        =         .620 * a5 + isc * .108990 * anz
a6        =         .250 * a6 + isc * .255784 * anz
apnz      =         a1 + a2 + a3 + a4 + a5 + a6
apnz      butterbp  apnz, ksw, ksw * .05     ; SWEEP FILTER
apnz      butterlp  apnz, ksw * 1.2  ; REMOVE HIGH END WHICH PASSES THRU
          out       apnz
          endin

