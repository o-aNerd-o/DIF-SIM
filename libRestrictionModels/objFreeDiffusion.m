%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	cylinder bundles (AD)
%               v 0.1
%   2019-10-23: 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef objFreeDiffusion < handle
    properties (Access = protected)
        isInitialized = false;
        % parameters from initialization
        para = struct;        
        createDocAvailable = false;
    end
    methods
        function obj = objFreeDiffusion(para)
            % required parameters
            %   ADCfree, TE, stepwidth (deltaT)
            obj.para = para;
            obj.isInitialized = true;
            obj.createDocAvailable = true;
        end

        function setNoMol(obj,noMol)
            if ( obj.isInitialized )
                obj.para.noMol = noMol;
            end
        end
        
        function Init(obj,para)
            % required parameters
            %   ADCfree, TE, stepwidth (deltaT)
            obj.para = para;
            obj.isInitialized = true;
            obj.createDocAvailable = true;
        end
        
        function vecOut = RstFunc(obj, vecIn, vecInDelta)
            vecOut = vecIn+vecInDelta;
        end
        
        function vecOut = DstFunc(obj)
            vecOut = repmat([0 0 0],obj.para.noMol,1);
        end
        
        function vecOut = DisFunc(obj, vecIn)
            vecOut = vecIn;
        end
        
        function visDiffusion(obj)
            noMol = 3; % the number of particles that are simulated
        end
        
        function createDoc(obj)
            if (obj.createDocAvailable)
                %figHdls = obj.showPlot();
                %cleanfigure('handle',figHdls(1,1),'minimumPointsDistance', 10,'scalePrecision',0);
                %cleanfigure('handle',figHdls(1,2),'minimumPointsDistance', 10,'scalePrecision',0);
                %matlab2tikz('figurehandle',figHdls(1,1),'filename',['tmpLatexTemplate\fig\g' num2str(1) '.tikz']);
                %matlab2tikz('figurehandle',figHdls(1,2),'filename',['tmpLatexTemplate\fig\g' num2str(2) '.tikz']);
                %close(figHdls);
                newcell = { ...
                             '%\paragraph{Parameters}\noindent'                     ; ...
                             '\begin{table}[h!]'                                     ; ...
                             '\begin{tabular}{lll}'                                  ; ...
                             '\textbf{Restriction type}                        &  \multicolumn{2}{l}{no restrictions (free diffusion)}                   \\'  ; ...
                            ['$\boldsymbol{ADC_\mathrm{free}}$                 &' '\num{' sprintf('%.1e',obj.para.ADCfree) '}& $\si{\square\milli\meter\per\second}$ \\'] ; ...
                            %['\textbf{N/$\boldsymbol{\mathrm{\alpha}}$} &' sprintf('%.0f/%.0f',obj.para.noPeriods,obj.para.alpha)    '& \\'] ; ...
                            %['\textbf{TD($\boldsymbol{\omega_\mathrm{eff}}$)}&' sprintf('%.1f(%.1f)',obj.TdEff,obj.omegaEff) '& $\mathrm{ms}$($\mathrm{Hz}$) \\']; ...
                            %['\textbf{grad error}    &' '' sprintf('%.1f',obj.pctErr*100 ) '& \%' '\\']; ...
                            %['\textbf{grad momentum} &' '\multicolumn{2}{l}{$\int_{0}^{TE/2}G(t)dt=\num{' sprintf('%.1e',sum(obj.grad1)) '}$\quad\quad\quad$\int_{TE/2}^{TE}G(t)dt=\num{' sprintf('%.1e',sum(obj.grad2)) '}$}' '\\']; ...
                             '\end{tabular}' ; ...
                             '\end{table}' ; ...
                             %'\begin{figure}[htb]' ; ...
                             %'\centering' ; ...
                             %'\begin{subfigure}{.5\textwidth}' ; ...
                             %   '\centering' ; ...  
                             %   '\resizebox{1.0\textwidth}{!}{\input{fig/g1.tikz}}' ; ...
                             %'\end{subfigure}%' ; ...
                             %'\begin{subfigure}{.5\textwidth}' ; ...
                             %   '\centering' ; ...  
                             %   '\resizebox{1.0\textwidth}{!}{\input{fig/g2.tikz}}' ; ...
                             %'\end{subfigure}%' ; ...
                             %'%\caption{my figure drawn in tikz}\label{fig:myfigure}' ; ...
                             %'\end{figure}'        ; ...
                          };
                delete 'tmpLatexTemplate\rest.tex';
                R2L_Append2TexOutput('tmpLatexTemplate\rest.tex',newcell);
            end
        end        
    end
end