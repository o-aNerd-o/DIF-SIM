%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	cylinder bundles (AD)
%               v 0.1
%   2019-10-23: 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef objCylBundles < handle
    properties (Access = protected)
        isInitialized = false;
        
        % parameters from initialization
        para = struct;
        radiusNum = [];
        
        % helper parameters
        disMatrix = []; % matrices used for dispersing confinement structures
    end
    properties
        RstFunc = [];   % restriction functor:  function handle used for restrictions
        DstFunc = [];   % distribution functor: function handle used for initial distribution (depending on restrictions)
        DisFunc = [];   % dispersion functor:   function handle used for disperssion
        
        createDocAvailable = true;
    end
%     properties (Abstract)
%         uniqueFormateToken;
%     end
%     methods (Abstract)
%         readFile(file);
%     end
    methods
        function obj = objCylBundles(para)
            % options to define confinement structure
            if (strcmp(para.InitOpt,'parallel') )
                obj.InitParallel(para);
            end
            if (strcmp(para.InitOpt,'fully_dispersed') )
                obj.InitFullDispersed(para);
            end
            if (strcmp(para.InitOpt,'partially_dispersed') )
                obj.InitPartDispersed(para);
            end
        end
        
        function setNoMol(obj,noMol)
            obj.disMatrix = [];
            %if ( obj.isInitialized )
                obj.para.noMol = noMol;
                if ( isa(obj.para.radius,'function_handle') )
                    obj.radiusNum = obj.para.radius(obj.para.noMol);
                    obj.radiusNum(obj.radiusNum < 1e-8) = 1e-8; % don't allow radii smaller than 1nm (diffusion in this length scales cannot be simulated by a simple Gaussian model)
                else
                    obj.radiusNum = obj.para.radius;
                end
            %end

            switch (obj.para.InitOpt)
                case 'fully_dispersed'
                    obj.prepFullDis();
                case 'partially_dispersed'
                    obj.prepPartDis();
                case 'parallel'
                    if ( obj.para.mainAx ~= 'Z' )
                        obj.prepParaDis();
                    end
            end
            
