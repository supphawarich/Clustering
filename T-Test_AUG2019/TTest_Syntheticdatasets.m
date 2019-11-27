clc;
clear;

load synResultsSilhouetteClu1_synthetic720_16JUL2019.mat
Sil = ([OTBsynthetic720Sil.Jaccard,OTBsynthetic720Sil.AdjustRand,OTBsynthetic720Sil.FM,OTBsynthetic720Sil.Rand]);

load synResultsHybridClu1_synthetic720_16JUL2019.mat
Hybrid = ([OTBsynthetic720.Jaccard,OTBsynthetic720.AdjustRand,OTBsynthetic720.FM,OTBsynthetic720.Rand]);

x = Sil;
y = Hybrid;
[h,p,ci,stats] = ttest(x,y)

Lastname = {'Jaccard','AdjustRand','FM','Rand'}';
% or Function
% [h,p] = ttest2(x,y,'Vartype','unequal')

            H = (h)';
            P = (p)';
            CI = [ci]';
            Tstat = (stats.tstat)';
            Df = (stats.df)';
            Sd = (stats.sd)';

TTEST = table(H,P,CI,Tstat,Df,Sd, ...
          'RowNames',Lastname);
      
      save('Clustering Projects/T-Test/Results T-Test/synResultSynthetic_T-Test_17JUL2019.mat','TTEST');
