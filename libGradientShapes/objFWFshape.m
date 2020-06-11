%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	free wave forms (AD)
%               v 0.1
%   2019-11-05: integration of NOW toolbox for gradient optimization
%       Ref: [1] NOW:     Sjölund, J., Szczepankiewicz, F., Nilsson, M., Topgaard, D., Westin, C. F., & Knutsson, H. (2015). Constrained optimization of gradient waveforms for generalized diffusion encoding. Journal of Magnetic Resonance, 261, 157-168.
%            [2] Maxwell: Szczepankiewicz F, Westin, C?F, Nilsson M. Maxwell?compensated design of asymmetric gradient waveforms for tensor?valued diffusion encoding. Magn Reson Med. 2019;00:1–14. https://doi.org/10.1002/mrm.27828
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef objFWFshape < handle
    properties (Access = protected)
        isInitialized = false;
        % parameters from initialization
        para = struct; % required fields, TE, deltaT, alpha, noPeriods, ploarity
        
        time = [];
        tAx  = [];
        
        grad1Real = []; % extrapolated to a finer grid
        grad2Real = []; % extrapolated to a finer grid

        grad1Orig = []; % gradient before rotation
        grad2Orig = []; % gradient before rotation
        
        timeReal  = [];
        pctErr    = [];
        
        allFWFstruct     = [];
    end
    properties
        excMsg = '';
        
        grad1  = [];
        grad2  = [];
        
        powerSpec = [];
        omegaEff  = [];
        TdEff     = [];
        refBValue = [];
        
        diffType = 'FWF';
        createDocAvailable = false;
        
        currentFWFstruct = [];
        currentStructStr = '';
    end
    methods
        function Init(obj,para)
            obj.isInitialized = true;
            %obj.grad1  = [];
            %obj.grad2  = [];
            %obj.currentFWFstruct = [];
            try
                %check if all fields with correct format are available
                isa(para.TE,'double');
                isa(para.deltaT,'double');
                if (mod(para.TE,para.deltaT/1000)~=0)
                    obj.isInitialized = false;
                    obj.excMsg = 'Discretization step-width does not align with TE.';
                else
                    obj.para = para;
                end
            catch
                obj.excMsg = 'Initialization parameter is missing.';
                obj.isInitialized = false;
            end
            obj.tAx = (obj.para.deltaT*1e-6):(obj.para.deltaT*1e-6):(obj.para.TE*1e-3); % sec
            obj.checkInitStatus();
            
            % load safed wave forms
            fwfFileName  = 'gradShape.mat';
            subStructId  = 'ad_20191215';
            if ( isfile(fwfFileName) )
                tmp = load(fwfFileName,subStructId);
            else
                % create file
                tmp.(subStructId) = [];
                save(fwfFileName, '-struct', 'tmp','-v6');  % only v6 matlab files can be used on the scanner (no hdf5 support in IDEA possible!!)
                tmp = load(fwfFileName,subStructId);
            end
            obj.allFWFstruct = tmp.(subStructId);
            
            obj.createDocAvailable = false;
        end
        
        function paraOut = getPara(obj)
            paraOut = obj.para;
        end
        
        function createPlot(obj, figObj)
            hold(figObj);
            plot(figObj, [0 obj.tAx*1e3],[obj.grad1 [0;0;0] obj.grad2] ,'LineWidth',2);
            xline(figObj,0,'r');
            xline(figObj,obj.para.TE/2,'r');
            legend(figObj,'Gx','Gy','Gz');
            hold(figObj);