%             if (strcmp(obj.para.InitOpt,'fully_dispersed') )
%                 obj.prepFullDis();
%             end
%             if (strcmp(obj.para.InitOpt,'partially_dispersed') )
%                 obj.prepPartDis();
%             end
            
            %obj.DisFunc = @(vecIn) obj.nonDis(vecIn);            
            
            obj.checkInitStatus();
        end
        
        
        function Init(obj,para)
            obj.isInitialized = true;
            % options to define confinement structure
            if (strcmp(para.InitOpt,'parallel') )
                obj.InitParallel(para);
            end
            if (strcmp(para.InitOpt,'fully_dispersed') )
                obj.InitFullDispersed(para);
            end
            if (strcmp(para.InitOpt,'partially_dispersed') )
                obj.InitPartDispersed(para);
            end
            obj.checkInitStatus();
        end
        % 
        %function RestFunc(varargin) end
        function createDoc(obj)
            figHdls = obj.getRstStruct();
            cleanfigure('handle',figHdls,'targetResolution', 5,'scalePrecision',0);
            matlab2tikz('figurehandle',figHdls,'filename',['tmpLatexTemplate\fig\r' num2str(1) '.tikz']);
            close(figHdls);
            newcell = { ...
                         '%\paragraph{Parameters}\noindent'                     ; ...
                         '\begin{table}[h!]'                                     ; ...
                         '\begin{tabular}{lll}'                                  ; ...
                         '\textbf{Restriction type}                        &  \multicolumn{2}{l}{cylindrical restriction}                   \\'  ; ...
                        ['$\boldsymbol{ADC_\mathrm{free}}$                 &' '\num{' sprintf('%.1e',obj.para.ADCfree)     '} & \si{\square\milli\meter\per\second} \\'] ; ...
                        ['\textbf{radius}                                  &' '\num{'  sprintf('%.1f',obj.para.radius*1e6) '} & \si{\micro\meter} \\'] ; ...
                        %['\textbf{TD($\boldsymbol{\omega_\mathrm{eff}}$)}&' sprintf('%.1f(%.1f)',obj.TdEff,obj.omegaEff) '& $\mathrm{ms}$($\mathrm{Hz}$) \\']; ...
                        %['\textbf{grad error}    &' '' sprintf('%.1f',obj.pctErr*100 ) '& \%' '\\']; ...
                        %['\textbf{grad momentum} &' '\multicolumn{2}{l}{$\int_{0}^{TE/2}G(t)dt=\num{' sprintf('%.1e',sum(obj.grad1)) '}$\quad\quad\quad$\int_{TE/2}^{TE}G(t)dt=\num{' sprintf('%.1e',sum(obj.grad2)) '}$}' '\\']; ...
                         '\end{tabular}' ; ...
                         '\end{table}' ; ...
                         '\begin{figure}[h!]' ; ...
                         '\centering' ; ...
                         %'\begin{subfigure}{.5\textwidth}' ; ...
                            '\centering' ; ...  
                            '\resizebox{1.0\textwidth}{!}{\input{fig/r1.tikz}}' ; ...
                         %'\end{subfigure}%' ; ...
                         %'\begin{subfigure}{.5\textwidth}' ; ...
                         %   '\centering' ; ...  
                         %   '\resizebox{1.0\textwidth}{!}{\input{fig/g2.tikz}}' ; ...
                         %'\end{subfigure}%' ; ...
                         %'%\caption{my figure drawn in tikz}\label{fig:myfigure}' ; ...
                         '\end{figure}'        ; ...
                      };
            delete 'tmpLatexTemplate\rest.tex';
            R2L_Append2TexOutput('tmpLatexTemplate\rest.tex',newcell);                
        end
    end
    methods (Access = protected)
        % init functions (set isInitialized) =>
        function InitParallel(obj,para)
            % check if variables are defined
            %if ( ~isfield(para,'radius') || ~isfield(para,'noMol') )
            %    obj.isInitialized = false;
            %end
            obj.para = para;
            % assign correct memberfunctions
            if (isa(obj.para.radius,'double'))                      % equal radius for all cylinders
                obj.RstFunc = @(vecIn, vecInDelta) obj.cylSglRadRst(vecIn, vecInDelta);
                if (isfield(para,'dstCnt'))
                    if (para.dstCnt)
                        obj.DstFunc = @() obj.cylNonRadDst();
                    else
                        obj.DstFunc = @() obj.cylSglRadDst();                        
                    end
                else
                    obj.DstFunc = @() obj.cylSglRadDst();
                end
            elseif (isa(obj.para.radius,'function_handle'))   % vector of radii for all cylinders
                obj.RstFunc = @(vecIn, vecInDelta) obj.cylMltRadRst(vecIn, vecInDelta);
                if (isfield(para,'dstCnt'))
                    if (para.dstCnt)
                        obj.DstFunc = @() obj.cylNonRadDst();
                    else
                        obj.DstFunc = @() obj.cylMltRadDst();                        
                    end
                else
                    obj.DstFunc = @() obj.cylMltRadDst();
                end
            else
                obj.isInitialized = false;
            end
            %if (isfield(para,'noMol'))
            %    if (isa(obj.para.radius,'function_handle'))
            %        obj.para.radius = para.radius(obj.para.noMol);
            %    end
            %    obj.para.radius(obj.para.radius < 1e-8) = 1e-8; % don't allow radii smaller than 1nm (diffusion in this length scales cannot be simulated by a simple Gaussian model)
            %    if (obj.para.mainAx ~= 'Z')
            %        obj.prepParaDis();
            %    end
            %end
            obj.DisFunc = @(vecIn) obj.nonDis(vecIn);
        end
        
        function InitFullDispersed(obj,para)
            % check if variables are defined
            if ( ~isfield(para,'radius') )
                obj.isInitialized = false;
            end
            obj.para = para;
            % generate matrix required for full dispersed structures
            if (isa(obj.para.radius,'double'))                      % equal radius for all cylinders
                obj.RstFunc = @(vecIn, vecInDelta) obj.cylSglRadRst(vecIn, vecInDelta);
                if (isfield(para,'dstCnt'))
                    if (para.dstCnt)
                        obj.DstFunc = @() obj.cylNonRadDst();
                    else
                        obj.DstFunc = @() obj.cylSglRadDst();                        
                    end
                else
                    obj.DstFunc = @() obj.cylSglRadDst();
                end
            elseif (isa(obj.para.radius,'function_handle'))   % vector of radii for all cylinders
                obj.RstFunc = @(vecIn, vecInDelta) obj.cylMltRadRst(vecIn, vecInDelta);
                if (isfield(para,'dstCnt'))
                    if (para.dstCnt)
                        obj.DstFunc = @() obj.cylNonRadDst();
                    else
                        obj.DstFunc = @() obj.cylMltRadDst();                        
                    end
                else
                    obj.DstFunc = @() obj.cylMltRadDst();
                end
            else
                obj.isInitialized = false;
            end
            
            if (isfield(para,'noMol'))
                if (isa(obj.para.radius,'function_handle'))
                    obj.para.radius = para.radius(obj.para.noMol);
                end
                obj.para.radius(obj.para.radius < 1e-8) = 1e-8;
                obj.prepFullDis();
            end
            obj.DisFunc = @(vecIn) obj.fullDis(vecIn);
        end
        
        function InitPartDispersed(obj,para)
            % check if variables are defined
            if ( ~isfield(para,'radius') )
                obj.isInitialized = false;
            end
            obj.para = para;
            
            % generate matrix required for full dispersed structures
            if (isa(obj.para.radius,'double'))                      % equal radius for all cylinders
                obj.RstFunc = @(vecIn, vecInDelta) obj.cylSglRadRst(vecIn, vecInDelta);
                if (isfield(para,'dstCnt'))
                    if (para.dstCnt)
                        obj.DstFunc = @() obj.cylNonRadDst();
                    else
                        obj.DstFunc = @() obj.cylSglRadDst();                        
                    end
                else
                    obj.DstFunc = @() obj.cylSglRadDst();
                end
            elseif (isa(obj.para.radius,'function_handle'))   % vector of radii for all cylinders
                obj.RstFunc = @(vecIn, vecInDelta) obj.cylMltRadRst(vecIn, vecInDelta);
                if (isfield(para,'dstCnt'))
                    if (para.dstCnt)
                        obj.DstFunc = @() obj.cylNonRadDst();
                    else
                        obj.DstFunc = @() obj.cylMltRadDst();                        
                    end
                else
                    obj.DstFunc = @() obj.cylMltRadDst();
                end
            else
                obj.isInitialized = false;
            end
            obj.DisFunc = @(vecIn) obj.partDis(vecIn);
        end
        % <=        
        function checkInitStatus(obj)
            if (~obj.isInitialized)
                ME = MException('InitFailure:notInitialized', ...
                                'Object was not initialized, please use "InitParallel","InitFullDispersed" or "InitPartDispersed".');
            end
        end
        
        % restriction/confinement functions
        function vecOut = cylSglRadRst(obj, vecIn, vecInDelta)
            obj.isInitialized();
            radius = obj.radiusNum; %obj.para.radius;
            center = [0 0 0];
            vecOut = vecIn + vecInDelta;

            % Now check that they are all inside circle
            isOutside = sum(bsxfun(@minus, vecOut(:,1:2), center(1,1:2)).^2, 2) > radius^2;

            % The ones that are outside should "bounce" back into the circle
            if any(isOutside)
                orig  =  vecIn(isOutside,1:2);
                new   =  vecOut(isOutside,1:2);
                delta = -vecInDelta(isOutside,1:2);

                % Find intersection of this path with the circle
                % Taken from: https://math.stackexchange.com/a/311956
                a = sum(delta.^2, 2);
                b = sum(2 .* delta .* bsxfun(@minus, orig, center(1,1:2)), 2);
                c = sum(bsxfun(@minus, orig, center(1,1:2)).^2, 2) - radius^2;

                t = (2 * c) ./ (-b + sqrt(b.^2 - 4 .* a .* c));
                if (imag(t) == 0)
                    xintersect = orig(:,1) + delta(:,1) .* t;
                    yintersect = orig(:,2) + delta(:,2) .* t;

                    % Get tangent at this intersection (slope/intercept form)
                    m = - 1 ./ ((yintersect - center(2)) ./ (xintersect - center(1)));
                    b = yintersect - m .* xintersect;

                    % "Reflect" outside points across the tangent line to "bounce" them
                    % Equations from: https://stackoverflow.com/a/3307181/670206
                    d = (new(:,1) + (new(:,2) - b) .* m) ./ (1 + m.^2);

                    vecOut(isOutside,1) = 2 * d - new(:,1);
                    vecOut(isOutside,2) = 2 .* d .* m - new(:,2) + 2 .* b;

                    % Now check that they are all inside circle
                    isOutside = sum(bsxfun(@minus, vecOut(:,1:2), center(1,1:2)).^2, 2) > radius^2;
                    if any(isOutside)
                        %vecOut(isOutside,1) = xintersect(isOutside);
                        %vecOut(isOutside,2) = yintersect(isOutside);
                        vecNorm = sqrt(sum(vecIn(isOutside,1:2).^2,2));
                        vecNorm(vecNorm==0) = 1;
                        vecOut(isOutside,1:2) = vecIn(isOutside,1:2)./vecNorm*radius*0.99;
                    end
                else
                    %vecOut(isOutside,1:2) = vecIn(isOutside,1:2);
                    vecNorm = sqrt(sum(vecIn(isOutside,1:2).^2,2));
                    vecNorm(vecNorm==0) = 1;
                    vecOut(isOutside,1:2) = vecIn(isOutside,1:2)./vecNorm*radius*0.99;
                end
            end        
        end

        function vecOut = cylMltRadRst(obj, vecIn, vecInDelta)
            % IMPORTANT: THIS IS THE WORKING EXAMPLE
            radius = obj.radiusNum; %obj.para.radius;
            center = [0 0 0];
            vecOut = vecIn + vecInDelta;

            % Now check that they are all inside circle
            isOutside = sum(bsxfun(@minus, vecOut(:,1:2), center(1,1:2)).^2, 2) > (radius.^2)';

            % The ones that are outside should "bounce" back into the circle
            if any(isOutside)        
                orig  = vecIn(isOutside,1:2);
                new   = vecOut(isOutside,1:2);
                delta =  -vecInDelta(isOutside,1:2);

                % Find intersection of this path with the circle
                % Taken from: https://math.stackexchange.com/a/311956
                a = sum(delta.^2, 2);
                b = sum(2 .* delta .* bsxfun(@minus, orig, center(1,1:2)), 2);
                c = sum(bsxfun(@minus, orig, center(1,1:2)).^2, 2) - (radius(isOutside).^2)';

                t = (2 * c) ./ (-b + sqrt(b.^2 - 4 .* a .* c));
                if (imag(t) == 0)
                    xintersect = orig(:,1) + delta(:,1) .* t;
                    yintersect = orig(:,2) + delta(:,2) .* t;

                    % Get tangent at this intersection (slope/intercept form)
                    m = - 1 ./ ((yintersect - center(2)) ./ (xintersect - center(1)));
                    b = yintersect - m .* xintersect;

                    % "Reflect" outside points across the tangent line to "bounce" them
                    % Equations from: https://stackoverflow.com/a/3307181/670206
                    d = (new(:,1) + (new(:,2) - b) .* m) ./ (1 + m.^2);

                    vecOut(isOutside,1) = 2 * d - new(:,1);
                    vecOut(isOutside,2) = 2 .* d .* m - new(:,2) + 2 .* b;

                    % Now check that they are all inside circle
                    isOutside = sum(bsxfun(@minus, vecOut(:,1:2), center(1,1:2)).^2, 2) > (radius.^2)';
                    if any(isOutside)
                        %vecOut(isOutside,1) = xintersect(isOutside);
                        %vecOut(isOutside,2) = yintersect(isOutside);
                        vecNorm = sqrt(sum(vecIn(isOutside,1:2).^2,2));
                        vecNorm(vecNorm==0) = 1;
                        vecOut(isOutside,1:2) = vecIn(isOutside,1:2)./vecNorm.*(radius(isOutside).^2)'*0.99;
                    end
                else
                    %vecOut(isOutside,1:2) = vecIn(isOutside,1:2);
                    vecNorm = sqrt(sum(vecIn(isOutside,1:2).^2,2));
                    vecNorm(vecNorm==0) = 1;
                    vecOut(isOutside,1:2) = vecIn(isOutside,1:2)./vecNorm.*(radius(isOutside).^2)'*0.99;
                end
            end        
        end
        
        % distribution functions
        function vecOut = cylNonRadDst(obj)
            obj.isInitialized();
            vecOut = repmat([0 0 0],obj.para.noMol,1);
        end

        function vecOut = cylSglRadDst(obj)
            obj.isInitialized();
            n = obj.para.noMol;
            radius = obj.radiusNum*0.95;
            xc = 0;
            yc = 0;
            
            theta = rand(1,n)*(2*pi);
            r = sqrt(rand(1,n))*radius;
            vecOut = repmat([0 0 0],n,1);
            vecOut(:,1) = xc + r.*cos(theta); vecOut(:,2) = yc + r.*sin(theta);
        end

        function vecOut = cylMltRadDst(obj)
            obj.isInitialized();
            n = obj.para.noMol;
            %radius = obj.para.radius(n)*0.95;
            radius = obj.radiusNum*0.95;
            xc = 0;
            yc = 0;
            
            theta = rand(1,n)*(2*pi);
            r = sqrt(rand(1,n)).*radius;
            vecOut = repmat([0 0 0],n,1);
            vecOut(:,1) = xc + r.*cos(theta); vecOut(:,2) = yc + r.*sin(theta);
        end
        
        % dispersion functions
        function vecOut = nonDis(obj, vecIn)
            obj.isInitialized();
            % along Z
            if ( obj.para.mainAx == 'Z')
                vecOut = vecIn;
            else
            % along X or Y
                vecOut = squeeze(sum(bsxfun(@times, permute(obj.disMatrix, [3 2 1]), vecIn),2));
            end
        end

        function vecOut = fullDis(obj, vecIn)
            obj.isInitialized();
            %vecOut = squeeze(sum(bsxfun(@times, permute(obj.disMatrix, [3 2 1]), vecIn),3));
            vecOut = squeeze(sum(bsxfun(@times, permute(obj.disMatrix, [3 2 1]), vecIn),2));
        end

        function vecOut = partDis(obj, vecIn)
            obj.isInitialized();
            %vecOut = squeeze(sum(bsxfun(@times, permute(obj.disMatrix, [3 2 1]), vecIn),3));
            vecOut = squeeze(sum(bsxfun(@times, permute(obj.disMatrix, [3 2 1]), vecIn),2));
        end        
        
        % helper functions
            % generates rotation matricis with uniformly random dispersions
            % (fully dispersed system, e.g. fibre bundles)
        function prepFullDis(obj)
            % rotation axis in 2D (xy-plane) AD ->
            TH = 2*pi*rand(1,obj.para.noMol);
            %TH = pi*rand(1,obj.para.noMol);
            %[rx,ry,rz] = sph2cart(TH,0,1);
 %           rndRotAxVec = [rx; ry; zeros(1,length(rx))]';
            % <- AD

            % rotation axis in 3D AD -> 
            PH = asin(-1+2*rand(1,obj.para.noMol));
            [rx,ry,rz] = sph2cart(TH,PH,1);

            rndRotAxVec = [rx./sqrt(rx.^2+ry.^2); ry./sqrt(rx.^2+ry.^2); zeros(1,length(rx))]';
            %rndRotAxVec = [rx; ry; zeros(1,length(rx))]';
