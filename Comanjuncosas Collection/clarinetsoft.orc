sr        =         44100
kr        =         44100                                                       ; use sr=kr please
ksmps     =         1
nchnls    =         1
          zakinit   4,4

instr 1; INSTR 1 ACTS LIKE "THE PLAYER" AND INSTR 2 LIKE "THE INSTRUMENT"
; INSTR 2 MUST BE ACTIVE TROUGHOUT THE ENTIRE PIECE
; INSTR 1 IS ACTIVATED AT EACH NOTE EVENT

; MIDI SETUP
ifrequency          pchmidi
print               ifrequency                                                  ; displays current note being played
ifreq               cpsmidi

ittime    =         1/ifreq                                                     ; transition time between two different fingerings
iatt      =         .5/ifreq                                                    ; attack time
irel      =         4/ifreq                                                     ; release time - experiment!

iamp      ampmidi   500
kamp7     midictrl  7,100
kamp7     =         kamp7/128


iamp      =         500+iamp
icontrol  zir       0                                                           ; = 0 at compilation start time
icontrol  =         (icontrol == 0 ? 1:0)                                       ; this swaps bores at each new event
          ziw       icontrol,0
          ziw       ifreq, icontrol+1                                           ; writes fre. at zk location 1 or 2. First is 2 <-- !

; TO DO: COMPENSATE FLOW NEEDED TO REACH BEATING RELATED TO FREQUENCY

kdepth    linseg    5,.5,25,100,20                                              ; FIX THIS
kspeed    linseg    3,.2,3,.5,6.5,100,6                                         ; FIX THIS
kvibr     oscil     kdepth,kspeed,1
kp0       expsegr   10,iatt,iamp,100-iatt-irel,iamp,irel,10                     ; pressure envelope
knoize    gauss     .0015*kp0                                                   ; add some pressure-dependent breath noise
kp0       =         (kp0 + knoize+kvibr)*kamp7

          zkwm      kp0,3                                                       ; writes flow at zk location 3

; WEIGHTING FACTOR FOR BORE SWAP
; ACTIVATED AT EACH NEW EVENT

istart    =         icontrol
iend      =         1-istart
transition:
kweight   linseg    istart,ittime,iend,100,iend
          zkw       kweight,4

output:
endin


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
instr 2
; MIDIFIED CLARINET MODEL
; VARIABLE EMBOCHURE MODEL FOR WAVEGUIDE WOODWINDS
; LOOSELY BASED ON A JNMR ARTICLE (VOL.24 PP.148-163)
; WRITTEN BY GIJS DE BRUIN & MAARTEN VAN WALSTIJM
; CODED TO CSOUND BY JOSEP M COMAJUNCOSAS / DEC´98-FEB´99
; THANKS TO MARTEEN FOR HIS VALUABLE HELP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ipi       =         3.14159265359
;ixtiny   =         0.000000004                                                 ; small value
inumb_iter =        3                                                           ; number of iterations, suggested 1 to 3
                                                                                ; used in the Newton-Rhapson method.

                                                                                ; default clarinet values
ifr       =         2500                                                        ; reed resonance frequency
iwr       =         2*ipi*ifr                                                   ; normalized in radians/cycle
ier       =         44.4                                                        ; = B^(-3/2) where B = airflow constant ~ 0.08
ihr       =         0.0004                                                      ; aperture of the reed in equilibrium
iir       =         731                                                         ; inertance of the air above the reed
iq        =         1.5                                                         ; set q=2 for lip & double reed????
ist       =         0.000177  
isr       =         0.000146
iqr       =         5.0
igr       =         iwr/iqr
iur       =         0.0231

ic        =         343;sound velocity
irho      =         1.21;air density
iz0       =         (irho*ic)/ist

; INITIALISE VARIABLES
kuf1      init      0                                                           ; normal volume flow
apm1      init      0                                                           ; mouthpiece pressure at t=0 is 0
apr2      init      0                                                           ; reflected pressure wave from the tube
kx1       init      ihr                                                         ; previous reed aperture (at t=-1)
kx2       init      ihr                                                         ; initial reed aperture (at t=0)


; THE CONSTANTS ARE COMPUTED AS:
iv        =         1                                                           ; iv = -1 (lip) or 1 (cane). Here "cane"
it        =         1/sr                                                        ; sampling period

