function [h,Param] = fitDistEtienne(Data,Nbin,distName)

%% GOAL
%  fit a probability distribution to dat,
%  with a plot of the fitted normalized pdf

%% INPUT
% Data: type float: size [Nx1] 
% Nbin: type integer: size : [1x1] 
% distName:  type: string : distribution type (cf. fitdist doc)

%% OUTPUT
%  h: handle of the figure
%  Param: parameters of the fitted pdf

%% SCRIPT

% force the input to be a column vector
Data = Data(:);

h = figure;
% fit data to pdf
pd = fitdist(Data,distName);
Param = pd.Params; % get mean and std
% critical values, i.e. extrema of the fitted pdf
q = icdf(pd,[0.0001,0.9999]);
% vector for abscissa
x = linspace(q(1),q(2),1000);
% histogram of  experimental data
[bincounts,bincenters]=hist(Data(:),Nbin);
% bar plot of the experimental data
hh = bar(bincenters,bincounts./sum(bincounts),[min(Data),max(Data)],'hist');
set(hh,'faceColor','r','edgeColor','r')
% Finds the range of this data.
rangex = max(Data) - min(Data); 
% Finds the width of each bin.
binwidth = rangex/Nbin;          
area = length(Data) * binwidth;
% fitted pdf normalized
y = area * pdf(pd,x)./sum(bincounts);

% plot fitted pdf
hold on 
hh1 = plot(x,y,'k-','LineWidth',3);
xlim([q(1),q(2)])
set(gcf,'units','normalized','outerposition', [0 0 1 1])
set(gcf,'color','w')
end