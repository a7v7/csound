; pm5.orc
sr        =         44100
kr        =         44100
ksmps     =         1                        ; ESSENTIAL FOR THIS INSTRUMENT. DON´T CHANGE IT!
nchnls    =         1

gimaxn    =         20                       ;THE MAXIMUM NUMBER OF DISCRETE MASSES YOU´LL USE
; ALLOCATE SOME zak SPACE
          zakinit   1,4*gimaxn               ; WE SHOULD NEED A 4-DIMENSIONAL ARRAY HERE 
; (ACTUAL, PREVIOUS AND NEXT POSITIONS, AND ACTUAL FORCES)


;""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
; strange strucked string. 20 masses! (be patient)
          instr 1             ; AS pm5 WITH A HAMMER ACTION LINK (THE LAST ONE)
; coded by Josep M Comajuncosas / Barcelona - jan.´98
; gelida@intercom.es
; variables to play with : inm (<=gimaxn), k (0 to 1), z
;""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inm       =         20                       ; 98 EFFECTIVE MASSES (BOTH GROUNDS ACT LIKE INFINITE MASSES)
kndx      init      1

; SET K AND Z
ik        =         p4
iz        =         p5

; NORMALIZE (DON'T TOUCH THIS!)
ik        =         ik/(sr*sr)
iz        =         iz/(1000000000*sr)

imaxx     =         2000
imaxm     =         40
imhammer  =         20

kskip     init      0
          if        kskip == 1 kgoto noinitveloc

; INITIALIZE POSITIONS WITH A WAVEFORM (f2)
; INITIAL VELOCITIES ARE SET TO 0
loop0:
kiprevx   table     kndx/inm, 2, 1
          zkw       imaxx*(kiprevx), kndx
          zkw       imaxx*(kiprevx), inm + kndx


kndx      =         kndx +1
          if        kndx < inm -1 goto loop0
kndx      =         0
kskip     =         1

noinitveloc:

; CALCULATE ACTUAL FORCES AND POSITIONS OF MASSES

; "MASS" ON THE LEFT - GROUND

krightx   zkr       kndx +1
kprevrightx zkr     kndx + inm +1
kf        =         ik*(krightx) + iz*((krightx-kprevrightx))
          zkw       kf, kndx + 3*inm
kndx      =         kndx + 1

; CENTRAL MASSES
loop1:

; INITIALIZE MASSES (f1)
km        tablei    kndx/inm, 1, 1
km        =         imaxm*(km+1)/2           ; FOR A TABLE IN (-1,1) - MASSES MUST BE > 0!
;km       =         imaxm*km                 ; FOR A TABLE IN (0,1)
km        =         km/1000000000            ; DON´T TOUCH!

kx        zkr       kndx
kprevx    zkr       kndx + inm
krightx   zkr       kndx +1
kprevrightx zkr     kndx + inm +1
kleftf    zkr       kndx + 3*inm -1

kf        =         -kleftf + ik*(krightx-kx) + iz*((krightx-kprevrightx)-(kx-kprevx))
knextx    =         kf/km + 2*kx-kprevx
          zkw       kf, kndx + 3*inm
          zkw       knextx, kndx + 2*inm

kndx      =         kndx + 1
          if        kndx < inm-2 goto loop1

; LAST MASS,HAMMER-TYPE LINK & GROUND 

km        tablei    kndx/inm, 1, 1
km        =         imaxm*(km+1)/2           ; FOR A TABLE IN (-1,1) - MASSES MUST BE > 0!
;km       =         imaxm*km                 ; FOR A TABLE IN (0,1)
km        =         km/1000000000            ; DON´T TOUCH!
                                        
kleftx    =         kx
kx        =         krightx
kprevx    zkr       kndx + inm
krightx   zkr       kndx +1
kprevrightx zkr     kndx + inm +1
kleftf    =         kf
          if        kx > kleftx goto nolink
kf        =         -kleftf + ik*(krightx-kx) + iz*((krightx-kprevrightx)-(kx-kprevx))
kflast    =         -kf + ik*(-krightx) + iz*(-(krightx-kprevrightx))
          goto      next

nolink:
kf        =         -kleftf
kflast    =         ik*(-krightx) + iz*(-(krightx-kprevrightx))

next:
knextx    =         kf/km + 2*kx-kprevx
klastx    =         kflast/imhammer + 2*krightx-kprevrightx


; UPDATE VARIABLES FOR NEXT PASS
kndx      =         1
loop2:
kx        zkr       kndx
knextx    zkr       kndx + 2*inm

          zkw       kx, kndx + inm
          zkw       knextx, kndx
          zkw       0, kndx + 2*inm          ; THIS SHOULD´T BE NECESSARY (?)
          zkw       0, kndx + 3*inm          ; ID. (?)

kndx      =         kndx + 1
          if        kndx < inm -1 goto loop2

          kout      zkr int(inm/2)
          aout      upsamp kout
          out       aout

kndx      =         0
          endin

          instr 2
          zkcl      0, 4*gimaxn              ; SORRY FOR THE TRICK !
          endin

;i fer turnon 2,0 i a 2 zkcl -> turnoff?
; o bé zkcl turnon 2,p3 turnoff tot a instr 1, amb gip4 gip5
