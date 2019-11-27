clc;
clear;

load synResultsSilhouetteClu1_Realdataset20_16JUL2019.mat
Sil = ([OTBRealUCI20.Jaccard,OTBRealUCI20.AdjustRand,OTBRealUCI20.FM,OTBRealUCI20.Rand]);

load synResultsHybridClu1_Realdataset20_16JUL2019.mat
Hybrid = ([OTBRealUCI20.Jaccard,OTBRealUCI20.AdjustRand,OTBRealUCI20.FM,OTBRealUCI20.Rand]);

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
      
      save('Clustering Projects/T-Test/Results T-Test/synResultRealdataset_T-Test_17JUL2019.mat','TTEST');