ic1       =         2-iwr*iwr*it*it - igr*it
ic2       =         igr*it - 1
ic3       =         -it*it*iv/iur       
ic4       =         it*it*iwr*iwr
ic6       =         isr/it
ic7       =         -(iz0*it/iir + 1)
ic8       =         -it*ier/iir
ic9       =         it/iir

kp0       zkr       3                                                           ; get flow value fron zk location 3

adp1      =         kp0 - apm1
kdp1      downsamp  adp1                                                        ; necessary to compute a k-rate variable
kpr2      downsamp  apr2                                                        ; idem

kx0       =         kx1  
kx1       =         kx2       
kx2       =         ic1*kx1 + ic2*kx0 + ic3*kdp1 + ic4*ihr


; CLIPPING ROUTINE FOR CLARINET BEATING

; the routine uses a value kclipd that sets the distance bewteen
; kclipg and kclipx1. So for high values of kclipd, the clipping is
; very 'soft'. and for kclipd=0 there is no softening at all,
; and the clipping is equivalent to the way we have it now.

; Clipping Routine for clarinet beating
; the clipping routine has two control parameters:
; kclipg = minimum value for x to clip at
; kclipm = 'softness' of clipping: m corresponds to
; the half-width (kclipd) of the range in which the clipping
; does 'circular' waveshaping
; kclipm is experessed in fraction(0 to 1) of the equilibrium opening ihr
; 0 means no softening at all
; 1 means very much softening

; EXAMPLE VALUES

kcliph    =         ihr
kclipg    =         .00005;
kclipm    =         .4;0.5;

; INITIALISATION PART OF THE CLIPPING ROUTINE

kclipd    =         kclipm*kcliph ;
kclipk    =         1 - sqrt(2) ;
kclipx1   =         kclipg - kclipd ;
kclipa    =         kclipx1 ;
kclipr    =         (kclipa-kclipg)/kclipk ;
kclipb    =         kclipr + kclipg ;
kclipx2   =         (kclipx1 + kclipb)/2 ;

; THE ROUTINE ITSELF

if kx2 < kclipx1 goto full
goto nofull
full:
kx2       =         kclipg                                                      ; full clipping
goto clipped

nofull:
if kx2 > kclipx2 goto noclip
goto nonoclip
noclip:
kx2       =         kx2                                                         ; no clipping
goto clipped

nonoclip:
kx2       =         kclipb - sqrt(kclipr*kclipr - (kx2-kclipx1)*(kx2-kclipx1))  ; circular (soft) clipping
clipped:


;kur2     =         ic6*(kx2 - kx1)                                             ; must compensate for the phase delay induced by kur2! 
kur2      =         0                                                           ;IN TUNE!!!!!!!     

id1       =         ic7  
kd2       =         ic8/(kx2 * kx2)     
kd3       =         ic9*(kp0 - 2*kpr2 + iz0*kur2) + kuf1    
     
; NEWTON-RHAPSON iteration.

; Uf(n) is used as initial value.

 kd4      =         kd2*iq;
 kd5      =         kd4-kd2;
 kxo      =         kuf1;

kcounter  =         inumb_iter                                                  ; reinitialise counter
iter:

kbsaxo    =         abs(kxo)
ksign     =         kbsaxo                                                      ; temp. variable
ksign_axo =         (ksign<0?-1:1)
kbsaxoq1  =         kbsaxo^(iq-1)
kbsaxoq   =         kbsaxo*kbsaxoq1

kxo       =         (kd5*ksign_axo*kbsaxoq-kd3)/(id1+kd4*kbsaxoq1)

kcounter  =         kcounter - 1
if kcounter > 0 goto iter                                                       ; iterate inumb_iter times

kuf2      =         kxo                                                         ; get value
     
kub2      =         kuf2 - kur2                                                 ; total volume flow for next pass  
api2      =         iz0*kub2 + apr2                                             ; ingoing pressure wave into the tube
apm2      =         api2 + apr2                                                 ; mouthpiece pressure         

; CILYNDRICAL WAVEGUIDE (lowpass inverting)
; bore logic : swap if a new note has started
; this feature allows playing legato notes