%            rndRotAxVec = [rx; ry; rz]';
            % <- AD
            
            % TODO: 1/3 -> x, 1/3 -> y, 1/3 -> z and then apply random
            % rotation
            
%            rndRotAngle = pi*rand(1,obj.para.noMol)';
            rndRotAngle = acos(rz)';

            % ONLY FOR TESTING, REMOVE LATER AD ->
%            rndRotAxVec = [zeros(1,length(rx)); ones(1,obj.para.noMol); zeros(1,length(rx))]'; % rotation axis [0 1 0] -> y-axis
%            rndRotAngle = pi/2*ones(1,obj.para.noMol);                                         % rotation agnle 90Â°
                                                                                               % => cylinders along [1 0 0] instead [0 0 1]
            % <- AD
            
            rotMatrix = @(a,rotVec) [ rotVec(1)^2*(1-cos(a))+cos(a)                    rotVec(1)*rotVec(2)*(1-cos(a))-rotVec(3)*sin(a)  rotVec(1)*rotVec(3)*(1-cos(a))+rotVec(2)*sin(a) ; ...
                                      rotVec(2)*rotVec(1)*(1-cos(a))+rotVec(3)*sin(a)  rotVec(2)^2*(1-cos(a))+cos(a)                    rotVec(2)*rotVec(3)*(1-cos(a))-rotVec(1)*sin(a) ; ...
                                      rotVec(3)*rotVec(1)*(1-cos(a))-rotVec(2)*sin(a)  rotVec(3)*rotVec(2)*(1-cos(a))+rotVec(1)*sin(a)  rotVec(3)^2*(1-cos(a))+cos(a)                   ];

