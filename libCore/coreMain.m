function result = coreMain(para)
    gamma = 42.577; % MHz/T
    disp_out( prepHeading('simulation','=',65), para.outputHdl );
    for itxGrad = 1:length(para.bValues)
        tic;
        % calculate b-value by integration
        %if (size(para.gradShapeObj.grad1,1)==1)
        %    G_int_t_x = cumsum(Gmax_x(itxGrad)*[shapeObj.grad1 -shapeObj.grad2]*1e-3)*stepWidth*1e-6;
        %    G_int_t_y = cumsum(Gmax_y(itxGrad)*[shapeObj.grad1 -shapeObj.grad2]*1e-3)*stepWidth*1e-6;
        %    G_int_t_z = cumsum(Gmax_z(itxGrad)*[shapeObj.grad1 -shapeObj.grad2]*1e-3)*stepWidth*1e-6;
        %    simRes(itxGrad).bValue = (2*pi*gamma)^2*(trapz((G_int_t_x).^2) + trapz((G_int_t_y).^2) +  trapz((G_int_t_z).^2))*stepWidth*1e-6*1e6;
        %    grad1(1,:) = shapeObj.grad1;
        %    grad1(2,:) = shapeObj.grad1;
        %    grad1(3,:) = shapeObj.grad1;
        %    grad2(1,:) = shapeObj.grad2;
        %    grad2(2,:) = shapeObj.grad2;
        %    grad2(3,:) = shapeObj.grad2;
        %elseif (size(shapeObj.grad1,1)==3)

            scaling = sqrt(para.bValues(itxGrad)/para.gradShapeObj.refBValue());
            G_int_t_x = cumsum(scaling*[para.gradShapeObj.grad1(1,:) -para.gradShapeObj.grad2(1,:)]*1e-3)*para.stepWidth*1e-6;
            G_int_t_y = cumsum(scaling*[para.gradShapeObj.grad1(2,:) -para.gradShapeObj.grad2(2,:)]*1e-3)*para.stepWidth*1e-6;
            G_int_t_z = cumsum(scaling*[para.gradShapeObj.grad1(3,:) -para.gradShapeObj.grad2(3,:)]*1e-3)*para.stepWidth*1e-6;
            simRes(itxGrad).bValue = (2*pi*gamma)^2*(trapz((G_int_t_x).^2) + trapz((G_int_t_y).^2) +  trapz((G_int_t_z).^2))*para.stepWidth*1e-6*1e6;
            grad1(1,:) = para.gradShapeObj.grad1(1,:);
            grad1(2,:) = para.gradShapeObj.grad1(2,:);
            grad1(3,:) = para.gradShapeObj.grad1(3,:);
            grad2(1,:) = para.gradShapeObj.grad2(1,:);
            grad2(2,:) = para.gradShapeObj.grad2(2,:);
            grad2(3,:) = para.gradShapeObj.grad2(3,:);
        %end
        disp_out([num2str(itxGrad) '. b-Value: '  num2str(simRes(itxGrad).bValue) ' s/mm² | Gmax: (' num2str(round(max(abs(scaling*[para.gradShapeObj.grad1(1,:) -para.gradShapeObj.grad2(1,:)])),1)) ',' num2str(round(max(abs(scaling*[para.gradShapeObj.grad1(2,:) -para.gradShapeObj.grad2(2,:)])),1)) ',' num2str(round(max(abs(scaling*[para.gradShapeObj.grad1(3,:) -para.gradShapeObj.grad2(3,:)])),1)) ') mT/m'], para.outputHdl );
        %drawnow limitrate nocallbacks

        %calculate scaling factor
        if (para.autoScale)
            pctMax = 0.95; % if signal loss is 95% use maximum of points
            %maxPts = maxNrMol;
            maxPts = para.maxNoPart;
            bLimit = -log(1-pctMax)/para.ADC;
            raise  = bLimit/5;
            % use Fermi distribution
            nrMol = round(maxPts*(1-1/(exp((simRes(itxGrad).bValue-bLimit)/raise)+1)));
            if (nrMol > maxPts)
                nrMol = maxPts;
                disp_out([sprintf('\t') 'WARNING: maximum number of particles reached!'], para.outputHdl );
            end
            if (nrMol < para.minNoPart)
                nrMol = para.minNoPart;
            end
        else
            nrMol = maxNrMol;
        end
        disp_out([sprintf('\t') 'Total number of simulated particles: ' num2str(nrMol)], para.outputHdl );
        tmp = horzcat(para.rstCollect{:});
        noPartFrac = round([tmp(:).Frac]/100*nrMol);
        nameFrac   = {tmp(:).Name}';
        %for itxFrac = 1:length(tmp)
        %end

        totPartCount = 1;
        for itxCmp = 1:length(para.rstCollect)
            disp_out([sprintf('\t\tRunning compartment ') sprintf( '%s %s particles (%s%%)', ['"' nameFrac{itxCmp} '" with'], num2str(noPartFrac(itxCmp)), num2str(tmp(itxCmp).Frac) )], para.outputHdl );
            %drawnow limitrate %nocallbacks
            rstObj = [];
            rstObj = para.rstCollect{itxCmp}.rstShapeObj;
            rstObj.setNoMol(noPartFrac(itxCmp));
            % generate VoI
            if (strcmp(para.repPara,'store'))
                randStorage(itxGrad).spinDist = rng;
            elseif (strcmp(para.repPara,'apply'))
                rng(randStorage(itxGrad).spinDist);
            end
            rDist = (-para.VoI/2 + (para.VoI+para.VoI)/2*rand(noPartFrac(itxCmp),3))*1e-3;
            %if ( debugging & ((debugLevel==2)))
            %    if (para.VoI==0)
            %        lim = 1;
            %    else
            %        lim = para.VoI/2;
            %    end
                %figure;
                %scatter3(rDist(:,1),rDist(:,2),rDist(:,3));
                %xlim([-lim*(1+0.1)*1e-3 lim*(1+0.1)*1e-3]);
                %ylim([-lim*(1+0.1)*1e-3 lim*(1+0.1)*1e-3]);
                %zlim([-lim*(1+0.1)*1e-3 lim*(1+0.1)*1e-3]);
                %xlabel('x [m]');
                %ylabel('y [m]');
                %zlabel('z [m]');
                %title(['initial spin distribution at b=' num2str(round(simRes(itxGrad).bValue)) 's/mm²']);
            %end

            % 24/10/2019 = new object structure for restrictions = AD ->
            %rstPara.noMol   = nrMol;

            % TODO: iterate over all compartements!!!!! (only for testing with one compartement)
            % <-

            % initialize parameters
            rStart    = rstObj.DstFunc();
            rInit     = rStart;
            rTheo     = rStart;
            rTheoRest = rStart;

            initPhase = repmat([0],noPartFrac(itxCmp),1);
            initSpin  = exp(i*initPhase);

            time1     = 0;
            time2     = 0;

            % time evolution before the 180? pulse
            %sigmaEvM = repmat(sigmaEv, 1, 1, nrMol);
            if (strcmp(para.repPara,'store'))
                randStorage(itxGrad).grad1 = rng;
            elseif (strcmp(para.repPara,'apply'))
                rng(randStorage(itxGrad).grad1);
            end
            randR = normrnd(0,sqrt(2*para.ADC*1e-6*para.stepWidth*1e-6),[3 length(grad1) noPartFrac(itxCmp)]);

            for itxEv = 1:length(grad1)
                drawnow limitrate
                data = guidata( findall(0,'Type','figure', 'Name', 'DIF | SIM') );
                    %disp(data.simStatus);
                if strcmp( data.simStatus, 'sig_break')
                    result = cell(0);
                    data.simStatus = 'stopped';
                    return ;
                    %disp(data.simStatus);
                    %data.simStatus = 'stopped';
                end
                rTheo       = rTheo + (squeeze(randR(:,itxEv,:))');
                rTheoRest   = rstObj.RstFunc(rTheoRest, (squeeze(randR(:,itxEv,:))'));
                %moPara.part = 1; moPara.time = time1; moPara.stepWidth = stepWidth; moPara.nrSteps = length(shapeObj.grad1); moPara.grad = [Gmax_x(itxGrad)*shapeObj.grad1(itxEv) Gmax_y(itxGrad)*shapeObj.grad1(itxEv) Gmax_z(itxGrad)*shapeObj.grad1(itxEv)]; moPara.gradMax = [Gmax_x(itxGrad) Gmax_y(itxGrad) Gmax_z(itxGrad)];
                %rStart(:,:) =  motionFunc( (disFunc(rTheoRest-rInit)+rDist) ,moPara); % new
                rStart(:,:) =  rstObj.DisFunc(rTheoRest-rInit)+rDist; % without motion

                initSpin = initSpin.*exp(i*para.stepWidth*1e-6*2*pi*gamma*1e6*1e-3*dot(repmat([scaling*grad1(1,itxEv) scaling*grad1(2,itxEv) scaling*grad1(3,itxEv)],noPartFrac(itxCmp),1),rStart,2));
                time1    = time1 + para.stepWidth;
            end
            % apply 180? refocussing pulse
            %initSpin = initSpin*(exp(i*pi));
            %initSpin = conj(initSpin);%*(exp(i*pi));

            % time evolution after the 180? pulse
            if (strcmp(para.repPara,'store'))
                randStorage(itxGrad).grad2 = rng;
            elseif (strcmp(para.repPara,'apply'))
                rng(randStorage(itxGrad).grad2);
            end
            randR = normrnd(0,sqrt(2*para.ADC*1e-6*para.stepWidth*1e-6),[3 length(grad2) noPartFrac(itxCmp)]);

            for itxEv = 1:length(grad2)
                drawnow limitrate
                data = guidata( findall(0,'Type','figure', 'Name', 'DIF | SIM') );
                    %disp(data.simStatus);
                if strcmp( data.simStatus, 'sig_break')
                    result = cell(0);
                    data.simStatus = 'stopped';
                    return;
                    %disp('sig');
                    %data.simStatus = 'stopped';
                end
                rTheo       = rTheo + (squeeze(randR(:,itxEv,:))');
                rTheoOld    = rTheoRest;
                rTheoRest   = rstObj.RstFunc(rTheoRest, (squeeze(randR(:,itxEv,:))'));
                %moPara.part = 2; moPara.time = time2; moPara.stepWidth = stepWidth; moPara.nrSteps = length(shapeObj.grad2); moPara.grad = [Gmax_x(itxGrad)*shapeObj.grad2(itxEv) Gmax_y(itxGrad)*shapeObj.grad2(itxEv) Gmax_z(itxGrad)*shapeObj.grad2(itxEv)]; moPara.gradMax = [Gmax_x(itxGrad) Gmax_y(itxGrad) Gmax_z(itxGrad)];
                %rStart(:,:) =  motionFunc( (disFunc(rTheoRest-rInit)+rDist) ,moPara); % new
                rStart(:,:) =  rstObj.DisFunc(rTheoRest-rInit)+rDist; % new

                initSpin = initSpin.*exp(-i*para.stepWidth*1e-6*2*pi*gamma*1e6*1e-3*dot(repmat([scaling*grad2(1,itxEv) scaling*grad2(2,itxEv) scaling*grad2(3,itxEv)],noPartFrac(itxCmp),1),rStart,2));
                %initSpin = initSpin.*exp(i*stepWidth*1e-6*2*pi*gamma*1e6*1e-3*dot(repmat([Gmax_x(itxGrad)*shapeObj.grad2(itxEv) Gmax_y(itxGrad)*shapeObj.grad2(itxEv) Gmax_z(itxGrad)*shapeObj.grad2(itxEv)],nrMol,1),rStart,2));
                time2    = time2 + para.stepWidth;
            end

            % store data of first FID point
            for itxSpins = 1:noPartFrac(itxCmp)
                simRes(itxGrad).Amp(totPartCount)             = initSpin(itxSpins);%exp(i*initPhase(itxSpins));  %%%%
                simRes(itxGrad).rSquare(totPartCount)         = norm(rTheo(itxSpins,:)-rInit(itxSpins,:))^2;
                simRes(itxGrad).rSquareRest(totPartCount)     = norm(rTheoRest(itxSpins,:)-rInit(itxSpins,:))^2;
                simRes(itxGrad).rSquareRestDisp(totPartCount) = norm(rStart(itxSpins,:)-rDist(itxSpins,:))^2;
                totPartCount = totPartCount+1;
            end
        end
        
        %simRes(itxGrad).grad         = Gmax(itxGrad);
        simRes(itxGrad).ADCfree      = mean(simRes(itxGrad).rSquare(:))/((time1+time2)*1e-6)/6*1e6;
        %simRes(itxGrad).errorADCfree = std(simRes(itxGrad).rSquare(:))/((time1+time2)*1e-6)/6*1e6;       % Gauss error propagation (SD as absolute error)
        simRes(itxGrad).ADCrest      = mean(simRes(itxGrad).rSquareRest(:))/((time1+time2)*1e-6)/6*1e6;
        %simRes(itxGrad).errorADCrest = std(simRes(itxGrad).rSquareRest(:))/((time1+time2)*1e-6)/6*1e6;   % Gauss error propagation (SD as absolute error)
        simRes(itxGrad).ADCrestdisp      = mean(simRes(itxGrad).rSquareRestDisp(:))/((time1+time2)*1e-6)/6*1e6;

        %fprintf('ADCfree:\t%0.2e mm²/s\n',   simRes(itxGrad).ADCfree);
        %fprintf('ADCrest:\t%0.2e mm²/s\n',   simRes(itxGrad).ADCrest);
        %fprintf('ADCrestdisp:\t%0.2e mm²/s\n', simRes(itxGrad).ADCrestdisp);
        
        disp_out([sprintf('\t') sprintf( '%-15s%0.2e mm²/s', 'ADCfree: ', simRes(itxGrad).ADCfree) ], para.outputHdl );
        disp_out([sprintf('\t') sprintf( '%-15s%0.2e mm²/s', 'ADCrest: ', simRes(itxGrad).ADCrest) ], para.outputHdl );
        disp_out([sprintf('\t') sprintf( '%-15s%0.2e mm²/s', 'ADCrestdisp: ', simRes(itxGrad).ADCrestdisp )], para.outputHdl );
        
        
        disp_out(['Runtime needed: ' num2str(toc()) ' s'], para.outputHdl );
        disp_out('================================================', para.outputHdl );
        %scroll(para.outputHdl,'bottom');
        %drawnow limitrate %nocallbacks
    end
    result = simRes;
end