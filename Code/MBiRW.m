Wrr = importdata('DrugSimMat');
Wdd = importdata('DiseaseSimMat');
Wrname = importdata('DrugsName');
Wdname = importdata('DiseasesName');
Wdr = importdata('DiDrAMat');
Wrd = Wdr';
A = Wrd;

alpha = 0.3;
l = 2;
r = 2;
d = log(9999);

dn = size(Wdd,1);
dr = size(Wrr,1);

newWrr = importdata('shareWrr.mat');
newWdd = importdata('shareWdd.mat');
      
LWrr = Wrr;
LWdd = Wdd;
cr = setparFun(Wrd,LWrr);
cd = setparFun(Wdr,LWdd);

LWrr = 1./(1+exp(cr*LWrr+d));
LWdd = 1./(1+exp(cd*LWdd+d));

[RWrr,RWdd] = nManiCluester(LWrr,LWdd,newWrr,newWdd,Wrname,Wdname);

normWrr = normFun(RWrr);
normWdd = normFun(RWdd);

R0 = A/sum(A(:));
Rt = R0;

for t=1:max(l,r)
    ftl = 0;
    ftr = 0;
    
    if(t<=l)
        nRtleft = alpha * normWrr*Rt + (1-alpha)*R0;
        ftl = 1;
    end
    if(t<=r)
        nRtright = alpha * Rt * normWdd + (1-alpha)*R0;
        ftr = 1;
    end
    Rt =  (ftl*nRtleft + ftr*nRtright)/(ftl + ftr);
end

save('Wrd_result.mat','Rt');

