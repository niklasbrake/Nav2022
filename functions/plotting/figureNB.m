function fig = figureNB(x,y)
    if(nargin==0)
        x = 8;
        y=8;
    end
    fig = figure('color','w','units','centimeters','ToolBar','none');
    fig.Position = [0,0,x,y];
    set(fig,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[x,y],'Renderer','Painters');
