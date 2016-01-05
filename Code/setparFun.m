function [ c ] = setparFun( AssMat,SimMat )
    %num indicates the 
    dnum = size(SimMat,1);
    
    %S_Mat stores the analysis results of datasets SimMat based on AssMat;
    S_Mat = zeros(10,1);
    
    s1 = 0 ;
    s2 =0;
    s3 = 0;
    s4=0;
    s5= 0;
    s6 =0;
    s7 = 0;
    s8 =0;
    s9 =0;
    s10 =0;

    n1 = 0 ;
    n2 =0;
    n3 = 0;
    n4=0;
    n5= 0;
    n6 =0;
    n7 = 0;
    n8 =0;
    n9 =0;
    n10 =0;
    %firstly, we statistic anaylze the percentage of drug or disease pairs in different similarity values;
    %and put the analysis results in S_Mat;
    for i = 2:dnum
        for j=1:i-1
           sValue = SimMat(i,j);
                if(sValue<0.1)
                    s1 = s1+1;
                end
                if((sValue>=0.1)&&(sValue<0.2))
                    s2 = s2+1;
                end
                if((sValue>=0.2)&&(sValue<0.3))
                    s3 = s3+1;
                end
                if((sValue>=0.3)&&(sValue<0.4))
                    s4 = s4+1;
                end
                if((sValue>=0.4)&&(sValue<0.5))
                    s5 = s5+1;
                end
                if((sValue>=0.5)&&(sValue<0.6))
                    s6 = s6+1;
                end
                if((sValue>=0.6)&&(sValue<0.7))
                    s7 = s7+1;
                end
                if((sValue>=0.7)&&(sValue<0.8))
                    s8 = s8+1;
                end
                if((sValue>=0.8)&&(sValue<0.9))
                    s9 = s9+1;
                end
                if((sValue>=0.9)&&(sValue<=1))
                    s10 = s10+1;
                end
        end
    end

    for i = 2:dnum
        for j = 1:i-1
            sValue = SimMat(i,j);
            sharedValue = sum(AssMat(i,:).*AssMat(j,:));
            
            if(sharedValue>=1)
                if(sValue<0.1)
                    n1 = n1+1;
                end
                if((sValue>=0.1)&&(sValue<0.2))
                    n2 = n2+1;
                end
                if((sValue>=0.2)&&(sValue<0.3))
                    n3 = n3+1;
                end
                if((sValue>=0.3)&&(sValue<0.4))
                    n4 = n4+1;
                end
                if((sValue>=0.4)&&(sValue<0.5))
                    n5 = n5+1;
                end
                if((sValue>=0.5)&&(sValue<0.6))
                    n6 = n6+1;
                end
                if((sValue>=0.6)&&(sValue<0.7))
                    n7 = n7+1;
                end
                if((sValue>=0.7)&&(sValue<0.8))
                    n8 = n8+1;
                end
                if((sValue>=0.8)&&(sValue<0.9))
                    n9 = n9+1;
                end
                if((sValue>=0.9)&&(sValue<=1))
                    n10 = n10+1;
                end
            end
        end
    end
    S_Mat(1) = n1/s1;
    S_Mat(2) = n2/s2;
    S_Mat(3) = n3/s3;
    S_Mat(4) = n4/s4;
    S_Mat(5) = n5/s5;
    S_Mat(6) = n6/s6;
    S_Mat(7) = n7/s7;
    S_Mat(8) = n8/s8;
    S_Mat(9) = n9/s9;
    S_Mat(10) = n10/s10;
    
    %Secondly, for randomized similarity matrix;
    %we statistic anaylze the percentage of drug or disease pairs in different similarity values;
    %and put the analysis results in R_Mat;
    RresultMat = zeros(10,10);
    %for drug similarity matrix,statistic the percentage of the drug pairs in
    %each similarity bins which share diseases;
    for num = 1:10
        s1 = 0 ;
        s2 =0;
        s3 = 0;
        s4=0;
        s5= 0;
        s6 =0;
        s7 = 0;
        s8 =0;
        s9 =0;
        s10 =0;

        n1 = 0 ;
        n2 =0;
        n3 = 0;
        n4=0;
        n5= 0;
        n6 =0;
        n7 = 0;
        n8 =0;
        n9 =0;
        n10 =0;
        %Manipulate SimMat,permute half of the SimMat;
        m = 1;
        rsum = dnum*(dnum-1)/2;
        %dMat stores all similarity values;
        dMat = zeros(1,rsum);
        for i = 2:dnum
            for j=1:i-1
                dMat(m) = SimMat(i,j);
                m = m+1;
            end
        end
        %permute the dMat matrix based on fisher shuffle algorithm;
        for i = 1:rsum
            j = randi([i,rsum],1,1);
            temp = dMat(j);
            dMat(j) = dMat(i);
            dMat(i) = temp;
        end
        %modify SimMat based on the shuffling results;
        m = 1;
        for i = 2:dnum
            for j=1:i-1
                SimMat(i,j) = dMat(m);
                m = m+1;
            end
        end

        for i = 2:dnum
            for j=1:i-1
                sValue = SimMat(i,j);
                if(sValue<0.1)
                    s1 = s1+1;
                end
                if((sValue>=0.1)&&(sValue<0.2))
                    s2 = s2+1;
                end
                if((sValue>=0.2)&&(sValue<0.3))
                    s3 = s3+1;
                end
                if((sValue>=0.3)&&(sValue<0.4))
                    s4 = s4+1;
                end
                if((sValue>=0.4)&&(sValue<0.5))
                    s5 = s5+1;
                end
                if((sValue>=0.5)&&(sValue<0.6))
                    s6 = s6+1;
                end
                if((sValue>=0.6)&&(sValue<0.7))
                    s7 = s7+1;
                end
                if((sValue>=0.7)&&(sValue<0.8))
                    s8 = s8+1;
                end
                if((sValue>=0.8)&&(sValue<0.9))
                    s9 = s9+1;
                end
                if((sValue>=0.9)&&(sValue<=1))
                    s10 = s10+1;
                end
            end
        end

        for i = 2:dnum
            for j = 1:i-1
                sValue = SimMat(i,j);
                sharedValue = sum(AssMat(i,:).*AssMat(j,:));

                if(sharedValue>=1)
                    if(sValue<0.1)
                        n1 = n1+1;
                    end
                    if((sValue>=0.1)&&(sValue<0.2))
                        n2 = n2+1;
                    end
                    if((sValue>=0.2)&&(sValue<0.3))
                        n3 = n3+1;
                    end
                    if((sValue>=0.3)&&(sValue<0.4))
                        n4 = n4+1;
                    end
                    if((sValue>=0.4)&&(sValue<0.5))
                        n5 = n5+1;
                    end
                    if((sValue>=0.5)&&(sValue<0.6))
                        n6 = n6+1;
                    end
                    if((sValue>=0.6)&&(sValue<0.7))
                        n7 = n7+1;
                    end
                    if((sValue>=0.7)&&(sValue<0.8))
                        n8 = n8+1;
                    end
                    if((sValue>=0.8)&&(sValue<0.9))
                        n9 = n9+1;
                    end
                    if((sValue>=0.9)&&(sValue<=1))
                        n10 = n10+1;
                    end
                end
            end
        end

        RresultMat(num,1) = n1/s1;
        RresultMat(num,2) = n2/s2;
        RresultMat(num,3) = n3/s3;
        RresultMat(num,4) = n4/s4;
        RresultMat(num,5) = n5/s5;
        RresultMat(num,6) = n6/s6;
        RresultMat(num,7) = n7/s7;
        RresultMat(num,8) = n8/s8;
        RresultMat(num,9) = n9/s9;
        RresultMat(num,10) = n10/s10;
    end
    %R_Mat stores the analysis results of randomized datasets;
    R_Mat = mean(RresultMat);
    
    threshold_Value = 0;
    
    for i = 1:10
       result_p = S_Mat(i);
       result_pr = R_Mat(i);
       if(result_p>=1*result_pr)
           threshold_Value = i*0.1;
           break;
       end
    end
    
    c = (log(99)-log(9999))/threshold_Value;
end

