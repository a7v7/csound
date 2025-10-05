sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1


          instr     1
ktab      table     p4,1
kliner    linen     10000,.1,p3,.1
anoise    rand      7000,.9
abpf      reson     anoise,ktab,0.047
asig      oscil     kliner,ktab,2
aball     balance   abpf,asig
          out       aball
          endin