%             figHdl2 = figure;
%             plot(obj.powerSpec(1,:),obj.powerSpec(2,:),'LineWidth',2);
%             vline(obj.omegaEff,'r','\omega');
%             xlabel('frequency [Hz]');
%             ylabel('power spectrum');
%             axHdl = gca;
%             axHdl.FontSize = 12;
%             axHdl.Box = 'on';
%             title('PGSE resonances');

        end

        function createTensorPlot(obj, figObj)
            hold(figObj);
            cla(figObj);
            plot3(figObj, [obj.grad1(1,:) -obj.grad2(1,:)], [obj.grad1(2,:) -obj.grad2(2,:)],[obj.grad1(3,:) -obj.grad2(3,:)],'LineWidth',3);
            view(figObj,3);
            xlabel(figObj, 'x');
            ylabel(figObj, 'y');
            zlabel(figObj, 'z');
            hold(figObj);
        end        
        
        function figHdls = showPlot(obj)
            figHdl1 = figure;
            hold on;
            %plot([0 obj.timeReal*1e3],[obj.grad1Real obj.grad2Real],':k','LineWidth',1);
            plot([obj.tAx*1e3],[obj.grad1 -obj.grad2],'LineWidth',2);
            hold off;
            vline(0,'r','RF90');
            vline(obj.para.TE/2,'r','RF180');
            xlabel('time [msec]');
            ylabel('nrom grad ampl');
            axHdl = gca;
            axHdl.FontSize = 12;
            axHdl.Box = 'on';
            title('NOW gradient shape');
            legend('x','y','z');
            
