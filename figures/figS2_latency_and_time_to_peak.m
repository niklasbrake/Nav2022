function fig = main

load('C:\Users\brake\Documents\GitHub\Nav2022\data\modelling\latency_time_to_peak.mat')

fig = figureNB(4,4);
h = scatter(output.t0(:),output.t2p(:),5,'filled');
h.MarkerFaceAlpha = 0.1
set(gca,'xscale','log')
set(gca,'yscale','log')
xlabel('Median first latency (ms)');
ylabel('Peak time (ms)');
xlim([0.01,10])
ylim([0.01,10])
gcaformat;