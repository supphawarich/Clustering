clear;
clc;

load synthetic_720data.mat %1

TSE(1) = datetime('now','TimeZone','Asia/Bangkok','Format','d-MMM-y HH:mm:ss Z');
TSE(1)

for ddset=1:720
    
    nametable=data(ddset,1);
   % cutN = countcell(data,ddset);
   % N = size(data{ddset,2}); %view size data
    %cutN = (N(2)-1);
    
    datasyn=data{ddset,2};%2
    realIDX=datasyn(:,end); %3
    dd=datasyn(realIDX>0,1:end-1); %4
    %realIDX=realIDX(realIDX>0);
   %%%%% plotWithG(dd,realIDX);
    saveJunk=inf;%---------
    Cluster = 10;
    for i=1:Cluster
        %opts = statset('Display','final');
        [idx,c]=kmeans(dd,i,'Replicates',30); %'Options',opts
           DataIDX = {idx};
           %DataIDX = {idx};
           DataCentroid = {c};
        
       
        summ(i,:)= table(DataIDX,DataCentroid);
             
            DataName = (nametable);
            Data = {summ};
%             Data = [{dd},{idx},{c}];
%             IDX = {idx};
%             Centroid = {c};
%             Rand = result_valid(1);
%             AdjRand = result_valid(2);
%             Jaccard = result_valid(3);
%             FM = result_valid(4);
            
dataRS(ddset,:) = table(DataName,Data);
   
    end

ddset
end

 save('Clustering Projects/Results TRUE-JUL2019/Dataset Clustering - TRUE/synResultsClustering_720data_16JUL2019.mat','dataRS');

TSE(2) = datetime('now','TimeZone','Asia/Bangkok','Format','d-MMM-y HH:mm:ss Z');
TSE(2)
%end