%             rotMatrix = @(a,rotVec) [ rotVec(1)^2*(1-cos(a))+cos(a);                    rotVec(1)*rotVec(2)*(1-cos(a))-rotVec(3)*sin(a);  rotVec(1)*rotVec(3)*(1-cos(a))+rotVec(2)*sin(a)  ...
%                                       rotVec(2)*rotVec(1)*(1-cos(a))+rotVec(3)*sin(a);  rotVec(2)^2*(1-cos(a))+cos(a);                    rotVec(2)*rotVec(3)*(1-cos(a))-rotVec(1)*sin(a)  ...
%                                       rotVec(3)*rotVec(1)*(1-cos(a))-rotVec(2)*sin(a);  rotVec(3)*rotVec(2)*(1-cos(a))+rotVec(1)*sin(a);  rotVec(3)^2*(1-cos(a))+cos(a)                   ];

            % we need a matrix for each molecule
            for itx = 1:obj.para.noMol
                 obj.disMatrix(:,:,itx) = rotMatrix(rndRotAngle(itx),rndRotAxVec(itx,:));
%                 if (itx < 1/3*obj.para.noMol)
%                     obj.disMatrix(:,:,itx) = rotMatrix(rndRotAngle(itx),rndRotAxVec(itx,:));
%                 elseif ( (itx > 1/3*obj.para.noMol) && (itx < 2/3*obj.para.noMol) )
%                     obj.disMatrix(:,:,itx) = rotMatrix(rndRotAngle(itx),rndRotAxVec(itx,:))*rotMatrix(pi/2,[1,0,0]);
%                 else
%                     obj.disMatrix(:,:,itx) = rotMatrix(rndRotAngle(itx),rndRotAxVec(itx,:))*rotMatrix(pi/2,[0,1,0]);
%                 end
            end
            %obj.disMatrix(:,:,round(1/3*obj.para.noMol):round(2/3*obj.para.noMol)) = bsxfun(@times,obj.disMatrix(:,:,round(1/3*obj.para.noMol):round(2/3*obj.para.noMol)),rotMatrix(pi/2,[1,0,0]));
            %obj.disMatrix(:,:,(round(2/3*obj.para.noMol)+1):end)                   = bsxfun(@times,obj.disMatrix(:,:,(round(2/3*obj.para.noMol)+1):end),rotMatrix(pi/2,[0,1,0]));
        end
        
        function prepPartDis(obj)
            % rotation axis in 2D (xy-plane) AD ->
            
            %ang = 180;%5;%15;%0.1;
            
            ang = obj.para.dispAngle;
            
            TH = ang * (-1+2*rand(1,obj.para.noMol));
            %TH = 0.2*2*pi*rand(1,obj.para.noMol);
            %TH = pi*rand(1,obj.para.noMol);
            %[rx,ry,rz] = sph2cart(TH,0,1);
 %           rndRotAxVec = [rx; ry; zeros(1,length(rx))]';
            % <- AD

            % rotation axis in 3D AD -> 
            PH = (ang/90 * asin( ( -1+2*rand(1,obj.para.noMol) )) + pi/2);
            [rx,ry,rz] = sph2cart(TH,PH,1);

            rndRotAxVec = [rx./sqrt(rx.^2+ry.^2); ry./sqrt(rx.^2+ry.^2); zeros(1,length(rx))]';
            %rndRotAxVec = [ones(1,length(rx)); zeros(1,length(rx)); zeros(1,length(rx))]';
            %rndRotAxVec = [rx; ry; zeros(1,length(rx))]';
