sr        =         44100
kr        =         4410
ksmps     =         10                       ; DON´T CHANGE IT!
nchnls    =         1

gimaxn    =         20
; ALLOCATE SOME zak SPACE
          zakinit   1,4*gimaxn               ; WE SHOULD NEED A 4-DIMENSIONAL ARRAY HERE 
; (ACTUAL, PREVIOUS AND NEXT POSITIONS, AND ACTUAL FORCES)
; imaxn IS THE MAXIMUM NUMBER OF DISCRETE MASSES YOU´LL USE


;""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
          instr 1             ; STRING WITH ARBITRARY N MASSES. CONSTANT LINEAR DENSITY
; coded by Josep M Comajuncosas / gelida@intercom.es
;""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

inm       =         20                       ; 18 EFFECTIVE MASSES (BOTH GROUNDS ACT LIKE INFINITE MASSES)
kndx      init      0

; SET INITIAL POSITION AND VELOCITY OF THE MASS
          ziw       15, 3 + inm              ; INITIALIZE ONE POSITION - HERE, THE PREVIOUS POSITION OF THE 4th MASS
          ziw       15, 3                    ; INITIALIZE ONE POSITION - HERE, THE ACTUAL POSITION OF THE 4th MASS

; SET K, Z AND M
ik        =         p4
iz        =         p5
im        =         30

; NORMALIZE (DON'T TOUCH THIS!)
ik        =         ik/(sr*sr)
iz        =         iz/(1000000000*sr)       ; Z GIVEN IN N*s/(kg*10e-9)
im        =         im/1000000000            ; MASS GIVEN IN kg*10e-9


; CALCULATE ACTUAL FORCES AND POSITIONS OF MASSES

; "MASS" ON THE LEFT - GROUND
krightx   zkr       kndx +1
kprevrightx zkr     kndx + inm +1
kf        =         ik*(krightx) + iz*((krightx-kprevrightx))
          zkw       kf, kndx + 3*inm
kndx      =         kndx + 1

; CENTRAL MASSES
loop1:
kx        zkr       kndx
kprevx    zkr       kndx + inm
krightx   zkr       kndx +1
kprevrightx zkr     kndx + inm +1
kleftf    zkr       kndx + 3*inm -1

kf        =         -kleftf + ik*(krightx-kx) + iz*((krightx-kprevrightx)-(kx-kprevx))
knextx    =         kf/im + 2*kx-kprevx
          zkw       kf, kndx + 3*inm
          zkw       knextx, kndx + 2*inm

kndx      =         kndx + 1
          if        kndx < inm-1 goto loop1

; "MASS" ON THE RIGHT - GROUND
kx        zkr       kndx 
kprevx    zkr       kndx + inm
kleftf    zkr       kndx + 3*inm -1
kf        =         -kleftf + ik*(-kx) + iz*(-(kx-kprevx))
          zkw       kf, kndx + 3*inm

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

          kout      zkr 3
          aout      upsamp kout              ; I´M AFRAID THIS IS THE BEST WAY TO DO IT...
          out       aout

kndx      =         0
          endin

          instr 2
          zkcl      0, 4*gimaxn              ; SORRY FOR THE TRICK !
          endin
