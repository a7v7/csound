sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

          instr  1

idur      =         p3
iamp      =         p4
ifqc      =         p5
ipan      =         p6

kamp      linseg    0, idur/2, iamp, idur/2, 0
aout      oscil     kamp, ifqc, 1
          outs      aout*sqrt(ipan), aout*sqrt(1-ipan)

          endin

          instr   2

idur      =         p3
iamp      =         p4
ifqc      =         p5
ipan      =         p6
krez      init      1

kfco      linseg    200, .05, 5000, idur-.05, 200
kamp      linseg    0, .01, iamp, idur-.01, 0

asig      vco       1, ifqc, 0, .5, 1, 1/ifqc
aflt      moogvcf   asig, kfco, krez, 1

          outs      aflt*sqrt(ipan)*kamp, aflt*sqrt(1-ipan)*kamp

          endin

          instr   3

idur      =         p3
iamp      =         p4
ifqc      =         p5
ipan      =         p6
ifco      =         p7
krez      init      p8

kfco      linseg    200+ifco/100, .05, ifco, idur-.05, 200+ifco/100
kamp      linseg    0, .01, iamp, idur-.01, 0

asig      vco       1, ifqc, 0, .5, 1, 1/ifqc
aflt      moogvcf   asig, kfco, krez, 1

          outs      aflt*sqrt(ipan)*kamp, aflt*sqrt(1-ipan)*kamp

          endin