%            rndRotAxVec = [rx; ry; rz]';
            % <- AD
            
            % TODO: 1/3 -> x, 1/3 -> y, 1/3 -> z and then apply random
            % rotation
            
            %rndRotAngle = deg2rad(ang)*20*rand(1,obj.para.noMol)';
            rndRotAngle = acos(rz)';

            % ONLY FOR TESTING, REMOVE LATER AD ->
%            rndRotAxVec = [zeros(1,length(rx)); ones(1,obj.para.noMol); zeros(1,length(rx))]'; % rotation axis [0 1 0] -> y-axis
%            rndRotAngle = pi/2*ones(1,obj.para.noMol);                                         % rotation agnle 90Â°
                                                                                               % => cylinders along [1 0 0] instead [0 0 1]
            % <- AD
            
            rotMatrix = @(a,rotVec) [ rotVec(1)^2*(1-cos(a))+cos(a)                    rotVec(1)*rotVec(2)*(1-cos(a))-rotVec(3)*sin(a)  rotVec(1)*rotVec(3)*(1-cos(a))+rotVec(2)*sin(a) ; ...
                                      rotVec(2)*rotVec(1)*(1-cos(a))+rotVec(3)*sin(a)  rotVec(2)^2*(1-cos(a))+cos(a)                    rotVec(2)*rotVec(3)*(1-cos(a))-rotVec(1)*sin(a) ; ...
                                      rotVec(3)*rotVec(1)*(1-cos(a))-rotVec(2)*sin(a)  rotVec(3)*rotVec(2)*(1-cos(a))+rotVec(1)*sin(a)  rotVec(3)^2*(1-cos(a))+cos(a)                   ];

