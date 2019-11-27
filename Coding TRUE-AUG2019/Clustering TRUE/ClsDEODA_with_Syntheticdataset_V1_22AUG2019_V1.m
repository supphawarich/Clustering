% The DEODA version is usable.

%1-(myInd.maxScore/totSuum{i}) fn
clear;
clc;

load synResultsClustering_720data_16JUL2019
load synthetic_720data.mat %1



% load Datasyn-3datas.mat
% 
% load DataORsyn-3datas.mat

%load synResultsClustering_720dataGV4-True.mat %1 Note TEST FN
% load synResultsClustering_720data_16JUL2019
% load synthetic_720data.mat %1
% 
% TSE(1) = datetime('now','TimeZone','Asia/Bangkok','Format','d-MMM-y HH:mm:ss Z');
% TSE(1)
% dataRS = Datas;
% 
% data = DataOR;

for ddset=1:720
    Timer = datetime('now','TimeZone','Asia/Bangkok','Format','d-MMM-y HH:mm:ss Z');
    
    nametable=dataRS{ddset,1};


    %datasyn=dataRS{ddset,2};%2
    %datasyn=dataRS.Data{ddset,1}.DataClu{1,1};  % Import Data from dataRS in the tablename DataClu.
    %%datasyn2=dataRS.Data{ddset,1}.DataIDX{1,1}; %Not Necessary

    
    datareal=data{ddset,2};%2
    realIDX=datareal(:,end); %3
    
    %dd=datareal(realIDX>0,1:end-1); %4
    dd=datareal(realIDX>0,1:end-1); %4
    
    realIDX=realIDX(realIDX>0);
   %%%%% plotWithG(dd,realIDX);
    saveJunk=0;%--------- inf
    Cluster = 10;
    
    for k=1:Cluster
        %opts = statset('Display','final');
       % [idx,c]=kmeans(dd,i,'Replicates',30); %'Options',opts
       %[idx] =  dataRS.Data{ddset,1}.DataClu{i,1}(:,end); %Add load IDX from dataRS.mat
       [idx] = dataRS.Data{ddset,1}.DataIDX{k,1};
       [c] = dataRS.Data{ddset,1}.DataCentroid{k,1};   %Add load DataCentroid from dataRS.mat
        myInd=WithInClusterScore(dd,idx);
        MaxScore = myInd.maxScore;
        
        %%%%%  Add from ClusteringBetweenGPV2 
        
%         %[idx] =  dataRS.Data{ddset,1}.DataClu{i,1}(:,end); %Add load IDX from dataRS.mat
%         [idx] = dataRS.Data{ddset,1}.DataIDX{i,1};
%         [c] = dataRS.Data{ddset,1}.DataCentroid{i,1};   %Add load DataCentroid from dataRS.mat
%         k=i;

%%%%%% "This is same fn "  and K is number of cluster.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       %myInd=WithInClusterScore(dd,idx);
       
         myIndBT=BetweenClusterScorev2(dd,c,idx,k);

        suum{k,:}=(myIndBT.scores);
    
       % totSuum(i)=max(max(suum{i}));
       % totSuum(k,:)= max(mean(suum{k})); %Noted Max(mean) results is
       % good. อันเก่า
       
       %%%%%%%% FN ใหม่
       
%        totSuum(k,:) = max(mean(suum{k},2)); % อันเก่า
        
        totSuum{k} = min(mean(suum{k,:},2));
        %%%%%%%%%%%%%%%%%%%%%%%
        
        
       % ns = 1-(myInd.maxScore/totSuum{i})  % Noted function hybrid WithIn
       % & Between Cluster
       
%         if (myInd.maxScore<=saveJunk)  %Complete fn
%             saveKbest = i;
%             saveJunk = myInd.maxScore;
%             saveIDX = idx;
%             saveCentroid = c;
%         end
        
          

        ns(k,:)=(1-(MaxScore/totSuum{k}));
        
        if (ns(k,:)>saveJunk)    % NOTE FOCUS
            saveKbest = k;
            saveJunk = ns(k,:);
            saveIDX = idx;
            saveCentroid = c; 
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    end
           % ourIdx=kmeans(dd,saveKbest);
            valid_external(saveIDX,realIDX);
            result_valid = ans;
        
          % Create Table Name 
            DataName = (nametable);
            KBest = [saveKbest];
            Score = [saveJunk];
            IDX = {saveIDX};
            Centroid = {saveCentroid};
            Jaccard = result_valid(1);
            AdjustRand = result_valid(2);
            FM = result_valid(3);
            Rand = result_valid(4);
            StartDate = Timer;
            
OTBsynthetic720DEODA(ddset,:) = table(DataName,KBest,Score,IDX,Centroid,Jaccard,AdjustRand,FM,Rand,StartDate);

ddset

end

save('Clustering Projects/Results TRUE-AUG2019/Results Clustering-TRUE/synResultsDEODAClu1_synthetic720_19NOV2019_V1.mat','OTBsynthetic720DEODA');

TSE(2) = datetime('now','TimeZone','Asia/Bangkok','Format','d-MMM-y HH:mm:ss Z');
TSE(2)
%end


%'Replicates' — Number of times to repeat clustering using new initial cluster centroid position