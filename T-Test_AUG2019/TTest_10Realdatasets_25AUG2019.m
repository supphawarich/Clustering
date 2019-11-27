clc;
clear;

load synResultsSilhouetteClu1_Realdataset10_25AUG2019_V2.mat
Sil = ([OTBRealUCI10Sil.Jaccard,OTBRealUCI10Sil.AdjustRand,OTBRealUCI10Sil.FM,OTBRealUCI10Sil.Rand]);

load synResultsDEODAClu1_Realdataset10_25AUG2019_V2.mat
DEODA = ([OTBRealUCI10DEODA.Jaccard,OTBRealUCI10DEODA.AdjustRand,OTBRealUCI10DEODA.FM,OTBRealUCI10DEODA.Rand]);

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

TTEST10Real = table(H,P,CI,Tstat,Df,Sd, ...
          'RowNames',Lastname);
      
      save('Clustering Projects/T-Test_AUG2019/Results T-Test/synResultReal_T-Test_25AUG2019_V1.mat','TTEST10Real');