%             rotMatrix = @(a,rotVec) [ rotVec(1)^2*(1-cos(a))+cos(a);                    rotVec(1)*rotVec(2)*(1-cos(a))-rotVec(3)*sin(a);  rotVec(1)*rotVec(3)*(1-cos(a))+rotVec(2)*sin(a)  ...
%                                       rotVec(2)*rotVec(1)*(1-cos(a))+rotVec(3)*sin(a);  rotVec(2)^2*(1-cos(a))+cos(a);                    rotVec(2)*rotVec(3)*(1-cos(a))-rotVec(1)*sin(a)  ...
%                                       rotVec(3)*rotVec(1)*(1-cos(a))-rotVec(2)*sin(a);  rotVec(3)*rotVec(2)*(1-cos(a))+rotVec(1)*sin(a);  rotVec(3)^2*(1-cos(a))+cos(a)                   ];

            % we need a matrix for each molecule
            if (obj.para.mainAx == 'X')
                rndRotAxVecMain = [zeros(1,obj.para.noMol); ones(1,obj.para.noMol); zeros(1,obj.para.noMol)]';	% rotation axis [0 1 0] -> y-axis
                rndRotAngleMain = pi/2*ones(1,obj.para.noMol);                                                  % rotation agnle 90°
                                                                                                            % => cylinders along [1 0 0] instead [0 0 1]
            end
            if (obj.para.mainAx == 'Y')
                rndRotAxVecMain = [ones(1,obj.para.noMol); zeros(1,obj.para.noMol); zeros(1,obj.para.noMol)]';	% rotation axis [1 0 0] -> y-axis
                rndRotAngleMain = pi/2*ones(1,obj.para.noMol);                                                  % rotation agnle 90°
                                                                                                            % => cylinders along [1 0 0] instead [0 0 1]
            end
            
            for itx = 1:obj.para.noMol
                if (obj.para.mainAx == 'Z')
                    obj.disMatrix(:,:,itx) = rotMatrix(rndRotAngle(itx),rndRotAxVec(itx,:));
                else
                    obj.disMatrix(:,:,itx) = mtimes(rotMatrix(rndRotAngleMain(itx),rndRotAxVecMain(itx,:)),rotMatrix(rndRotAngle(itx),rndRotAxVec(itx,:)));
                end
