% The DEODA version is usable analyze with 20 real datasets.

%1-(myInd.maxScore/totSuum{i}) fn

clear;
clc;

%TTT = RSS(:,:);
load synResultsClustering_RealdataUCI_20Dataset_12SEP2019-1.mat
%  load synResultsClustering_RealdataUCI_20DatasetV2-1.mat %1 Note TEST FN
%  % This is Default ^^^^
%load synResultsClustering_720dataGV2-4.mat
load RealUCI_20datasetv2.mat %1

TSE(1) = datetime('now','TimeZone','Asia/Bangkok','Format','d-MMM-y HH:mm:ss Z');
TSE(1)


for ddset=1:20
    Timer = datetime('now','TimeZone','Asia/Bangkok','Format','d-MMM-y HH:mm:ss Z');
   %ddset = 5;
    
    nametable=dataUCIRealAll20ds.DataName{ddset,1};


    %datasyn=dataRS{ddset,2};%2
    %datasyn=dataRS.Data{ddset,1}.DataClu{1,1};  % Import Data from dataRS in the tablename DataClu.
    %%datasyn2=dataRS.Data{ddset,1}.DataIDX{1,1}; %Not Necessary

    datareal = RSSReal(ddset).X;
     %datareal = RSS.X{ddset,1};
   % datareal=data{ddset,2};%2
    %realIDX=RSS.idx{ddset,1}; %3
    %realIDX=RSSReal(ddset).idx;
    
    
    realIDX=datareal(:,end); %3
    
    
    dd=datareal(realIDX>0,1:end-1); %4
   
    

    %dd=datareal(realIDX>0,1:end-1); %4
    
    
    realIDX=realIDX(realIDX>0);
    
    %realIDX=realIDX(realIDX>0);
   %%%%% plotWithG(dd,realIDX);
    saveJunk=0;%--------- inf
    Cluster = 10;
    
    
    for k=1:Cluster
        %opts = statset('Display','final');
       % [idx,c]=kmeans(dd,i,'Replicates',30); %'Options',opts
       %[idx] =  dataRS.Data{ddset,1}.DataClu{i,1}(:,end); %Add load IDX from dataRS.mat
       [idx] = dataUCIRealAll20ds.Data{ddset,1}.DataIDX{k,1};
       [c] = dataUCIRealAll20ds.Data{ddset,1}.DataCentroid{k,1};   %Add load DataCentroid from dataRS.mat
        myInd=WithInClusterScore(dd,idx);
        MaxScore = myInd.maxScore;
        
        %%%%%  Add from ClusteringBetweenGPV2 
        
        %[idx] =  dataRS.Data{ddset,1}.DataClu{i,1}(:,end); %Add load IDX from dataRS.mat
%         [idx] = dataUCIRealAll20ds.Data{ddset,1}.DataIDX{i,1};
%         [c] = dataUCIRealAll20ds.Data{ddset,1}.DataCentroid{i,1};   %Add load DataCentroid from dataRS.mat
%         k=i;
       %myInd=WithInClusterScore(dd,idx);
         myIndBT=BetweenClusterScorev2(dd,c,idx,k);

        suum{k}=myIndBT.scores;
    
       % totSuum(i)=max(max(suum{i}));
        totSuum{k}= min(mean(suum{k},2)); %Noted Max(mean) results is good.
        
        
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
        
        if (ns(k,:)>=saveJunk)    % NOTE FOCUS
            saveKbest = k;
            saveJunk = ns(k,:);
            saveIDX = idx;
            saveCentroid = c; 
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    end
    
    % BB=saveIDX(realIDX>0,1:end-1); %4
     %BB=datareal(realIDX>0,1:end-1); %4
    
    
   % realIDX=saveIDX(realIDX>0);
    %saveIDX=saveIDX(realIDX>=0);
           % ourIdx=kmeans(dd,saveKbest);
            valid_external(saveIDX,realIDX);
            result_valid = ans;
        
          % Create Table Name 
            DataName = {nametable};
            KBest = [saveKbest];
            Score = [saveJunk];
            IDX = {saveIDX};
            Centroid = {saveCentroid};
            Jaccard = result_valid(1);
            AdjustRand = result_valid(2);
            FM = result_valid(3);
            Rand = result_valid(4);
            StartDate = Timer;
            
OTBRealUCI20DEODA(ddset,:) = table(DataName,KBest,Score,IDX,Centroid,Jaccard,AdjustRand,FM,Rand,StartDate);

ddset

end

%save('Clustering Projects/Results TRUE-AUG2019/Results Clustering-TRUE/synResultsDEODAClu1_Realdataset20_12SEP2019_V1.mat','OTBRealUCI20DEODA');

TSE(2) = datetime('now','TimeZone','Asia/Bangkok','Format','d-MMM-y HH:mm:ss Z');
TSE(2)
%end


%'Replicates' — Number of times to repeat clustering using new initial cluster centroid position