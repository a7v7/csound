;sco dee doh
f1 0 2048 9 1 10 87 2 5 207 3 0 90 4 4 36 5 0 90 6 3 207 f2 0 16 -2 8.02 8.11 8.09 8.00 8.02 8.07 8.04 8.00 f3 0 1024 10 10 5 0 4 0 3 0 2 0 1
f4 0 1024 10 10 0 5 0 4 0 3 0 2 0 1
f5 0 16 -2 95 90 88 86 82 80 75
f6 0 16 -2 5.00 6.04 5.02 6.05 5.07 6.04 5.09 7.04 f7 0 16 -2 9.04 9.07 9.05 9.09 9.11 9.11 10.00 10.00 f8 0 512 9 1 5 225 2 7 60 3 3 330
t 0 60 1.5 30 3 15

i1 0 1.5 1 6 8.00
i1 .5 1.5 1 6 7.07
i1 1 1.5 1 5 7.05
i1 1.5 1 2 4 7.00
i1 2 1 2 3 7.05
i1 2.5 1 2 2 7.07
i1 3 1.5 1 1 8.00
i1 3.5 1 1 3 7.07
i1 4.5 1 2 6 7.05

Use balance to correct for powerloss by filters! (see the manual and tutorials!)

i.e.


a1   = asig+asigr; temp result
a2   = asigp+asigm; temp result
ar1  reson a1,1200,10 ;  bandpass-filter
ar2  reson a2,1205,10 ;  bandpass-filter
ab1  balance ar1,a1 ;    balance filtered signal to original
ab2  balance ar2,a2 ;    balance filtered signal to original

outs ab1,ab2;


Good luck,






Hans Timmermans     email: hans.timmermans@kmt.hku.nl
Senior Lecturer Computermusic
Utrecht School of the Arts    phone: +31 356836464
Faculty of Art, Media & Technology fax: +31 356836480 Department Musictechnology
PO-Box 2471
1200 CL Hilversum
THE NETHERLANDS