%                 if (itx < 1/3*obj.para.noMol)
%                     obj.disMatrix(:,:,itx) = rotMatrix(rndRotAngle(itx),rndRotAxVec(itx,:));
%                 elseif ( (itx > 1/3*obj.para.noMol) && (itx < 2/3*obj.para.noMol) )
%                     obj.disMatrix(:,:,itx) = rotMatrix(rndRotAngle(itx),rndRotAxVec(itx,:))*rotMatrix(pi/2,[1,0,0]);
%                 else
%                     obj.disMatrix(:,:,itx) = rotMatrix(rndRotAngle(itx),rndRotAxVec(itx,:))*rotMatrix(pi/2,[0,1,0]);
%                 end
            end
            %obj.disMatrix(:,:,round(1/3*obj.para.noMol):round(2/3*obj.para.noMol)) = bsxfun(@times,obj.disMatrix(:,:,round(1/3*obj.para.noMol):round(2/3*obj.para.noMol)),rotMatrix(pi/2,[1,0,0]));
            %obj.disMatrix(:,:,(round(2/3*obj.para.noMol)+1):end)                   = bsxfun(@times,obj.disMatrix(:,:,(round(2/3*obj.para.noMol)+1):end),rotMatrix(pi/2,[0,1,0]));
        end
        
        function prepParaDis(obj)
            if (obj.para.mainAx == 'X')
                rndRotAxVec = [zeros(1,obj.para.noMol); ones(1,obj.para.noMol); zeros(1,obj.para.noMol)]';	% rotation axis [0 1 0] -> y-axis
                rndRotAngle = pi/2*ones(1,obj.para.noMol);                                                  % rotation agnle 90°
                                                                                                            % => cylinders along [1 0 0] instead [0 0 1]
            end
            if (obj.para.mainAx == 'Y')
                rndRotAxVec = [ones(1,obj.para.noMol); zeros(1,obj.para.noMol); zeros(1,obj.para.noMol)]';	% rotation axis [1 0 0] -> y-axis
                rndRotAngle = pi/2*ones(1,obj.para.noMol);                                                  % rotation agnle 90°
                                                                                                            % => cylinders along [1 0 0] instead [0 0 1]
            end
            rotMatrix = @(a,rotVec) [ rotVec(1)^2*(1-cos(a))+cos(a)                    rotVec(1)*rotVec(2)*(1-cos(a))-rotVec(3)*sin(a)  rotVec(1)*rotVec(3)*(1-cos(a))+rotVec(2)*sin(a) ; ...
                                      rotVec(2)*rotVec(1)*(1-cos(a))+rotVec(3)*sin(a)  rotVec(2)^2*(1-cos(a))+cos(a)                    rotVec(2)*rotVec(3)*(1-cos(a))-rotVec(1)*sin(a) ; ...
                                      rotVec(3)*rotVec(1)*(1-cos(a))-rotVec(2)*sin(a)  rotVec(3)*rotVec(2)*(1-cos(a))+rotVec(1)*sin(a)  rotVec(3)^2*(1-cos(a))+cos(a)                   ];

            % we need a matrix for each molecule
            for itx = 1:obj.para.noMol
                 obj.disMatrix(:,:,itx) = rotMatrix(rndRotAngle(itx),rndRotAxVec(itx,:));
