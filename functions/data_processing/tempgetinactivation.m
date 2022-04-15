function [V,inact,C2,P,cap,Rseries,tau1,tau2,n,CSI,Gpre] = tempgetinactivation(folder,fig);

[cap,Rseries,difV] = getparams(folder);
load(fullfile(folder,'inactivation.mat'));
Voltage = Voltage + difV/2;
PN1 = Current(:,Epochs(7)-1e3:Epochs(7)+5e3);
PN1 = (PN1-median(PN1(:,1:1e3),2));

PN2 = Current(:,Epochs(3)-1e3:Epochs(3)+5e3);
PN2 = -(PN2-median(PN2(:,1:1e3),2));

PN = mean(0.5*(PN1*0+2*PN2));

C2 = zeros(2e3+1,size(Current,1));
Cfit2 = nan(2e3+1,size(Current,1));
Cfit1 = Cfit2;
for j = 1:size(Current,1)

    response = Current(j,Epochs(4)-1e3:Epochs(4)+5e3);
    C1(:,j) = PNsubtract(PN,response);
   	Cfit1(35:end,j) = fitHH(C1(35:end,j),-1);

    response = Current(j,Epochs(5)-1e3:Epochs(5)+5e3);
    C2(:,j) = PNsubtract(PN,response);
    [Cfit2(35:end,j),tau1(j),tau2(j),n(j)] = fitHH(C2(35:end,j),-1);

	[~,I] = min(Cfit2(:,j));
	post(j) = Cfit2(I,j);

	V(j) = Voltage(j,Epochs(4)+20);
	lag(j) = I;
end

inact = post./min(post);

FT = fitSSIcurve(V(V>-135),inact(V>-135));
P = coeffvalues(FT);
inact = 1-inact*FT.Gmx;
FT2 = fitboltzman(V,inact,struct('v50',-100,'k',-10));

idcs = zeros(size(C1));
for i = 1:size(C1,2)
    [~,i0] = max(abs(Cfit1(:,i)));
    sgn = Cfit1(i0,i);
    imax = length(C1(:,i));
    i1 = i0;
    while(and(sgn*C1(i1,i)>0,i1<imax));
        i1 = i1+1;
    end
    if(i0<500)
        idcs(i0:i1,i) = 1;
    end
    IO = [Cfit1(1:i0,i);C1(find(idcs(:,i)),i)];
    Ipre(i) = nansum(IO);
end
Ipre = Ipre./max(abs(Ipre));
FTosi = fitGVcurve(V(V<40),Ipre(V<40));
Gpre = FTosi.Gmx*Ipre./(V-FTosi.ERev);

t = -160:0.1:60;
FT3 = fitboltzman(V(V<40),Gpre(V<40));
CSI0 = FT2(t)-FT3(t);
CSI = sum(0.1*CSI0);

if(nargin==2 && ~isempty(fig))
	figure(fig);
	clf
	subplot(1,3,1);
		plot(C2(:,1:32),'color',[0.6,0.6,0.6]); hold on;
		plot(Cfit2(:,1:32),'k'); hold on;

		% plot(C1); hold on;
		ylim([min(Cfit2(:))*1.2,max(Cfit2(:))*1.2])
		scatter(lag,inact,'filled');
		xlim([0,500])
		xticks([0:100:500])
		xticklabels([0:5]);
		xlabel('Time (ms)');
		ylabel('I_{post} (pA)')
		[~,cellName] = fileparts(folder);
		title(cellName)
		drawnow;
	subplot(1,3,2);
		plot(V,1-inact,'.k','MarkerSize',20); hold on;
		% FT = FitBoltzmanCurve(V,-post./min(post)*FT.Gmx,FT.v50,FT.k,1);
		plot(V,1-FT2(V),'LineWidth',1)
		title(['V_{1/2} = ' num2str(FT.v50,3) ' mV']);
		xlabel('Voltage (mV)');
		xlim([-120,-10]);
		ylim([-0.1,1.2]);
	subplot(1,3,3);
		plot(V,inact,'k','MarkerSize',20); hold on;
		plot(V,Gpre,'b','LineWidth',1)
		plot(t,CSI0,'r')
		title(['CSI = ' num2str(CSI,3) ' mV']);
		xlabel('Voltage (mV)');
		xlim([-120,0]);
		ylim([-0.1,1.2]);
