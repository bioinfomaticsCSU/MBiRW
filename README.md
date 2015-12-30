License
=========

Copyright (C) 2014 Jianxin Wang(jxwang@mail.csu.edu.cn),Huimin Luo(luohuimin@csu.edu.cn)

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 3
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, see <http://www.gnu.org/licenses/>.

Jianxin Wang(jxwang@mail.csu.edu.cn),Huimin Luo(luohuimin@csu.edu.cn)
School of Information Science and Engineering
Central South University
ChangSha
CHINA, 410083


Computational drug repositioning
=================


1)Dataset.

EPGA is written C++ and therefore will require a machine with GNU C++ pre-installed.

Create a main directory (eg:EPGA). Copy all source code to this directory.

Run command line: g++ main.cpp -o epga -lpthread

2)Running.

./epga libraryName insertsize sd libraryName1 insertsize1 sd1 kmerLength threadNumber

libraryName is paired-end reads file name in Fasta format (eg: read1.fa). Paired-end reads are in single file. Left mate read and right mate read stored in file one by one.(For mate-paired reads, please transform them to paired-end reads.)

insertsize is the sequence fragment length about paired-end reads (eg: 500).

sd is the standard deviation of insertsize.

kmerLength is one integer shorter than read length which is used for building De Bruijn graph.

threadNumber is thread number of program.

