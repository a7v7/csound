;------------------------- bd4004m.orc -----------------------

sr             =         44100
kr             =         44100
ksmps          =         1
nchnls         =         1

/* CONVERT MIDI NOTE NUMBER TO FREQUENCY */

#define        MIDI2CPS(xmidikey)
# (440.0*exp(log(2.0)*(($xmidikey)-69.0)/12.0)) #

/* CONVERT FREQUENCY TO MIDI NOTE NUMBER */

#define        CPS2MIDI(xfreqcps)
# (12.0*(log(($xfreqcps)/440.0)/log(2.0))+69.0) #

/* CONVERT VELOCITY TO AMPLITUDE */

#define        VELOC2AMP(xvelocity)
# (0.0039+(($xvelocity)*($xvelocity))/16192.0) #

/* CONVERT AMPLITUDE TO VELOCITY */

#define        AMP2VELOC(xamplitude)
# (sqrt((($xamplitude)-0.0039)*16192.0)) #

               seed      0

               instr     1

               kgoto     start01

/*-------------------------------------------------------- */

ivol           =         0.6            /* VOLUME                      */
ibpm           =         140.0          /* TEMPO                       */
irel           =         0.1667         /* RELEASE TIME (SEC.)         */
idel           =         0.02           /* DELAY TIME                  */
imod0          =         0.0025         /* RANDOM MOD. OF DELAY (SEC.)      */
imod1          =         0.005          /* RND. MOD. OF VELOCITY       */

if01           =         5.3333         /* OSC. START FREQUENCY (REL.)      */
ifd1           =         14.0           /* FREQ. ENVELOPE DECAY SPEED  */
ibw01          =         0.5            /* OSC1 BP BANDWIDTH (REL.)    */
ihp1           =         0.0625         /* OSC1 HP FREQUENCY (REL.)    */

iapf1          =         1.0            /* OSC1 ALLP. FLT. START FREQ. (REL.)    */
iapf2          =         1.0            /* OSC1 ALLP. FLT. END FREQ.             */
iapdx          =         8              /* OSC1 ALLP. FLT. ENVELOPE SPEED        */

ifr3           =         8              /* OSC2 HP1 FREQ. / BASE FRQ.  */
imx3           =         -5             /* OSC2 HP1 MIX                     */
ifr4           =         0.5            /* OSC2 OUTPUT HP F. / NOTE F.      */
imx2           =         -0.4           /* OSC2 OUTPUT GAIN            */
ihp2           =         1.5            /* OUTPUT HP FRQ. / NOTE F.    */
ibw02          =         2.0            /* OUTPUT HP RESONANCE         */

ifr1           =         8              /* OUT. LP START F. 1 / NOTE F. */
ifdx1          =         8              /* OUT. LP FREQ. 1 ENV. SPEED  */
ifr2           =         8              /* OUT. LP START F. 2 / NOTE F. */
ifdx2          =         8              /* OUT. LP FREQ. 2 ENV. SPEED  */

ifxBP1         =         7040           /* NOISE BP START FRQ. (HZ)    */
ifxBP2         =         7040           /* NOISE BP END FREQUENCY           */
ibw1           =         2              /* NOISE BP BANDWIDTH/FREQ.    */
ifxLP1         =         3520           /* NOISE LP START FRQ. (HZ)    */
ifxLP2         =         55             /* NOISE LP END FREQUENCY           */
ifxd           =         12             /* NOISE FILTER ENVELOPE SPEED      */
iattn1         =         0.01           /* NOISE ATTACK TIME (SEC.)    */
idecn1         =         3              /* NOISE DECAY SPEED                */
imxn           =         0.6            /* NOISE MIX                   */
     
/* ------------------------------------------------------- */

i001           =         1/65536
imkey          =         p4                            /* NOTE NUMBER       */
imvel          =         p5                            /* VELOCITY               */
ivel           =         $VELOC2AMP(imvel)             /* CONVERT VELOCITY  */
im0            unirand   2
im1            unirand   2
ivel           =         ivel*(1+(im1-1)*imod1)        /* RAND. VELOC. */
idel           =         idel+((im0-1)*imod0)          /* RAND. DELAY  */
ibtime         =         60/ibpm                       /* BEAT TIME    */
i002           =         exp(log(i001)*(idel+irel+16/kr)/irel)
ivol           =         ivel*ivol

icps           =         $MIDI2CPS(imkey)              /* BASE FREQ.        */
ifmax          =         sr*0.48                       /* MAX. ALLOWED FREQ.     */
ihp2           =         ihp2*icps
ibw02x         =         ihp2/ibw02
ifxLP2         =         ifxLP2-ifxLP1
ifxBP2         =         ifxBP2-ifxBP1
iapf2          =         iapf2-iapf1

ixtime         =         (irel+idel+16/kr)

p3             =         p3+ixtime                     /* INCREASE NOTE LENGTH    */

start01:

kenvn1         expseg    1,ibtime/idecn1,0.5           /* NOISE GENERATOR */
kenvn2         linseg    0,iattn1,1,1,1
aenvn          interp    kenvn1*kenvn2
kenvn3         expseg    1,ibtime/ifxd,0.5
kenvn3         =         (1-kenvn3)
kfxBPf         =         ifxBP1+(kenvn3*ifxBP2)
a1l            unirand   2
a1l            butterbp  imxn*32768*(a1l-1)*aenvn,kfxBPf,kfxBPf*ibw1
a1l            butterlp  a1l,ifxLP1+(ifxLP2*kenvn3)

/* ENVELOPES */

kamp1          expseg    1,p3-ixtime,1,ixtime,i002
kfrq1          expseg    1,ibtime/ifd1,0.5
kfrq           =         icps*(1+kfrq1*(if01-1))
kapfr          expseg    1,ibtime/iapdx,0.5
kapfr          =         kfrq*(iapf1+iapf2*(1-kapfr))
kfrx1          expseg    1,ibtime/ifdx1,0.5
kfrx2          expseg    1,ibtime/ifdx2,0.5
kfrx           =         kfrq*(kfrx1*ifr1+kfrx2*ifr2)
kfrx           =         (kfrx>ifmax ? ifmax : kfrx)

/* KFRQ = OSC. FREQUENCY, KAPFR = ALLPASS FILTER FREQUENCY */
/* KFRX = LP FILTER FREQUENCY                              */

/* OSCILLATOR */

knumh          =         sr/(2*kfrq)
a1             buzz      sr/(10*3.14159265), kfrq, knumh, 256, 0.25
a2             buzz      sr/(10*3.14159265), kfrq, knumh, 256, 0.75
a1             tone      (a1-a2)*16384, 10
a2             =         a1                                 /* A1 = A2 = OSC. SIGNAL   */

a1             butterhp  a1,kfrq*ihp1                       /* FILTERS */
a1             butterbp  a1,kfrq,kfrq*ibw01
a1x            tone      a1,kapfr
a1             =         2*a1x-a1
a3             butterhp  a2,kfrq*ifr3
a2             =         a2+a3*imx3
a2             butterhp  a2,kfrq*ifr4
a0x            =         a2*imx2+a1
atmp           butterbp  a0x*ibw02,ihp2,ibw02x
a0x            butterhp  a0x+atmp,ihp2
a0x            butterlp  a0x,kfrx

a0y            delay     (a0x+a1l)*ivol*kamp1,idel

               out       a0y

               endin
