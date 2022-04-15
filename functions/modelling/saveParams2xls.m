function saveParams2xls(Params)
	% [Q,OpenPositions,P] = nav15_NB(Params);
	[Q,OpenPositions,P] = nav15_NB_wDIII_v20220330(Params);
	fn =fieldnames(P);
	pars = struct2array(P);

	parNames = cellfun(@(x) x(1:end-1),fn,'UniformOutput',false);
	[uniqueParNames,I] = unique(parNames);

	parArray = zeros(length(uniqueParNames)-4,3);

	for i = 1:length(uniqueParNames)-4
		idcs = find(cellfun(@(x) strcmp(uniqueParNames{i},x),parNames));
		parArray(i,1) = round(pars(idcs(1)),3,'significant');
		try
			parArray(i,2) = round(pars(idcs(2)),2,'significant');
		catch
			parArray(i,2) = 0;
		end
	end
	parArray(1:4,3) = round(pars(end-3:end),2,'significant');

	greekAlphabet = {'alpha';'beta';'gamma';'delta';'epsilon';'zeta';...
	'eta';'theta';'iota';'kappa';'lambda';'mu';'nu';'xi';'omicron';'pi';'rho';...
	'varsigma';'sigma';'tay';'upsilon';'phi';'xi';'psi';'omega'};


	temp = cellfun(@(x)strsplit(x,'_'),uniqueParNames,'uniformoutput',false);
	temp = cat(1,temp{:});
	column1 = cell(size(temp,1),1);
	for i = 1:size(temp,1)
		if(strcmp(temp{i,2},'alph'))
			temp{i,2} = 'alpha';
		elseif(strcmp(temp{i,2},'bet'))
			temp{i,2} = 'beta';
		end
		greekIdcs = find(cellfun(@(x)~isempty(strfind(temp{i,1},x)),greekAlphabet));
		if(~isempty(greekIdcs))
			temp{i,1} = char(944+greekIdcs(1));
		end
		greekIdcs = find(cellfun(@(x)~isempty(strfind(temp{i,2},x)),greekAlphabet));
		if(~isempty(greekIdcs))
			temp{i,2} = char(944+greekIdcs(1));
		end
		if(isempty(temp{i,2}))
			column1{i} = temp{i,1};
		else
			column1{i} = [temp{i,1} '_' temp{i,2}];
		end
		if(~isempty(strfind(column1{i},'ii')))
			column1{i} = column1{i}(2:end);
		end
	end

	xlswrite('C:\Users\brake\Documents\GitHub\Nav2022\data\modelling\parameterTable.xls',{'Rate Constant'},1,'B2');
	xlswrite('C:\Users\brake\Documents\GitHub\Nav2022\data\modelling\parameterTable.xls',column1(1:end-4),1,'B3')
	xlswrite('C:\Users\brake\Documents\GitHub\Nav2022\data\modelling\parameterTable.xls',{'k*'},1,'C2');
	xlswrite('C:\Users\brake\Documents\GitHub\Nav2022\data\modelling\parameterTable.xls',parArray(:,1),1,'C3');
	xlswrite('C:\Users\brake\Documents\GitHub\Nav2022\data\modelling\parameterTable.xls',{'q'},1,'D2');
	xlswrite('C:\Users\brake\Documents\GitHub\Nav2022\data\modelling\parameterTable.xls',parArray(:,2),1,'D3');
	xlswrite('C:\Users\brake\Documents\GitHub\Nav2022\data\modelling\parameterTable.xls',{'Cooperativity Factor'},1,'E2');
	xlswrite('C:\Users\brake\Documents\GitHub\Nav2022\data\modelling\parameterTable.xls',column1(end-3:end),1,'E3')
	xlswrite('C:\Users\brake\Documents\GitHub\Nav2022\data\modelling\parameterTable.xls',parArray(1:4,3),1,'F3');