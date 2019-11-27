clc;
clear;

load synResultsSilhouetteClu1_Realdataset5_18JUL2019-1.mat
Sil = ([OTBRealUCI5Silhouette.Jaccard,OTBRealUCI5Silhouette.AdjustRand,OTBRealUCI5Silhouette.FM,OTBRealUCI5Silhouette.Rand]);

load synResultsHybridClu1_Realdataset5_18JUL2019-1.mat
Hybrid = ([OTBRealUCI5Hybrid.Jaccard,OTBRealUCI5Hybrid.AdjustRand,OTBRealUCI5Hybrid.FM,OTBRealUCI5Hybrid.Rand]);

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
      
      save('Clustering Projects/T-Test/Results T-Test/synResultRealdataset5UCI_T-Test_18JUL2019-1.mat','TTEST');
