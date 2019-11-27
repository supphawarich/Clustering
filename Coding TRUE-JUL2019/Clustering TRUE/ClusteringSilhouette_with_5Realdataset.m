% The 3 version is usable.

clear;
clc;


load synResultsClustering_RealdataUCI_5Dataset_18JUL2019-1.mat
%load synResultsClustering_RealdataUCI_20DatasetV2-1.mat %1 Note TEST FN
% This is default ^^^^
%load synResultsClustering_720dataGV2-4.mat
load RealUCI_20datasetv2.mat %1

TSE(1) = datetime('now','TimeZone','Asia/Bangkok','Format','d-MMM-y HH:mm:ss Z');
TSE(1)


for ddset=1:20
    
     Timer = datetime('now','TimeZone','Asia/Bangkok','Format','d-MMM-y HH:mm:ss Z');
      nametable=dataUCIRealAll20ds.DataName{ddset,1};
       
    

    %datasyn=dataRS{ddset,2};%2
    %datasyn=dataRS.Data{ddset,1}.DataClu{1,1};  % Import Data from dataRS in the tablename DataClu.
    %%datasyn2=dataRS.Data{ddset,1}.DataIDX{1,1}; %Not Necessary

    datareal = RSSReal(ddset).X;
     %datareal = RSS.X{ddset,1};
   % datareal=data{ddset,2};%2
    %realIDX=RSS.idx{ddset,1}; %3
   realIDX=datareal(:,end); %3
    
    %dd=datareal(realIDX>0,1:end-1); %4
    dd=datareal(realIDX>0,1:end-1); %4
    realIDX=realIDX(realIDX>0);
    
    %realIDX=realIDX(realIDX>0);
   %%%%% plotWithG(dd,realIDX);
    saveJunk=0;%--------- inf
    Cluster = 10;
    for i=1:Cluster
        %opts = statset('Display','final');
        %[idx,c]=kmeans(dd,i,'Replicates',30); %'Options',opts
%         [idx] =  dataRS.Data{ddset,1}.DataClu{i,1}(:,end); %Add load IDX from dataRS.mat
%         [c] = dataRS.Data{ddset,1}.DataCentroid{i,1};   %Add load DataCentroid from dataRS.mat
       
        [idx] = dataUCIRealAll20ds.Data{ddset,1}.DataIDX{i,1};
       [c] = dataUCIRealAll20ds.Data{ddset,1}.DataCentroid{i,1};   %Add load DataCentroid from dataRS.matd load DataCentroid from dataRS.mat
        
        ss=silhouette(dd,idx);
        sums(i,:)=mean(ss);

%         if (myInd.maxScore<=saveJunk)  %Complete fn
%             saveKbest = i;
%             saveJunk = myInd.maxScore;
%             saveIDX = idx;
%             saveCentroid = c;
%         end
%         
         if (mean(ss)>=saveJunk)  %Complete fn
                saveKbest = i;
                saveJunk = mean(ss);
                saveIDX = idx;
                saveCentroid = c;
         end
        
    end
           % ourIdx=kmeans(dd,saveKbest);
            valid_external(realIDX,saveIDX);
            result_valid = ans;
%         
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
            
OTBRealUCI5Silhouette(ddset,:) = table(DataName,KBest,Score,IDX,Centroid,Jaccard,AdjustRand,FM,Rand,StartDate);

ddset

end

save('Clustering Projects/Results TRUE-JUL2019/Results Clustering-TRUE/synResultsSilhouetteClu1_Realdataset5_18JUL2019-1.mat','OTBRealUCI5Silhouette');

TSE(2) = datetime('now','TimeZone','Asia/Bangkok','Format','d-MMM-y HH:mm:ss Z');
TSE(2)
%end


%'Replicates' — Number of times to repeat clustering using new initial cluster centroid position