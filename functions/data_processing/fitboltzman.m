function [fitresult, gof] = FitBoltzman(V, I,SP)
% [fitresult, gof] = FitBoltzman(V,I,Vhalf,K0) fits (V,I) with the function
% 	i = 1/(1+exp((v-v50)/k))
% fitresult is ordered as [k v50].

if(nargin<3)
    SP = struct('v50',-10,'k',-10);
end
[xData, yData] = prepareCurveData( V, I );

% Set up fittype and options.
ft = fittype( '1/(1+exp((v-v50)/k))', 'independent', 'v', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Algorithm = 'Trust-Region';
opts.DiffMaxChange = 100;
opts.Display = 'Off';
opts.MaxFunEvals = 600;
opts.MaxIter = 400;
opts.StartPoint = [SP.k SP.v50];
opts.TolFun = 1e-6;
opts.Lower = [-30 -150];
opts.Upper = [30 150];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );
