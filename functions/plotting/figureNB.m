function fig = figureNB(x,y)
    fig = figure('color','w','units','centimeters','ToolBar','none');
    fig.Position = [0,0,x,y];
    set(fig,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[x,y],'Renderer','Painters');
