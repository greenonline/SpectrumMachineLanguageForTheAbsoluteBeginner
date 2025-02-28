9000 REM
9010 REM checksum
9020 INPUT "From address: "; f
9030 INPUT "To address  : "; t
9040 LET s=0
9050 FOR I=f TO t
9060 LET s=s+PEEK I
9070 NEXT I
9080 PRINT "Checksum:";s
9090 GO TO 9020