%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	cylinder bundles (AD)
%               v 0.1
%   2019-10-23: 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef objSpheres < handle
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
        function obj = objSpheres(para)
            % required parameter at construction are:
            %   para.radius -> single radius or radii function
            %   para.dstCnt -> distribution centered (true = particles
            %                  start at [0,0,0], false = particles randomly 
            %                  distributed in confinement [DEFAULT])
            
            if ( isfield(para,'radius') )
                obj.para = para;
                
                % unique radius (equal for all spheres)
                if (isa(obj.para.radius,'double'))
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
                % probability distribution of radii (function handle)
                elseif (isa(obj.para.radius,'function_handle'))
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
                obj.isInitialized = true;
            else
                obj.isInitialized = false;
            end
        end

        function setNoMol(obj,noMol)
            if ( obj.isInitialized )
                obj.para.noMol = noMol;
                if (isa(obj.para.radius,'function_handle'))
                    obj.radiusNum = obj.para.radius(obj.para.noMol);
                    obj.radiusNum(obj.radiusNum < 1e-8) = 1e-8; % don't allow radii smaller than 1nm (diffusion in this length scales cannot be simulated by a simple Gaussian model)
                else
                    obj.radiusNum = obj.para.radius;
                end
%                 if (obj.para.mainAx ~= 'Z')
%                     obj.prepParaDis();
%                 end
            end
            obj.DisFunc = @(vecIn) obj.nonDis(vecIn);            
            
            obj.checkInitStatus();
        end

        function Init(obj,para)
            obj.isInitialized = true;

            % check if variables are defined
            if ( ~isfield(para,'radius') || ~isfield(para,'noMol') )
                obj.isInitialized = false;
            end
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
            if (isfield(para,'noMol'))
                if (isa(obj.para.radius,'function_handle'))
                    obj.para.radius = para.radius(obj.para.noMol);
                end
                obj.para.radius(obj.para.radius < 1e-8) = 1e-8; % don't allow radii smaller than 1nm (diffusion in this length scales cannot be simulated by a simple Gaussian model)
%                 if (obj.para.mainAx ~= 'Z')
%                     obj.prepParaDis();
%                 end
            end
            obj.DisFunc = @(vecIn) obj.nonDis(vecIn);            
            
            obj.checkInitStatus();
        end
    end
    
    methods (Access = protected)
        function checkInitStatus(obj)
            if (~obj.isInitialized)
                ME = MException('InitFailure:notInitialized', ...
                                'Object was not initialized, please use "InitParallel","InitFullDispersed" or "InitPartDispersed".');
            end
        end
        
        % restriction/confinement functions
        function vecOut = cylSglRadRst(obj, vecIn, vecInDelta)
            obj.isInitialized();
            radius = obj.radiusNum;
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
            radius = obj.radiusNum;
            center = [0 0 0];
            vecOut = vecIn + vecInDelta;
            % Now check that they are all inside circle
            isOutside = sum(bsxfun(@minus, vecOut(:,1:3), center(1,1:3)).^2, 2) > (radius.^2)';

            % The ones that are outside should "bounce" back into the circle
            if any(isOutside)
                orig  = vecIn(isOutside,1:3);
                new   = vecOut(isOutside,1:3);
                delta = vecInDelta(isOutside,1:3);

                norm = -new./sqrt(sum(new.^2,2));
                deltaNew = sqrt(sum(delta.^2,2)).*( delta./sqrt(sum(delta.^2,2)) - 2*norm.*dot(norm, delta./sqrt(sum(delta.^2,2)),2) );
                
                vecOut(isOutside,:) = orig-deltaNew;
                isOutside = sum(bsxfun(@minus, vecOut(:,1:3), center(1,1:3)).^2, 2) > (radius.^2)';
                %vecOut(~isOutside) = vecOutNew(~isOutside,:);
                if any(isOutside)
                    vecOut(isOutside,:) = vecOut(isOutside,:)./sqrt(sum(vecOut(isOutside,:).^2,2)).*sqrt((radius(isOutside).^2))'*0.99;
                    %disp('still outside');
                end
            end
%                 % Find intersection of this path with the circle
%                 % Taken from: https://math.stackexchange.com/a/311956
%                 a = sum(delta.^2, 2);
%                 b = sum(2 .* delta .* bsxfun(@minus, orig, center(1,1:3)), 2);
%                 c = sum(bsxfun(@minus, orig, center(1,1:3)).^2, 2) - (radius(isOutside).^2)';
% 
%                 t = (2 * c) ./ (-b + sqrt(b.^2 - 4 .* a .* c));
%                 if (imag(t) == 0)
%                     xintersect = orig(:,1) + delta(:,1) .* t;
%                     yintersect = orig(:,2) + delta(:,2) .* t;
%                     zintersect = orig(:,3) + delta(:,3) .* t;
% 
%                     % Get tangent at this intersection (slope/intercept form)
%                     m = - 1 ./ ((zintersect - center(3)) ./ ((yintersect - center(2)) ./ (xintersect - center(1)));
%                     b = yintersect - m .* xintersect;
% 
%                     % "Reflect" outside points across the tangent line to "bounce" them
%                     % Equations from: https://stackoverflow.com/a/3307181/670206
%                     d = (new(:,1) + (new(:,2) - b) .* m) ./ (1 + m.^2);
% 
%                     vecOut(isOutside,1) = 2 * d - new(:,1);
%                     vecOut(isOutside,2) = 2 .* d .* m - new(:,2) + 2 .* b;
% 
%                     % Now check that they are all inside circle
%                     isOutside = sum(bsxfun(@minus, vecOut(:,1:2), center(1,1:2)).^2, 2) > ((radius.^2)'-vecIn(:,3).^2);
%                     if any(isOutside)
%                         %vecOut(isOutside,1) = xintersect(isOutside);
%                         %vecOut(isOutside,2) = yintersect(isOutside);
%                         vecNorm = sqrt(sum(vecIn(isOutside,1:2).^2,2));
%                         vecNorm(vecNorm==0) = 1;
%                         vecOut(isOutside,1:2) = vecIn(isOutside,1:2)./vecNorm.*((radius(isOutside).^2)'-vecIn(isOutside,3).^2)*0.99;
%                     end
%                 else
%                     %vecOut(isOutside,1:2) = vecIn(isOutside,1:2);
%                     vecNorm = sqrt(sum(vecIn(isOutside,1:2).^2,2));
%                     vecNorm(vecNorm==0) = 1;
%                     vecOut(isOutside,1:2) = vecIn(isOutside,1:2)./vecNorm.*((radius(isOutside).^2)'-vecIn(isOutside,3).^2)*0.99;
%                 end
%                 
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
%             % along Z
%             if ( obj.para.mainAx == 'Z')
                vecOut = vecIn;
%             else
%             % along X or Y
%                 vecOut = squeeze(sum(bsxfun(@times, permute(obj.disMatrix, [3 2 1]), vecIn),2));
%             end
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