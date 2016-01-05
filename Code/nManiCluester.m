function [ RWrr,RWdd ] = nManiCluester( Wrr,Wdd,tnWrr,tnWdd,Wrname,Wdname)
dn = size(Wdd,1);
dr = size(Wrr,1);

rfid = fopen('DrugsP.txt','wt');
for i = 2:dr
    for j = 1:i-1
        numShared = tnWrr(i,j);
        if(numShared>0)
            fname = char(Wrname(i));
            fprintf(rfid,'%s',fname);
            fprintf(rfid,'\t');
            sname = char(Wrname(j));
            fprintf(rfid,'%s',sname);
            fprintf(rfid,'\t');
            fprintf(rfid,'%d',numShared);
            fprintf(rfid,'\n'); 
        end  
    end
end
fclose(rfid);

dfid = fopen('DiseasesP.txt','wt');
for i = 2:dn
    for j = 1:i-1
        numShared = tnWdd(i,j);
        if(numShared>0)
            fname =char(Wdname(i));
            fprintf(dfid,'%s',fname);
            fprintf(dfid,'\t');
            sname = char(Wdname(j));
            fprintf(dfid,'%s',sname);
            fprintf(dfid,'\t');
            fprintf(dfid,'%d',numShared);
            fprintf(dfid,'\n'); 
        end  
    end
end
fclose(dfid);
clc;

crfid = fopen('DrugsC.txt','w');
fclose(crfid);
diary('DrugsC.txt');
diary on
!java -jar "cluster_one-1.0.jar"  "DrugsP.txt" -F csv
diary off

cdfid = fopen('DiseasesC.txt','w');
fclose(cdfid);
diary('DiseasesC.txt');
diary on
!java -jar "cluster_one-1.0.jar"  "DiseasesP.txt" -F csv
diary off

%extract cluster results from the DrugsC.txt and DiseasesC.txt;
ClusterDrugs = cell(100,1);
ClusterDrugsQuality = size(100,1);
crfid = fopen('DrugsC.txt','r');
flag = 0;
drugcluster_n = 0;
while(true)
    tline = fgetl(crfid);
    if(tline==-1)
        break;
    end
    if(flag==1)
        while(true)
            tline = fgetl(crfid);
            if(tline==-1)
                break;
            end
            linestr = regexp(tline,',','split');
            quality = linestr(6);
            pvalue = linestr(7);
            quality = str2double(quality);
            pvalue = str2double(pvalue);

            if(pvalue<0.1)
                m_clusterstr =char(linestr(8));
                m_clusterstr = strtrim(m_clusterstr);
                m_clusterstr(1) = [];
                cstrlen = size(m_clusterstr,2);
                m_clusterstr(cstrlen) = [];
                
                drugcluster_n = drugcluster_n+1;
                ClusterDrugs{drugcluster_n} = m_clusterstr; 
                ClusterDrugsQuality(drugcluster_n) = quality;
            end  
        end
    end
    if(flag==1)
        break;
    end
    if(size(strfind(tline,'Detected'),1)~=0)
        flag = 1;
    end
end
fclose(crfid);
ClusterDiseases = cell(100,1);
ClusterDiseasesQuality = size(100,1);
cdfid = fopen('DiseasesC.txt','r');
flag = 0;
diseasecluster_n = 0;
while(true)
    tline = fgetl(cdfid);
    if(tline==-1)
        break;
    end
    if(flag==1)
        while(true)
            tline = fgetl(cdfid);
            if(tline==-1)
                break;
            end
            linestr = regexp(tline,',','split');
            quality = linestr(6);
            pvalue = linestr(7);
            quality = str2double(quality);
            pvalue = str2double(pvalue);
            
            if(pvalue<0.1)
                m_clusterstr =char(linestr(8));
                m_clusterstr = strtrim(m_clusterstr);
                m_clusterstr(1) = [];
                cstrlen = size(m_clusterstr,2);
                m_clusterstr(cstrlen) = [];
                
                diseasecluster_n = diseasecluster_n+1;
                ClusterDiseases{diseasecluster_n} = m_clusterstr;
                ClusterDiseasesQuality(diseasecluster_n) = quality;
            end  
        end
    end
    if(flag==1)
        break;
    end
    if(size(strfind(tline,'Detected'),1)~=0)
        flag = 1;
    end
end
fclose(cdfid);

RWrr = Wrr;
drugPos = zeros(100,1);
for i = 2:dr
    num = 1;
    cfname = char(Wrname(i));
    for m = 1:drugcluster_n
        ctline = ClusterDrugs{m};
        if(size(strfind(ctline,cfname),1)~=0)
            drugPos(num) = m;
            num = num +1;
        end
    end
    if(num>1)
        for j=1:i-1
            Rquality = 0;
            csname = char(Wrname(j));
            tflag = 0;

            for n=1:num-1
                cindex = drugPos(n);
                sctline = ClusterDrugs{cindex};
                if(size(strfind(sctline,csname),1)~=0)
                    tflag =1;
                    if(Rquality<ClusterDrugsQuality(cindex))
                        Rquality = ClusterDrugsQuality(cindex);
                    end
                end
            end
            if(tflag==1)
                RWrr(i,j) = (1+Rquality) * Wrr(i,j);
                if(RWrr(i,j)>=1)
                    RWrr(i,j) = 0.99;
                end
                if(RWrr(i,j)<Rquality)
                    RWrr(i,j) = Rquality;
                end
                if(RWrr(i,j)>=1)
                    RWrr(i,j) = 0.99;
                end
            end
        end
    end   
end
for i=1:dr
    for j=i+1:dr
        RWrr(i,j) = RWrr(j,i);
    end
end
RWdd = Wdd;
diseasePos = zeros(100,1);
for i = 2:dn
    num = 1;
    cfname = char(Wdname(i));
    for m = 1:diseasecluster_n
        ctline = ClusterDiseases{m};
        if(size(strfind(ctline,cfname),1)~=0)
            diseasePos(num) = m;
            num = num +1;
        end
    end
    if(num>1)
       for j=1:i-1
            csname = char(Wdname(j));
            tflag = 0;
            Rquality = 0;
            for n=1:num-1
                cindex = diseasePos(n);
                sctline = ClusterDiseases{cindex};
                if(size(strfind(sctline,csname),1)~=0)
                    tflag =1;
                    if(Rquality<ClusterDiseasesQuality(cindex))
                        Rquality = ClusterDiseasesQuality(cindex);
                    end
                end
            end
            if(tflag==1)
                RWdd(i,j) = (1+Rquality)*Wdd(i,j);
                if(RWdd(i,j)>=1)
                    RWdd(i,j) = 0.99;
                end

                if(RWdd(i,j)<Rquality)
                    RWdd(i,j) = Rquality;
                end
                if(RWdd(i,j)>=1)
                    RWdd(i,j) = 0.99;
                end
            end
        end 
    end
end
for i=1:dn
    for j=i+1:dn
        RWdd(i,j) = RWdd(j,i);
    end
end

for i=1:dr
    RWrr(i,i)=1;
end

for i=1:dn
    RWdd(i,i)=1;
end
end