%             figHdl2 = figure;
%             plot(obj.powerSpec(1,:),obj.powerSpec(2,:),'LineWidth',2);
%             vline(obj.omegaEff,'r','\omega');
%             xlabel('frequency [Hz]');
%             ylabel('power spectrum');
%             axHdl = gca;
%             axHdl.FontSize = 12;
%             axHdl.Box = 'on';
%             title('PGSE resonances');

            figHdls = [figHdl1];
        end
        function status = optimizeFWF(obj)
            problem                 = optimizationProblem;
            
            problem.gMax            = obj.para.Gmax;
            problem.sMax            = 200; % slew rate [mT/m/ms]
            problem.enforceSymmetry = 1;

            problem.durationFirstPartRequested    = 51;
            problem.durationSecondPartRequested   = 51;
            problem.durationZeroGradientRequested = 10;
            
            switch obj.para.tensorType
                case 'LTE'
                    problem.targetTensor      = eye(3);
                    problem.targetTensor(2,2) = 0;
                    problem.targetTensor(3,3) = 0;
                case 'PTE'
                    problem.targetTensor      = eye(3);
                    problem.targetTensor(3,3) = 0;
                case 'STE'
                    problem.targetTensor = eye(3);
            end
            
            problem.N = 150;

            problem.eta = 0.9; %In interval (0,1]

            problem.MaxwellIndex = obj.para.MaxwellIdx; %In units of (mT/m)^2 ms
            
            problem = optimizationProblem(problem);

            %problem.zeroGradientAtIndex = [problem.zeroGradientAtIndex 1 problem.N];
            
            [result, problem] = NOW_RUN(problem);
            
            data = guidata(findall(0,'Type','figure', 'Name', 'DIF | SIM') );
            breakFWFopt = data.progressHdl.CancelRequested || data.timerElapsed;
            close(data.progressHdl);
            
            if (~breakFWFopt)
                obj.currentFWFstruct.result      = result;
                obj.currentFWFstruct.result.type = obj.para.tensorType;
                obj.currentFWFstruct.maxAmp = problem.gMax;
                
                for ( itx=1:3 )
                    N = size(obj.currentFWFstruct.result.q,1);
                    if ( sum(abs(obj.currentFWFstruct.result.g(:,itx))) > 1e-2*max(sum(abs(obj.currentFWFstruct.result.g ))) )
                        try
                            % gradient 1
                            shape = obj.currentFWFstruct.result.g(1:round(N/2),itx);
                            idx1 = find( ( (shape==0) & [(diff(shape)~=0); 0] ) ~= 0);
                            idx2 = find( ( (shape==0) & [0; (diff(shape)~=0)] ) ~= 0);

                            obj.currentFWFstruct.grad1(itx,:) = obj.currentFWFstruct.result.g(idx1:idx2,itx)';

                            % gradient 2
                            shape = obj.currentFWFstruct.result.g(round(N/2):end,itx);
                            idx1 = find( ( (shape==0) & [(diff(shape)~=0); 0] ) ~= 0)+round(N/2)-1;
                            idx2 = find( ( (shape==0) & [0; (diff(shape)~=0)] ) ~= 0)+round(N/2)-1;

                            obj.currentFWFstruct.grad2(itx,:) = obj.currentFWFstruct.result.g((idx1):idx2,itx)';
                        catch
                            obj.currentFWFstruct.grad1(itx,:) = zeros(1,size(obj.currentFWFstruct.grad1,2));
                            obj.currentFWFstruct.grad2(itx,:) = zeros(1,size(obj.currentFWFstruct.grad2,2));                    
                        end
                    else
                        obj.currentFWFstruct.grad1(itx,:) = zeros(1,size(obj.currentFWFstruct.grad1,2));
                        obj.currentFWFstruct.grad2(itx,:) = zeros(1,size(obj.currentFWFstruct.grad2,2));                    
                    end
                end
            end
            
            
            
            status = ( ~breakFWFopt );
        end
        
        function status = save(obj,name)
            if ( ~isempty(obj.currentFWFstruct) )
                % check if name already exist
                saveDataset = true;
                if ( isfield( obj.allFWFstruct, name ) )
                    msg   = 'There is a dataset with the same name. Do you want to replace it?';
                    title = 'Replace dataset';
                    figHdl = findall(0,'Type','figure', 'Name', 'DIF | SIM');
                    uiOpt = uiconfirm(figHdl,msg,title,...
                                      'Options',{'Overwrite' 'Cancel'},...
                                      'DefaultOption',2,...
                                      'CancelOption',2,...
                                      'Icon','warning');
                    saveDataset = (uiOpt == 1);
                end
                if (saveDataset)
                    obj.allFWFstruct.(name) = obj.currentFWFstruct;

                    % load safed wave forms
                    fwfFileName  = 'gradShape.mat';
                    subStructId  = 'ad_20191215';
                    
                    tmp.(subStructId) = obj.allFWFstruct;
                    save(fwfFileName, '-struct', 'tmp','-v6');
                end
                status = true;
            else 
                status = false;
            end
        end
        
        function status = prepGrad(obj)
            if ( ~isempty(obj.currentFWFstruct) )
                obj.grad1 = [];
                obj.grad2 = [];
                for ( itx=1:3 )
                    N = size(obj.currentFWFstruct.result.q,1);
                    % gradient 1
                    if ( sum(abs(obj.currentFWFstruct.result.g(:,itx))) > 1e-2*max(sum(abs(obj.currentFWFstruct.result.g ))) )
                        try
                            shape = obj.currentFWFstruct.result.g(1:round(N/2),itx);
                            idx1 = find( ( (shape==0) & [(diff(shape)~=0); 0] ) ~= 0);
                            idx2 = find( ( (shape==0) & [0; (diff(shape)~=0)] ) ~= 0);

                            axOld = 1:size(obj.currentFWFstruct.result.g(idx1:idx2,itx));
                            axNew = linspace(1,max(axOld),size(obj.tAx,2)/2);

                            obj.grad1(itx,:) = interp1(axOld,obj.currentFWFstruct.result.g(idx1:idx2,itx),axNew,obj.para.interpolType);

                            % gradient 2
                            shape = obj.currentFWFstruct.result.g(round(N/2):end,itx);
                            idx1 = find( ( (shape==0) & [(diff(shape)~=0); 0] ) ~= 0)+round(N/2)-1;
                            idx2 = find( ( (shape==0) & [0; (diff(shape)~=0)] ) ~= 0)+round(N/2)-1;

                            axOld = 1:size(obj.currentFWFstruct.result.g((idx1):idx2,itx));
                            axNew = linspace(1,max(axOld),size(obj.tAx,2)/2);

                            obj.grad2(itx,:) = -interp1(axOld,obj.currentFWFstruct.result.g((idx1):idx2,itx),axNew,obj.para.interpolType);
                        catch
                            obj.grad1(itx,:) = zeros(1,size(obj.tAx,2)/2);
                            obj.grad2(itx,:) = zeros(1,size(obj.tAx,2)/2);                    
                        end
                    else
                        obj.grad1(itx,:) = zeros(1,size(obj.tAx,2)/2);
                        obj.grad2(itx,:) = zeros(1,size(obj.tAx,2)/2);                    
                    end
                end

                obj.grad1 = obj.grad1./max(max(abs([obj.grad1 [0;0;0] obj.grad2]),[],2));
                obj.grad2 = obj.grad2./max(max(abs([obj.grad1 [0;0;0] obj.grad2]),[],2));

                %obj.para.rotAngle

                rotMatrix = @(a,rotVec) [ rotVec(1)^2*(1-cos(a))+cos(a)                    rotVec(1)*rotVec(2)*(1-cos(a))-rotVec(3)*sin(a)  rotVec(1)*rotVec(3)*(1-cos(a))+rotVec(2)*sin(a) ; ...
                                          rotVec(2)*rotVec(1)*(1-cos(a))+rotVec(3)*sin(a)  rotVec(2)^2*(1-cos(a))+cos(a)                    rotVec(2)*rotVec(3)*(1-cos(a))-rotVec(1)*sin(a) ; ...
                                          rotVec(3)*rotVec(1)*(1-cos(a))-rotVec(2)*sin(a)  rotVec(3)*rotVec(2)*(1-cos(a))+rotVec(1)*sin(a)  rotVec(3)^2*(1-cos(a))+cos(a)                   ];
                                      
                %rotMatrix(obj.para.rotAngle,obj.para.rotAx)

                obj.grad1 = squeeze(sum(bsxfun(@times, permute(rotMatrix(deg2rad(obj.para.rotAngle),obj.para.rotAx), [3 2 1]), obj.grad1'),2))';
                obj.grad2 = squeeze(sum(bsxfun(@times, permute(rotMatrix(deg2rad(obj.para.rotAngle),obj.para.rotAx), [3 2 1]), obj.grad2'),2))';
                
                obj.calcRefBvalue();                
                
                status = true;
            else 
                status = false;
            end
        end

        function calcRefBvalue(obj)
            gamma         = 42.577; % MHz/T
            
            % b-value for FWF
            G_int_t_x = cumsum([obj.grad1(1,:) -obj.grad2(1,:)]*1e-3)*obj.para.deltaT*1e-6;
            G_int_t_y = cumsum([obj.grad1(2,:) -obj.grad2(2,:)]*1e-3)*obj.para.deltaT*1e-6;
            G_int_t_z = cumsum([obj.grad1(3,:) -obj.grad2(3,:)]*1e-3)*obj.para.deltaT*1e-6;
            obj.refBValue = (2*pi*gamma)^2*(trapz((G_int_t_x).^2) + trapz((G_int_t_y).^2) +  trapz((G_int_t_z).^2))*obj.para.deltaT*1e-6*1e6;
        end

        function gradScaleFac = getGradScaleFac(obj, bValueList)
            gradScaleFac = sqrt(bValueList/obj.refBValue);
        end        
        
        function fwfList = getFwfList(obj)
            try
                fwfList = fieldnames(obj.allFWFstruct);
            catch
                fwfList = {''};
            end
        end
        
        function setCurrentFwfStruct(obj,structStr)
            try
                obj.currentFWFstruct = obj.allFWFstruct.(structStr);
                obj.currentStructStr = structStr;
            catch
                obj.currentFWFstruct = [];
                obj.currentStructStr = '';                
            end
        end
    end
    
    methods (Access = protected)
        function checkInitStatus(obj)
            if (~obj.isInitialized)
                ME = MException('InitFailure:notInitialized', ...
                                obj.excMsg);
            end
        end
        
        function calcPara(obj)
            % calculate omega effective
            g_t   = [obj.grad1 obj.grad2]/1000;                       % [T/m]

            Fs = 1/(obj.para.deltaT*1e-6);         % Sampling frequency
            L =  size(obj.time,2);           % Length of signal

            Y = fft(g_t);
            P2 = abs(Y/L);
            P1 = P2(1:floor(L/2+1));
            P1(2:end-1) = 2*P1(2:end-1);

            f = Fs*(0:(L/2))/L;
            
            obj.powerSpec(1,:) = f;
            obj.powerSpec(2,:) = P1.^2.*f;
            obj.omegaEff       = sum(P1.^2.*f)/sum(P1.^2);
            
            obj.TdEff = obj.para.Delta-obj.para.delta/3;
            
            upsamplegrad = interp1(1:numel([obj.grad1 obj.grad2]),[obj.grad1 obj.grad2],linspace(1,numel([obj.grad1 obj.grad2]),numel([obj.grad1Real obj.grad2Real])));
            obj.pctErr = mean(sqrt(([obj.grad1Real obj.grad2Real]-upsamplegrad).^2));
        end
    end
end