clear;
clc;

load RealUCI_20datasetv2.mat



TSE(1) = datetime('now','TimeZone','Asia/Bangkok','Format','d-MMM-y HH:mm:ss Z');
TSE(1)

for ddset=1:20
    nametable = RSSReal(ddset).name;
    kReal = RSSReal(ddset).k;
    % nametable = RSS.name{ddset,1};
    %nametable=data(ddset,1);
   % cutN = countcell(data,ddset);
   % N = size(data{ddset,2}); %view size data
    %cutN = (N(2)-1);
    
    datasyn=RSSReal(ddset).X;%2
    %datasyn=RSS.X{ddset,1};%2
%     realIDX=RSSReal(ddset).idx; %3
%     %realIDX=RSS.idx{ddset,1}; %3
%     kReal = RSSReal(ddset).k;   
%     dd=datasyn;
   %%%%%%%%

    realIDX=datasyn(:,end); %3
    dd=datasyn(realIDX>0,1:end-1); %4
    %realIDX=realIDX(realIDX>0);
   %%%%% plotWithG(dd,realIDX);
   
   %%%%%%%
    saveJunk=inf;%---------
    Cluster = 10;
    for i=1:Cluster
        %opts = statset('Display','final');
        [idx,c]=kmeans(dd,i,'Replicates',30); %'Options',opts
           DataIDX = {idx};
           %DataIDX = {idx};
           DataCentroid = {c};
        
       
        summ(i,:)= table(DataIDX,DataCentroid);
             
            DataName = {nametable};
            Data = {summ};
            kReal = (kReal);
%             Data = [{dd},{idx},{c}];
%             IDX = {idx};
%             Centroid = {c};
%             Rand = result_valid(1);
%             AdjRand = result_valid(2);
%             Jaccard = result_valid(3);
%             FM = result_valid(4);
            
dataUCIRealAll20ds(ddset,:) = table(DataName,Data,kReal);
   
    end

ddset
end

save('Clustering Projects/Results TRUE-JUL2019/Dataset Clustering - TRUE/synResultsClustering_RealdataUCI_20Dataset_16JUL2019-3.mat','dataUCIRealAll20ds');

TSE(2) = datetime('now','TimeZone','Asia/Bangkok','Format','d-MMM-y HH:mm:ss Z');
TSE(2)
%end
