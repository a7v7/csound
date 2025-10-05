; ------------------------ bd16_01.orc ------------------------

sr             =         44100
kr             =         22050
ksmps          =         2
nchnls         =         1

/* ------------------------------------------------------- */

               seed      0

               instr     1

imkey          =         p4    /* GET NOTE PARAMETERS FROM SCORE FILE */
imvel          =         p5

icps           =         440.0*exp(log(2.0)*(imkey-69.0)/12.0)
iamp           =         0.0039+imvel*imvel/16192

/* ------------------------------------------------------- */

ivol           =         5500           /* OUTPUT VOLUME               */
ibpm           =         135            /* TEMPO                       */

ifrqs          =         5.3333         /* OSC. START FRQ. / NOTE FREQ. */
ifrqe          =         1.0            /* OSC. END FREQ. / NOTE FRQ.  */
ifrqd          =         16             /* OSC. FREQ. ENVELOPE SPEED   */

iffr1s         =         880            /* LP FILTER START FREQ. 1 (HZ) */
iffr1d         =         128            /* LP FILTER FRQ. 1 DECAY SPEED */
iffr2s         =         0              /* LP FILTER START FREQ. 2 (HZ) */
iffr2d         =         1              /* LP FILTER FRQ. 2 DECAY SPEED */
iffr3s         =         8              /* LP FILTER START FREQ. 3 / NOTE FRQ.   */
iffr3d         =         8              /* LOWPASS FILTER FREQ. 3 DECAY SPEED    */
iffr4s         =         0              /* LP FILTER START FREQ. 4 / NOTE FRQ.   */
iffr4d         =         1              /* LOWPASS FILTER FREQ. 4 DECAY SPEED    */

iEQ1fo         =         0.5            /* EQ 1 FREQUENCY / OSC. FREQ.      */
iEQ1fn         =         0              /* EQ 1 FREQUENCY / NOTE FREQ.      */
iEQ1fa         =         0              /* EQ 1 FREQUENCY (HZ)         */
iEQ1l          =         0.25           /* EQ 1 LEVEL                  */
iEQ1q          =         0.7071         /* EQ 1 Q                      */
iEQ1m          =         1              /* EQ 1 MODE (0:PEAK,1:LO,2:HI) */

iEQ2fo         =         0.5            /* EQ 2 FREQUENCY / OSC. FREQ.      */
iEQ2fn         =         0              /* EQ 2 FREQUENCY / NOTE FREQ.      */
iEQ2fa         =         0              /* EQ 2 FREQUENCY (HZ)         */
iEQ2l          =         0.25           /* EQ 2 LEVEL                  */
iEQ2q          =         0.7071         /* EQ 2 Q                      */
iEQ2m          =         1              /* EQ 2 MODE (0:PEAK,1:LO,2:HI) */

iEQ3fo         =         0.5            /* EQ 3 FREQUENCY / OSC. FREQ.      */
iEQ3fn         =         0              /* EQ 3 FREQUENCY / NOTE FREQ.      */
iEQ3fa         =         0              /* EQ 3 FREQUENCY (HZ)         */
iEQ3l          =         4              /* EQ 3 LEVEL                  */
iEQ3q          =         2.0            /* EQ 3 Q                      */
iEQ3m          =         0              /* EQ 3 MODE (0:PEAK,1:LO,2:HI) */

iEQ4fo         =         0              /* EQ 4 FREQUENCY / OSC. FREQ.      */
iEQ4fn         =         1.5            /* EQ 4 frequency / note freq.      */
iEQ4fa         =         0              /* EQ 4 frequency (Hz)         */
iEQ4l          =         2.0            /* EQ 4 level                  */
iEQ4q          =         1.0            /* EQ 4 Q                      */
iEQ4m          =         0              /* EQ 4 mode (0:peak,1:lo,2:hi) */

insmix         =         16             /* NOISE MIX                   */

iEQn1fo        =         0              /* NOISE EQ 1 FREQUENCY / OSC. FREQ.     */
iEQn1fn        =         1              /* NOISE EQ 1 FREQUENCY / NOTE FREQ.     */
iEQn1fa        =         0              /* NOISE EQ 1 FREQUENCY (HZ)             */
iEQn1l         =         0.0625         /* NOISE EQ 1 LEVEL            */
iEQn1q         =         0.7071         /* NOISE EQ 1 Q                     */
iEQn1m         =         1              /* NOISE EQ 1 MODE (0:PEAK,1:LO,2:HI)    */

iEQn2fo        =         0              /* NOISE EQ 2 FREQUENCY / OSC. FREQ.     */
iEQn2fn        =         16             /* NOISE EQ 2 FREQUENCY / NOTE FREQ.     */
iEQn2fa        =         0              /* NOISE EQ 2 FREQUENCY (HZ)             */
iEQn2l         =         0.0625         /* NOISE EQ 2 LEVEL            */
iEQn2q         =         0.7071         /* NOISE EQ 2 Q                     */
iEQn2m         =         1              /* NOISE EQ 2 MODE (0:PEAK,1:LO,2:HI)    */

/* ------------------------------------------------------- */

p3             =         p3+0.15        /* INCREASE NOTE LENGTH */

ibtime         =         60/ibpm

/* AMP. ENVELOPE */

kamp           linseg    1, p3-0.15, 1, 0.05, 0, 0.1, 0
kamp           =         kamp*iamp*ivol

/* KCPS        =         OSC. FREQUENCY, KNUMH = NUM. OF HARMONICS */

kcps           port      ifrqe*icps, ibtime/ifrqd, ifrqs*icps
knumh          =         sr/(2*kcps)

/* OSCILLATOR */

a_             buzz      sr/(3.14159265*10), kcps, knumh, 1, 0
a__            buzz      sr/(3.14159265*10), kcps, knumh, 1, 0.5

a0             tone      a_-a__,10

a_             unirand   2              /* NOISE GENERATOR */
a_             =         a_-1

a_             pareq     a_, iEQn1fa+icps*iEQn1fn+kcps*iEQn1fo, \
                         iEQn1l, iEQn1q, iEQn1m
a_             pareq     a_, iEQn2fa+icps*iEQn2fn+kcps*iEQn2fo, \
                         iEQn2l, iEQn2q, iEQn2m

a0             =         a0 + insmix*a_

/* EQ */

a0             pareq     a0, iEQ1fa+icps*iEQ1fn+kcps*iEQ1fo, iEQ1l, \
                         iEQ1q, iEQ1m
a0             pareq     a0, iEQ2fa+icps*iEQ2fn+kcps*iEQ2fo, iEQ2l, \
                         iEQ2q, iEQ2m
a0             pareq     a0, iEQ3fa+icps*iEQ3fn+kcps*iEQ3fo, iEQ3l, \
                         iEQ3q, iEQ3m
a0             pareq     a0, iEQ4fa+icps*iEQ4fn+kcps*iEQ4fo, iEQ4l, \
                         iEQ4q, iEQ4m

/* FILTER FREQ. ENVELOPES */

kffr1          port      0, ibtime/iffr1d, iffr1s
kffr2          port      0, ibtime/iffr2d, iffr2s
kffr3          port      0, ibtime/iffr3d, iffr3s*icps
kffr4          port      0, ibtime/iffr4d, iffr4s*icps

/* KFFRQ = LP FILTER FREQUENCY */

kffrq          =         kffr1 + kffr2 + kffr3 + kffr4

a0             butterlp  a0, kffrq                /* LP FILTER */

a_             =         a0*kamp

               out       a_

               endin
