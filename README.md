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
MBiRW is one novel computational method, which utilizes comprehensive similarity measures and Bi-Random walk algorithm to identify potential novel indications for a given drug.

1.Dataset.

1) DrugSimMat and DiseaseSimMat store drug similarity matrix and disease similarity matrix, respectively;

2) DiDrAMat stores known disease-drug association information;

3) DrugsName and DiseasesName store drug ids and disease ids, respectively;

4) For each drug pair, the number of their sharing common diseases is stored in shareWrr.mat;

5) For each disease pair, the number of their sharing common drugs is stored in shareWdd.mat;

6) CDataSets store the combined datasets; Datasets_indep store the independent dataset.

2.Code.
1) normFun.m: function implementing normalization;

2) setparFun.m: function analyzing similarity network;

3) nManiCluester.m : function implementing cluster operation by calling cluster_one-1.0;

4) MBiRW: predict potential indications for drugs; 

All files of Dataset and Code should be stored in the same folder to run MBiRW.
