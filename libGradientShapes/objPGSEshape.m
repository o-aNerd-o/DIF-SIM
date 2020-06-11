%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	pulsed gradients (AD)
%               v 0.1
%   2019-11-05: 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef objPGSEshape < handle
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
    end
    properties
        excMsg = '';
        
        grad1  = [];
        grad2  = [];
        
        powerSpec = [];
        omegaEff  = [];
        TdEff     = [];
        refBValue = [];
        
        diffType = 'PGSE';
        createDocAvailable = false;
    end
    methods
        function Init(obj,para)
            addpath(genpath('extSrc/matlab2tikz/'));
            obj.isInitialized = true;
            try
                %check if all fields with correct format are available
                isa(para.TE,'double');
                isa(para.delta,'double');
                isa(para.Delta,'double');
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
            obj.prepGrad();
            obj.prepRealGrad();
            obj.calcPara();
            obj.createDocAvailable = true;
        end

        function paraOut = getPara(obj)
            paraOut = obj.para;
        end
        
        function createPlot(obj, figObj)
            %figure(figObj);
            hold(figObj);
            %plot(figObj, [0 obj.timeReal*1e3],[0 obj.grad1Real obj.grad2Real],':k','LineWidth',1);
            %plot(figObj, [0 obj.tAx*1e3],[0 obj.grad1Orig obj.grad2Orig],'LineWidth',2);
            plot(figObj, [0 obj.tAx*1e3],[[0;0;0] obj.grad1 obj.grad2],'LineWidth',2);
            xline(figObj,0,'r');
            xline(figObj,obj.para.TE/2,'r');
            legend(figObj,'Gx','Gy','Gz');
            %legend(figObj,'real shape','gridded shape');
            hold(figObj);
            %vline(0,'r','RF90');
            %vline(obj.para.TE/2,'r','RF180');
            %xlabel('time [msec]');
            %ylabel('nrom grad ampl');
            %axHdl = gca;
            %axHdl.FontSize = 12;
            %axHdl.Box = 'on';
            %title('PGSE gradient shape');
            
            %figHdl2 = figure;
            %plot(obj.powerSpec(1,:),obj.powerSpec(2,:),'LineWidth',2);
            %vline(obj.omegaEff,'r','\omega');
            %xlabel('frequency [Hz]');
            %ylabel('power spectrum');
            %axHdl = gca;
            %axHdl.FontSize = 12;
            %axHdl.Box = 'on';
            %title('PGSE resonances');

            %figHdls = [figHdl1 figHdl2];
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
            plot([0 obj.timeReal*1e3],[0 obj.grad1Real obj.grad2Real],':k','LineWidth',1);
            plot([0 obj.tAx*1e3],[0 obj.grad1Orig obj.grad2Orig],'LineWidth',2);
            hold off;
            vline(0,'r','RF90');
            vline(obj.para.TE/2,'r','RF180');
            xlabel('time [msec]');
            ylabel('nrom grad ampl');
            axHdl = gca;
            axHdl.FontSize = 12;
            axHdl.Box = 'on';
            title('PGSE gradient shape');
            legend('real shape','gridded shape');
            
            figHdl2 = figure;
            plot(obj.powerSpec(1,:),obj.powerSpec(2,:),'LineWidth',2);
            vline(obj.omegaEff,'r','\omega');
            xlabel('frequency [Hz]');
            ylabel('power spectrum');
            axHdl = gca;
            axHdl.FontSize = 12;
            axHdl.Box = 'on';
            title('PGSE resonances');

            figHdls = [figHdl1 figHdl2];
        end
        function createDoc(obj)
            if (obj.createDocAvailable)
                figHdls = obj.showPlot();
                cleanfigure('handle',figHdls(1,1),'minimumPointsDistance', 10,'scalePrecision',0);
                cleanfigure('handle',figHdls(1,2),'minimumPointsDistance', 10,'scalePrecision',0);
                matlab2tikz('figurehandle',figHdls(1,1),'filename',['tmpLatexTemplate\fig\g' num2str(1) '.tikz']);
                matlab2tikz('figurehandle',figHdls(1,2),'filename',['tmpLatexTemplate\fig\g' num2str(2) '.tikz']);
                close(figHdls);
                newcell = { ...
                             '%\paragraph{Parameters}\noindent'                     ; ...
                             '\begin{table}[h!]'                                     ; ...
                             '\begin{tabular}{lll}'                                  ; ...
                             '\textbf{Gradient shape}                        &  \multicolumn{2}{l}{Pulsed Gradient spin-echo (PGSE)}                   \\'  ; ...
                            ['\textbf{TE/}$\boldsymbol{\mathrm{\Delta t}}$                 &' sprintf('%.1f/%.1f',obj.para.TE,obj.para.deltaT/1000) '& $\mathrm{ms}$ \\'] ; ...
                            ['\textbf{$\boldsymbol{\mathrm{\Delta}}$/$\boldsymbol{\mathrm{\delta}}$} &' sprintf('%.0f/%.0f',obj.para.Delta,obj.para.delta)    '& $\mathrm{ms}$ \\'] ; ...
                            ['\textbf{TD($\boldsymbol{\omega_\mathrm{eff}}$)}\tablefootnote{For PGSE there is no direct correlation between TD and $\omega_\mathrm{eff}$.} &' sprintf('%.1f(%.1f)',obj.para.Delta-obj.para.delta/3,obj.omegaEff) '& $\mathrm{ms}$($\mathrm{Hz}$) \\']; ...
                            ['\textbf{grad error}    &' '' sprintf('%.1f',obj.pctErr*100 ) '& \%' '\\']; ...
                            ['\textbf{grad momentum} &' '\multicolumn{2}{l}{$\int_{0}^{TE/2}G(t)dt=\num{' sprintf('%.1e',sum(obj.grad1)) '}$\quad\quad\quad$\int_{TE/2}^{TE}G(t)dt=\num{' sprintf('%.1e',sum(obj.grad2)) '}$}' '\\']; ...
                             '\end{tabular}' ; ...
                             '\end{table}' ; ...
                             '\begin{figure}[htb]' ; ...
                             '\centering' ; ...
                             '\begin{subfigure}{.5\textwidth}' ; ...
                                '\centering' ; ...  
                                '\resizebox{1.0\textwidth}{!}{\input{fig/g1.tikz}}' ; ...
                             '\end{subfigure}%' ; ...
                             '\begin{subfigure}{.5\textwidth}' ; ...
                                '\centering' ; ...  
                                '\resizebox{1.0\textwidth}{!}{\input{fig/g2.tikz}}' ; ...
                             '\end{subfigure}%' ; ...
                             '%\caption{my figure drawn in tikz}\label{fig:myfigure}' ; ...
                             '\end{figure}'        ; ...
                          };
                delete 'tmpLatexTemplate/grad.tex';
                R2L_Append2TexOutput('tmpLatexTemplate/grad.tex',newcell);
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
        function prepGrad(obj)
            G1 = zeros(1,ceil(((obj.para.TE/2-(obj.para.Delta+obj.para.delta)/2))/(obj.para.deltaT*1e-3)));
            G2 = ones(1,floor((obj.para.delta/(obj.para.deltaT*1e-3))));
            %G3 = zeros(1,((Delta-delta)/2)/(stepWidth*1e-3));
            G31 = zeros(1,floor(length(obj.tAx)/2)-length(G1)-length(G2));
            G32 = zeros(1,ceil (length(obj.tAx)/2)-length(G1)-length(G2));
            obj.grad1Orig = [G1 G2 G31];
            obj.grad2Orig = [G32 G2 G1];

            % prepare 3D gradients
            %obj.para.bVec = [1; 4; 3];
            if ( norm( obj.para.bVec ) ~=0 )
                normbVec = obj.para.bVec/norm(obj.para.bVec);
            else
                normbVec = [0; 0; 0];
            end
            obj.grad1 = repmat(obj.grad1Orig,3,1).*normbVec;
            obj.grad2 = repmat(obj.grad2Orig,3,1).*normbVec;

            obj.calcRefBvalue();
            % estimate TD and characteristic frequency
            obj.time  = (obj.para.deltaT:obj.para.deltaT:floor2grid(obj.para.TE*1000,obj.para.deltaT))/1e6;            
        end
        
        function prepRealGrad(obj)
            deltaT = 1;
            obj.timeReal  = (deltaT:deltaT:floor2grid(obj.para.TE*1000,deltaT))/1e6;            
            G1 = zeros(1,ceil(((obj.para.TE/2-(obj.para.Delta+obj.para.delta)/2))/(deltaT*1e-3)));
            G2 = ones(1,floor((obj.para.delta/(deltaT*1e-3))));
            %G3 = zeros(1,((Delta-delta)/2)/(stepWidth*1e-3));
            G3 = zeros(1,length(obj.timeReal)/2-length(G1)-length(G2));
            obj.grad1Real = [G1 G2 G3];
            obj.grad2Real = [G3 G2 G1];
            
            % estimate TD and characteristic frequency
        end
        
        function calcRefBvalue(obj)
            gamma         = 42.577; % MHz/T
            obj.refBValue = (2*pi*gamma)^2*( trapz((cumsum([obj.grad1Orig -obj.grad2Orig]*1e-3)*obj.para.deltaT*1e-6).^2) )*obj.para.deltaT*1e-6*1e6;
            
            % b-value for FWF
            %G_int_t_x = cumsum([obj.grad1(1,:) -obj.grad2(1,:)]*1e-3)*obj.para.deltaT*1e-6;
            %G_int_t_y = cumsum([obj.grad1(2,:) -obj.grad2(2,:)]*1e-3)*obj.para.deltaT*1e-6;
            %G_int_t_z = cumsum([obj.grad1(3,:) -obj.grad2(3,:)]*1e-3)*obj.para.deltaT*1e-6;
            %(2*pi*gamma)^2*(trapz((G_int_t_x).^2) + trapz((G_int_t_y).^2) +  trapz((G_int_t_z).^2))*obj.para.deltaT*1e-6*1e6
        end
        
        function gradScaleFac = getGradScaleFac(obj, bValueList)
            gradScaleFac = sqrt(bValueList/obj.refBValue);
        end
        
        function calcPara(obj)
            obj.powerSpec = [];
            % calculate omega effective
            g_t   = [obj.grad1Orig obj.grad2Orig]/1000;                       % [T/m]

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
            
            upsamplegrad = interp1(1:numel([obj.grad1Orig obj.grad2Orig]),[obj.grad1Orig obj.grad2Orig],linspace(1,numel([obj.grad1Orig obj.grad2Orig]),numel([obj.grad1Real obj.grad2Real])));
            obj.pctErr = mean(sqrt(([obj.grad1Real obj.grad2Real]-upsamplegrad).^2));
        end
    end
end