kbore1    zkr       1
kbore2    zkr       2

; THIS CONDITIONAL IS NORMALLY SKIPPED EXCEPT AT INIT TIME
; WHEN BORE1 CAN HAVE ITS LENGHT UNDEFINED

kbore1    =         (kbore1==0?kbore2:kbore1)
kweight   zkr       4

;kdlt1    =         -10/sr+1/kbore1                                             ; compensate for the Ur term
;kdlt2    =         -10/sr+1/kbore2
kdlt1     =         1/kbore1
kdlt2     =         1/kbore2

; CALCULATIONS FOR FRACTIONAL DELAY INTERPOLATION FILTER
; BY NOW A SIMPLE LINEAR INTERPOLATOR

kdltn1    =         int(sr*kdlt1/2)
kdltn2    =         int(sr*kdlt2/2)
kdltf1    =         frac(sr*kdlt1/2)                                            ; note than time=int(time)+frac(time) ;-)
kdltf2    =         frac(sr*kdlt2/2)

; PRESSURE SENT TO TWO BORES IN PARALLEL
bore1:
atemp11   delayr    1/20
api31     deltapn   -20+kdltn1

; REFLECTANCE FIR FILTER DESIGNED IN MATLAB BY MAARTEN

aprf1     filter2   -api31,41,0,-0.008343209925866,-0.007910950033872,-0.007620518287642,-0.006738665808330,\
-0.005916797248747,-0.004374587750018,-0.002725030499174,-0.000144882597869,\
 0.002777627331931, 0.006883107580930, 0.011573388562796, 0.017661143743584,\
 0.024485754828736, 0.032770073690024, 0.041721937043204, 0.051891016477932,\
 0.062252942559435, 0.073035907154156, 0.082761104355788, 0.090717776376361,\
 0.093643123844425, 0.090717776376361, 0.082761104355788, 0.073035907154156,\
 0.062252942559435, 0.051891016477932, 0.041721937043204, 0.032770073690024,\
 0.024485754828736, 0.017661143743584, 0.011573388562796, 0.006883107580930,\
 0.002777627331931,-0.000144882597869,-0.002725030499174,-0.004374587750018,\
-0.005916797248747,-0.006738665808330,-0.007620518287642,-0.007910950033872,-0.008343209925866
afdf12    biquad    aprf1, 1-kdltf1, kdltf1,0,1,0,0
          delayw    api2

bore2:
atemp21   delayr    1/20
api32     deltapn   -20+kdltn2

; REFLECTANCE FIR FILTER DESIGNED IN MATLAB BY MAARTEN

aprf2     filter2   -api32,41,0,-0.008343209925866,-0.007910950033872,-0.007620518287642,-0.006738665808330,\
-0.005916797248747,-0.004374587750018,-0.002725030499174,-0.000144882597869,\
 0.002777627331931, 0.006883107580930, 0.011573388562796, 0.017661143743584,\
 0.024485754828736, 0.032770073690024, 0.041721937043204, 0.051891016477932,\
 0.062252942559435, 0.073035907154156, 0.082761104355788, 0.090717776376361,\
 0.093643123844425, 0.090717776376361, 0.082761104355788, 0.073035907154156,\
 0.062252942559435, 0.051891016477932, 0.041721937043204, 0.032770073690024,\
 0.024485754828736, 0.017661143743584, 0.011573388562796, 0.006883107580930,\
 0.002777627331931,-0.000144882597869,-0.002725030499174,-0.004374587750018,\
-0.005916797248747,-0.006738665808330,-0.007620518287642,-0.007910950033872,-0.008343209925866
afdf22    biquad    aprf2, 1-kdltf2, kdltf2,0,1,0,0
          delayw    api2

; SIGNAL REACHING THE BORE CLOSED END

apr3      =         kweight*afdf12 + (1-kweight)*afdf22
; 

api3      =         kweight*api31 + (1-kweight)*api32

; SOUND OUTPUT

          aout      butterhp api3,p4*1.1
          out       aout*100;crude scaling


; UPDATE VARIABLES FOR NEXT PASS
kuf1      =         kuf2
apm1      =         apm2
apr2      =         apr3


          zkcl      3,3                                                    ; clean mixer
          endin