end

end

function [cap,Rseries,difV] = getparams(folder)
	difV = 0;
	[~,cellName] = fileparts(folder);
	if(~isempty(strfind(cellName,'ASM')))
		file = fullfile(folder,[cellName '.txt']);
		if(exist(file))
			% ADAMO FORMAT
			fid = fopen(file);
			txtLn = fgetl(fid);
			while(isempty(strfind(txtLn,'Cap')))
				txtLn = fgetl(fid);
			end
			temp = strsplit(txtLn,': ');
			cap = str2num(temp{2});

			fid = fopen(file);
			txtLn = fgetl(fid);
			while(isempty(strfind(txtLn,'RSeries')))
				txtLn = fgetl(fid);
			end
			temp = strsplit(txtLn,': ');
			Rseries = str2num(temp{2});
			fclose(fid);
		else
			cap = nan;
			Rseries = nan;
		end
	else
		[~,cellName] = fileparts(folder);
		file = fullfile(folder,['Params.txt']);
		if(exist(file))
			%% NIKLAS FORMAT
			fid = fopen(fullfile(folder,'params.txt'));
		    txt=textscan(fid,'%s');
		    if(length(txt{1})==2)
		    	params = cellfun(@(x)str2num(x),split(txt{1}{2},','));
		    	cap = params(1);
		    	Rseries = params(2);
		    	difV = params(3)*Rseries/1e3;
		    else
			    cap = str2num(txt{1}{6});
			    Rseries = str2num(txt{1}{3});
			    if(isempty(Rseries))
				    cap = str2num(txt{1}{4});
				    Rseries = str2num(txt{1}{6});
				    difV = str2num(txt{1}{8})*str2num(txt{1}{2})/1e3;
				end
			end
			fclose(fid);
		else
			cap = nan;
			Rseries = nan;
		end
	end
end

function pnY = PNsubtract(PNx,Y)
	ty = [zeros(1,1000),ones(1,5001)];
	FT = fitlm(ty,PNx);
	PNy = detrend(PNx-ty*FT.Coefficients{2,1});
	PNy = PNy(1e3:3e3);

	% [b,a] = butter(8,2/1e5/500e-6);
	% PNf = filtfilt(b,a,PNy);

	temp = Y-median(Y(1:1e3));
	idcs = setdiff(1:6e3,1e3:2e3);
	FT = fitlm(ty(idcs),temp(idcs));
	temp = temp-ty*FT.Coefficients{2,1};
	
	rawResponse = temp(1e3:3e3);
	FT = fitlm(PNy(1:50),rawResponse(1:50));
	A = FT.Coefficients{2,1};
	pnY = rawResponse-A*PNy;
end

function [I,tau1,tau2,n] = fitHH(C1,sgn)

    t = 1:length(C1);
    fun = fittype(@(gam1,gam2,A,x0,n,m,d,x) 0*d+(x>x0).*(A*(1 - exp(-(x-x0)*gam1)).^n.*exp(-(x-x0)*gam2).^m));

    [m,I] = max(abs(C1));
    StartPoint = [0.3,0.2,C1(I),20,2,1,0];
    Lower = [1/500,1/500,0,0,0.2,0.2,-m];
    Upper = [1,1,m*10,100,4,4,m];

    if(nargin==2)
        FT = fit(t(:),sgn*C1(:),fun,'StartPoint',StartPoint,'Lower',Lower,'Upper',Upper);
        I = sgn*FT(t);
    else     
        if(C1(I)<0)
            FT = fit(t(:),-C1(:),fun,'StartPoint',StartPoint,'Lower',Lower,'Upper',Upper);
            I = -FT(t);
        else
            FT = fit(t(:),C1(:),fun,'StartPoint',StartPoint,'Lower',Lower,'Upper',Upper);
            I = FT(t);
        end
    end
    tau1 = FT.gam1.^(-1)/100;
    tau2 = FT.gam2.^(-1)/100;
    n = FT.n;
end