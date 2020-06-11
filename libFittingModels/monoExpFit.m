% mono exp fit with outlier detection
function output = monoExpFit(input)
    % parameters
    ADCstart     = 1.0e-4;
    areaMinLimit = 1e-5;
    fitFunc = @(para,bAx) para(1)*exp(-para(2).*bAx);

    input.metabName
    lb = [0   0];
    ub = [inf inf];
    if (sum(input.area > areaMinLimit) > 1)
        % remove areas with zero values
        areaZeroExclMatrix = (input.area < areaMinLimit);
        input.area(areaZeroExclMatrix)    = [];
        input.sdArea(areaZeroExclMatrix)  = [];
        input.bValues(areaZeroExclMatrix) = [];
        if input.weightedFit
            weighting = 1./input.sdArea ./ max(1./input.sdArea);
        end
        if ~input.weightedFit
            weighting = ones(size(input.sdArea));
        end
        %weighting = input.sdAdrea ./ max(input.sdAdrea);

        % first fit for defining exclution range
        %opts = optimset('Display','off');
        %[fitRes,resNorm,resid,exitFlag,out,lambda,j] = lsqcurvefit(fitFunc,para,input.bValues,input.area,lb,ub,opts);
    	s = warning('error','stats:nlinfit:Overparameterized');
        try
            para(1) = input.area(1);
            para(2) = ADCstart;            
            opt     = statset('nlinfit');
            opt.MaxIter      = 300;
            opt.Lower        = [0   0];
            opt.Upper        = [inf inf];
            opt.RobustWgtFun = [];
            opt.Method       = 'NonlinearLeastSquares';
            %[fitRes,resid,j] = nlinfit(input.bValues(input.valueList), input.area(input.valueList), fitFunc, para,opt,'Weights',weighting(input.valueList));
            [fitRes,resid,j] = nlinfit(input.bValues, input.area, fitFunc, para,opt,'Weights',weighting);
            [yFitw, deltaw]  = nlpredci(fitFunc,input.bValues,fitRes,resid,j);
            upErrUncorr      = yFitw + deltaw;
            lwErrUncorr      = yFitw - deltaw;
            
            if ((input.debugLevel == 1) | (input.debugLevel == 2))
                xgrid = linspace(min(input.bValues),max(input.bValues),100)';
                [yFitw, deltaw] = nlpredci(fitFunc,xgrid,fitRes,resid,j);
                figure('name',['first fit: ' input.metabName]);
                plot(input.bValues,input.area,'ko', xgrid,yFitw,'b-',xgrid,yFitw+deltaw,'b:',xgrid,yFitw-deltaw,'b:');
                axHdl = gca;
                axHdl.YScale     = 'log';
                axHdl.YGrid      = 'on';
                axHdl.YMinorGrid = 'on';
                axHdl.XGrid      = 'on';
                axHdl.XMinorGrid = 'on';
                xlabel('diffusion weighting [s/mm²]');
                ylabel('area [a.u.]');
            end

            ciadc = nlparci(fitRes,resid,j);
            err   = abs(ciadc(:,2) - ciadc(:,1))/2;
            output.s0     = fitRes(1);
            output.s0Err  = err(1);
            output.adc    = fitRes(2);
            output.adcErr = err(2);

            % second fit only with reasonable values
            if input.outlierCor
                %upErrUncorr = fitFunc([fitRes(1)+1/input.exclFac*err(1) fitRes(2)-1/input.exclFac*err(2)],input.bValues);
                %lwErrUncorr = fitFunc([fitRes(1)-1/input.exclFac*err(1) fitRes(2)+1/input.exclFac*err(2)],input.bValues);

                areaOutlierExclMatrixUp = (input.area > upErrUncorr);
                areaOutlierExclMatrixLw = (input.area < lwErrUncorr);

                input.area(areaOutlierExclMatrixUp    | areaOutlierExclMatrixLw) = [];
                input.bValues(areaOutlierExclMatrixUp | areaOutlierExclMatrixLw) = [];
                weighting(areaOutlierExclMatrixUp     | areaOutlierExclMatrixLw) = [];
            end
            para(1) = fitRes(1);
            para(2) = fitRes(2);            
            %[fitRes,resNorm,resid,exitFlag,out,lambda,j] = lsqcurvefit(fitFunc,para,input.bValues,input.area,lb,ub,opts);
            [fitRes,resid,j] = nlinfit(input.bValues, input.area, fitFunc, para,opt,'Weights',weighting);
            
            if ((input.debugLevel == 2) & (input.outlierCor))
                xgrid = linspace(min(input.bValues),max(input.bValues),100)';
                [yFitw, deltaw] = nlpredci(fitFunc,xgrid,fitRes,resid,j);
                figure('name',['second fit: ' input.metabName]);
                plot(input.bValues,input.area,'ko', xgrid,yFitw,'b-',xgrid,yFitw+deltaw,'b:',xgrid,yFitw-deltaw,'b:');
                axHdl = gca;
                axHdl.YScale     = 'log';
                axHdl.YGrid      = 'on';
                axHdl.YMinorGrid = 'on';
                axHdl.XGrid      = 'on';
                axHdl.XMinorGrid = 'on';
                xlabel('diffusion weighting [s/mm²]');
                ylabel('area [a.u.]');               
            end

            ciadc = nlparci(fitRes,resid,'jacobian',j);
            err   = abs(ciadc(:,2) - ciadc(:,1))/2;
            output.fit(1,:)   = linspace(min(input.bValues),max(input.bValues),100);
            output.fit(2,:)   = fitFunc([fitRes(1) fitRes(2)],linspace(min(input.bValues),max(input.bValues),100)');
            output.s0Corr     = fitRes(1);
            output.s0ErrCorr  = err(1);
            output.adcCorr    = fitRes(2);
            output.adcErrCorr = err(2);
        catch
            output.fit    = NaN;
            output.s0     = NaN;
            output.s0Err  = NaN;
            output.adc    = NaN;
            output.adcErr = NaN;

            output.s0Corr     = NaN;
            output.s0ErrCorr  = NaN;
            output.adcCorr    = NaN;
            output.adcErrCorr = NaN;             
        end
        warning(s);
    else
        output.fit    = NaN;
        output.s0     = NaN;
        output.s0Err  = NaN;
        output.adc    = NaN;
        output.adcErr = NaN;

        output.s0Corr     = NaN;
        output.s0ErrCorr  = NaN;
        output.adcCorr    = NaN;
        output.adcErrCorr = NaN;        
    end
end