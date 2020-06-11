% vis diffusion model
%
%%%%%%%%%%%%%%%%%%%%%%
function coreTest(para)
    %cd(fileparts(matlab.desktop.editor.getActiveFilename));

    % contains restriction models
    %addpath('libRestrictionModels/');
    %addpath('libFittingModels/');
    %addpath('libGradientShapes/');

    %TE        = 200;  % [ms]
    
    ADC       = para.freeADC;   %3e-4; % [mm²/s]
    stepWidth = para.stepWidth; %1000;  % [us]
    noPart    = para.noPart;    %20;    %
    live      = true;
    noItr     = para.noItr;     %100000;

    % chose model and initialize parameters

    % free diffusion
    %rstObj  = objFreeDiffusion();

    % cylindrical restriction
        %rstPara.InitOpt = 'fully_dispersed';
        %rstPara.InitOpt = 'parallel';
        %rstPara.mainAx  = 'Y'; % either 'X', 'Y' or 'Z'; ('Z' is default)
        
        
        %rstPara.radius  = @(n) ones([1 n])*3e-6;%10;%3e-6;
        
        
        %rstPara.radius  = 3e-6;%10;%3e-6;

        %rstPara.radius = @(n) random(makedist('Gamma','a',4,'b',100000),[1 n])/(4*100000)*1.0e-6;
    %     figure;
    %     histogram(rstPara.radius(10000) );
    %      mean(rstPara.radius(100000))
    %      median(rstPara.radius(100000))

        %rstObj          = objCylBundles(rstPara);
        
        
        %rstObj          = objSpheres(rstPara);


    %para.rstObj.Init(rstPara);
    para.rstObj.setNoMol(noPart);

    %rStart = normrnd(0,sqrt(2*ADC*1e-6*stepWidth*1e-6),[noPart 3]);%rstObj.DstFunc();
    rStart = para.rstObj.DstFunc();

    %%
    % prepare plot
    figHdl = figure('Name','Diffusion Test Trajectory','NumberTitle','off');
    subPltLft = subplot(2,2,2);
        xlabel('X [m]');
        ylabel('Y [m]');
        title('XY-plane');
        %axis equal;
    subPltMdl = subplot(2,2,4);
        xlabel('X [m]');
        ylabel('Z [m]');
        title('XZ-plane');
        %axis equal;
    subPltRgt = subplot(2,2,[1 3]);
        xlabel('X [m]');
        ylabel('Y [m]');
        zlabel('Z [m]');
        title('3D');
        axis equal;
    figHdl.Position =  [1000 100 1500 1200];
    subPltLft.Box = 'on';
    subPltMdl.Box = 'on';
    subPltRgt.Box = 'on';
    colMap = jet(noPart);

    for (itx = 1:noPart)
        % XY
        axes(subPltLft);
        hold on;
            plot(rStart(itx,1)',rStart(itx,2)','o','Color',colMap(itx,:));
        hold off;
        % XZ
        axes(subPltMdl);
        hold on;
            plot(rStart(itx,1)',rStart(itx,3)','o','Color',colMap(itx,:));
        hold off;
    end

    rndStep = rStart;

    path = [];
    path(1).value = rStart;


    for (itx = 1:noItr)
        randR  = normrnd(0,sqrt(2*ADC*1e-6*stepWidth*1e-6),[noPart 3]);
        rndStep = para.rstObj.RstFunc( rndStep, randR(:,:) );
        rndPlot = para.rstObj.DisFunc(rndStep);
        %rndPlot = rstObj.DisFunc(rndStep-rStart)+rStart;

        path(itx+1).value = rndPlot;

        % draw particle path
        if (live)
            axes(subPltLft);
                hold on;
                cla;
                plot( reshape(cell2mat( arrayfun(@(c) c.value(:,1), path(1), 'Uniform', 0) ),noPart,1)', reshape(cell2mat( arrayfun(@(c) c.value(:,2), path(1), 'Uniform', 0) ),noPart,1)', 'ok');
                plot( reshape(cell2mat( arrayfun(@(c) c.value(:,1), path(:), 'Uniform', 0) ),noPart,length(path))', reshape(cell2mat( arrayfun(@(c) c.value(:,2), path(:), 'Uniform', 0) ),noPart,length(path))' );
                hold off;

            axes(subPltMdl);
                hold on;
                cla;
                plot( reshape(cell2mat( arrayfun(@(c) c.value(:,1), path(1), 'Uniform', 0) ),noPart,1)', reshape(cell2mat( arrayfun(@(c) c.value(:,3), path(1), 'Uniform', 0) ),noPart,1)','ok' );
                plot( reshape(cell2mat( arrayfun(@(c) c.value(:,1), path(:), 'Uniform', 0) ),noPart,length(path))', reshape(cell2mat( arrayfun(@(c) c.value(:,3), path(:), 'Uniform', 0) ),noPart,length(path))' );
                hold off;
            axes(subPltRgt);
                hold on;
                cla;
                plot3( reshape(cell2mat( arrayfun(@(c) c.value(:,1), path(1), 'Uniform', 0) ),noPart,1)',reshape(cell2mat( arrayfun(@(c) c.value(:,2), path(1), 'Uniform', 0) ),noPart,1)', reshape(cell2mat( arrayfun(@(c) c.value(:,3), path(1), 'Uniform', 0) ),noPart,1)','ok' );
                plot3( reshape(cell2mat( arrayfun(@(c) c.value(:,1), path(:), 'Uniform', 0) ),noPart,length(path))',reshape(cell2mat( arrayfun(@(c) c.value(:,2), path(:), 'Uniform', 0) ),noPart,length(path))', reshape(cell2mat( arrayfun(@(c) c.value(:,3), path(:), 'Uniform', 0) ),noPart,length(path))' );
                hold off;

            w = waitforbuttonpress;
            switch w 
                case 1 % (keyboard press) 
                   key = get(gcf,'currentcharacter'); 
                   switch key
            %                   case 116 % 116 is lowercase t
            %                       disp('Have some tea.') 
                       case 27 % 27 is the escape key
                           disp('User pressed the escape key. I''m quitting.')
                           live = false;
                           %break % break out of the while loop
            %                   case 13 % 13 is the return key 
            %                       disp('User pressed the return key. Quitting the loop.')
            %                       break
            %                   otherwise 
            %                       % Wait for a different command. 
                   end
            end
        end
        %rndStep = rndStepNew;
    end

        axes(subPltLft);
            hold on;
            cla;
            plot( reshape(cell2mat( arrayfun(@(c) c.value(:,1), path(1), 'Uniform', 0) ),noPart,1)', reshape(cell2mat( arrayfun(@(c) c.value(:,2), path(1), 'Uniform', 0) ),noPart,1)', 'ok');
            plot( reshape(cell2mat( arrayfun(@(c) c.value(:,1), path(:), 'Uniform', 0) ),noPart,length(path))', reshape(cell2mat( arrayfun(@(c) c.value(:,2), path(:), 'Uniform', 0) ),noPart,length(path))' );
            hold off;
        axes(subPltMdl);
            hold on;
            cla;
            plot( reshape(cell2mat( arrayfun(@(c) c.value(:,1), path(1), 'Uniform', 0) ),noPart,1)', reshape(cell2mat( arrayfun(@(c) c.value(:,3), path(1), 'Uniform', 0) ),noPart,1)','ok' );
            plot( reshape(cell2mat( arrayfun(@(c) c.value(:,1), path(:), 'Uniform', 0) ),noPart,length(path))', reshape(cell2mat( arrayfun(@(c) c.value(:,3), path(:), 'Uniform', 0) ),noPart,length(path))' );
            hold off;
        axes(subPltRgt);
            hold on;
            cla;
            plot3( reshape(cell2mat( arrayfun(@(c) c.value(:,1), path(1), 'Uniform', 0) ),noPart,1)',reshape(cell2mat( arrayfun(@(c) c.value(:,2), path(1), 'Uniform', 0) ),noPart,1)', reshape(cell2mat( arrayfun(@(c) c.value(:,3), path(1), 'Uniform', 0) ),noPart,1)','ok' );
            plot3( reshape(cell2mat( arrayfun(@(c) c.value(:,1), path(:), 'Uniform', 0) ),noPart,length(path))',reshape(cell2mat( arrayfun(@(c) c.value(:,2), path(:), 'Uniform', 0) ),noPart,length(path))', reshape(cell2mat( arrayfun(@(c) c.value(:,3), path(:), 'Uniform', 0) ),noPart,length(path))' );
            hold off;
end