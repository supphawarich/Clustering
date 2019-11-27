clc;
clear;

load synResultsSilhouetteClu1_synthetic720_16JUL2019.mat
Sil = ([OTBsynthetic720Sil.Jaccard,OTBsynthetic720Sil.AdjustRand,OTBsynthetic720Sil.FM,OTBsynthetic720Sil.Rand]);

load synResultsDEODAClu1_synthetic720_25AUG2019_V1.mat
DEODA = ([OTBsynthetic720DEODA.Jaccard,OTBsynthetic720DEODA.AdjustRand,OTBsynthetic720DEODA.FM,OTBsynthetic720DEODA.Rand]);

x = Sil;
y = DEODA;
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

TTEST720Synthetic = table(H,P,CI,Tstat,Df,Sd, ...
          'RowNames',Lastname);
      
      save('Clustering Projects/T-Test_AUG2019/Results T-Test/synResultSynthetic_T-Test_25AUG2019_V1.mat','TTEST720Synthetic');
