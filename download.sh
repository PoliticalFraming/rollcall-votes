#!/usr/bin/env sh

cd data/dta

curl -O "ftp://voteview.com/wf1/sen101kh.dta" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/wf1/sen102kh.dta" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/wf1/sen103kh.dta" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/wf1/sen104kh.dta" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/wf1/sen105kh.dta" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/wf1/sen106kh.dta" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/wf1/sen107kh.dta" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/wf1/sen108kh.dta" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/wf1/sen109kh.dta" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/wf1/sen110kh.dta" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/wf1/sen111kh.dta" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/wf1/sen112kh.dta" -# -w "%{filename_effective}\n"

curl -O "ftp://voteview.com/wf1/hou101kh.dta" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/wf1/hou102kh.dta" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/wf1/hou103kh.dta" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/wf1/hou104kh.dta" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/wf1/hou105kh.dta" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/wf1/hou106kh.dta" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/wf1/hou107kh.dta" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/wf1/hou108kh.dta" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/wf1/hou109kh.dta" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/wf1/hou110kh.dta" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/wf1/hou111kh.dta" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/wf1/hou112kh.dta" -# -w "%{filename_effective}\n"

cd -
cd data/ord

curl -O "ftp://voteview.com/dtaord/sen101kh.ord" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtaord/sen102kh.ord" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtaord/sen103kh.ord" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtaord/sen104kh.ord" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtaord/sen105kh.ord" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtaord/sen106kh.ord" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtaord/sen107kh.ord" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtaord/sen108kh.ord" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtaord/sen109kh.ord" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtaord/sen110kh.ord" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtaord/sen111kh.ord" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtaord/sen112kh.ord" -# -w "%{filename_effective}\n"

curl -O "ftp://voteview.com/dtaord/hou101kh.ord" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtaord/hou102kh.ord" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtaord/hou103kh.ord" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtaord/hou104kh.ord" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtaord/hou105kh.ord" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtaord/hou106kh.ord" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtaord/hou107kh.ord" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtaord/hou108kh.ord" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtaord/hou109kh.ord" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtaord/hou110kh.ord" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtaord/hou111kh.ord" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtaord/hou112kh.ord" -# -w "%{filename_effective}\n"

cd -
cd data/desc

curl -O "ftp://voteview.com/Senate107_dictionary.txt" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/Senate108_dictionary.txt" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtaord/s109desc_final.csv" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtaord/s110desc_December_2008.csv" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtaord/s111desc_2010.csv" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtaord/s112desc.csv" -# -w "%{filename_effective}\n"

cd -
cd data/dtl

curl -O "ftp://voteview.com/dtl/101s.dtl" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtl/102s.dtl" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtl/103s.dtl" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtl/104s.dtl" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtl/105s.dtl" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/dtl/106s.dtl" -# -w "%{filename_effective}\n"

cd -
cd data

curl -O "ftp://voteview.com/junkord/S01_112_codes.TXT" -# -w "%{filename_effective}\n"
curl -O "ftp://voteview.com/junkord/H01_112_codes.TXT" -# -w "%{filename_effective}\n"

cd -

# https://github.com/kawadia/estrangement/blob/master/data/voteview/rollcall.py

# for i in `seq 10 111`; do wget ftp://voteview.com/dtaord/sen${i}kh.ord ; done
# for i in `seq 1 9`; do wget ftp://voteview.com/dtaord/sen0${i}kh.ord ; done

# for i in `seq 10 111`; do wget ftp://voteview.com/dtaord/hou${i}kh.ord ; done
# for i in `seq 1 9`; do wget ftp://voteview.com/dtaord/hou0${i}kh.ord ; done