%                 if (itx < 1/3*obj.para.noMol)
%                     obj.disMatrix(:,:,itx) = rotMatrix(rndRotAngle(itx),rndRotAxVec(itx,:));
%                 elseif ( (itx > 1/3*obj.para.noMol) && (itx < 2/3*obj.para.noMol) )
%                     obj.disMatrix(:,:,itx) = rotMatrix(rndRotAngle(itx),rndRotAxVec(itx,:))*rotMatrix(pi/2,[1,0,0]);
%                 else
%                     obj.disMatrix(:,:,itx) = rotMatrix(rndRotAngle(itx),rndRotAxVec(itx,:))*rotMatrix(pi/2,[0,1,0]);
%                 end
            end
            %obj.disMatrix(:,:,round(1/3*obj.para.noMol):round(2/3*obj.para.noMol)) = bsxfun(@times,obj.disMatrix(:,:,round(1/3*obj.para.noMol):round(2/3*obj.para.noMol)),rotMatrix(pi/2,[1,0,0]));
            %obj.disMatrix(:,:,(round(2/3*obj.para.noMol)+1):end)                   = bsxfun(@times,obj.disMatrix(:,:,(round(2/3*obj.para.noMol)+1):end),rotMatrix(pi/2,[0,1,0]));
        end
        
            % function to visualize the structure of the confinement
        function figHdl = getRstStruct(obj)
            maxStructSize = 10*sqrt(obj.para.ADCfree*1e-6*obj.para.TE*1e-3);
            minStructSize = 1/10*sqrt(obj.para.ADCfree*1e-6*obj.para.deltaT*1e-6);
            noPart1D      = round(maxStructSize/minStructSize);
            
            TH = 2*pi*rand(1,noPart1D);
            PH = asin(-1+2*rand(1,noPart1D));
            structPts   = NaN(3,noPart1D);
            doNotChange = boolean(zeros(1,noPart1D));
            vecIn  = NaN(3,noPart1D);
            vecNew = NaN(3,noPart1D);
            vecStart = zeros(3,noPart1D);
            %vecStart(3,:) = linspace(-maxStructSize,+maxStructSize,noPart1D);
            for itxStep = 1:10000
                [vecIn(1,:)  vecIn(2,:)  vecIn(3,:) ] = sph2cart(TH, PH, (itxStep-1)*minStructSize);
                [vecNew(1,:) vecNew(2,:) vecNew(3,:)] = sph2cart(TH, PH, itxStep*minStructSize);
                deltaVec = vecNew-vecIn;
                vecOut                                      = obj.RstFunc(vecStart',deltaVec');
                vecStart = vecOut';
                tmp = (itxStep-1)*vecIn + 1/2*(vecNew-vecIn);
                %sum(any(vecOut'-(vecIn+deltaVec),1))
                structPts(:,(any(vecOut'-(vecIn+deltaVec),1) & ~doNotChange)) = tmp(:,(any(vecOut'-(vecIn+deltaVec),1) & ~doNotChange));
                doNotChange = doNotChange | any(vecOut'-(vecIn+deltaVec),1);
            end

            figHdl = figure;
            subplot(1,4,1)
            hold on;
            plot(vecStart(1,:),vecStart(2,:),'.');
            xlabel('x-axis');
            ylabel('y-axis');
            axHdl = gca;
            axHdl.LineWidth =  1;
            axHdl.Box = 'on';
            pbaspect([1 1 1]);

            subplot(1,4,2)
            hold on;
            plot(vecStart(1,:),vecStart(3,:),'.');
            xlabel('x-axis');
            ylabel('z-axis');
            axHdl = gca;
            axHdl.LineWidth =  1;
            axHdl.Box = 'on';
            pbaspect([1 1 1]);

            subplot(1,4,3)
            hold on;
            plot(vecStart(2,:),vecStart(3,:),'.');
            xlabel('y-axis');
            ylabel('z-axis');
            axHdl = gca;
            axHdl.LineWidth =  1;
            axHdl.Box = 'on';
            pbaspect([1 1 1]);
            
            subplot(1,4,4)
            hold on;
            plot3(vecStart(1,:),vecStart(2,:),vecStart(3,:),'.');
            view(3);
            xlabel('x-axis');
            ylabel('y-axis');
            zlabel('z-axis');
            axHdl = gca;
            axHdl.LineWidth =  1;
            axHdl.Box = 'on';
            pbaspect([1 1 1]);
            %axHdl.FontSize  = 12;
            figHdl.Position = [125 397 1241 241];
            pbaspect([1 1 1]);
            
%             pc = pointCloud(vecStart','Label','Confienment Reconstruction')
%             pc.plot('MarkerSize', 5);
%             pc.getVoxelHull(5);
%             pc.reconstruct();
%             pc.plot('color','y')
%             %pc.plotNormals('Scale', 10, 'Color', 'y');
%             view([-35 88])
%             colormap('red');
%             %data = rand(100,3) ;
%             figure;
%             x = vecStart(1,:)' ; y = vecStart(2,:)' ; z = vecStart(3,:)' ;
%             tri = delaunay(x, y, z)
%             dt = delaunayTriangulation(x,y) ;
%             %tri = dt.ConnectivityList ;
%             xi = dt.Points(:,1) ; yi = dt.Points(:,2) ;
%             F = scatteredInterpolant(x,y,z);
%             zi = F(xi,yi) ;
%             trisurf(tri,xi,yi,zi) 
%             view(2)
%             shading interp
% 
%             figure;
%             coeff = 0.5;
%             tri = triangulation(boundary(vecStart', coeff), vecStart');
%             trisurf(tri); colormap(jet);
%             
%             [t,tnorm]=MyRobustCrust(vecStart');
%             figure(1)
%             %subplot(1,2,2)
%             hold on
%             title('Output Triangulation','fontsize',14)
%             axis equal
%             trisurf(t,vecStart(1,:),vecStart(2,:),vecStart(3,:),'facecolor','c','edgecolor','b')%plot della superficie trattata
%             view(3);
%             axis vis3d
%             
%             [t] = MyCrustOpen(vecStart');
%             figure(1)
%             %subplot(1,2,2)
%             hold on
%             title('Output Triangulation','fontsize',14)
%             axis equal
%             trisurf(t,vecStart(1,:),vecStart(2,:),vecStart(3,:),'facecolor','c','edgecolor','b')%plot della superficie
%             axis vis3d
%             view(3)
%                         
%             figure;
%             hold on;
%             %plot3(x(1,:),x(2,:),x(3,:),'o')
%             %plot3(1.01*x(1,:),1.01*x(2,:),1.01*x(3,:),'o')
%             plot3(rx,ry,rz,'x')
%             hold off;
%             
        end
        
        % used to combine structures
        function into = mergestruct(into, from)
          %MERGESTRUCT merge all the fields of scalar structure from into scalar structure into
          validateattributes(from, {'struct'}, {'scalar'});
          validateattributes(into, {'struct'}, {'scalar'});
          fns = fieldnames(from);
          for fn = fns.'
             if isstruct(from.(fn{1})) && isfield(into, fn{1})
                  %nested structure where the field already exist, merge again
                  into.(fn{1}) = mergestruct(into.(fn{1}), from.(fn{1}));
             else
                 %non structure field, or nested structure field that does not already exist, simply copy
                 into.(fn{1}) = from.(fn{1});
             end
          end
        end
        
        function name = getClassName(obj)
            name = class(obj);
        end
    end
end