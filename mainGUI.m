classdef mainGUI < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        DIFSIMUIFigure                  matlab.ui.Figure
        tgControlPanel                  matlab.ui.container.TabGroup
        SeqTab                          matlab.ui.container.Tab
        MRPanel                         matlab.ui.container.Panel
        Label                           matlab.ui.control.Label
        TLabel                          matlab.ui.control.Label
        msLabel                         matlab.ui.control.Label
        mmLabel                         matlab.ui.control.Label
        TEEditFieldLabel                matlab.ui.control.Label
        efTE                            matlab.ui.control.NumericEditField
        BLabel                          matlab.ui.control.Label
        BEditField                      matlab.ui.control.NumericEditField
        VOIEditFieldLabel               matlab.ui.control.Label
        efVoI                           matlab.ui.control.NumericEditField
        DiffusionPanel                  matlab.ui.container.Panel
        mmsLabel                        matlab.ui.control.Label
        sLabel                          matlab.ui.control.Label
        freeLabel                       matlab.ui.control.Label
        ADCEditFieldLabel               matlab.ui.control.Label
        efADCglobal                     matlab.ui.control.NumericEditField
        stepwidthEditFieldLabel         matlab.ui.control.Label
        efStepWidth                     matlab.ui.control.NumericEditField
        reprodDropDownLabel             matlab.ui.control.Label
        ddReprod                        matlab.ui.control.DropDown
        ParticleNoLabel                 matlab.ui.control.Label
        ef_minMolNo                     matlab.ui.control.NumericEditField
        minLabel                        matlab.ui.control.Label
        maxLabel                        matlab.ui.control.Label
        ParticleNoLabel_2               matlab.ui.control.Label
        ef_maxMolNo                     matlab.ui.control.NumericEditField
        cbAutoScale                     matlab.ui.control.CheckBox
        GradTab                         matlab.ui.container.Tab
        GradienttypePanel               matlab.ui.container.Panel
        tgGradTypes                     matlab.ui.container.TabGroup
        PGSETab                         matlab.ui.container.Tab
        EditFieldLabel                  matlab.ui.control.Label
        efPGSE_Delta                    matlab.ui.control.NumericEditField
        Label_2                         matlab.ui.control.Label
        efPGSE_delta                    matlab.ui.control.NumericEditField
        msLabel_2                       matlab.ui.control.Label
        msLabel_3                       matlab.ui.control.Label
        msLabel_4                       matlab.ui.control.Label
        TDLabel                         matlab.ui.control.Label
        efPGSE_TD                       matlab.ui.control.NumericEditField
        OGSETab                         matlab.ui.container.Tab
        periodsLabel                    matlab.ui.control.Label
        efOGSE_periods                  matlab.ui.control.NumericEditField
        Label_3                         matlab.ui.control.Label
        efOGSE_alpha                    matlab.ui.control.NumericEditField
        polarityDropDownLabel           matlab.ui.control.Label
        ddOGSE_polaritylue              matlab.ui.control.DropDown
        msLabel_5                       matlab.ui.control.Label
        TDLabel_2                       matlab.ui.control.Label
        efOGSE_TD                       matlab.ui.control.NumericEditField
        FWFTab                          matlab.ui.container.Tab
        ButtonGroup                     matlab.ui.container.ButtonGroup
        rbCreate                        matlab.ui.control.RadioButton
        rbLoad                          matlab.ui.control.RadioButton
        TensorDropDownLabel             matlab.ui.control.Label
        ddTensorType                    matlab.ui.control.DropDown
        bFWFCreate                      matlab.ui.control.Button
        InterpolDropDownLabel           matlab.ui.control.Label
        ddInterpolType                  matlab.ui.control.DropDown
        bFWFSave                        matlab.ui.control.Button
        NameEditFieldLabel              matlab.ui.control.Label
        efFWFName                       matlab.ui.control.EditField
        DataSetDropDownLabel            matlab.ui.control.Label
        ddFWFDataSet                    matlab.ui.control.DropDown
        FWFmaxLabel                     matlab.ui.control.Label
        GEditFieldLabel                 matlab.ui.control.Label
        efFWFGmax                       matlab.ui.control.NumericEditField
        mTmLabel                        matlab.ui.control.Label
        MaxwellIdxEditFieldLabel        matlab.ui.control.Label
        efFWFMaxwellIdx                 matlab.ui.control.NumericEditField
        mTmmsLabel                      matlab.ui.control.Label
        bValuePanel                     matlab.ui.container.Panel
        bEditFieldLabel                 matlab.ui.control.Label
        ef_bValueMin                    matlab.ui.control.NumericEditField
        minLabel_4                      matlab.ui.control.Label
        maxLabel_4                      matlab.ui.control.Label
        bEditField_2Label               matlab.ui.control.Label
        ef_bValueMax                    matlab.ui.control.NumericEditField
        NoEditFieldLabel                matlab.ui.control.Label
        ef_bValueNo                     matlab.ui.control.NumericEditField
        smmLabel                        matlab.ui.control.Label
        tgBValueSettings                matlab.ui.container.TabGroup
        linBTensorTab                   matlab.ui.container.Tab
        bVectorLabel                    matlab.ui.control.Label
        normLabel                       matlab.ui.control.Label
        ef_bVecXNorm                    matlab.ui.control.NumericEditField
        ef_bVecYNorm                    matlab.ui.control.NumericEditField
        ef_bVecZNorm                    matlab.ui.control.NumericEditField
        xEditFieldLabel                 matlab.ui.control.Label
        ef_bVecX                        matlab.ui.control.NumericEditField
        yEditFieldLabel                 matlab.ui.control.Label
        ef_bVecY                        matlab.ui.control.NumericEditField
        zEditFieldLabel                 matlab.ui.control.Label
        ef_bVecZ                        matlab.ui.control.NumericEditField
        hoBTensorTab                    matlab.ui.container.Tab
        rotAxisLabel                    matlab.ui.control.Label
        normLabel_2                     matlab.ui.control.Label
        ef_RotAxXNorm                   matlab.ui.control.NumericEditField
        ef_RotAxYNorm                   matlab.ui.control.NumericEditField
        ef_RotAxZNorm                   matlab.ui.control.NumericEditField
        xEditFieldLabel_2               matlab.ui.control.Label
        ef_RotAxX                       matlab.ui.control.NumericEditField
        yEditFieldLabel_2               matlab.ui.control.Label
        ef_RotAxY                       matlab.ui.control.NumericEditField
        zEditFieldLabel_2               matlab.ui.control.Label
        ef_RotAxZ                       matlab.ui.control.NumericEditField
        rotAngleEditFieldLabel          matlab.ui.control.Label
        ef_rotAngle                     matlab.ui.control.NumericEditField
        Label_6                         matlab.ui.control.Label
        ddGradType                      matlab.ui.control.DropDown
        bValueTable                     matlab.ui.control.Table
        bShowGrad                       matlab.ui.control.Button
        GradientshapePanel              matlab.ui.container.Panel
        plotGradShape                   matlab.ui.control.UIAxes
        DiffusionTensorPanel            matlab.ui.container.Panel
        plotDifTensor                   matlab.ui.control.UIAxes
        SmpTab                          matlab.ui.container.Tab
        CompartmentsPanel               matlab.ui.container.Panel
        lbCompartment                   matlab.ui.control.ListBox
        bCmpDelete                      matlab.ui.control.Button
        bCmpReLoad                      matlab.ui.control.Button
        plotCmpFraction                 matlab.ui.control.UIAxes
        CompartmentselectPanel          matlab.ui.container.Panel
        tgCmpSelect                     matlab.ui.container.TabGroup
        freeTab                         matlab.ui.container.Tab
        spheresTab                      matlab.ui.container.Tab
        tgRadDistSph                    matlab.ui.container.TabGroup
        deltaTabSph                     matlab.ui.container.Tab
        gammaTabSph                     matlab.ui.container.Tab
        shapeparaEditField_9Label       matlab.ui.control.Label
        efSphGammaShape                 matlab.ui.control.NumericEditField
        scaleparaEditField_9Label       matlab.ui.control.Label
        efSphGammaScale                 matlab.ui.control.NumericEditField
        meanradiusrefSwitch_4Label      matlab.ui.control.Label
        swSphGammaRadiusAuto            matlab.ui.control.Switch
        bgSphGamma                      matlab.ui.container.ButtonGroup
        rbSphGammaShape                 matlab.ui.control.RadioButton
        rbSphGammaScale                 matlab.ui.control.RadioButton
        gevTabSph                       matlab.ui.container.Tab
        shapeparaEditField_5Label       matlab.ui.control.Label
        efSphGevShape                   matlab.ui.control.NumericEditField
        scaleparaEditField_5Label       matlab.ui.control.Label
        efSphGevScale                   matlab.ui.control.NumericEditField
        locationparaEditField_2Label    matlab.ui.control.Label
        efSphGevLocation                matlab.ui.control.NumericEditField
        meanradiusrefSwitch_3Label      matlab.ui.control.Label
        swSphGevRadiusAuto              matlab.ui.control.Switch
        bgSphGev                        matlab.ui.container.ButtonGroup
        rbSphGevShape                   matlab.ui.control.RadioButton
        rbSphGevScale                   matlab.ui.control.RadioButton
        rbSphGevLocation                matlab.ui.control.RadioButton
        mLabel_4                        matlab.ui.control.Label
        fromLabel_2                     matlab.ui.control.Label
        toLabel_2                       matlab.ui.control.Label
        RadiidistributionDropDownLabel_2  matlab.ui.control.Label
        ddRadDistSph                    matlab.ui.control.DropDown
        RadiusLabel_2                   matlab.ui.control.Label
        efRadSph                        matlab.ui.control.NumericEditField
        minLabel_3                      matlab.ui.control.Label
        mLabel_5                        matlab.ui.control.Label
        rEditFieldLabel_2               matlab.ui.control.Label
        efRadMinSph                     matlab.ui.control.NumericEditField
        maxLabel_3                      matlab.ui.control.Label
        mLabel_6                        matlab.ui.control.Label
        rEditField_2Label_2             matlab.ui.control.Label
        efRadMaxSph                     matlab.ui.control.NumericEditField
        bVisProbDistSph                 matlab.ui.control.Button
        cylindersTab                    matlab.ui.container.Tab
        DispersionDropDownLabel         matlab.ui.control.Label
        ddDispersionOptCyl              matlab.ui.control.DropDown
        RadiidistributionDropDownLabel  matlab.ui.control.Label
        ddRadDistCyl                    matlab.ui.control.DropDown
        RadiusLabel                     matlab.ui.control.Label
        efRadCyl                        matlab.ui.control.NumericEditField
        mLabel                          matlab.ui.control.Label
        fromLabel                       matlab.ui.control.Label
        toLabel                         matlab.ui.control.Label
        minLabel_2                      matlab.ui.control.Label
        mLabel_2                        matlab.ui.control.Label
        rEditFieldLabel                 matlab.ui.control.Label
        efRadMinCyl                     matlab.ui.control.NumericEditField
        maxLabel_2                      matlab.ui.control.Label
        mLabel_3                        matlab.ui.control.Label
        rEditField_2Label               matlab.ui.control.Label
        efRadMaxCyl                     matlab.ui.control.NumericEditField
        bVisProbDistCyl                 matlab.ui.control.Button
        tgDispersionCyl                 matlab.ui.container.TabGroup
        emptyTab                        matlab.ui.container.Tab
        MainaxisDropDownLabel           matlab.ui.control.Label
        ddMainAxisOptPara               matlab.ui.control.DropDown
        partiallyTab                    matlab.ui.container.Tab
        dispangleEditFieldLabel         matlab.ui.control.Label
        efDispAngle                     matlab.ui.control.NumericEditField
        Label_7                         matlab.ui.control.Label
        MainaxisDropDownLabel_2         matlab.ui.control.Label
        ddMainAxisOptPart               matlab.ui.control.DropDown
        fullyTab                        matlab.ui.container.Tab
        tgRadDistCyl                    matlab.ui.container.TabGroup
        deltaTabCyl                     matlab.ui.container.Tab
        gammaTabCyl                     matlab.ui.container.Tab
        shapeparaEditField_10Label      matlab.ui.control.Label
        efCylGammaShape                 matlab.ui.control.NumericEditField
        scaleparaEditField_10Label      matlab.ui.control.Label
        efCylGammaScale                 matlab.ui.control.NumericEditField
        meanradiusrefSwitch_2Label      matlab.ui.control.Label
        swCylGammaRadiusAuto            matlab.ui.control.Switch
        bgCylGamma                      matlab.ui.container.ButtonGroup
        rbCylGammaShape                 matlab.ui.control.RadioButton
        rbCylGammaScale                 matlab.ui.control.RadioButton
        gevTabCyl                       matlab.ui.container.Tab
        shapeparaEditField_11Label      matlab.ui.control.Label
        efCylGevShape                   matlab.ui.control.NumericEditField
        scaleparaEditField_11Label      matlab.ui.control.Label
        efCylGevScale                   matlab.ui.control.NumericEditField
        locationparaEditField_3Label    matlab.ui.control.Label
        efCylGevLocation                matlab.ui.control.NumericEditField
        meanradiusrefSwitchLabel        matlab.ui.control.Label
        swCylGevRadiusAuto              matlab.ui.control.Switch
        bgCylGev                        matlab.ui.container.ButtonGroup
        rbCylGevShape                   matlab.ui.control.RadioButton
        rbCylGevScale                   matlab.ui.control.RadioButton
        rbCylGevLocation                matlab.ui.control.RadioButton
        NameEditFieldLabel_2            matlab.ui.control.Label
        efCmpName                       matlab.ui.control.EditField
        bCmpAdd                         matlab.ui.control.Button
        FractionLabel                   matlab.ui.control.Label
        efCmpFraction                   matlab.ui.control.NumericEditField
        Label_5                         matlab.ui.control.Label
        Label_4                         matlab.ui.control.Label
        ddCmpSelect                     matlab.ui.control.DropDown
        RadiidistrubutionPanel          matlab.ui.container.Panel
        plotRadiiProbDist               matlab.ui.control.UIAxes
        TestingPanelvisualizediffusionprocess  matlab.ui.container.Panel
        DEditFieldLabel                 matlab.ui.control.Label
        efTestADC                       matlab.ui.control.NumericEditField
        mmsLabel_2                      matlab.ui.control.Label
        tLabel                          matlab.ui.control.Label
        efTestStepWidth                 matlab.ui.control.NumericEditField
        sLabel_2                        matlab.ui.control.Label
        noparticlesEditFieldLabel       matlab.ui.control.Label
        efTestNoParticles               matlab.ui.control.NumericEditField
        noiterationsEditFieldLabel      matlab.ui.control.Label
        efTestNoIterations              matlab.ui.control.NumericEditField
        bTestStart                      matlab.ui.control.Button
        TextArea_3                      matlab.ui.control.TextArea
        lCmpFrac                        matlab.ui.control.Label
        SimTab                          matlab.ui.container.Tab
        bStartSimu                      matlab.ui.control.Button
        bExpFig                         matlab.ui.control.Button
        Panel                           matlab.ui.container.Panel
        plotDiffSignal                  matlab.ui.control.UIAxes
        LogViewerPanel                  matlab.ui.container.Panel
        taLogViewer                     matlab.ui.control.TextArea
        PlotfreeADCofCheckBox           matlab.ui.control.CheckBox
        mmsLabel_3                      matlab.ui.control.Label
        efADCglobal_2                   matlab.ui.control.NumericEditField
        AboutTab                        matlab.ui.container.Tab
        TextArea                        matlab.ui.control.TextArea
        TextArea_2                      matlab.ui.control.TextArea
        bgMenu                          matlab.ui.container.ButtonGroup
        bGeneralSettings                matlab.ui.control.ToggleButton
        bSampleSettings                 matlab.ui.control.ToggleButton
        bSimulate                       matlab.ui.control.ToggleButton
        bAbout                          matlab.ui.control.ToggleButton
        bGradientSettings               matlab.ui.control.ToggleButton
    end

    
    properties (Access = private)
        % gradient shape objects
        gradShapeObj;   % object handle for gradient shape
            paraShape;  % parametrization for gradient shape
        
        % a list of objects who handle the type of restrictions (free diffusion, spherical confinement, cylindrical confinement)
        restDefObjList;
        
        radiusDistFunct; % Description
        radiusDistFunctStr;
        
        % simulation result
        simRes;
    end
    
    methods (Access = private)
        function cbCloseProgressDlg(app, src, event, guiHdl)
            data              = guidata(app.DIFSIMUIFigure );
            data.timerElapsed = true;
            guidata( app.DIFSIMUIFigure, data );

            msg = 'No FWF created within timeout. Please try it again.';
            title = 'FWF Optimization';
            uiconfirm(app.DIFSIMUIFigure,msg,title,...
                      'Options',{'OK'},...
                      'DefaultOption',1,...
                      'CancelOption', 1,...
                      'Icon','warning');
        end

        function gammaOpt(app)
            % see what option is selected
            switch app.ddCmpSelect.Value
                case 'spheres'
                    if ( strcmp(app.swSphGammaRadiusAuto.Value,'On') )
                        r     = app.efRadSph.Value*1e-6;        % [m]
                        shape = app.efSphGammaShape.Value;
                        scale = app.efSphGammaScale.Value;
                        switch app.bgSphGamma.SelectedObject
                            case app.rbSphGammaScale
                                app.efSphGammaScale.Value = r*(1/shape);
                            case app.rbSphGammaShape
                                app.efSphGammaShape.Value = r*(1/scale);                            
                        end
                    end
                    try
                        eval(['app.radiusDistFunct = makedist(''Gamma'',''a'',' num2str(app.efSphGammaShape.Value) ',''b'',' num2str(app.efSphGammaScale.Value) ');']);
                        app.radiusDistFunctStr = ['makedist(''Gamma'',''a'',' num2str(app.efSphGammaShape.Value) ',''b'',' num2str(app.efSphGammaScale.Value) ')'];
                        makedist('Gamma','a',app.efSphGammaShape.Value,'b',app.efSphGammaScale.Value);
                    catch ME
                        
                    end
                case 'cylinders'
                    if ( strcmp(app.swCylGammaRadiusAuto.Value,'On') )
                        r     = app.efRadCyl.Value*1e-6;        % [m]
                        shape = app.efCylGammaShape.Value;
                        scale = app.efCylGammaScale.Value;
                        switch app.bgCylGamma.SelectedObject
                            case app.rbCylGammaScale
                                app.efCylGammaScale.Value = r*(1/shape);
                            case app.rbCylGammaShape
                                app.efCylGammaShape.Value = r*(1/scale);                            
                        end
                    end
                    try
                        eval(['app.radiusDistFunct = makedist(''Gamma'',''a'',' num2str(app.efCylGammaShape.Value) ',''b'',' num2str(app.efCylGammaScale.Value) ');']);
                        app.radiusDistFunctStr = ['makedist(''Gamma'',''a'',' num2str(app.efCylGammaShape.Value) ',''b'',' num2str(app.efCylGammaScale.Value) ')'];
                        makedist('Gamma','a',app.efCylGammaShape.Value,'b',app.efCylGammaScale.Value);
                    catch ME
                        
                    end
            end
        end
        
        function gevOpt(app)
            % see what option is selected
            switch app.ddCmpSelect.Value
                case 'spheres'
                    if ( strcmp(app.swSphGevRadiusAuto.Value,'On') )
                        r        = app.efRadSph.Value*1e-6;        % [m]
                        k    = app.efSphGevShape.Value;
                        s    = app.efSphGevScale.Value;
                        m    = app.efSphGevLocation.Value;
                        switch app.bgSphGev.SelectedObject
                            case app.rbSphGevScale
                                try
                                    r_s = @(s) r-mean(makedist('GeneralizedExtremeValue','k',k,'sigma',s,'mu',m));
                                    app.efSphGevScale.Value = fzero(r_s,1e-6);
                                    app.efSphGevScale.FontColor = [0; 0; 0];
                                catch
                                    app.efSphGevScale.FontColor = [1; 0; 0];
                                end
                                %app.efSphGammaScale.Value = r*(1/shape);
                            case app.rbSphGevShape
                                try
                                    r_k = @(k) r-mean(makedist('GeneralizedExtremeValue','k',k,'sigma',s,'mu',m));
                                    app.efSphGevShape.Value = fzero(r_k,0.2);
                                    app.efSphGevShape.FontColor = [0; 0; 0];
                                catch
                                    app.efSphGevShape.FontColor = [1; 0; 0];
                                end
                                %app.efSphGammaShape.Value = r*(1/scale);                            
                            case app.rbSphGevLocation
                                try
                                    r_m = @(m) r-mean(makedist('GeneralizedExtremeValue','k',k,'sigma',s,'mu',m));
                                    app.efSphGevLocation.Value = fzero(r_m,1e-6);
                                    app.efSphGevLocation.FontColor = [0; 0; 0];
                                catch
                                    app.efSphGevLocation.FontColor = [1; 0; 0];
                                end
                                %app.efSphGammaShape.Value = r*(1/scale);                            
                        end
                    end
                    try
                        eval(['app.radiusDistFunct = makedist(''GeneralizedExtremeValue'',''k'',' num2str(app.efSphGevShape.Value) ',''sigma'',' num2str(app.efSphGevScale.Value) ',''mu'',' num2str(app.efSphGevLocation.Value) ');']);
                        app.radiusDistFunctStr = ['makedist(''GeneralizedExtremeValue'',''k'',' num2str(app.efSphGevShape.Value) ',''sigma'',' num2str(app.efSphGevScale.Value) ',''mu'',' num2str(app.efSphGevLocation.Value) ')'];
                        makedist('GeneralizedExtremeValue','k',app.efSphGevShape.Value,'sigma',app.efSphGevScale.Value,'mu',app.efSphGevLocation.Value);
                    catch ME
                        
                    end
                case 'cylinders'
                    if ( strcmp(app.swCylGevRadiusAuto.Value,'On') )
                        r    = app.efRadCyl.Value*1e-6;        % [m]
                        k    = app.efCylGevShape.Value;
                        s    = app.efCylGevScale.Value;
                        m    = app.efCylGevLocation.Value;
                        switch app.bgCylGev.SelectedObject
                            case app.rbCylGevScale
                                try
                                    r_s = @(s) r-mean(makedist('GeneralizedExtremeValue','k',k,'sigma',s,'mu',m));
                                    app.efCylGevScale.Value = fzero(r_s,1e-6);
                                    app.efCylGevScale.FontColor = [0; 0; 0];
                                catch
                                    app.efCylGevScale.FontColor = [1; 0; 0];
                                end
                                %app.efSphGammaScale.Value = r*(1/shape);
                            case app.rbCylGevShape
                                try
                                    r_k = @(k) r-mean(makedist('GeneralizedExtremeValue','k',k,'sigma',s,'mu',m));
                                    app.efCylGevShape.Value = fzero(r_k,0.2);
                                    app.efCylGevShape.FontColor = [0; 0; 0];
                                catch
                                    app.efCylGevShape.FontColor = [1; 0; 0];
                                end
                                %app.efSphGammaShape.Value = r*(1/scale);                            
                            case app.rbCylGevLocation
                                try
                                    r_m = @(m) r-mean(makedist('GeneralizedExtremeValue','k',k,'sigma',s,'mu',m));
                                    app.efCylGevLocation.Value = fzero(r_m,1e-6);
                                    app.efCylGevLocation.FontColor = [0; 0; 0];
                                catch
                                    app.efCylGevLocation.FontColor = [1; 0; 0];
                                end
                                %app.efSphGammaShape.Value = r*(1/scale);                            
                        end
                    end
                    try
                        eval(['app.radiusDistFunct = makedist(''GeneralizedExtremeValue'',''k'',' num2str(app.efCylGevShape.Value) ',''sigma'',' num2str(app.efCylGevScale.Value) ',''mu'',' num2str(app.efCylGevLocation.Value) ');']);
                        app.radiusDistFunctStr = ['makedist(''GeneralizedExtremeValue'',''k'',' num2str(app.efCylGevShape.Value) ',''sigma'',' num2str(app.efCylGevScale.Value) ',''mu'',' num2str(app.efCylGevLocation.Value) ')'];
                        makedist('GeneralizedExtremeValue','k',app.efCylGevShape.Value,'sigma',app.efCylGevScale.Value,'mu',app.efCylGevLocation.Value);
                    catch ME
                        
                    end
            end
        end
        
        function cmpStruct = saveCmpStruct(app)
            cmpStruct.Name    = app.efCmpName.Value;
            cmpStruct.Frac    = app.efCmpFraction.Value;
            
            cmpStruct.CmpSelect = app.ddCmpSelect.Value;
            cmpStruct.CmpType   = app.tgCmpSelect.SelectedTab;
            switch app.tgCmpSelect.SelectedTab
                case app.spheresTab
                    cmpStruct.rad    = app.efRadSph.Value;
                    cmpStruct.radEn  = app.efRadSph.Enable;
                    cmpStruct.radMin = app.efRadMinSph.Value;
                    cmpStruct.radMax = app.efRadMaxSph.Value;
                    
                    cmpStruct.radDistValue = app.ddRadDistSph.Value;
                    cmpStruct.radDist      = app.tgRadDistSph.SelectedTab;
                    switch app.tgRadDistSph.SelectedTab
                        case app.gammaTabSph
                            cmpStruct.RadiusAutoSwitch = app.swSphGammaRadiusAuto.Value;
                            cmpStruct.distSelect       = app.bgSphGamma.SelectedObject;
                            cmpStruct.distPara(1)      = app.efSphGammaShape.Value;
                            cmpStruct.distPara(2)      = app.efSphGammaScale.Value;
                        case app.gevTabSph
                            cmpStruct.RadiusAutoSwitch = app.swSphGevRadiusAuto.Value;
                            cmpStruct.distSelect       = app.bgSphGev.SelectedObject;
                            cmpStruct.distPara(1)      = app.efSphGevShape.Value;
                            cmpStruct.distPara(2)      = app.efSphGevScale.Value;
                            cmpStruct.distPara(3)      = app.efSphGevLocation.Value;
                    end
                case app.cylindersTab
                    cmpStruct.rad    = app.efRadCyl.Value;
                    cmpStruct.radEn  = app.efRadCyl.Enable;
                    cmpStruct.radMin = app.efRadMinCyl.Value;
                    cmpStruct.radMax = app.efRadMaxCyl.Value;
                    
                    cmpStruct.radDistValue = app.ddRadDistCyl.Value;
                    cmpStruct.radDist      = app.tgRadDistCyl.SelectedTab;
                    switch app.tgRadDistCyl.SelectedTab
                        case app.gammaTabCyl
                            cmpStruct.RadiusAutoSwitch = app.swCylGammaRadiusAuto.Value;
                            cmpStruct.distSelect       = app.bgCylGamma.SelectedObject;
                            cmpStruct.distPara(1)      = app.efCylGammaShape.Value;
                            cmpStruct.distPara(2)      = app.efCylGammaScale.Value;
                        case app.gevTabCyl
                            cmpStruct.RadiusAutoSwitch = app.swCylGevRadiusAuto.Value;
                            cmpStruct.distSelect       = app.bgCylGev.SelectedObject;
                            cmpStruct.distPara(1)      = app.efCylGevShape.Value;
                            cmpStruct.distPara(2)      = app.efCylGevScale.Value;
                            cmpStruct.distPara(3)      = app.efCylGevLocation.Value;
                    end
                    
                    cmpStruct.dispersionOpt = app.ddDispersionOptCyl.Value;
                    cmpStruct.cylDispTab    = app.tgDispersionCyl.SelectedTab;
                    switch app.tgDispersionCyl.SelectedTab
                        case app.emptyTab
                            cmpStruct.mainAxisOpt   = app.ddMainAxisOptPara.Value;
                        case app.partiallyTab
                            cmpStruct.mainAxisOpt   = app.ddMainAxisOptPart.Value;
                            cmpStruct.dispAngle     = app.efDispAngle.Value;
                        %case app.fullyTab
                    end
            end
        end
        
        function loadCmpStruct(app)
            if ( ~isempty(app.lbCompartment.Value) )
                cmpStruct = app.lbCompartment.Value;
                app.efCmpName.Value     = cmpStruct.Name;
                app.efCmpFraction.Value = cmpStruct.Frac;
                
                app.ddCmpSelect.Value = cmpStruct.CmpSelect;
                app.tgCmpSelect.SelectedTab = cmpStruct.CmpType;
                switch app.tgCmpSelect.SelectedTab
                    case app.spheresTab
                        app.efRadSph.Value    = cmpStruct.rad;
                        app.efRadSph.Enable   = cmpStruct.radEn;
                        app.efRadMinSph.Value = cmpStruct.radMin;
                        app.efRadMaxSph.Value = cmpStruct.radMax;
                        
                        app.ddRadDistSph.Value = cmpStruct.radDistValue;
                        app.tgRadDistSph.SelectedTab = cmpStruct.radDist;
                        switch app.tgRadDistSph.SelectedTab
                            case app.gammaTabSph
                                app.swSphGammaRadiusAuto.Value = cmpStruct.RadiusAutoSwitch;
                                app.bgSphGamma.SelectedObject  = cmpStruct.distSelect;
                                if ( strcmp(cmpStruct.RadiusAutoSwitch,'On') )
                                    set( findall(app.bgSphGamma, '-property', 'Enable'), 'Enable', 'on');
                                    app.bgSphGammaSelectionChanged();
                                else
                                    set( findall(app.bgSphGamma, '-property', 'Enable'), 'Enable', 'off');
                                    app.efSphGammaShape.Editable = 'on';
                                    app.efSphGammaScale.Editable = 'on';
                                end
                                app.efSphGammaShape.Value      = cmpStruct.distPara(1);
                                app.efSphGammaScale.Value      = cmpStruct.distPara(2);
                            case app.gevTabSph
                                app.swSphGevRadiusAuto.Value = cmpStruct.RadiusAutoSwitch;
                                app.bgSphGev.SelectedObject  = cmpStruct.distSelect;
                                if ( strcmp(cmpStruct.RadiusAutoSwitch,'On') )
                                    set( findall(app.bgSphGev, '-property', 'Enable'), 'Enable', 'on');
                                    app.bgSphGevSelectionChanged();
                                else
                                    set( findall(app.bgSphGev, '-property', 'Enable'), 'Enable', 'off');
                                    app.efSphGevShape.Editable    = 'on';
                                    app.efSphGevScale.Editable    = 'on';
                                    app.efSphGevLocation.Editable = 'on';
                                end
                                app.efSphGevShape.Value      = cmpStruct.distPara(1);
                                app.efSphGevScale.Value      = cmpStruct.distPara(2);
                                app.efSphGevLocation.Value   = cmpStruct.distPara(3);
                        end
                    case app.cylindersTab
                        app.efRadCyl.Value    = cmpStruct.rad;
                        app.efRadCyl.Enable   = cmpStruct.radEn;
                        app.efRadMinCyl.Value = cmpStruct.radMin;
                        app.efRadMaxCyl.Value = cmpStruct.radMax;
                        
                        app.ddRadDistCyl.Value = cmpStruct.radDistValue;                        
                        app.tgRadDistCyl.SelectedTab = cmpStruct.radDist;
                        switch app.tgRadDistCyl.SelectedTab
                            case app.gammaTabCyl
                                app.swCylGammaRadiusAuto.Value = cmpStruct.RadiusAutoSwitch;
                                app.bgCylGamma.SelectedObject  = cmpStruct.distSelect;
                                if ( strcmp(cmpStruct.RadiusAutoSwitch,'On') )
                                    set( findall(app.bgCylGamma, '-property', 'Enable'), 'Enable', 'on');
                                    app.bgCylGammaSelectionChanged();
                                else
                                    set( findall(app.bgCylGamma, '-property', 'Enable'), 'Enable', 'off');
                                    app.efCylGammaShape.Editable = 'on';
                                    app.efCylGammaScale.Editable = 'on';
                                end
                                app.efCylGammaShape.Value      = cmpStruct.distPara(1);
                                app.efCylGammaScale.Value      = cmpStruct.distPara(2);
                            case app.gevTabCyl
                                app.swCylGevRadiusAuto.Value = cmpStruct.RadiusAutoSwitch;
                                app.bgCylGev.SelectedObject  = cmpStruct.distSelect;
                                if ( strcmp(cmpStruct.RadiusAutoSwitch,'On') )
                                    set( findall(app.bgCylGev, '-property', 'Enable'), 'Enable', 'on');
                                    app.bgCylGevSelectionChanged();
                                else
                                    set( findall(app.bgCylGev, '-property', 'Enable'), 'Enable', 'off');
                                    app.efCylGevShape.Editable    = 'on';
                                    app.efCylGevScale.Editable    = 'on';
                                    app.efCylGevLocation.Editable = 'on';
                                end
                                app.efCylGevShape.Value      = cmpStruct.distPara(1);
                                app.efCylGevScale.Value      = cmpStruct.distPara(2);
                                app.efCylGevLocation.Value   = cmpStruct.distPara(3);
                        end
                        
                    app.ddDispersionOptCyl.Value = cmpStruct.dispersionOpt;
                    app.tgDispersionCyl.SelectedTab = cmpStruct.cylDispTab;
                    switch app.tgDispersionCyl.SelectedTab
                        case app.emptyTab
                            app.ddMainAxisOptPara.Value = cmpStruct.mainAxisOpt;
                        case app.partiallyTab
                            app.ddMainAxisOptPart.Value = cmpStruct.mainAxisOpt;
                            app.efDispAngle.Value       = cmpStruct.dispAngle;
                        %case app.fullyTab
                    end                        
                end
            end            
        end
        
        function updateCmpBar(app)
            cla(app.plotCmpFraction);   % clear plot
            
%             tabData = [];
%             colergen = @(color,text) ['<table border=0 width=400 bgcolor=',color,'><TR><TD>',text,'</TD></TR> </table>'];
            for itx = 1:length(app.lbCompartment.ItemsData)
                %tmp = horzcat(app.lbCompartment.ItemsData{:});
                tmp(itx).name = app.lbCompartment.ItemsData{itx}.Name;
                tmp(itx).Frac = app.lbCompartment.ItemsData{itx}.Frac;
%                 if (isempty(tabData))
%                    tabData = {tmp(itx).name tmp(itx).Frac  ''};
%                 else
%                    tabData{itx,1} = tmp(itx).name;
%                    tabData{itx,2} = tmp(itx).Frac;
%                    tabData{itx,3} = colergen('#FF0000','AD');
%                 end
            end
%             app.tabCmp.ColumnFormat = {'char','numeric','char'};
%             s = uistyle('BackgroundColor','yellow');
%             addStyle(app.tabCmp,s,'cell',[1,3]);
%             set(app.tabCmp,'Data', tabData);

            %{tmp(:).name}
            %{tmp(:).Name}
            %[tmp(:).Frac]
            %figure;
            % y = [2 2 3; 2 5 6; 2 8 9; 2 11 12];
            % bar(y,'stacked')            
            %bar(repmat([tmp(:).Frac],2,1),'stacked')
            if ( exist('tmp','var') )
                barh(app.plotCmpFraction,repmat([tmp(:).Frac],2,1),'stacked');
                %legend(app.plotCmpFraction,'test');
                %legend(app.plotCmpFraction,'Line 1','Position',[1.8 0.9 0.05 0.0269]);
                app.plotCmpFraction.YLim = [0.6 1.4];
                %xLim = app.plotCmpFraction.XLim;
                app.lCmpFrac.Text = [num2str(sum([tmp(:).Frac])) '%'];
                if ( sum([tmp(:).Frac]) <= 100 )
                    app.plotCmpFraction.XLim = [0 100];
                else
                    app.plotCmpFraction.XLim = [0 sum([tmp(:).Frac])];
                    xline(app.plotCmpFraction,100,'r','LineWidth',2);
                end
                if ( sum([tmp(:).Frac]) == 100 )
                    app.lCmpFrac.FontColor = [0 0.6 0];
                else
                    app.lCmpFrac.FontColor = [1 0 0];
                end
            else
                app.plotCmpFraction.XLim = [0 100];
                app.lCmpFrac.Text = '0%';
                app.lCmpFrac.FontColor = [1 0 0];
            end
            % adjust colormap accordingly
            %get(app.lbCompartment, 'String')
            %app.lbCompartment.Items{1} = '<HTML><BODY bgcolor="0000FF">Test</HTML>'
            %set(app.lbCompartment.Items{1} ={'<HTML><FONT color="0000FF">Test</FONT></HTML>'});
            %colMap = lines;
            %for itx = 1:length(tmp)
            %    if ([tmp(itx).Frac] ~= 0)
            %        app.lbCompartment
            %    else
            %    end
            %end
            %[tmp(:).Frac] ~= 0
            %test = lines;
            
%             for itx = 1:length(app.lbCompartment.Items)
%                 % redraw bars
%                 
%             end
        end
        
        function rstObj = createRestrictionObj(app)
            rstPara = [];
            %rstPara.dstCnt  = true;    % uncomment to enforce that diffusion of all particles start at coordinate-system's origin
            switch app.tgCmpSelect.SelectedTab
                case app.freeTab
                    %% create Obj (usually rstPara is an empty structure here)
                    rstObj = objFreeDiffusion(rstPara);
                case app.spheresTab
                    switch app.tgRadDistSph.SelectedTab
                        case app.deltaTabSph
                            rstPara.radius  = @(n) ones([1 n])*app.efRadSph.Value*1e-6;
                        case app.gammaTabSph
                            rstPara.radius  = @(n) @(n) random(makedist('Gamma','a',app.efSphGammaShape.Value,'b',app.efSphGammaScale.Value),[1 n]);
                        case app.gevTabSph
                            rstPara.radius  = @(n) @(n) random(makedist('GeneralizedExtremeValue','k',app.efSphGevShape.Value,'sigma',app.efSphGevScale.Value,'mu',app.efSphGevLocation.Value),[1 n]);
                    end
                    %% create Obj
                    rstObj = objSpheres(rstPara);
                case app.cylindersTab
                    switch app.tgRadDistCyl.SelectedTab
                        case app.deltaTabCyl
                            rstPara.radius  = @(n) ones([1 n])*app.efRadCyl.Value*1e-6;
                        case app.gammaTabCyl
                            rstPara.radius  = @(n) @(n) random(makedist('Gamma','a',app.efCylGammaShape.Value,'b',app.efCylGammaScale.Value),[1 n]);
                        case app.gevTabCyl
                            rstPara.radius  = @(n) @(n) random(makedist('GeneralizedExtremeValue','k',app.efCylGevShape.Value,'sigma',app.efCylGevScale.Value,'mu',app.efCylGevLocation.Value),[1 n]);
                    end
                    switch app.ddDispersionOptCyl
                        case 'non (parallel)'
                            rstPara.InitOpt = 'parallel';
                        case 'partially'
                            rstPara.InitOpt = 'partially_dispersed';
                        case 'fully'
                            rstPara.InitOpt = 'fully_dispersed';
                    end
                    rstPara.mainAx = app.ddMainAxisOptPara.Value;
                    %% create Obj
                    rstObj = objCylBundles(rstPara);
            end            
        end
        
        function prepResDoc(app)
            disp_out( prepHeading('parametrization','=',65), app.taLogViewer );
            %disp_out( sprintf('\n'), app.taLogViewer );
            % General Settings
            disp_out( '< General Settings >', app.taLogViewer );
            disp_out( sprintf('\tADCfree:\t%0.2e mm²/s', app.efADCglobal.Value ), app.taLogViewer );
            disp_out( sprintf('\tTE:\t\t%0.2u ms', app.efTE.Value ), app.taLogViewer );
            disp_out( sprintf('\tstepWidth:\t%0.2u us', app.efStepWidth.Value ), app.taLogViewer );
            disp_out( sprintf('\tnoProbes_min:\t%0.2u', app.ef_minMolNo.Value ), app.taLogViewer );
            disp_out( sprintf('\tnoProbes_max:\t%0.2u', app.ef_maxMolNo.Value ), app.taLogViewer );
            disp_out( sprintf('\n'), app.taLogViewer );

            % Diffusion Settings
            disp_out( '< Gradient Settings >', app.taLogViewer );
            disp_out( sprintf('\tType:\t\t%s', app.ddGradType.Value ), app.taLogViewer );
            switch app.gradShapeObj.diffType
                case 'PGSE'
                    disp_out( sprintf('\tDelta:\t\t%0.2u ms', getfield(app.gradShapeObj.getPara,'Delta') ), app.taLogViewer );
                    disp_out( sprintf('\tdelta:\t\t%0.2u ms', getfield(app.gradShapeObj.getPara,'delta') ), app.taLogViewer );
                    disp_out( sprintf('\tTD:\t\t%0.2f ms',    app.gradShapeObj.TdEff ), app.taLogViewer );
                    bVec = getfield(app.gradShapeObj.getPara,'bVec');
                    disp_out( sprintf('\tb-vector:\t(%0.2f,%0.2f,%0.2f)', bVec(1), bVec(2), bVec(3) ), app.taLogViewer );

                case 'OGSE'
                    disp_out( sprintf('\tperiods:\t%0.1u',    getfield(app.gradShapeObj.getPara,'noPeriods') ), app.taLogViewer );
                    disp_out( sprintf('\talpha:\t\t%0.1u',    getfield(app.gradShapeObj.getPara,'alpha')     ), app.taLogViewer );
                    if ( getfield(app.gradShapeObj.getPara,'polarity') == 1)
                        polarStr = 'positive';
                    else
                        polarStr = 'negative';
                    end                        
                    disp_out( sprintf('\tpolarity:\t%s',      polarStr ), app.taLogViewer );
                    disp_out( sprintf('\tTDeff:\t\t%0.2f ms', app.gradShapeObj.TdEff ), app.taLogViewer );
                    bVec = getfield(app.gradShapeObj.getPara,'bVec');
                    disp_out( sprintf('\tb-vector:\t(%0.2f,%0.2f,%0.2f)', bVec(1), bVec(2), bVec(3) ), app.taLogViewer );
                    
                case 'FWF'
                    if ( isempty(app.gradShapeObj.currentStructStr) )
                        disp_out( sprintf('\tDataset name:\t%s',      'NOT SAVED YET' ), app.taLogViewer );
                    else
                        disp_out( sprintf('\tDataset name:\t%s',      app.gradShapeObj.currentStructStr ), app.taLogViewer );
                    end
                    disp_out( sprintf('\tencoding:\t%s',         app.gradShapeObj.currentFWFstruct.result.type ), app.taLogViewer );
                    disp_out( sprintf('\tGmax:\t\t%0.2f mT/m', app.gradShapeObj.currentFWFstruct.maxAmp  ), app.taLogViewer );
                    rotAx = getfield(app.gradShapeObj.getPara,'rotAx');
                    disp_out( sprintf('\trot axis:\t(%0.2f,%0.2f,%0.2f)', rotAx(1), rotAx(2), rotAx(3) ), app.taLogViewer );
                    %rotAngle = getfield(app.gradShapeObj.getPara,'rotAngle');
                    disp_out( sprintf('\trot angle:\t%0.2f°', getfield(app.gradShapeObj.getPara,'rotAngle') ), app.taLogViewer );
            end
            disp_out( sprintf('\tb-min:\t\t%0.2f s/mm²', app.ef_bValueMin.Value ), app.taLogViewer );            
            disp_out( sprintf('\tb-max:\t\t%0.2f s/mm²', app.ef_bValueMax.Value ), app.taLogViewer );            
            disp_out( sprintf('\tb-values:\t%s s/mm²', strjoin(arrayfun(@(x) num2str(x),app.bValueTable.Data,'UniformOutput',false),', ') ), app.taLogViewer );
            disp_out( sprintf('\n'), app.taLogViewer );
            
            % Sample Settings
            disp_out( '< Sample Settings >', app.taLogViewer );
            disp_out( sprintf('\tSamples:\t%0.1u', length(app.lbCompartment.ItemsData) ), app.taLogViewer );            
            for itx = 1:length(app.lbCompartment.ItemsData)
                disp_out( sprintf('\t%0.1u. Sample: %s', itx, app.lbCompartment.ItemsData{itx}.Name ), app.taLogViewer );
                disp_out( [sprintf('\t') repmat('-',1,length(sprintf('%0.1u. Sample: %s', itx, app.lbCompartment.ItemsData{itx}.Name) ) )], app.taLogViewer );
                disp_out( sprintf('\tType:\t\t%s', app.lbCompartment.ItemsData{itx}.CmpSelect), app.taLogViewer );
                disp_out( sprintf('\tFraction:\t%0.1u%%', app.lbCompartment.ItemsData{itx}.Frac ), app.taLogViewer );
                
                para.rstCollect{itx}.Name        = app.lbCompartment.ItemsData{itx}.Name;
                para.rstCollect{itx}.Frac        = app.lbCompartment.ItemsData{itx}.Frac;
                para.rstCollect{itx}.rstShapeObj = app.lbCompartment.ItemsData{itx}.rstObj;
            end

        end
        
        function prepResPlot(app, para)
            for itx = 1:length(app.simRes)
                sig(itx) = abs(mean(app.simRes(itx).Amp,2));
            end
            b             = [app.simRes(:).bValue];
            zeroIntensity = 1e6;
            sig = zeroIntensity*sig;
                
            if ( isfield(para,'figHdl') )
                % plot to gui
                plot(para.figHdl,b,sig,'o','LineWidth',2);
                axis(para.figHdl, 'tight');
                para.figHdl.XLim = [min(b) max(b)];
                dy = (max(sig) - min(sig))*0.02;
                if (min(sig)-dy < 0) minY = 0; else minY = min(sig)-dy; end
                para.figHdl.YLim = [minY max(sig)+dy];
            else
                % create new figure
                figure('Name','Simulation Result');
                plot(b,sig,'o','LineWidth',2);
                axHdl = gca;
                axHdl.YScale = 'log';
                axHdl.FontSize   = 11;
                axHdl.FontWeight = 'bold';
                axHdl.XLim = [min(b) max(b)];
                dy = (max(sig) - min(sig))*0.02;
                if (min(sig)-dy < 0) minY = 0; else minY = min(sig)-dy; end
                axHdl.YLim = [minY max(sig)+dy];
                xlabel('b-value [s/mm²]');
                ylabel('log signal [a.u.]');
                figHdl = gcf;
                figHdl.Position = [800,400,1000,600];
            end
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            % get current gui path
            GUI_script = mfilename();                           %name of the file
            GUI_path   = mfilename('fullpath');                 %full path including filename
            GUI_path   = regexprep(GUI_path,GUI_script,'');     %full path without file name

            cd(GUI_path);
            
            % add libraries needed
            % contains restriction models
            addpath('intSrc/helperFunc/');
            addpath('libRestrictionModels/');
            addpath('libFittingModels/');
            addpath('libGradientShapes/');
            addpath('libCore/');
            % some addition libraries
            addpath('extSrc/hvLine/');
            addpath('extSrc/mesher/');
            addpath('extSrc/MyCrust/');
            addpath('extSrc/NOW/');
            addpath(genpath('extSrc/PCT'));

            % init defaults
            app.gradShapeObj = objPGSEshape();

            set( findall(app.ddFWFDataSet, '-property', 'Enable'), 'Enable', 'off');

            set( findall(app.efRadMaxSph, '-property', 'Enable'), 'Enable', 'off');
            set( findall(app.efRadMinSph, '-property', 'Enable'), 'Enable', 'off');            
            
            set( findall(app.efRadMaxCyl, '-property', 'Enable'), 'Enable', 'off');
            set( findall(app.efRadMinCyl, '-property', 'Enable'), 'Enable', 'off');
            
            %app.bgSphGammaSelectionChanged();
            %app.bgSphGevSelectionChanged();
            %app.bgCylGammaSelectionChanged();
            %app.bgCylGevSelectionChanged();
            set( findall(app.bgSphGamma, '-property', 'Enable'), 'Enable', 'off');
            set( findall(app.bgSphGev, '-property', 'Enable'), 'Enable', 'off');
            set( findall(app.bgCylGamma, '-property', 'Enable'), 'Enable', 'off');
            set( findall(app.bgCylGev, '-property', 'Enable'), 'Enable', 'off');
            
            %removeToolbarExplorationButtons( findall( app.plotCmpFraction, 'type', 'figure') );
            tmp = app.plotCmpFraction;
            tmp.Toolbar.Visible = 'off';
            disableDefaultInteractivity(tmp);
            %app.plotCmpFraction.CurrentAxes
            %associated_axes = get(tmp, 'axes');
            %set(app.plotCmpFraction, 'MenuBar', 'none');
            %set(app.plotCmpFraction, 'ToolBar', 'none');
            
            app.paraShape.bVec     = [1; 0; 0];
            app.paraShape.rotAx    = [1; 0; 0];
            app.paraShape.rotAngle = 0;
            
            % exchange structure to provide information to external
            % functions
            data = guidata( app.DIFSIMUIFigure );
                % status of the simulation
                data.simStatus = 'stopped'; % possible indications: 'stopped', 'running', 'sig_break'
            guidata( app.DIFSIMUIFigure, data );
        end

        % Value changed function: ddGradType
        function ddGradTypeValueChanged(app, event)
            value = app.ddGradType.Value;
            app.plotGradShape.cla;
            
            %app.paraShape = [];
            
            app.paraShape.TE           = app.efTE.Value;
            app.paraShape.deltaT       = app.efStepWidth.Value;
            switch value
                case 'PGSE'
                    app.tgGradTypes.SelectedTab      = app.PGSETab;
                    app.tgBValueSettings.SelectedTab = app.linBTensorTab;
                    
                    app.gradShapeObj = objPGSEshape();
                    
                    app.paraShape.delta    = app.efPGSE_delta.Value;    % ms
                    app.paraShape.Delta    = app.efPGSE_Delta.Value;    % ms
                    
                    try
                        app.gradShapeObj.Init(app.paraShape);
                    catch
                        msg = app.gradShapeObj.excMsg;
                        title = 'Initialization error';
                        uiconfirm(app.DIFSIMUIFigure,msg,title,...
                                  'Options',{'OK'},...
                                  'DefaultOption', 1,...
                                  'CancelOption',  1,...
                                  'Icon','error');                        
                    end
                case 'OGSE'
                    app.tgGradTypes.SelectedTab      = app.OGSETab;
                    app.tgBValueSettings.SelectedTab = app.linBTensorTab;
                    
                    app.gradShapeObj = objOGSEshape();
                                        
                    app.paraShape.noPeriods = app.efOGSE_periods.Value;
                    app.paraShape.alpha     = app.efOGSE_alpha.Value;
                    if (app.ddOGSE_polaritylue.Value == "positive")
                        app.paraShape.polarity  = +1; % polarity of the second gradient
                    end
                    if (app.ddOGSE_polaritylue.Value == "negative")
                        app.paraShape.polarity  = -1; % polarity of the second gradient
                    end
                    
                    try
                        app.gradShapeObj.Init(app.paraShape);
                    catch
                        msg = app.gradShapeObj.excMsg;
                        title = 'Initialization error';
                        uiconfirm(app.DIFSIMUIFigure,msg,title,...
                                  'Options',{'OK'},...
                                  'DefaultOption', 1,...
                                  'CancelOption',  1,...
                                  'Icon','error');                        
                    end                        
                case 'FWF'
                    app.tgGradTypes.SelectedTab      = app.FWFTab;
                    app.tgBValueSettings.SelectedTab = app.hoBTensorTab;

                    app.gradShapeObj = objFWFshape();
                    
                    app.paraShape.interpolType = app.ddInterpolType.Value;
                    app.paraShape.tensorType   = app.ddTensorType.Value;
                    app.paraShape.Gmax         = app.efFWFGmax.Value;
                    app.paraShape.MaxwellIdx   = app.efFWFMaxwellIdx.Value;
    
                    
                    try
                        app.gradShapeObj.Init(app.paraShape);
                    catch
                        msg = app.gradShapeObj.excMsg;
                        title = 'Initialization error';
                        uiconfirm(app.DIFSIMUIFigure,msg,title,...
                                  'Options',{'OK'},...
                                  'DefaultOption', 1,...
                                  'CancelOption',  1,...
                                  'Icon','error');                        
                    end                    
                    app.ddFWFDataSet.Items = app.gradShapeObj.getFwfList();
            end
        end

        % Value changed function: efPGSE_Delta
        function efPGSE_DeltaValueChanged(app, event)
            value = app.efPGSE_Delta.Value;
            if ( app.efPGSE_delta.Value + app.efPGSE_Delta.Value > app.efTE.Value )
                app.efPGSE_Delta.Value = app.efTE.Value - 2*app.efPGSE_delta.Value;
            end
            app.efPGSE_Delta.Limits = [app.efStepWidth.Value/1000, app.efTE.Value - 2*app.efPGSE_delta.Value];
        end

        % Button pushed function: bShowGrad
        function bShowGradButtonPushed(app, event)
            app.bValueTable.Data = linspace(app.ef_bValueMin.Value,app.ef_bValueMax.Value,app.ef_bValueNo.Value)';
        
            gradType = app.ddGradType.Value;
            
            %app.paraShape = [];

            app.paraShape.TE        = app.efTE.Value;
            app.paraShape.deltaT    = app.efStepWidth.Value;
            
            switch gradType
                case 'PGSE'
                    app.plotGradShape.YLim = [0, 1.1];
                    
                    app.paraShape.delta    = app.efPGSE_delta.Value;    % ms
                    app.paraShape.Delta    = app.efPGSE_Delta.Value;    % ms
                    
%                     try
                        app.gradShapeObj.Init(app.paraShape);
%                     catch
%                         msg = app.gradShapeObj.excMsg;
%                         title = 'Initialization error';
%                         uiconfirm(app.DIFSIMUIFigure,msg,title,...
%                                   'Options',{'OK'},...
%                                   'DefaultOption',1,...
%                                   'CancelOption',1,...
%                                   'Icon','error');                        
%                     end                    
                    app.efPGSE_TD.Value = app.gradShapeObj.TdEff;
                    app.plotGradShape.cla;
                    app.gradShapeObj.createPlot( app.plotGradShape );
                    app.gradShapeObj.createTensorPlot( app.plotDifTensor );
                case 'OGSE'
                    app.plotGradShape.YLim = [-1.1, 1.1];
                    
                    app.paraShape.noPeriods = app.efOGSE_periods.Value;
                    app.paraShape.alpha     = app.efOGSE_alpha.Value;
                    if (app.ddOGSE_polaritylue.Value == "positive")
                        app.paraShape.polarity  = +1; % polarity of the second gradient
                    end
                    if (app.ddOGSE_polaritylue.Value == "negative")
                        app.paraShape.polarity  = -1; % polarity of the second gradient
                    end
                    
%                     try
                        app.gradShapeObj.Init(app.paraShape);
%                     catch
%                         msg = app.gradShapeObj.excMsg;
%                         title = 'Initialization error';
%                         uiconfirm(app.DIFSIMUIFigure,msg,title,...
%                                   'Options',{'OK'},...
%                                   'DefaultOption',1,...
%                                   'CancelOption',1,...
%                                   'Icon','error');                        
%                     end                    
                    app.efOGSE_TD.Value = app.gradShapeObj.TdEff;
                    app.plotGradShape.cla;
                    app.gradShapeObj.createPlot( app.plotGradShape );
                    app.gradShapeObj.createTensorPlot( app.plotDifTensor );
                case 'FWF'
                    app.plotGradShape.YLim = [-1.1, 1.1];

                    app.paraShape.interpolType = app.ddInterpolType.Value;
                    app.paraShape.tensorType   = app.ddTensorType.Value;
                    app.paraShape.Gmax         = app.efFWFGmax.Value;
                    app.paraShape.MaxwellIdx   = app.efFWFMaxwellIdx.Value;
    
%                     try
                        app.gradShapeObj.Init(app.paraShape);
%                     catch
%                         msg = app.gradShapeObj.excMsg;
%                         title = 'Initialization error';
%                         uiconfirm(app.DIFSIMUIFigure,msg,title,...
%                                   'Options',{'OK'},...
%                                   'DefaultOption', 1,...
%                                   'CancelOption',  1,...
%                                   'Icon','error');                        
%                     end                    
                    app.plotGradShape.cla;
                    if (app.gradShapeObj.prepGrad() )
                        app.gradShapeObj.createPlot( app.plotGradShape );
                        app.gradShapeObj.createTensorPlot( app.plotDifTensor );
                    else
                        msg = 'No FWF data set available. Please create or load a data set.';
                        title = 'FWF Optimization';
                        uiconfirm(app.DIFSIMUIFigure,msg,title,...
                                  'Options',{'OK'},...
                                  'DefaultOption', 1,...
                                  'CancelOption',  1,...
                                  'Icon','warning');                        
                    end
            end
        end

        % Selection changed function: bgMenu
        function bgMenuSelectionChanged(app, event)
            selectedButton = app.bgMenu.SelectedObject;
            switch selectedButton.Text
                case 'General Settings'
                    app.tgControlPanel.SelectedTab = app.SeqTab;
                case 'Gradient Settings'
                    app.tgControlPanel.SelectedTab = app.GradTab;
                case 'Sample Settings'
                    app.tgControlPanel.SelectedTab = app.SmpTab;
                case 'Simulate'
                    app.tgControlPanel.SelectedTab = app.SimTab;
                case 'About'
                    app.tgControlPanel.SelectedTab = app.AboutTab;
            end            
        end

        % Button pushed function: bFWFCreate
        function bFWFCreateButtonPushed(app, event)
                app.plotGradShape.cla;
                
                %app.paraShape = [];
        
                app.paraShape.TE           = app.efTE.Value;
                app.paraShape.deltaT       = app.efStepWidth.Value;
                app.paraShape.interpolType = app.ddInterpolType.Value;
                app.paraShape.tensorType   = app.ddTensorType.Value;
                app.paraShape.Gmax         = app.efFWFGmax.Value;
                app.paraShape.MaxwellIdx   = app.efFWFMaxwellIdx.Value;

                try
                    app.gradShapeObj.Init(app.paraShape);
                catch
                    msg = app.gradShapeObj.excMsg;
                    title = 'Initialization error';
                    uiconfirm(app.DIFSIMUIFigure,msg,title,...
                              'Options',{'OK'},...
                              'DefaultOption',1,...
                              'CancelOption',1,...
                              'Icon','error');                        
                end                    

                guiHdl = uiprogressdlg(app.DIFSIMUIFigure,'Title','FWF Optimization',...
                                                                  'Message','FWF optimization is running. This might take a while ...', ...
                                                                  'Indeterminate','on', ...
                                                                  'Cancelable','on' );
                
                data = guidata( app.DIFSIMUIFigure );
                data.progressHdl  = guiHdl;
                data.timerElapsed = false;
                guidata( app.DIFSIMUIFigure, data );
                    
                timeOut = 300; % [s] default 5min = 300s
                tHdl = timer('TimerFcn', {@app.cbCloseProgressDlg guiHdl}, 'StartDelay', timeOut);%300); % timeout of 5 min for creation of FWF
                start(tHdl);
                
                app.gradShapeObj.optimizeFWF();
                
                stop(tHdl);
        end

        % Selection changed function: ButtonGroup
        function ButtonGroupSelectionChanged(app, event)
            selectedButton = app.ButtonGroup.SelectedObject;
            
            %app.paraShape = [];
            
            switch selectedButton
                    case app.rbCreate
                    app.plotGradShape.cla;
            
                    app.paraShape.TE           = app.efTE.Value;
                    app.paraShape.deltaT       = app.efStepWidth.Value;
                    app.paraShape.interpolType = app.ddInterpolType.Value;
                    app.paraShape.tensorType   = app.ddTensorType.Value;
                    app.paraShape.Gmax         = app.efFWFGmax.Value;
                    app.paraShape.MaxwellIdx   = app.efFWFMaxwellIdx.Value;
    
                    try
                        app.gradShapeObj.Init(app.paraShape);
                    catch
                        msg = app.gradShapeObj.excMsg;
                        title = 'Initialization error';
                        uiconfirm(app.DIFSIMUIFigure,msg,title,...
                                  'Options',{'OK'},...
                                  'DefaultOption',1,...
                                  'CancelOption',1,...
                                  'Icon','error');                        
                    end                    
                    
                    set( findall(app.ddTensorType, '-property', 'Enable'), 'Enable', 'on');
                    set( findall(app.efFWFName, '-property', 'Enable'), 'Enable', 'on');
                    set( findall(app.bFWFCreate, '-property', 'Enable'), 'Enable', 'on');
                    set( findall(app.bFWFSave, '-property', 'Enable'), 'Enable', 'on');
                    set( findall(app.efFWFGmax , '-property', 'Enable'), 'Enable', 'on');
                    set( findall(app.efFWFMaxwellIdx, '-property', 'Enable'), 'Enable', 'on');                    
                    set( findall(app.ddFWFDataSet, '-property', 'Enable'), 'Enable', 'off');
                case app.rbLoad
                    app.ddFWFDataSet.Items = app.gradShapeObj.getFwfList();
                    
                    set( findall(app.ddTensorType, '-property', 'Enable'), 'Enable', 'off');
                    set( findall(app.efFWFName, '-property', 'Enable'), 'Enable', 'off');
                    set( findall(app.bFWFCreate, '-property', 'Enable'), 'Enable', 'off');
                    set( findall(app.bFWFSave, '-property', 'Enable'), 'Enable', 'off');
                    set( findall(app.efFWFGmax , '-property', 'Enable'), 'Enable', 'off');
                    set( findall(app.efFWFMaxwellIdx, '-property', 'Enable'), 'Enable', 'off');                    
                    set( findall(app.ddFWFDataSet, '-property', 'Enable'), 'Enable', 'on');
                    
                    value = app.ddFWFDataSet.Value;
                    app.gradShapeObj.setCurrentFwfStruct(value);
            end
        end

        % Value changed function: ddTensorType
        function ddTensorTypeValueChanged(app, event)
            value = app.ddTensorType.Value;
            app.plotGradShape.cla;
            
            %app.paraShape = [];

            app.gradShapeObj = objFWFshape();
            
            app.paraShape.TE           = app.efTE.Value;
            app.paraShape.deltaT       = app.efStepWidth.Value;
            app.paraShape.interpolType = app.ddInterpolType.Value;
            app.paraShape.tensorType   = value;
            app.paraShape.Gmax         = app.efFWFGmax;
            app.paraShape.MaxwellIdx   = app.efFWFMaxwellIdx;
            
            try
                app.gradShapeObj.Init(app.paraShape);
            catch
                msg = app.gradShapeObj.excMsg;
                title = 'Initialization error';
                uiconfirm(app.DIFSIMUIFigure,msg,title,...
                          'Options',{'OK'},...
                          'DefaultOption',1,...
                          'CancelOption',1,...
                          'Icon','error');
            end                    
        end

        % Value changed function: ddFWFDataSet
        function ddFWFDataSetValueChanged(app, event)
            value = app.ddFWFDataSet.Value;
            app.gradShapeObj.setCurrentFwfStruct(value);
        end

        % Button pushed function: bFWFSave
        function bFWFSaveButtonPushed(app, event)
            app.gradShapeObj.save(app.efFWFName.Value);
        end

        % Button pushed function: bCmpAdd
        function bCmpAddButtonPushed(app, event)
            % check if name already exits in structure, and if so display
            % warning overwrite message dialog
            currentItemIdx = ( size(app.lbCompartment.Items,2) + 1);
            saveCmp = true;
            
            items = app.lbCompartment.Items;
            for itemItx = 1:length(items)
                if ( strcmp(items{itemItx}, app.efCmpName.Value) )
                    msg = ['Compartment "' app.efCmpName.Value '" already exists. Do you want to replace it?'];
                    title = 'Compartment creation';
                    selection = uiconfirm(app.DIFSIMUIFigure,msg,title,...
                                          'Options',{'Yes','No'},...
                                          'DefaultOption',1,...
                                          'CancelOption', 2,...
                                          'Icon','warning');
                    saveCmp        = strcmp(selection,'Yes');
                    currentItemIdx = itemItx;
                    break;
                end
            end
            
            if ( ~strcmp(app.efCmpName.Value,'') )
            % only if we are allowed to save we do so
                if (saveCmp)
                    %disp ('Save');
                    % readjust list which stores compartment overview 
                    app.lbCompartment.Items{currentItemIdx}     = app.efCmpName.Value;
                    app.lbCompartment.ItemsData{currentItemIdx} = app.saveCmpStruct();

                    %% create restriction object
                    % prepare restriction object for testing
                    rstPara = [];
                    % initialize default parameters
                    rstPara.freeADC   = app.efTestADC.Value;
                    rstPara.stepWidth = app.efTestStepWidth.Value;
                    rstPara.noPart    = app.efTestNoParticles.Value;
                    rstPara.noItr     = app.efTestNoIterations.Value;
                    switch app.tgCmpSelect.SelectedTab
                        case app.freeTab
                            app.lbCompartment.ItemsData{currentItemIdx}.rstObj = objFreeDiffusion(rstPara);
                        case app.spheresTab
                            if (isa(app.radiusDistFunct,'double'))
                                eval(['rstPara.radius = @(n) ones([1 n])*' num2str(app.radiusDistFunct) ';']);
                                %rstPara.radius = @(n) ones([1 n])*app.radiusDistFunct;
                            else
                                %rstPara.radius = @(n) random(app.radiusDistFunct,[1 n]);
                                eval(['rstPara.radius = @(n) random(' app.radiusDistFunctStr ',[1 n]);']);
                            end
                            app.lbCompartment.ItemsData{currentItemIdx}.rstObj = objSpheres(rstPara);
                        case app.cylindersTab
                            if (isa(app.radiusDistFunct,'double'))
                                eval(['rstPara.radius = @(n) ones([1 n])*' num2str(app.radiusDistFunct) ';']);
                                %rstPara.radius = @(n) ones([1 n])*app.radiusDistFunct;
                            else
                                %rstPara.radius = @(n) random(app.radiusDistFunct,[1 n]);
                                eval(['rstPara.radius = @(n) random(' app.radiusDistFunctStr ',[1 n]);']);
                            end
                            switch app.ddDispersionOptCyl.Value
                                case 'non (parallel)'
                                    rstPara.InitOpt = 'parallel';
                                    rstPara.mainAx = app.ddMainAxisOptPara.Value;
                                case 'partially'
                                    rstPara.dispAngle = app.efDispAngle.Value;
                                    rstPara.mainAx    = app.ddMainAxisOptPart.Value;
                                    rstPara.InitOpt   = 'partially_dispersed';
                                case 'fully'
                                    rstPara.InitOpt   = 'fully_dispersed';
                            end                           
                            app.lbCompartment.ItemsData{currentItemIdx}.rstObj = objCylBundles(rstPara);
                    end
                    
                    
                    % global parameters
                    %app.restDefObjList(currentItemIdx).name      = app.efCmpName.Value;
                    %app.restDefObjList(currentItemIdx).frac      = app.efCmpFraction.Value; 
                    %app.restDefObjList(currentItemIdx).cmpStruct = app.saveCmpStruct();
                    
    %                 switch app.tgCmpSelect.SelectedTab
    %                     case app.freeTab
    %                         %app.restDefObjList(newItemIdx).objHdl = objFreeDiffusion();
    %                     case app.spheresTab
    %                         % collect all important parameters
    %                         guiSet = []; % store important gui settings to restore previous state (e.g. if loaded)
    %                         switch app.tgRadDistSph.SelectedTab
    %                             case app.deltaTabSph
    %                             case app.gammaTabSph
    %                             case app.gevTabSph
    %                         end
    %                         
    %                         app.restDefObjList(newItemIdx).objHdl = objSpheres();
    %                     case app.cylindersTab
    %                         switch app.tgRadDistCyl.SelectedTab
    %                             case app.deltaTabCyl
    %                             case app.gammaTabCyl
    %                             case app.gevTabCyl
    %                         end
    %                         %app.restDefObjList(newItemIdx).objHdl = objCylBundles();
    %                 end
                end
                
                app.updateCmpBar();
            else
                msg = ['Please enter a compartment name.'];
                title = 'Compartment creation';
                selection = uiconfirm(app.DIFSIMUIFigure,msg,title,...
                                      'Options',{'OK'},...
                                      'DefaultOption',1,...
                                      'CancelOption', 1,...
                                      'Icon','warning');                
            end
            % general parameters
            
            
            % parameters for free diffusion
            %para.noMol ?
            %para.ADCfree ?
            
            
            % parameters for spherical-restricted diffusion
            %para.radius
            %para.dstCnt 'true', 'false'
            %para.noMol
            
            
            % parameters for cylindrical-restricted diffusion
            %para.InitOpt 'parallel', 'fully_dispersed', 'partially_dispersed'
            %    para.mainAx
                
            %para.ADCfree
            %para.radius
            %para.noMol
            %para.dstCnt 'true', 'false'
            %para.deltaT ??
            %para.TE ??
            
            %app.restDefObjList(newItemIdx).name   = 'name';
            %app.restDefObjList(newItemIdx).type   = 'type';
            
            %app.restDefObjList(newItemIdx).objHdl = objFreeDiffusion();
            %restPara      = [];
            %restPara.Idx  =  1;
            %restPara.Frac =  1;
            %app.restDefObjList(1).obj.Init(restPara);
        end

        % Value changed function: ddCmpSelect
        function ddCmpSelectValueChanged(app, event)
            value = app.ddCmpSelect.Value;
            switch value
                case 'free'
                    app.tgCmpSelect.SelectedTab = app.freeTab;
                case 'spheres'
                    app.tgCmpSelect.SelectedTab = app.spheresTab;
                    app.radiusDistFunct = app.efRadSph.Value*1e-6;
                case 'cylinders'
                    app.tgCmpSelect.SelectedTab = app.cylindersTab;
                    app.radiusDistFunct = app.efRadCyl.Value*1e-6;
            end            
        end

        % Value changed function: ddRadDistCyl
        function ddRadDistCylValueChanged(app, event)
            value = app.ddRadDistCyl.Value;
            switch value
                case 'delta'
                    app.tgRadDistCyl.SelectedTab = app.deltaTabCyl;

                    set( findall(app.efRadMaxCyl, '-property', 'Enable'), 'Enable', 'off');
                    set( findall(app.efRadMinCyl, '-property', 'Enable'), 'Enable', 'off');
                    
                    set( findall(app.efRadCyl, '-property', 'Enable'), 'Enable', 'on');
                    
                    app.radiusDistFunct = app.efRadCyl.Value*1e-6;
                case 'gamma'
                    app.tgRadDistCyl.SelectedTab = app.gammaTabCyl;
                    
                    set( findall(app.efRadMaxCyl, '-property', 'Enable'), 'Enable', 'on');
                    set( findall(app.efRadMinCyl, '-property', 'Enable'), 'Enable', 'on');
                    
                    if ( strcmp(app.swCylGammaRadiusAuto.Value,'Off') )
                        set( findall(app.efRadCyl, '-property', 'Enable'), 'Enable', 'off');
                    else
                        set( findall(app.efRadCyl, '-property', 'Enable'), 'Enable', 'on');
                    end

                    app.gammaOpt();                    
                case 'GEV'
                    app.tgRadDistCyl.SelectedTab = app.gevTabCyl;
                    
                    set( findall(app.efRadMaxCyl, '-property', 'Enable'), 'Enable', 'on');
                    set( findall(app.efRadMinCyl, '-property', 'Enable'), 'Enable', 'on');                    
                    
                    if ( strcmp(app.swCylGevRadiusAuto.Value,'Off') )
                        set( findall(app.efRadCyl, '-property', 'Enable'), 'Enable', 'off');
                    else
                        set( findall(app.efRadCyl, '-property', 'Enable'), 'Enable', 'on');
                    end
                    
                    app.gevOpt();
            end
        end

        % Value changed function: ddRadDistSph
        function ddRadDistSphValueChanged(app, event)
            value = app.ddRadDistSph.Value;
            switch value
                case 'delta'
                    app.tgRadDistSph.SelectedTab = app.deltaTabSph;

                    set( findall(app.efRadMaxSph, '-property', 'Enable'), 'Enable', 'off');
                    set( findall(app.efRadMinSph, '-property', 'Enable'), 'Enable', 'off');
                    
                    set( findall(app.efRadSph, '-property', 'Enable'), 'Enable', 'on');
                    
                    app.radiusDistFunct = app.efRadSph.Value*1e-6;
                case 'gamma'
                    app.tgRadDistSph.SelectedTab = app.gammaTabSph;
                    
                    set( findall(app.efRadMaxSph, '-property', 'Enable'), 'Enable', 'on');
                    set( findall(app.efRadMinSph, '-property', 'Enable'), 'Enable', 'on');
                    
                    if ( strcmp(app.swSphGammaRadiusAuto.Value,'Off') )
                        set( findall(app.efRadSph, '-property', 'Enable'), 'Enable', 'off');
                    else
                        set( findall(app.efRadSph, '-property', 'Enable'), 'Enable', 'on');
                    end
                    
                    app.gammaOpt();
                case 'GEV'
                    app.tgRadDistSph.SelectedTab = app.gevTabSph;
                    
                    set( findall(app.efRadMaxSph, '-property', 'Enable'), 'Enable', 'on');
                    set( findall(app.efRadMinSph, '-property', 'Enable'), 'Enable', 'on');                    
                    
                    if ( strcmp(app.swSphGevRadiusAuto.Value,'Off') )
                        set( findall(app.efRadSph, '-property', 'Enable'), 'Enable', 'off');
                    else
                        set( findall(app.efRadSph, '-property', 'Enable'), 'Enable', 'on');
                    end
                    
                    app.gevOpt();
            end            
        end

        % Value changed function: efCmpFraction
        function efCmpFractionValueChanged(app, event)
            value = app.efCmpFraction.Value;
            app.efCmpFraction.Value = round(value);
        end

        % Value changed function: ef_bVecX, ef_bVecY, ef_bVecZ
        function bVecValueChange(app, event)
            app.ef_bVecXNorm.Value = app.ef_bVecX.Value/norm([app.ef_bVecX.Value app.ef_bVecY.Value app.ef_bVecZ.Value]);
            app.ef_bVecYNorm.Value = app.ef_bVecY.Value/norm([app.ef_bVecX.Value app.ef_bVecY.Value app.ef_bVecZ.Value]);
            app.ef_bVecZNorm.Value = app.ef_bVecZ.Value/norm([app.ef_bVecX.Value app.ef_bVecY.Value app.ef_bVecZ.Value]);
            app.paraShape.bVec = [app.ef_bVecXNorm.Value; app.ef_bVecYNorm.Value; app.ef_bVecZNorm.Value ];
        end

        % Value changed function: ef_RotAxX, ef_RotAxY, ef_RotAxZ
        function rotAxValueChange(app, event)
            value = app.ef_RotAxX.Value;
            app.ef_RotAxXNorm.Value = app.ef_RotAxX.Value/norm([app.ef_RotAxX.Value app.ef_RotAxY.Value app.ef_RotAxZ.Value]);
            app.ef_RotAxYNorm.Value = app.ef_RotAxY.Value/norm([app.ef_RotAxX.Value app.ef_RotAxY.Value app.ef_RotAxZ.Value]);
            app.ef_RotAxZNorm.Value = app.ef_RotAxZ.Value/norm([app.ef_RotAxX.Value app.ef_RotAxY.Value app.ef_RotAxZ.Value]);
            app.paraShape.rotAx = [app.ef_RotAxXNorm.Value; app.ef_RotAxYNorm.Value; app.ef_RotAxZNorm.Value ];
        end

        % Value changed function: ef_rotAngle
        function ef_rotAngleValueChanged(app, event)
            value = app.ef_rotAngle.Value;
            app.paraShape.rotAngle = value;
        end

        % Callback function
        function bgGammaDistSelectionChanged(app, event)
            selectedButton = app.bgGammaDist.SelectedObject;
            switch selectedButton
                case app.rbShapeGamma
                    set( findall(app.efShapeGamma, '-property', 'Enable'), 'Enable', 'on');
                    set( findall(app.efScaleGamma, '-property', 'Enable'), 'Enable', 'off');
                case app.rbScaleGamma
                    set( findall(app.efShapeGamma, '-property', 'Enable'), 'Enable', 'off');
                    set( findall(app.efScaleGamma, '-property', 'Enable'), 'Enable', 'on');
            end
        end

        % Button pushed function: bVisProbDistSph
        function bVisProbDistSphButtonPushed(app, event)
            cla(app.plotRadiiProbDist);
            if ( isobject(app.radiusDistFunct) ) % any type of probability distribution
                % find case to plot
                %rmin = 1e-7;
                %rmax = 1e-5;
                x = linspace(app.efRadMinSph.Value*1e-6, app.efRadMaxSph.Value*1e-6, 10000);
                y = pdf(app.radiusDistFunct,x);
                rRndFct = @(n) random(app.radiusDistFunct,[1 n]);
                
                hold(app.plotRadiiProbDist,'on');
                h = histogram(app.plotRadiiProbDist,rRndFct(10000),'Normalization','probability');
                h.BinWidth = 0.1e-6;
                maxHist = max(h.Values);
                %histfit(app.plotRadiiProbDist,rRndFct(100000),400,'gev');
                plot(app.plotRadiiProbDist,x,y/max(y)*maxHist,'b','LineWidth',1.5);
                xline(app.plotRadiiProbDist,mean(app.radiusDistFunct),'r','LineWidth',1.5);
                hold(app.plotRadiiProbDist,'off');
                app.plotRadiiProbDist.YTickLabel = [];
            else % delta function
                x = linspace(app.efRadMinSph.Value*1e-6, app.efRadMaxSph.Value*1e-6, 10000);
                x = sort(unique([x app.radiusDistFunct]));
                y = dirac(x-app.radiusDistFunct);
                y(y==inf) = 100;
                plot(app.plotRadiiProbDist,x, y);
                app.plotRadiiProbDist.YTickLabel = [];
                %app.plotRadiiProbDist.XLim = [app.efRadMinSph.Value*1e-6; app.efRadMaxSph.Value*1e-6];
            end
            app.plotRadiiProbDist.XLim = [0 app.efRadMaxSph.Value*1e-6];
        end

        % Value changed function: swCylGammaRadiusAuto
        function swCylGammaRadiusAutoValueChanged(app, event)
            value = app.swCylGammaRadiusAuto.Value;
            if (strcmp(value,'On') )
                set( findall(app.bgCylGamma, '-property', 'Enable'), 'Enable', 'on');
                app.bgCylGammaSelectionChanged();
                app.gammaOpt();
            else
                set( findall(app.bgCylGamma, '-property', 'Enable'), 'Enable', 'off');
                
                app.efCylGammaShape.Editable = 'on';
                app.efCylGammaScale.Editable = 'on';
                %set( findall(app.efCylGammaShape, '-property', 'Enable'), 'Enable', 'on');
                %set( findall(app.efCylGammaScale, '-property', 'Enable'), 'Enable', 'on');
            end
            
            if ( strcmp(app.swCylGammaRadiusAuto.Value,'Off') )
                set( findall(app.efRadCyl, '-property', 'Enable'), 'Enable', 'off');
            else
                set( findall(app.efRadCyl, '-property', 'Enable'), 'Enable', 'on');
            end            
        end

        % Value changed function: swCylGevRadiusAuto
        function swCylGevRadiusAutoValueChanged(app, event)
            value = app.swCylGevRadiusAuto.Value;
            if (strcmp(value,'On') )
                set( findall(app.bgCylGev, '-property', 'Enable'), 'Enable', 'on');
                app.bgCylGevSelectionChanged();
                app.gevOpt();
            else
                set( findall(app.bgCylGev, '-property', 'Enable'), 'Enable', 'off');
                
                app.efCylGevShape.Editable = 'on';
                app.efCylGevScale.Editable = 'on';
                app.efCylGevLocation.Editable = 'on';
                %set( findall(app.efCylGevShape, '-property', 'Enable'), 'Enable', 'on');
                %set( findall(app.efCylGevScale, '-property', 'Enable'), 'Enable', 'on');
                %set( findall(app.efCylGevLocation, '-property', 'Enable'), 'Enable', 'on');
            end
            
            if ( strcmp(app.swCylGevRadiusAuto.Value,'Off') )
                set( findall(app.efRadCyl, '-property', 'Enable'), 'Enable', 'off');
            else
                set( findall(app.efRadCyl, '-property', 'Enable'), 'Enable', 'on');
            end                        
        end

        % Value changed function: swSphGammaRadiusAuto
        function swSphGammaRadiusAutoValueChanged(app, event)
            value = app.swSphGammaRadiusAuto.Value;
            if (strcmp(value,'On') )
                set( findall(app.bgSphGamma, '-property', 'Enable'), 'Enable', 'on');
                app.bgSphGammaSelectionChanged();
                app.gammaOpt();
            else
                set( findall(app.bgSphGamma, '-property', 'Enable'), 'Enable', 'off');
                
                app.efSphGammaShape.Editable = 'on';
                app.efSphGammaScale.Editable = 'on';
                %set( findall(app.efSphGammaShape, '-property', 'Enable'), 'Enable', 'on');
                %set( findall(app.efSphGammaScale, '-property', 'Enable'), 'Enable', 'on');
            end    
            
            if ( strcmp(app.swSphGammaRadiusAuto.Value,'Off') )
                set( findall(app.efRadSph, '-property', 'Enable'), 'Enable', 'off');
            else
                set( findall(app.efRadSph, '-property', 'Enable'), 'Enable', 'on');
            end                                    
        end

        % Value changed function: swSphGevRadiusAuto
        function swSphGevRadiusAutoValueChanged(app, event)
            value = app.swSphGevRadiusAuto.Value;
            if (strcmp(value,'On') )
                set( findall(app.bgSphGev, '-property', 'Enable'), 'Enable', 'on');
                app.bgSphGevSelectionChanged();
                app.gevOpt();
            else
                set( findall(app.bgSphGev, '-property', 'Enable'), 'Enable', 'off');
                
                app.efSphGevShape.Editable = 'on';
                app.efSphGevScale.Editable = 'on';
                app.efSphGevLocation.Editable = 'on';
                %set( findall(app.efSphGevShape, '-property', 'Enable'), 'Enable', 'on');
                %set( findall(app.efSphGevScale, '-property', 'Enable'), 'Enable', 'on');
                %set( findall(app.efSphGevLocation, '-property', 'Enable'), 'Enable', 'on');
            end
            
            if ( strcmp(app.swSphGevRadiusAuto.Value,'Off') )
                set( findall(app.efRadSph, '-property', 'Enable'), 'Enable', 'off');
            else
                set( findall(app.efRadSph, '-property', 'Enable'), 'Enable', 'on');
            end            
        end

        % Selection changed function: bgSphGamma
        function bgSphGammaSelectionChanged(app, event)
            selectedButton = app.bgSphGamma.SelectedObject;
            switch selectedButton
                case app.rbSphGammaShape
                    app.efSphGammaShape.Editable = 'off';
                    app.efSphGammaScale.Editable = 'on';
                case app.rbSphGammaScale
                    app.efSphGammaShape.Editable = 'on';
                    app.efSphGammaScale.Editable = 'off';
            end
        end

        % Selection changed function: bgCylGamma
        function bgCylGammaSelectionChanged(app, event)
            selectedButton = app.bgCylGamma.SelectedObject;
            switch selectedButton
                case app.rbCylGammaShape
                    app.efCylGammaShape.Editable = 'off';
                    app.efCylGammaScale.Editable = 'on';
                case app.rbCylGammaScale
                    app.efCylGammaShape.Editable = 'on';
                    app.efCylGammaScale.Editable = 'off';
            end            
        end

        % Selection changed function: bgSphGev
        function bgSphGevSelectionChanged(app, event)
            selectedButton = app.bgSphGev.SelectedObject;
            switch selectedButton
                case app.rbSphGevShape
                    app.efSphGevShape.Editable = 'off';
                    app.efSphGevScale.Editable = 'on';
                    app.efSphGevLocation.Editable = 'on';
                case app.rbSphGevScale
                    app.efSphGevShape.Editable = 'on';
                    app.efSphGevScale.Editable = 'off';
                    app.efSphGevLocation.Editable = 'on';
                case app.rbSphGevLocation
                    app.efSphGevShape.Editable = 'on';
                    app.efSphGevScale.Editable = 'on';
                    app.efSphGevLocation.Editable = 'off';
            end
        end

        % Selection changed function: bgCylGev
        function bgCylGevSelectionChanged(app, event)
            selectedButton = app.bgCylGev.SelectedObject;
            switch selectedButton
                case app.rbCylGevShape
                    app.efCylGevShape.Editable = 'off';
                    app.efCylGevScale.Editable = 'on';
                    app.efCylGevLocation.Editable = 'on';
                case app.rbCylGevScale
                    app.efCylGevShape.Editable = 'on';
                    app.efCylGevScale.Editable = 'off';
                    app.efCylGevLocation.Editable = 'on';
                case app.rbCylGevLocation
                    app.efCylGevShape.Editable = 'on';
                    app.efCylGevScale.Editable = 'on';
                    app.efCylGevLocation.Editable = 'off';
            end            
        end

        % Value changed function: efCylGammaScale, efCylGammaShape, 
        % efSphGammaScale, efSphGammaShape
        function gammaValueChanged(app, event)
            %value = app.efCylGammaShape.Value;
                app.gammaOpt();
        end

        % Value changed function: efRadSph
        function efRadSphValueChanged(app, event)
            %value = app.efRadSph.Value;
            switch app.tgRadDistSph.SelectedTab
                case app.deltaTabSph
                    app.radiusDistFunct = app.efRadSph.Value*1e-6;
                case app.gammaTabSph
                    app.gammaOpt();
                case app.gevTabSph
                    app.gevOpt();
            end
        end

        % Button pushed function: bVisProbDistCyl
        function bVisProbDistCylButtonPushed(app, event)
            cla(app.plotRadiiProbDist);
            if ( isobject(app.radiusDistFunct) ) % any type of probability distribution
                % find case to plot
                %rmin = 1e-7; 
                %rmax = 1e-5;
                x = linspace(app.efRadMinCyl.Value*1e-6, app.efRadMaxCyl.Value*1e-6, 10000);
                y = pdf(app.radiusDistFunct,x);
                rRndFct = @(n) random(app.radiusDistFunct,[1 n]);
                
                %mean(pd)
                
                %figure;
                hold(app.plotRadiiProbDist,'on');
                h = histogram(app.plotRadiiProbDist,rRndFct(10000), 'Normalization','probability');
                h.BinWidth = 0.1e-6;
                maxHist = max(h.Values);
                plot(app.plotRadiiProbDist,x,y/max(y)*maxHist,'b','LineWidth',1.5);
                xline(app.plotRadiiProbDist,mean(app.radiusDistFunct),'r','LineWidth',1.5);
                hold(app.plotRadiiProbDist,'off');
                app.plotRadiiProbDist.YTickLabel = [];
            else % delta function
                x = linspace(app.efRadMinCyl.Value*1e-6, app.efRadMaxCyl.Value*1e-6, 10000);
                x = sort(unique([x app.radiusDistFunct]));
                y = dirac(x-app.radiusDistFunct);
                y(y==inf) = 100;
                plot(app.plotRadiiProbDist,x, y);
                app.plotRadiiProbDist.YTickLabel = [];
                %app.plotRadiiProbDist.XLim = [app.efRadMinSph.Value*1e-6; app.efRadMaxSph.Value*1e-6];
            end
            app.plotRadiiProbDist.XLim = [0 app.efRadMaxCyl.Value*1e-6];
        end

        % Value changed function: efRadCyl
        function efRadCylValueChanged(app, event)
            %value = app.efRadCyl.Value;
            switch app.tgRadDistCyl.SelectedTab
                case app.deltaTabCyl
                    app.radiusDistFunct = app.efRadCyl.Value*1e-6;                
                case app.gammaTabCyl
                    app.gammaOpt();
                case app.gevTabCyl
                    app.gevOpt();
            end            
        end

        % Value changed function: efCylGevLocation, efCylGevScale, 
        % efCylGevShape, efSphGevLocation, efSphGevScale, 
        % efSphGevShape
        function gevValueChanged(app, event)
            %value = app.efSphGevShape.Value;
            app.gevOpt();
        end

        % Button pushed function: bCmpReLoad
        function bCmpReLoadButtonPushed(app, event)
            app.lbCompartment.Value
            app.loadCmpStruct();
            switch app.tgCmpSelect.SelectedTab
                case app.freeTab
                case app.spheresTab
                    switch app.tgRadDistSph.SelectedTab
                        case app.deltaTabSph
                            app.radiusDistFunct = app.efRadSph.Value*1e-6;
                        case app.gammaTabSph
                            app.gammaOpt();
                        case app.gevTabSph
                            app.gevOpt();
                    end            
                case app.cylindersTab
                    switch app.tgRadDistCyl.SelectedTab
                        case app.deltaTabCyl
                            app.radiusDistFunct = app.efRadCyl.Value*1e-6;
                        case app.gammaTabCyl
                            app.gammaOpt();
                        case app.gevTabCyl
                            app.gevOpt();
                    end            
            end
            %app.lbCompartment.
        end

        % Button pushed function: bCmpDelete
        function bCmpDeleteButtonPushed(app, event)
            if ( ~isempty(app.lbCompartment.Value) )
                [~,idx] = ismember(app.lbCompartment.Value.Name,app.lbCompartment.Items);
                if (idx ~=0)
                    app.lbCompartment.Items(idx)     = [];
                    app.lbCompartment.ItemsData(idx) = [];
                else
                     app.lbCompartment.ItemsData(1)  = [];
                end
                app.updateCmpBar();
            end
        end

        % Button pushed function: bTestStart
        function bTestStartButtonPushed(app, event)
            % prepare restriction object for testing
            rstPara = [];
            % initialize default parameters
            rstPara.freeADC   = app.efTestADC.Value;
            rstPara.stepWidth = app.efTestStepWidth.Value;
            rstPara.noPart    = app.efTestNoParticles.Value;
            rstPara.noItr     = app.efTestNoIterations.Value;
            switch app.tgCmpSelect.SelectedTab
                case app.freeTab
                    rstPara.rstObj = objFreeDiffusion(rstPara);
                case app.spheresTab
                    if (isa(app.radiusDistFunct,'double'))
                        rstPara.radius = @(n) ones([1 n])*app.radiusDistFunct;
                    else
                        rstPara.radius = @(n) random(app.radiusDistFunct,[1 n]);
                    end
                    rstPara.rstObj = objSpheres(rstPara);
                case app.cylindersTab
                    if (isa(app.radiusDistFunct,'double'))
                        rstPara.radius = @(n) ones([1 n])*app.radiusDistFunct;
                    else
                        rstPara.radius = @(n) random(app.radiusDistFunct,[1 n]);
                    end
                    switch app.ddDispersionOptCyl.Value
                        case 'non (parallel)'
                            rstPara.InitOpt = 'parallel';
                            rstPara.mainAx = app.ddMainAxisOptPara.Value;
                        case 'partially'
                            rstPara.dispAngle = app.efDispAngle.Value;
                            rstPara.mainAx    = app.ddMainAxisOptPart.Value;
                            rstPara.InitOpt   = 'partially_dispersed';
                        case 'fully'
                            rstPara.InitOpt   = 'fully_dispersed';
                    end
                    
                    rstPara.rstObj = objCylBundles(rstPara);
            end
            %try
                coreTest(rstPara);
            %catch
            %end
        end

        % Value changed function: ddDispersionOptCyl
        function ddDispersionOptCylValueChanged(app, event)
            %value = app.ddDispersionOptCyl.Value;
            switch app.ddDispersionOptCyl.Value
                case 'non (parallel)'
                    app.tgDispersionCyl.SelectedTab = app.emptyTab;
                case 'partially'
                    app.tgDispersionCyl.SelectedTab = app.partiallyTab;
                case 'fully'
                    app.tgDispersionCyl.SelectedTab = app.fullyTab;
            end
        end

        % Button pushed function: bStartSimu
        function bStartSimuButtonPushed(app, event)
            % TODO !!!!!
            %   - implement check for consistent configuration, i.e.
            %       + gradient configuration (gradient object available,
            %         b-values configured)
            %       + restriction model configuration (100% of restrictions
            %         adjusted)
            data = guidata( app.DIFSIMUIFigure );
            %if (exist('data.simStatus','var'))
            %try
                if ( strcmp(data.simStatus,'running') )
                    data.simStatus = 'sig_break'; % possible indications: 'stopped', 'running', 'sig_break'
                    guidata( app.DIFSIMUIFigure, data );
                    %return;
                else
                        % status of the simulation
                        %disp(data.simStatus);
                        data.simStatus = 'running'; % possible indications: 'stopped', 'running', 'sig_break'
                    guidata( app.DIFSIMUIFigure, data );
                    app.bStartSimu.Text = 'STOP';
                    %simApproved = true;
                    
                    % Gradient shape object
                    if ( ~isempty(app.gradShapeObj.grad1) && ~isempty(app.gradShapeObj.grad2) )
                        para.gradShapeObj = app.gradShapeObj;
                    else
                        app.bStartSimu.Text = 'START';
                        data.simStatus = 'stopped';
                        
                        %simApproved = false;
                        msg = ['Gradient settings not configured. Do you want to switch to "Gradient Settings"?'];
                        title = 'Simulation message';
                        selection = uiconfirm(app.DIFSIMUIFigure,msg,title,...
                                              'Options',{'Yes','No'},...
                                              'DefaultOption',1,...
                                              'CancelOption', 2,...
                                              'Icon','warning');
                        if ( strcmp(selection,'Yes') )
                            app.tgControlPanel.SelectedTab = app.GradTab;
                            app.bgMenu.SelectedObject = app.bGradientSettings;
                        end
                        
                        return;
                    end
                    
                    % Restriction collection objects
                    if ( ~isempty(app.lbCompartment.ItemsData) )
                        para.rstCollect = {};
                        totFrac = 0;
                        for itx = 1:length(app.lbCompartment.ItemsData)
                            para.rstCollect{itx}.Name        = app.lbCompartment.ItemsData{itx}.Name;
                            para.rstCollect{itx}.Frac        = app.lbCompartment.ItemsData{itx}.Frac;
                            para.rstCollect{itx}.rstShapeObj = app.lbCompartment.ItemsData{itx}.rstObj;
                            totFrac = totFrac + app.lbCompartment.ItemsData{itx}.Frac;
                        end
                        if (totFrac ~= 100)
                            app.bStartSimu.Text = 'START';
                            data.simStatus = 'stopped';
                            
                            msg = ['Total sample fraction is ' num2str(totFrac) '%. Please ensure a total sample fraction of 100%. Do you want to switch to "Sample Settings"?'];
                            title = 'Simulation message';
                            selection = uiconfirm(app.DIFSIMUIFigure,msg,title,...
                                                  'Options',{'Yes','No'},...
                                                  'DefaultOption',1,...
                                                  'CancelOption', 2,...
                                                  'Icon','warning');
                            if ( strcmp(selection,'Yes') )
                                app.tgControlPanel.SelectedTab = app.SmpTab;
                                app.bgMenu.SelectedObject = app.bSampleSettings;
                            end
                            return;                    
                        end
                    else
                        app.bStartSimu.Text = 'START';
                        data.simStatus = 'stopped';
                        
                        msg = ['No samples configured. Do you want to switch to "Sample Settings"?'];
                        title = 'Simulation message';
                        selection = uiconfirm(app.DIFSIMUIFigure,msg,title,...
                                              'Options',{'Yes','No'},...
                                              'DefaultOption',1,...
                                              'CancelOption', 2,...
                                              'Icon','warning');
                        if ( strcmp(selection,'Yes') )
                            app.tgControlPanel.SelectedTab = app.SmpTab;
                            app.bgMenu.SelectedObject = app.bSampleSettings;
                        end
                        return;
                    end
        
                    % parameters
                        % simulation parameters
                        para.stepWidth = app.efStepWidth.Value;
                        para.autoScale = app.cbAutoScale.Value;
                        para.minNoPart = app.ef_minMolNo.Value;
                        para.maxNoPart = app.ef_maxMolNo.Value;
                        para.repPara   = app.ddReprod.Value;
                        para.VoI       = app.efVoI.Value;
                        % diffusion parameters
                        para.ADC       = app.efADCglobal.Value;
                        para.bValues   = app.bValueTable.Data;
                    
                    % config parameters (not required in consol version)
                    para.outputHdl = app.taLogViewer;
                    
                    app.taLogViewer.Value = '';
                    
                    app.prepResDoc();
                    disp_out( sprintf('\n'), app.taLogViewer );
                    app.simRes = [];
                    app.simRes = coreMain(para);
                    
                    app.bStartSimu.Text = 'START';
                    data.simStatus = 'stopped';
                    guidata( app.DIFSIMUIFigure, data );
                    
                    if (~isempty(app.simRes))
                        
                        para = [];
                        para.figHdl = app.plotDiffSignal;
                        app.prepResPlot(para);

%                         for itx = 1:length(app.simRes)
%                             sig(itx) = abs(mean(app.simRes(itx).Amp,2));
%                         end
%                         
%                         b   = [app.simRes(:).bValue];
%                         zeroIntensity = 1e6;
%                         
%                         plot(app.plotDiffSignal,b,zeroIntensity*sig,'o','LineWidth',2);
%                         axis(app.plotDiffSignal, 'tight');
%                         app.plotDiffSignal.XLim = [min(b) max(b)];
                    else
                        app.taLogViewer.Value = '';
                        msg = ['Simulation canceled. Please restart.'];
                        title = 'Simulation message';
                        uiconfirm(app.DIFSIMUIFigure,msg,title,...
                                              'Options',{'OK'},...
                                              'DefaultOption',1,...
                                              'CancelOption', 1,...
                                              'Icon','warning');                
                    end
                end
            %catch
            %end
            %end

            

        end

        % Button pushed function: bExpFig
        function bExpFigButtonPushed(app, event)
            %app.taLogViewer.Value = 'Andre; Ist mein Name';
            %app.prepResDoc();
            %disp(app.taLogViewer.Value );
            if (~isempty(app.simRes))
                para = [];
                %para.figHdl = app.plotDiffSignal;
                app.prepResPlot(para);
            else
                app.taLogViewer.Value = '';
                msg = ['No simulation results available for export. Please restart simulation.'];
                title = 'Simulation message';
                uiconfirm(app.DIFSIMUIFigure,msg,title,...
                                      'Options',{'OK'},...
                                      'DefaultOption',1,...
                                      'CancelOption', 1,...
                                      'Icon','warning');                
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create DIFSIMUIFigure and hide until all components are created
            app.DIFSIMUIFigure = uifigure('Visible', 'off');
            app.DIFSIMUIFigure.Position = [100 100 1357 565];
            app.DIFSIMUIFigure.Name = 'DIF | SIM';
            app.DIFSIMUIFigure.Resize = 'off';

            % Create tgControlPanel
            app.tgControlPanel = uitabgroup(app.DIFSIMUIFigure);
            app.tgControlPanel.TabLocation = 'bottom';
            app.tgControlPanel.Position = [1 -28 1359 565];

            % Create SeqTab
            app.SeqTab = uitab(app.tgControlPanel);
            app.SeqTab.AutoResizeChildren = 'off';
            app.SeqTab.Title = 'General Settings';

            % Create MRPanel
            app.MRPanel = uipanel(app.SeqTab);
            app.MRPanel.AutoResizeChildren = 'off';
            app.MRPanel.Title = 'MR';
            app.MRPanel.FontWeight = 'bold';
            app.MRPanel.Position = [10 415 260 115];

            % Create Label
            app.Label = uilabel(app.MRPanel);
            app.Label.FontSize = 11;
            app.Label.FontWeight = 'bold';
            app.Label.Position = [27 61 25 22];
            app.Label.Text = '0';

            % Create TLabel
            app.TLabel = uilabel(app.MRPanel);
            app.TLabel.Position = [146 68 25 22];
            app.TLabel.Text = 'T';

            % Create msLabel
            app.msLabel = uilabel(app.MRPanel);
            app.msLabel.Position = [146 36 25 22];
            app.msLabel.Text = 'ms';

            % Create mmLabel
            app.mmLabel = uilabel(app.MRPanel);
            app.mmLabel.Position = [146 10 29 22];
            app.mmLabel.Text = 'mm³';

            % Create TEEditFieldLabel
            app.TEEditFieldLabel = uilabel(app.MRPanel);
            app.TEEditFieldLabel.HorizontalAlignment = 'right';
            app.TEEditFieldLabel.FontWeight = 'bold';
            app.TEEditFieldLabel.Position = [1 39 25 22];
            app.TEEditFieldLabel.Text = 'TE';

            % Create efTE
            app.efTE = uieditfield(app.MRPanel, 'numeric');
            app.efTE.Limits = [0 Inf];
            app.efTE.Position = [41 39 100 22];
            app.efTE.Value = 150;

            % Create BLabel
            app.BLabel = uilabel(app.MRPanel);
            app.BLabel.HorizontalAlignment = 'right';
            app.BLabel.FontWeight = 'bold';
            app.BLabel.Position = [1 68 25 22];
            app.BLabel.Text = 'B';

            % Create BEditField
            app.BEditField = uieditfield(app.MRPanel, 'numeric');
            app.BEditField.Limits = [0 Inf];
            app.BEditField.Position = [41 68 100 22];
            app.BEditField.Value = 2.9;

            % Create VOIEditFieldLabel
            app.VOIEditFieldLabel = uilabel(app.MRPanel);
            app.VOIEditFieldLabel.HorizontalAlignment = 'right';
            app.VOIEditFieldLabel.FontWeight = 'bold';
            app.VOIEditFieldLabel.Position = [0 10 26 22];
            app.VOIEditFieldLabel.Text = 'VOI';

            % Create efVoI
            app.efVoI = uieditfield(app.MRPanel, 'numeric');
            app.efVoI.Limits = [0 Inf];
            app.efVoI.Position = [41 10 100 22];
            app.efVoI.Value = 30;

            % Create DiffusionPanel
            app.DiffusionPanel = uipanel(app.SeqTab);
            app.DiffusionPanel.AutoResizeChildren = 'off';
            app.DiffusionPanel.Title = 'Diffusion';
            app.DiffusionPanel.FontWeight = 'bold';
            app.DiffusionPanel.Position = [10 210 260 195];

            % Create mmsLabel
            app.mmsLabel = uilabel(app.DiffusionPanel);
            app.mmsLabel.Position = [196 149 39 22];
            app.mmsLabel.Text = 'mm²/s';

            % Create sLabel
            app.sLabel = uilabel(app.DiffusionPanel);
            app.sLabel.Position = [196 91 25 22];
            app.sLabel.Text = 'ÿs';

            % Create freeLabel
            app.freeLabel = uilabel(app.DiffusionPanel);
            app.freeLabel.FontSize = 11;
            app.freeLabel.FontWeight = 'bold';
            app.freeLabel.Position = [68 142 26 22];
            app.freeLabel.Text = 'free';

            % Create ADCEditFieldLabel
            app.ADCEditFieldLabel = uilabel(app.DiffusionPanel);
            app.ADCEditFieldLabel.HorizontalAlignment = 'right';
            app.ADCEditFieldLabel.FontWeight = 'bold';
            app.ADCEditFieldLabel.Position = [35 149 41 22];
            app.ADCEditFieldLabel.Text = 'ADC   ';

            % Create efADCglobal
            app.efADCglobal = uieditfield(app.DiffusionPanel, 'numeric');
            app.efADCglobal.Limits = [0 Inf];
            app.efADCglobal.ValueDisplayFormat = '%11.2e';
            app.efADCglobal.Position = [91 149 100 22];
            app.efADCglobal.Value = 0.0004;

            % Create stepwidthEditFieldLabel
            app.stepwidthEditFieldLabel = uilabel(app.DiffusionPanel);
            app.stepwidthEditFieldLabel.HorizontalAlignment = 'right';
            app.stepwidthEditFieldLabel.FontWeight = 'bold';
            app.stepwidthEditFieldLabel.Position = [11 91 65 22];
            app.stepwidthEditFieldLabel.Text = 'step width';

            % Create efStepWidth
            app.efStepWidth = uieditfield(app.DiffusionPanel, 'numeric');
            app.efStepWidth.Limits = [100 Inf];
            app.efStepWidth.ValueDisplayFormat = '%.0f';
            app.efStepWidth.Position = [91 91 100 22];
            app.efStepWidth.Value = 1000;

            % Create reprodDropDownLabel
            app.reprodDropDownLabel = uilabel(app.DiffusionPanel);
            app.reprodDropDownLabel.HorizontalAlignment = 'right';
            app.reprodDropDownLabel.FontWeight = 'bold';
            app.reprodDropDownLabel.Position = [32 120 47 22];
            app.reprodDropDownLabel.Text = 'reprod.';

            % Create ddReprod
            app.ddReprod = uidropdown(app.DiffusionPanel);
            app.ddReprod.Items = {'store', 'apply'};
            app.ddReprod.Position = [91 120 100 22];
            app.ddReprod.Value = 'store';

            % Create ParticleNoLabel
            app.ParticleNoLabel = uilabel(app.DiffusionPanel);
            app.ParticleNoLabel.HorizontalAlignment = 'right';
            app.ParticleNoLabel.FontWeight = 'bold';
            app.ParticleNoLabel.Position = [1 62 75 22];
            app.ParticleNoLabel.Text = 'ParticleNo   ';

            % Create ef_minMolNo
            app.ef_minMolNo = uieditfield(app.DiffusionPanel, 'numeric');
            app.ef_minMolNo.Limits = [1000 Inf];
            app.ef_minMolNo.ValueDisplayFormat = '%.0f';
            app.ef_minMolNo.Position = [91 62 100 22];
            app.ef_minMolNo.Value = 10000;

            % Create minLabel
            app.minLabel = uilabel(app.DiffusionPanel);
            app.minLabel.FontSize = 11;
            app.minLabel.FontWeight = 'bold';
            app.minLabel.Position = [66 56 25 22];
            app.minLabel.Text = 'min';

            % Create maxLabel
            app.maxLabel = uilabel(app.DiffusionPanel);
            app.maxLabel.FontSize = 11;
            app.maxLabel.FontWeight = 'bold';
            app.maxLabel.Position = [66 1 28 22];
            app.maxLabel.Text = 'max';

            % Create ParticleNoLabel_2
            app.ParticleNoLabel_2 = uilabel(app.DiffusionPanel);
            app.ParticleNoLabel_2.HorizontalAlignment = 'right';
            app.ParticleNoLabel_2.FontWeight = 'bold';
            app.ParticleNoLabel_2.Position = [1 7 75 22];
            app.ParticleNoLabel_2.Text = 'ParticleNo   ';

            % Create ef_maxMolNo
            app.ef_maxMolNo = uieditfield(app.DiffusionPanel, 'numeric');
            app.ef_maxMolNo.Limits = [10 Inf];
            app.ef_maxMolNo.ValueDisplayFormat = '%.0f';
            app.ef_maxMolNo.Position = [91 7 100 22];
            app.ef_maxMolNo.Value = 500000;

            % Create cbAutoScale
            app.cbAutoScale = uicheckbox(app.DiffusionPanel);
            app.cbAutoScale.Text = 'Auto adjust particle number';
            app.cbAutoScale.FontWeight = 'bold';
            app.cbAutoScale.Position = [8 34 181 22];
            app.cbAutoScale.Value = true;

            % Create GradTab
            app.GradTab = uitab(app.tgControlPanel);
            app.GradTab.Title = 'Gradient Settings';

            % Create GradienttypePanel
            app.GradienttypePanel = uipanel(app.GradTab);
            app.GradienttypePanel.Title = 'Gradient type';
            app.GradienttypePanel.FontWeight = 'bold';
            app.GradienttypePanel.Position = [10 274 264 256];

            % Create tgGradTypes
            app.tgGradTypes = uitabgroup(app.GradienttypePanel);
            app.tgGradTypes.TabLocation = 'left';
            app.tgGradTypes.Position = [-84 0 350 237];

            % Create PGSETab
            app.PGSETab = uitab(app.tgGradTypes);
            app.PGSETab.Title = 'PGSETab';

            % Create EditFieldLabel
            app.EditFieldLabel = uilabel(app.PGSETab);
            app.EditFieldLabel.HorizontalAlignment = 'right';
            app.EditFieldLabel.FontWeight = 'bold';
            app.EditFieldLabel.Position = [1 207 25 22];
            app.EditFieldLabel.Text = 'ÿ';

            % Create efPGSE_Delta
            app.efPGSE_Delta = uieditfield(app.PGSETab, 'numeric');
            app.efPGSE_Delta.Limits = [0 Inf];
            app.efPGSE_Delta.ValueChangedFcn = createCallbackFcn(app, @efPGSE_DeltaValueChanged, true);
            app.efPGSE_Delta.Position = [41 207 100 22];
            app.efPGSE_Delta.Value = 40;

            % Create Label_2
            app.Label_2 = uilabel(app.PGSETab);
            app.Label_2.HorizontalAlignment = 'right';
            app.Label_2.FontWeight = 'bold';
            app.Label_2.Position = [1 177 25 22];
            app.Label_2.Text = 'ÿ';

            % Create efPGSE_delta
            app.efPGSE_delta = uieditfield(app.PGSETab, 'numeric');
            app.efPGSE_delta.Limits = [0 Inf];
            app.efPGSE_delta.Position = [41 177 100 22];
            app.efPGSE_delta.Value = 10;

            % Create msLabel_2
            app.msLabel_2 = uilabel(app.PGSETab);
            app.msLabel_2.Position = [151 205 25 22];
            app.msLabel_2.Text = 'ms';

            % Create msLabel_3
            app.msLabel_3 = uilabel(app.PGSETab);
            app.msLabel_3.Position = [151 175 25 22];
            app.msLabel_3.Text = 'ms';

            % Create msLabel_4
            app.msLabel_4 = uilabel(app.PGSETab);
            app.msLabel_4.Position = [175 30 25 22];
            app.msLabel_4.Text = 'ms';

            % Create TDLabel
            app.TDLabel = uilabel(app.PGSETab);
            app.TDLabel.HorizontalAlignment = 'right';
            app.TDLabel.FontWeight = 'bold';
            app.TDLabel.Position = [25 32 25 22];
            app.TDLabel.Text = 'TD';

            % Create efPGSE_TD
            app.efPGSE_TD = uieditfield(app.PGSETab, 'numeric');
            app.efPGSE_TD.Limits = [0 Inf];
            app.efPGSE_TD.Editable = 'off';
            app.efPGSE_TD.Position = [65 32 100 22];

            % Create OGSETab
            app.OGSETab = uitab(app.tgGradTypes);
            app.OGSETab.Title = 'OGSETab';

            % Create periodsLabel
            app.periodsLabel = uilabel(app.OGSETab);
            app.periodsLabel.HorizontalAlignment = 'right';
            app.periodsLabel.FontWeight = 'bold';
            app.periodsLabel.Position = [9 206 49 22];
            app.periodsLabel.Text = 'periods';

            % Create efOGSE_periods
            app.efOGSE_periods = uieditfield(app.OGSETab, 'numeric');
            app.efOGSE_periods.Limits = [0 Inf];
            app.efOGSE_periods.ValueDisplayFormat = '%.0f';
            app.efOGSE_periods.Position = [73 207 100 22];
            app.efOGSE_periods.Value = 1;

            % Create Label_3
            app.Label_3 = uilabel(app.OGSETab);
            app.Label_3.HorizontalAlignment = 'right';
            app.Label_3.FontWeight = 'bold';
            app.Label_3.Position = [33 177 25 22];
            app.Label_3.Text = 'ÿ';

            % Create efOGSE_alpha
            app.efOGSE_alpha = uieditfield(app.OGSETab, 'numeric');
            app.efOGSE_alpha.Limits = [1 40];
            app.efOGSE_alpha.Position = [73 177 100 22];
            app.efOGSE_alpha.Value = 1;

            % Create polarityDropDownLabel
            app.polarityDropDownLabel = uilabel(app.OGSETab);
            app.polarityDropDownLabel.HorizontalAlignment = 'right';
            app.polarityDropDownLabel.FontWeight = 'bold';
            app.polarityDropDownLabel.Position = [9 147 49 22];
            app.polarityDropDownLabel.Text = 'polarity';

            % Create ddOGSE_polaritylue
            app.ddOGSE_polaritylue = uidropdown(app.OGSETab);
            app.ddOGSE_polaritylue.Items = {'positive', 'negative'};
            app.ddOGSE_polaritylue.Position = [73 147 100 22];
            app.ddOGSE_polaritylue.Value = 'positive';

            % Create msLabel_5
            app.msLabel_5 = uilabel(app.OGSETab);
            app.msLabel_5.Position = [175 30 25 22];
            app.msLabel_5.Text = 'ms';

            % Create TDLabel_2
            app.TDLabel_2 = uilabel(app.OGSETab);
            app.TDLabel_2.HorizontalAlignment = 'right';
            app.TDLabel_2.FontWeight = 'bold';
            app.TDLabel_2.Position = [25 32 25 22];
            app.TDLabel_2.Text = 'TD';

            % Create efOGSE_TD
            app.efOGSE_TD = uieditfield(app.OGSETab, 'numeric');
            app.efOGSE_TD.Limits = [0 Inf];
            app.efOGSE_TD.Editable = 'off';
            app.efOGSE_TD.Position = [65 32 100 22];

            % Create FWFTab
            app.FWFTab = uitab(app.tgGradTypes);
            app.FWFTab.Title = 'FWFTab';

            % Create ButtonGroup
            app.ButtonGroup = uibuttongroup(app.FWFTab);
            app.ButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @ButtonGroupSelectionChanged, true);
            app.ButtonGroup.BorderType = 'none';
            app.ButtonGroup.Position = [1 2 265 237];

            % Create rbCreate
            app.rbCreate = uiradiobutton(app.ButtonGroup);
            app.rbCreate.Text = 'Create';
            app.rbCreate.FontWeight = 'bold';
            app.rbCreate.FontColor = [0.851 0.3255 0.098];
            app.rbCreate.Position = [7 205 65 22];
            app.rbCreate.Value = true;

            % Create rbLoad
            app.rbLoad = uiradiobutton(app.ButtonGroup);
            app.rbLoad.Text = 'Load';
            app.rbLoad.FontWeight = 'bold';
            app.rbLoad.FontColor = [0.851 0.3255 0.098];
            app.rbLoad.Position = [7 59 58 22];

            % Create TensorDropDownLabel
            app.TensorDropDownLabel = uilabel(app.ButtonGroup);
            app.TensorDropDownLabel.HorizontalAlignment = 'right';
            app.TensorDropDownLabel.FontWeight = 'bold';
            app.TensorDropDownLabel.Position = [69 205 45 22];
            app.TensorDropDownLabel.Text = 'Tensor';

            % Create ddTensorType
            app.ddTensorType = uidropdown(app.ButtonGroup);
            app.ddTensorType.Items = {'LTE', 'PTE', 'STE'};
            app.ddTensorType.ValueChangedFcn = createCallbackFcn(app, @ddTensorTypeValueChanged, true);
            app.ddTensorType.Position = [124 205 56 22];
            app.ddTensorType.Value = 'LTE';

            % Create bFWFCreate
            app.bFWFCreate = uibutton(app.ButtonGroup, 'push');
            app.bFWFCreate.ButtonPushedFcn = createCallbackFcn(app, @bFWFCreateButtonPushed, true);
            app.bFWFCreate.Position = [199 136 59 22];
            app.bFWFCreate.Text = 'Create';

            % Create InterpolDropDownLabel
            app.InterpolDropDownLabel = uilabel(app.ButtonGroup);
            app.InterpolDropDownLabel.HorizontalAlignment = 'right';
            app.InterpolDropDownLabel.FontWeight = 'bold';
            app.InterpolDropDownLabel.Position = [4 13 49 22];
            app.InterpolDropDownLabel.Text = 'Interpol';

            % Create ddInterpolType
            app.ddInterpolType = uidropdown(app.ButtonGroup);
            app.ddInterpolType.Items = {'linear', 'cubic', 'spline'};
            app.ddInterpolType.Position = [68 13 71 22];
            app.ddInterpolType.Value = 'linear';

            % Create bFWFSave
            app.bFWFSave = uibutton(app.ButtonGroup, 'push');
            app.bFWFSave.ButtonPushedFcn = createCallbackFcn(app, @bFWFSaveButtonPushed, true);
            app.bFWFSave.Position = [199 104 59 22];
            app.bFWFSave.Text = 'Save';

            % Create NameEditFieldLabel
            app.NameEditFieldLabel = uilabel(app.ButtonGroup);
            app.NameEditFieldLabel.HorizontalAlignment = 'right';
            app.NameEditFieldLabel.FontWeight = 'bold';
            app.NameEditFieldLabel.Position = [4 104 38 22];
            app.NameEditFieldLabel.Text = 'Name';

            % Create efFWFName
            app.efFWFName = uieditfield(app.ButtonGroup, 'text');
            app.efFWFName.FontWeight = 'bold';
            app.efFWFName.Position = [51 104 139 22];

            % Create DataSetDropDownLabel
            app.DataSetDropDownLabel = uilabel(app.ButtonGroup);
            app.DataSetDropDownLabel.HorizontalAlignment = 'right';
            app.DataSetDropDownLabel.FontWeight = 'bold';
            app.DataSetDropDownLabel.Position = [69 59 54 22];
            app.DataSetDropDownLabel.Text = 'Data Set';

            % Create ddFWFDataSet
            app.ddFWFDataSet = uidropdown(app.ButtonGroup);
            app.ddFWFDataSet.Items = {};
            app.ddFWFDataSet.ValueChangedFcn = createCallbackFcn(app, @ddFWFDataSetValueChanged, true);
            app.ddFWFDataSet.Position = [132 59 100 22];
            app.ddFWFDataSet.Value = {};

            % Create FWFmaxLabel
            app.FWFmaxLabel = uilabel(app.ButtonGroup);
            app.FWFmaxLabel.FontSize = 11;
            app.FWFmaxLabel.FontWeight = 'bold';
            app.FWFmaxLabel.Position = [57 166 28 22];
            app.FWFmaxLabel.Text = 'max';

            % Create GEditFieldLabel
            app.GEditFieldLabel = uilabel(app.ButtonGroup);
            app.GEditFieldLabel.HorizontalAlignment = 'right';
            app.GEditFieldLabel.FontWeight = 'bold';
            app.GEditFieldLabel.Position = [31 172 25 22];
            app.GEditFieldLabel.Text = 'G';

            % Create efFWFGmax
            app.efFWFGmax = uieditfield(app.ButtonGroup, 'numeric');
            app.efFWFGmax.Limits = [0 300];
            app.efFWFGmax.ValueDisplayFormat = '%.0f';
            app.efFWFGmax.Position = [82 172 44 22];
            app.efFWFGmax.Value = 120;

            % Create mTmLabel
            app.mTmLabel = uilabel(app.ButtonGroup);
            app.mTmLabel.Position = [131 172 36 22];
            app.mTmLabel.Text = 'mT/m';

            % Create MaxwellIdxEditFieldLabel
            app.MaxwellIdxEditFieldLabel = uilabel(app.ButtonGroup);
            app.MaxwellIdxEditFieldLabel.HorizontalAlignment = 'right';
            app.MaxwellIdxEditFieldLabel.FontWeight = 'bold';
            app.MaxwellIdxEditFieldLabel.Position = [5 136 72 22];
            app.MaxwellIdxEditFieldLabel.Text = 'Maxwell Idx';

            % Create efFWFMaxwellIdx
            app.efFWFMaxwellIdx = uieditfield(app.ButtonGroup, 'numeric');
            app.efFWFMaxwellIdx.Limits = [0 300];
            app.efFWFMaxwellIdx.ValueDisplayFormat = '%.0f';
            app.efFWFMaxwellIdx.Position = [82 136 44 22];
            app.efFWFMaxwellIdx.Value = 100;

            % Create mTmmsLabel
            app.mTmmsLabel = uilabel(app.ButtonGroup);
            app.mTmmsLabel.Position = [131 136 67 22];
            app.mTmmsLabel.Text = '(mT/m)² ms';

            % Create bValuePanel
            app.bValuePanel = uipanel(app.GradTab);
            app.bValuePanel.Title = 'b-Value';
            app.bValuePanel.FontWeight = 'bold';
            app.bValuePanel.Position = [12 15 264 246];

            % Create bEditFieldLabel
            app.bEditFieldLabel = uilabel(app.bValuePanel);
            app.bEditFieldLabel.HorizontalAlignment = 'right';
            app.bEditFieldLabel.FontWeight = 'bold';
            app.bEditFieldLabel.Position = [-11 90 25 22];
            app.bEditFieldLabel.Text = 'b';

            % Create ef_bValueMin
            app.ef_bValueMin = uieditfield(app.bValuePanel, 'numeric');
            app.ef_bValueMin.Limits = [0 Inf];
            app.ef_bValueMin.Position = [38 90 50 22];

            % Create minLabel_4
            app.minLabel_4 = uilabel(app.bValuePanel);
            app.minLabel_4.FontSize = 11;
            app.minLabel_4.FontWeight = 'bold';
            app.minLabel_4.Position = [16 81 25 22];
            app.minLabel_4.Text = 'min';

            % Create maxLabel_4
            app.maxLabel_4 = uilabel(app.bValuePanel);
            app.maxLabel_4.FontSize = 11;
            app.maxLabel_4.FontWeight = 'bold';
            app.maxLabel_4.Position = [110 81 28 22];
            app.maxLabel_4.Text = 'max';

            % Create bEditField_2Label
            app.bEditField_2Label = uilabel(app.bValuePanel);
            app.bEditField_2Label.HorizontalAlignment = 'right';
            app.bEditField_2Label.FontWeight = 'bold';
            app.bEditField_2Label.Position = [84 90 25 22];
            app.bEditField_2Label.Text = 'b';

            % Create ef_bValueMax
            app.ef_bValueMax = uieditfield(app.bValuePanel, 'numeric');
            app.ef_bValueMax.Limits = [0 Inf];
            app.ef_bValueMax.Position = [135 90 50 22];
            app.ef_bValueMax.Value = 1000;

            % Create NoEditFieldLabel
            app.NoEditFieldLabel = uilabel(app.bValuePanel);
            app.NoEditFieldLabel.HorizontalAlignment = 'right';
            app.NoEditFieldLabel.FontWeight = 'bold';
            app.NoEditFieldLabel.Position = [7 54 25 22];
            app.NoEditFieldLabel.Text = 'No';

            % Create ef_bValueNo
            app.ef_bValueNo = uieditfield(app.bValuePanel, 'numeric');
            app.ef_bValueNo.Limits = [1 Inf];
            app.ef_bValueNo.Position = [38 54 41 22];
            app.ef_bValueNo.Value = 5;

            % Create smmLabel
            app.smmLabel = uilabel(app.bValuePanel);
            app.smmLabel.Position = [196 90 39 22];
            app.smmLabel.Text = 's/mm²';

            % Create tgBValueSettings
            app.tgBValueSettings = uitabgroup(app.bValuePanel);
            app.tgBValueSettings.TabLocation = 'left';
            app.tgBValueSettings.Position = [-73 124 337 104];

            % Create linBTensorTab
            app.linBTensorTab = uitab(app.tgBValueSettings);
            app.linBTensorTab.Title = 'lin';

            % Create bVectorLabel
            app.bVectorLabel = uilabel(app.linBTensorTab);
            app.bVectorLabel.FontWeight = 'bold';
            app.bVectorLabel.Position = [25 61 54 22];
            app.bVectorLabel.Text = 'b-Vector';

            % Create normLabel
            app.normLabel = uilabel(app.linBTensorTab);
            app.normLabel.FontWeight = 'bold';
            app.normLabel.Position = [49 40 35 22];
            app.normLabel.Text = 'norm';

            % Create ef_bVecXNorm
            app.ef_bVecXNorm = uieditfield(app.linBTensorTab, 'numeric');
            app.ef_bVecXNorm.Editable = 'off';
            app.ef_bVecXNorm.HorizontalAlignment = 'center';
            app.ef_bVecXNorm.Position = [83 40 35 22];
            app.ef_bVecXNorm.Value = 1;

            % Create ef_bVecYNorm
            app.ef_bVecYNorm = uieditfield(app.linBTensorTab, 'numeric');
            app.ef_bVecYNorm.Editable = 'off';
            app.ef_bVecYNorm.HorizontalAlignment = 'center';
            app.ef_bVecYNorm.Position = [133 40 35 22];

            % Create ef_bVecZNorm
            app.ef_bVecZNorm = uieditfield(app.linBTensorTab, 'numeric');
            app.ef_bVecZNorm.Editable = 'off';
            app.ef_bVecZNorm.HorizontalAlignment = 'center';
            app.ef_bVecZNorm.Position = [184 40 35 22];

            % Create xEditFieldLabel
            app.xEditFieldLabel = uilabel(app.linBTensorTab);
            app.xEditFieldLabel.HorizontalAlignment = 'right';
            app.xEditFieldLabel.Position = [80 82 25 22];
            app.xEditFieldLabel.Text = 'x';

            % Create ef_bVecX
            app.ef_bVecX = uieditfield(app.linBTensorTab, 'numeric');
            app.ef_bVecX.ValueChangedFcn = createCallbackFcn(app, @bVecValueChange, true);
            app.ef_bVecX.HorizontalAlignment = 'center';
            app.ef_bVecX.Position = [83 61 35 22];
            app.ef_bVecX.Value = 1;

            % Create yEditFieldLabel
            app.yEditFieldLabel = uilabel(app.linBTensorTab);
            app.yEditFieldLabel.HorizontalAlignment = 'right';
            app.yEditFieldLabel.Position = [130 82 25 22];
            app.yEditFieldLabel.Text = 'y';

            % Create ef_bVecY
            app.ef_bVecY = uieditfield(app.linBTensorTab, 'numeric');
            app.ef_bVecY.ValueChangedFcn = createCallbackFcn(app, @bVecValueChange, true);
            app.ef_bVecY.HorizontalAlignment = 'center';
            app.ef_bVecY.Position = [133 61 35 22];

            % Create zEditFieldLabel
            app.zEditFieldLabel = uilabel(app.linBTensorTab);
            app.zEditFieldLabel.HorizontalAlignment = 'right';
            app.zEditFieldLabel.Position = [180 82 25 22];
            app.zEditFieldLabel.Text = 'z';

            % Create ef_bVecZ
            app.ef_bVecZ = uieditfield(app.linBTensorTab, 'numeric');
            app.ef_bVecZ.ValueChangedFcn = createCallbackFcn(app, @bVecValueChange, true);
            app.ef_bVecZ.HorizontalAlignment = 'center';
            app.ef_bVecZ.Position = [184 61 35 22];

            % Create hoBTensorTab
            app.hoBTensorTab = uitab(app.tgBValueSettings);
            app.hoBTensorTab.Title = 'ho';

            % Create rotAxisLabel
            app.rotAxisLabel = uilabel(app.hoBTensorTab);
            app.rotAxisLabel.FontWeight = 'bold';
            app.rotAxisLabel.Position = [25 61 50 22];
            app.rotAxisLabel.Text = 'rot Axis';

            % Create normLabel_2
            app.normLabel_2 = uilabel(app.hoBTensorTab);
            app.normLabel_2.FontWeight = 'bold';
            app.normLabel_2.Position = [49 40 35 22];
            app.normLabel_2.Text = 'norm';

            % Create ef_RotAxXNorm
            app.ef_RotAxXNorm = uieditfield(app.hoBTensorTab, 'numeric');
            app.ef_RotAxXNorm.Editable = 'off';
            app.ef_RotAxXNorm.HorizontalAlignment = 'center';
            app.ef_RotAxXNorm.Position = [83 40 35 22];
            app.ef_RotAxXNorm.Value = 1;

            % Create ef_RotAxYNorm
            app.ef_RotAxYNorm = uieditfield(app.hoBTensorTab, 'numeric');
            app.ef_RotAxYNorm.Editable = 'off';
            app.ef_RotAxYNorm.HorizontalAlignment = 'center';
            app.ef_RotAxYNorm.Position = [133 40 35 22];

            % Create ef_RotAxZNorm
            app.ef_RotAxZNorm = uieditfield(app.hoBTensorTab, 'numeric');
            app.ef_RotAxZNorm.Editable = 'off';
            app.ef_RotAxZNorm.HorizontalAlignment = 'center';
            app.ef_RotAxZNorm.Position = [184 40 35 22];

            % Create xEditFieldLabel_2
            app.xEditFieldLabel_2 = uilabel(app.hoBTensorTab);
            app.xEditFieldLabel_2.HorizontalAlignment = 'right';
            app.xEditFieldLabel_2.Position = [80 82 25 22];
            app.xEditFieldLabel_2.Text = 'x';

            % Create ef_RotAxX
            app.ef_RotAxX = uieditfield(app.hoBTensorTab, 'numeric');
            app.ef_RotAxX.ValueChangedFcn = createCallbackFcn(app, @rotAxValueChange, true);
            app.ef_RotAxX.HorizontalAlignment = 'center';
            app.ef_RotAxX.Position = [83 61 35 22];
            app.ef_RotAxX.Value = 1;

            % Create yEditFieldLabel_2
            app.yEditFieldLabel_2 = uilabel(app.hoBTensorTab);
            app.yEditFieldLabel_2.HorizontalAlignment = 'right';
            app.yEditFieldLabel_2.Position = [130 82 25 22];
            app.yEditFieldLabel_2.Text = 'y';

            % Create ef_RotAxY
            app.ef_RotAxY = uieditfield(app.hoBTensorTab, 'numeric');
            app.ef_RotAxY.ValueChangedFcn = createCallbackFcn(app, @rotAxValueChange, true);
            app.ef_RotAxY.HorizontalAlignment = 'center';
            app.ef_RotAxY.Position = [133 61 35 22];

            % Create zEditFieldLabel_2
            app.zEditFieldLabel_2 = uilabel(app.hoBTensorTab);
            app.zEditFieldLabel_2.HorizontalAlignment = 'right';
            app.zEditFieldLabel_2.Position = [180 82 25 22];
            app.zEditFieldLabel_2.Text = 'z';

            % Create ef_RotAxZ
            app.ef_RotAxZ = uieditfield(app.hoBTensorTab, 'numeric');
            app.ef_RotAxZ.ValueChangedFcn = createCallbackFcn(app, @rotAxValueChange, true);
            app.ef_RotAxZ.HorizontalAlignment = 'center';
            app.ef_RotAxZ.Position = [184 61 35 22];

            % Create rotAngleEditFieldLabel
            app.rotAngleEditFieldLabel = uilabel(app.hoBTensorTab);
            app.rotAngleEditFieldLabel.HorizontalAlignment = 'right';
            app.rotAngleEditFieldLabel.FontWeight = 'bold';
            app.rotAngleEditFieldLabel.Position = [13 6 58 22];
            app.rotAngleEditFieldLabel.Text = 'rot Angle';

            % Create ef_rotAngle
            app.ef_rotAngle = uieditfield(app.hoBTensorTab, 'numeric');
            app.ef_rotAngle.Limits = [-360 360];
            app.ef_rotAngle.ValueChangedFcn = createCallbackFcn(app, @ef_rotAngleValueChanged, true);
            app.ef_rotAngle.Position = [83 6 40 22];

            % Create Label_6
            app.Label_6 = uilabel(app.hoBTensorTab);
            app.Label_6.Position = [127 9 25 22];
            app.Label_6.Text = '°';

            % Create ddGradType
            app.ddGradType = uidropdown(app.GradTab);
            app.ddGradType.Items = {'PGSE', 'OGSE', 'FWF'};
            app.ddGradType.ValueChangedFcn = createCallbackFcn(app, @ddGradTypeValueChanged, true);
            app.ddGradType.Position = [99 509 70 22];
            app.ddGradType.Value = 'PGSE';

            % Create bValueTable
            app.bValueTable = uitable(app.GradTab);
            app.bValueTable.ColumnName = {'b-values'};
            app.bValueTable.RowName = {};
            app.bValueTable.Position = [292 15 120 246];

            % Create bShowGrad
            app.bShowGrad = uibutton(app.GradTab, 'push');
            app.bShowGrad.ButtonPushedFcn = createCallbackFcn(app, @bShowGradButtonPushed, true);
            app.bShowGrad.Position = [208 509 60 22];
            app.bShowGrad.Text = 'Apply';

            % Create GradientshapePanel
            app.GradientshapePanel = uipanel(app.GradTab);
            app.GradientshapePanel.Title = 'Gradient shape';
            app.GradientshapePanel.FontWeight = 'bold';
            app.GradientshapePanel.Position = [292 274 823 256];

            % Create plotGradShape
            app.plotGradShape = uiaxes(app.GradientshapePanel);
            title(app.plotGradShape, '')
            xlabel(app.plotGradShape, {'time [ms]'; ''})
            ylabel(app.plotGradShape, '')
            app.plotGradShape.PlotBoxAspectRatio = [4.06511619096075 1 1];
            app.plotGradShape.YLim = [0 1.1];
            app.plotGradShape.Box = 'on';
            app.plotGradShape.YTick = [];
            app.plotGradShape.YTickLabel = '';
            app.plotGradShape.Position = [-35 -4 904 242];

            % Create DiffusionTensorPanel
            app.DiffusionTensorPanel = uipanel(app.GradTab);
            app.DiffusionTensorPanel.Title = 'Diffusion Tensor';
            app.DiffusionTensorPanel.FontWeight = 'bold';
            app.DiffusionTensorPanel.Position = [426 15 260 245];

            % Create plotDifTensor
            app.plotDifTensor = uiaxes(app.DiffusionTensorPanel);
            title(app.plotDifTensor, '')
            xlabel(app.plotDifTensor, 'X')
            ylabel(app.plotDifTensor, 'Y')
            app.plotDifTensor.PlotBoxAspectRatio = [1.15217391304348 1 1];
            app.plotDifTensor.XLim = [-1 1];
            app.plotDifTensor.YLim = [-1 1];
            app.plotDifTensor.ZLim = [-1 1];
            app.plotDifTensor.Box = 'on';
            app.plotDifTensor.Position = [0 0 260 226];

            % Create SmpTab
            app.SmpTab = uitab(app.tgControlPanel);
            app.SmpTab.AutoResizeChildren = 'off';
            app.SmpTab.Title = 'Sample Settings';

            % Create CompartmentsPanel
            app.CompartmentsPanel = uipanel(app.SmpTab);
            app.CompartmentsPanel.AutoResizeChildren = 'off';
            app.CompartmentsPanel.Title = 'Compartments';
            app.CompartmentsPanel.Position = [15 13 122 515];

            % Create lbCompartment
            app.lbCompartment = uilistbox(app.CompartmentsPanel);
            app.lbCompartment.Items = {};
            app.lbCompartment.Position = [0 39 122 457];
            app.lbCompartment.Value = {};

            % Create bCmpDelete
            app.bCmpDelete = uibutton(app.CompartmentsPanel, 'push');
            app.bCmpDelete.ButtonPushedFcn = createCallbackFcn(app, @bCmpDeleteButtonPushed, true);
            app.bCmpDelete.Position = [72 7 45 22];
            app.bCmpDelete.Text = 'Delete';

            % Create bCmpReLoad
            app.bCmpReLoad = uibutton(app.CompartmentsPanel, 'push');
            app.bCmpReLoad.ButtonPushedFcn = createCallbackFcn(app, @bCmpReLoadButtonPushed, true);
            app.bCmpReLoad.Position = [4.5 7 42 22];
            app.bCmpReLoad.Text = 'Load';

            % Create plotCmpFraction
            app.plotCmpFraction = uiaxes(app.SmpTab);
            title(app.plotCmpFraction, '')
            xlabel(app.plotCmpFraction, '')
            ylabel(app.plotCmpFraction, '')
            app.plotCmpFraction.DataAspectRatio = [3.90624976716936 0.5 1.25];
            app.plotCmpFraction.PlotBoxAspectRatio = [32.0000019073487 2 1];
            app.plotCmpFraction.XLim = [0 100];
            app.plotCmpFraction.YLim = [0.6 1.4];
            app.plotCmpFraction.Box = 'on';
            app.plotCmpFraction.XTick = [0 20 40 60 80 100];
            app.plotCmpFraction.XTickLabel = '';
            app.plotCmpFraction.YTick = [];
            app.plotCmpFraction.YTickLabel = '';
            app.plotCmpFraction.Position = [146 8 377 42];

            % Create CompartmentselectPanel
            app.CompartmentselectPanel = uipanel(app.SmpTab);
            app.CompartmentselectPanel.AutoResizeChildren = 'off';
            app.CompartmentselectPanel.Title = 'Compartment select';
            app.CompartmentselectPanel.Position = [150 52 370 475];

            % Create tgCmpSelect
            app.tgCmpSelect = uitabgroup(app.CompartmentselectPanel);
            app.tgCmpSelect.AutoResizeChildren = 'off';
            app.tgCmpSelect.TabLocation = 'bottom';
            app.tgCmpSelect.Position = [0 -32 372 455];

            % Create freeTab
            app.freeTab = uitab(app.tgCmpSelect);
            app.freeTab.AutoResizeChildren = 'off';
            app.freeTab.Title = 'free';

            % Create spheresTab
            app.spheresTab = uitab(app.tgCmpSelect);
            app.spheresTab.AutoResizeChildren = 'off';
            app.spheresTab.Title = 'spheres';

            % Create tgRadDistSph
            app.tgRadDistSph = uitabgroup(app.spheresTab);
            app.tgRadDistSph.TabLocation = 'left';
            app.tgRadDistSph.Position = [-76 264 292 129];

            % Create deltaTabSph
            app.deltaTabSph = uitab(app.tgRadDistSph);
            app.deltaTabSph.Title = 'delta';

            % Create gammaTabSph
            app.gammaTabSph = uitab(app.tgRadDistSph);
            app.gammaTabSph.Title = 'gamma';

            % Create shapeparaEditField_9Label
            app.shapeparaEditField_9Label = uilabel(app.gammaTabSph);
            app.shapeparaEditField_9Label.HorizontalAlignment = 'right';
            app.shapeparaEditField_9Label.Position = [15 69 66 22];
            app.shapeparaEditField_9Label.Text = 'shape para';

            % Create efSphGammaShape
            app.efSphGammaShape = uieditfield(app.gammaTabSph, 'numeric');
            app.efSphGammaShape.Limits = [0 Inf];
            app.efSphGammaShape.ValueChangedFcn = createCallbackFcn(app, @gammaValueChanged, true);
            app.efSphGammaShape.Position = [96 69 100 22];
            app.efSphGammaShape.Value = 2;

            % Create scaleparaEditField_9Label
            app.scaleparaEditField_9Label = uilabel(app.gammaTabSph);
            app.scaleparaEditField_9Label.HorizontalAlignment = 'right';
            app.scaleparaEditField_9Label.Position = [20 38 61 22];
            app.scaleparaEditField_9Label.Text = 'scale para';

            % Create efSphGammaScale
            app.efSphGammaScale = uieditfield(app.gammaTabSph, 'numeric');
            app.efSphGammaScale.Limits = [0 Inf];
            app.efSphGammaScale.ValueChangedFcn = createCallbackFcn(app, @gammaValueChanged, true);
            app.efSphGammaScale.Position = [96 38 100 22];
            app.efSphGammaScale.Value = 1e-06;

            % Create meanradiusrefSwitch_4Label
            app.meanradiusrefSwitch_4Label = uilabel(app.gammaTabSph);
            app.meanradiusrefSwitch_4Label.HorizontalAlignment = 'center';
            app.meanradiusrefSwitch_4Label.Position = [9 101 89 22];
            app.meanradiusrefSwitch_4Label.Text = 'mean radius ref';

            % Create swSphGammaRadiusAuto
            app.swSphGammaRadiusAuto = uiswitch(app.gammaTabSph, 'slider');
            app.swSphGammaRadiusAuto.ValueChangedFcn = createCallbackFcn(app, @swSphGammaRadiusAutoValueChanged, true);
            app.swSphGammaRadiusAuto.Position = [142 101 45 20];

            % Create bgSphGamma
            app.bgSphGamma = uibuttongroup(app.gammaTabSph);
            app.bgSphGamma.AutoResizeChildren = 'off';
            app.bgSphGamma.SelectionChangedFcn = createCallbackFcn(app, @bgSphGammaSelectionChanged, true);
            app.bgSphGamma.BorderType = 'none';
            app.bgSphGamma.Position = [202 7 20 81];

            % Create rbSphGammaShape
            app.rbSphGammaShape = uiradiobutton(app.bgSphGamma);
            app.rbSphGammaShape.Text = '';
            app.rbSphGammaShape.Position = [3 63 20 22];
            app.rbSphGammaShape.Value = true;

            % Create rbSphGammaScale
            app.rbSphGammaScale = uiradiobutton(app.bgSphGamma);
            app.rbSphGammaScale.Text = '';
            app.rbSphGammaScale.Position = [3 31 20 22];

            % Create gevTabSph
            app.gevTabSph = uitab(app.tgRadDistSph);
            app.gevTabSph.Title = 'gev';

            % Create shapeparaEditField_5Label
            app.shapeparaEditField_5Label = uilabel(app.gevTabSph);
            app.shapeparaEditField_5Label.HorizontalAlignment = 'right';
            app.shapeparaEditField_5Label.Position = [15 69 66 22];
            app.shapeparaEditField_5Label.Text = 'shape para';

            % Create efSphGevShape
            app.efSphGevShape = uieditfield(app.gevTabSph, 'numeric');
            app.efSphGevShape.Limits = [0 Inf];
            app.efSphGevShape.ValueChangedFcn = createCallbackFcn(app, @gevValueChanged, true);
            app.efSphGevShape.Position = [96 69 100 22];
            app.efSphGevShape.Value = 0.8;

            % Create scaleparaEditField_5Label
            app.scaleparaEditField_5Label = uilabel(app.gevTabSph);
            app.scaleparaEditField_5Label.HorizontalAlignment = 'right';
            app.scaleparaEditField_5Label.Position = [20 38 61 22];
            app.scaleparaEditField_5Label.Text = 'scale para';

            % Create efSphGevScale
            app.efSphGevScale = uieditfield(app.gevTabSph, 'numeric');
            app.efSphGevScale.Limits = [0 Inf];
            app.efSphGevScale.ValueChangedFcn = createCallbackFcn(app, @gevValueChanged, true);
            app.efSphGevScale.Position = [96 38 100 22];
            app.efSphGevScale.Value = 1e-06;

            % Create locationparaEditField_2Label
            app.locationparaEditField_2Label = uilabel(app.gevTabSph);
            app.locationparaEditField_2Label.HorizontalAlignment = 'right';
            app.locationparaEditField_2Label.Position = [7 7 74 22];
            app.locationparaEditField_2Label.Text = 'location para';

            % Create efSphGevLocation
            app.efSphGevLocation = uieditfield(app.gevTabSph, 'numeric');
            app.efSphGevLocation.Limits = [0 Inf];
            app.efSphGevLocation.ValueChangedFcn = createCallbackFcn(app, @gevValueChanged, true);
            app.efSphGevLocation.Position = [96 7 100 22];
            app.efSphGevLocation.Value = 1e-06;

            % Create meanradiusrefSwitch_3Label
            app.meanradiusrefSwitch_3Label = uilabel(app.gevTabSph);
            app.meanradiusrefSwitch_3Label.HorizontalAlignment = 'center';
            app.meanradiusrefSwitch_3Label.Position = [9 101 89 22];
            app.meanradiusrefSwitch_3Label.Text = 'mean radius ref';

            % Create swSphGevRadiusAuto
            app.swSphGevRadiusAuto = uiswitch(app.gevTabSph, 'slider');
            app.swSphGevRadiusAuto.ValueChangedFcn = createCallbackFcn(app, @swSphGevRadiusAutoValueChanged, true);
            app.swSphGevRadiusAuto.Position = [142 101 45 20];

            % Create bgSphGev
            app.bgSphGev = uibuttongroup(app.gevTabSph);
            app.bgSphGev.AutoResizeChildren = 'off';
            app.bgSphGev.SelectionChangedFcn = createCallbackFcn(app, @bgSphGevSelectionChanged, true);
            app.bgSphGev.BorderType = 'none';
            app.bgSphGev.Position = [202 7 20 81];

            % Create rbSphGevShape
            app.rbSphGevShape = uiradiobutton(app.bgSphGev);
            app.rbSphGevShape.Text = '';
            app.rbSphGevShape.Position = [3 63 20 22];
            app.rbSphGevShape.Value = true;

            % Create rbSphGevScale
            app.rbSphGevScale = uiradiobutton(app.bgSphGev);
            app.rbSphGevScale.Text = '';
            app.rbSphGevScale.Position = [3 31 20 22];

            % Create rbSphGevLocation
            app.rbSphGevLocation = uiradiobutton(app.bgSphGev);
            app.rbSphGevLocation.Text = '';
            app.rbSphGevLocation.Position = [3 -1 20 22];

            % Create mLabel_4
            app.mLabel_4 = uilabel(app.spheresTab);
            app.mLabel_4.Position = [339 402 25 22];
            app.mLabel_4.Text = 'ÿm';

            % Create fromLabel_2
            app.fromLabel_2 = uilabel(app.spheresTab);
            app.fromLabel_2.FontWeight = 'bold';
            app.fromLabel_2.FontColor = [0.851 0.3255 0.098];
            app.fromLabel_2.Position = [228 376 32 22];
            app.fromLabel_2.Text = 'from';

            % Create toLabel_2
            app.toLabel_2 = uilabel(app.spheresTab);
            app.toLabel_2.FontWeight = 'bold';
            app.toLabel_2.FontColor = [0.851 0.3255 0.098];
            app.toLabel_2.Position = [228 352 25 22];
            app.toLabel_2.Text = 'to';

            % Create RadiidistributionDropDownLabel_2
            app.RadiidistributionDropDownLabel_2 = uilabel(app.spheresTab);
            app.RadiidistributionDropDownLabel_2.HorizontalAlignment = 'right';
            app.RadiidistributionDropDownLabel_2.FontWeight = 'bold';
            app.RadiidistributionDropDownLabel_2.Position = [3 402 104 22];
            app.RadiidistributionDropDownLabel_2.Text = 'Radii distribution';

            % Create ddRadDistSph
            app.ddRadDistSph = uidropdown(app.spheresTab);
            app.ddRadDistSph.Items = {'delta', 'gamma', 'GEV'};
            app.ddRadDistSph.ValueChangedFcn = createCallbackFcn(app, @ddRadDistSphValueChanged, true);
            app.ddRadDistSph.Position = [116 402 100 22];
            app.ddRadDistSph.Value = 'delta';

            % Create RadiusLabel_2
            app.RadiusLabel_2 = uilabel(app.spheresTab);
            app.RadiusLabel_2.HorizontalAlignment = 'right';
            app.RadiusLabel_2.FontWeight = 'bold';
            app.RadiusLabel_2.Position = [234 402 45 22];
            app.RadiusLabel_2.Text = 'Radius';

            % Create efRadSph
            app.efRadSph = uieditfield(app.spheresTab, 'numeric');
            app.efRadSph.Limits = [0 Inf];
            app.efRadSph.ValueDisplayFormat = '%.2f';
            app.efRadSph.ValueChangedFcn = createCallbackFcn(app, @efRadSphValueChanged, true);
            app.efRadSph.Position = [286 402 48 22];
            app.efRadSph.Value = 3;

            % Create minLabel_3
            app.minLabel_3 = uilabel(app.spheresTab);
            app.minLabel_3.FontSize = 11;
            app.minLabel_3.FontWeight = 'bold';
            app.minLabel_3.Position = [267 370 25 22];
            app.minLabel_3.Text = 'min';

            % Create mLabel_5
            app.mLabel_5 = uilabel(app.spheresTab);
            app.mLabel_5.Position = [338 377 25 22];
            app.mLabel_5.Text = 'ÿm';

            % Create rEditFieldLabel_2
            app.rEditFieldLabel_2 = uilabel(app.spheresTab);
            app.rEditFieldLabel_2.HorizontalAlignment = 'right';
            app.rEditFieldLabel_2.FontWeight = 'bold';
            app.rEditFieldLabel_2.Position = [241 377 25 22];
            app.rEditFieldLabel_2.Text = 'r';

            % Create efRadMinSph
            app.efRadMinSph = uieditfield(app.spheresTab, 'numeric');
            app.efRadMinSph.Limits = [0 Inf];
            app.efRadMinSph.Position = [293 377 41 22];
            app.efRadMinSph.Value = 0.01;

            % Create maxLabel_3
            app.maxLabel_3 = uilabel(app.spheresTab);
            app.maxLabel_3.FontSize = 11;
            app.maxLabel_3.FontWeight = 'bold';
            app.maxLabel_3.Position = [267 345 28 22];
            app.maxLabel_3.Text = 'max';

            % Create mLabel_6
            app.mLabel_6 = uilabel(app.spheresTab);
            app.mLabel_6.Position = [338 352 25 22];
            app.mLabel_6.Text = 'ÿm';

            % Create rEditField_2Label_2
            app.rEditField_2Label_2 = uilabel(app.spheresTab);
            app.rEditField_2Label_2.HorizontalAlignment = 'right';
            app.rEditField_2Label_2.FontWeight = 'bold';
            app.rEditField_2Label_2.Position = [241 352 25 22];
            app.rEditField_2Label_2.Text = 'r';

            % Create efRadMaxSph
            app.efRadMaxSph = uieditfield(app.spheresTab, 'numeric');
            app.efRadMaxSph.Limits = [0 Inf];
            app.efRadMaxSph.ValueDisplayFormat = '%.2f';
            app.efRadMaxSph.Position = [293 352 41 22];
            app.efRadMaxSph.Value = 20;

            % Create bVisProbDistSph
            app.bVisProbDistSph = uibutton(app.spheresTab, 'push');
            app.bVisProbDistSph.ButtonPushedFcn = createCallbackFcn(app, @bVisProbDistSphButtonPushed, true);
            app.bVisProbDistSph.Position = [251 268 100 22];
            app.bVisProbDistSph.Text = 'Visualize';

            % Create cylindersTab
            app.cylindersTab = uitab(app.tgCmpSelect);
            app.cylindersTab.Title = 'cylinders';

            % Create DispersionDropDownLabel
            app.DispersionDropDownLabel = uilabel(app.cylindersTab);
            app.DispersionDropDownLabel.HorizontalAlignment = 'right';
            app.DispersionDropDownLabel.FontWeight = 'bold';
            app.DispersionDropDownLabel.Position = [3 219 68 22];
            app.DispersionDropDownLabel.Text = 'Dispersion';

            % Create ddDispersionOptCyl
            app.ddDispersionOptCyl = uidropdown(app.cylindersTab);
            app.ddDispersionOptCyl.Items = {'non (parallel)', 'partially', 'fully'};
            app.ddDispersionOptCyl.ValueChangedFcn = createCallbackFcn(app, @ddDispersionOptCylValueChanged, true);
            app.ddDispersionOptCyl.Position = [86 219 111 22];
            app.ddDispersionOptCyl.Value = 'non (parallel)';

            % Create RadiidistributionDropDownLabel
            app.RadiidistributionDropDownLabel = uilabel(app.cylindersTab);
            app.RadiidistributionDropDownLabel.HorizontalAlignment = 'right';
            app.RadiidistributionDropDownLabel.FontWeight = 'bold';
            app.RadiidistributionDropDownLabel.Position = [3 402 104 22];
            app.RadiidistributionDropDownLabel.Text = 'Radii distribution';

            % Create ddRadDistCyl
            app.ddRadDistCyl = uidropdown(app.cylindersTab);
            app.ddRadDistCyl.Items = {'delta', 'gamma', 'GEV'};
            app.ddRadDistCyl.ValueChangedFcn = createCallbackFcn(app, @ddRadDistCylValueChanged, true);
            app.ddRadDistCyl.Position = [116 402 100 22];
            app.ddRadDistCyl.Value = 'delta';

            % Create RadiusLabel
            app.RadiusLabel = uilabel(app.cylindersTab);
            app.RadiusLabel.HorizontalAlignment = 'right';
            app.RadiusLabel.FontWeight = 'bold';
            app.RadiusLabel.Position = [233 402 46 22];
            app.RadiusLabel.Text = 'Radius';

            % Create efRadCyl
            app.efRadCyl = uieditfield(app.cylindersTab, 'numeric');
            app.efRadCyl.Limits = [0 Inf];
            app.efRadCyl.ValueDisplayFormat = '%.2f';
            app.efRadCyl.ValueChangedFcn = createCallbackFcn(app, @efRadCylValueChanged, true);
            app.efRadCyl.Position = [286 402 48 22];
            app.efRadCyl.Value = 3;

            % Create mLabel
            app.mLabel = uilabel(app.cylindersTab);
            app.mLabel.Position = [339 402 25 22];
            app.mLabel.Text = 'ÿm';

            % Create fromLabel
            app.fromLabel = uilabel(app.cylindersTab);
            app.fromLabel.FontWeight = 'bold';
            app.fromLabel.FontColor = [0.851 0.3255 0.098];
            app.fromLabel.Position = [228 376 32 22];
            app.fromLabel.Text = 'from';

            % Create toLabel
            app.toLabel = uilabel(app.cylindersTab);
            app.toLabel.FontWeight = 'bold';
            app.toLabel.FontColor = [0.851 0.3255 0.098];
            app.toLabel.Position = [228 352 25 22];
            app.toLabel.Text = 'to';

            % Create minLabel_2
            app.minLabel_2 = uilabel(app.cylindersTab);
            app.minLabel_2.FontSize = 11;
            app.minLabel_2.FontWeight = 'bold';
            app.minLabel_2.Position = [267 370 25 22];
            app.minLabel_2.Text = 'min';

            % Create mLabel_2
            app.mLabel_2 = uilabel(app.cylindersTab);
            app.mLabel_2.Position = [338 377 25 22];
            app.mLabel_2.Text = 'ÿm';

            % Create rEditFieldLabel
            app.rEditFieldLabel = uilabel(app.cylindersTab);
            app.rEditFieldLabel.HorizontalAlignment = 'right';
            app.rEditFieldLabel.FontWeight = 'bold';
            app.rEditFieldLabel.Position = [241 377 25 22];
            app.rEditFieldLabel.Text = 'r';

            % Create efRadMinCyl
            app.efRadMinCyl = uieditfield(app.cylindersTab, 'numeric');
            app.efRadMinCyl.Limits = [0 Inf];
            app.efRadMinCyl.Position = [293 377 41 22];
            app.efRadMinCyl.Value = 0.01;

            % Create maxLabel_2
            app.maxLabel_2 = uilabel(app.cylindersTab);
            app.maxLabel_2.FontSize = 11;
            app.maxLabel_2.FontWeight = 'bold';
            app.maxLabel_2.Position = [267 345 28 22];
            app.maxLabel_2.Text = 'max';

            % Create mLabel_3
            app.mLabel_3 = uilabel(app.cylindersTab);
            app.mLabel_3.Position = [338 352 25 22];
            app.mLabel_3.Text = 'ÿm';

            % Create rEditField_2Label
            app.rEditField_2Label = uilabel(app.cylindersTab);
            app.rEditField_2Label.HorizontalAlignment = 'right';
            app.rEditField_2Label.FontWeight = 'bold';
            app.rEditField_2Label.Position = [241 352 25 22];
            app.rEditField_2Label.Text = 'r';

            % Create efRadMaxCyl
            app.efRadMaxCyl = uieditfield(app.cylindersTab, 'numeric');
            app.efRadMaxCyl.Limits = [0 Inf];
            app.efRadMaxCyl.ValueDisplayFormat = '%.2f';
            app.efRadMaxCyl.Position = [293 352 41 22];
            app.efRadMaxCyl.Value = 20;

            % Create bVisProbDistCyl
            app.bVisProbDistCyl = uibutton(app.cylindersTab, 'push');
            app.bVisProbDistCyl.ButtonPushedFcn = createCallbackFcn(app, @bVisProbDistCylButtonPushed, true);
            app.bVisProbDistCyl.Position = [251 268 100 22];
            app.bVisProbDistCyl.Text = 'Visualize';

            % Create tgDispersionCyl
            app.tgDispersionCyl = uitabgroup(app.cylindersTab);
            app.tgDispersionCyl.TabLocation = 'left';
            app.tgDispersionCyl.Position = [-76 1 292 206];

            % Create emptyTab
            app.emptyTab = uitab(app.tgDispersionCyl);
            app.emptyTab.Title = 'empty';

            % Create MainaxisDropDownLabel
            app.MainaxisDropDownLabel = uilabel(app.emptyTab);
            app.MainaxisDropDownLabel.HorizontalAlignment = 'right';
            app.MainaxisDropDownLabel.FontWeight = 'bold';
            app.MainaxisDropDownLabel.Position = [9 178 60 22];
            app.MainaxisDropDownLabel.Text = 'Main axis';

            % Create ddMainAxisOptPara
            app.ddMainAxisOptPara = uidropdown(app.emptyTab);
            app.ddMainAxisOptPara.Items = {'X', 'Y', 'Z'};
            app.ddMainAxisOptPara.Position = [84 178 43 22];
            app.ddMainAxisOptPara.Value = 'X';

            % Create partiallyTab
            app.partiallyTab = uitab(app.tgDispersionCyl);
            app.partiallyTab.Title = 'partially';

            % Create dispangleEditFieldLabel
            app.dispangleEditFieldLabel = uilabel(app.partiallyTab);
            app.dispangleEditFieldLabel.HorizontalAlignment = 'right';
            app.dispangleEditFieldLabel.Position = [19 149 60 22];
            app.dispangleEditFieldLabel.Text = 'disp angle';

            % Create efDispAngle
            app.efDispAngle = uieditfield(app.partiallyTab, 'numeric');
            app.efDispAngle.Limits = [0 180];
            app.efDispAngle.Position = [94 149 100 22];

            % Create Label_7
            app.Label_7 = uilabel(app.partiallyTab);
            app.Label_7.Position = [199 151 10 22];
            app.Label_7.Text = '°';

            % Create MainaxisDropDownLabel_2
            app.MainaxisDropDownLabel_2 = uilabel(app.partiallyTab);
            app.MainaxisDropDownLabel_2.HorizontalAlignment = 'right';
            app.MainaxisDropDownLabel_2.FontWeight = 'bold';
            app.MainaxisDropDownLabel_2.Position = [9 178 60 22];
            app.MainaxisDropDownLabel_2.Text = 'Main axis';

            % Create ddMainAxisOptPart
            app.ddMainAxisOptPart = uidropdown(app.partiallyTab);
            app.ddMainAxisOptPart.Items = {'X', 'Y', 'Z'};
            app.ddMainAxisOptPart.Position = [84 178 43 22];
            app.ddMainAxisOptPart.Value = 'X';

            % Create fullyTab
            app.fullyTab = uitab(app.tgDispersionCyl);
            app.fullyTab.Title = 'fully';

            % Create tgRadDistCyl
            app.tgRadDistCyl = uitabgroup(app.cylindersTab);
            app.tgRadDistCyl.TabLocation = 'left';
            app.tgRadDistCyl.Position = [-76 264 292 129];

            % Create deltaTabCyl
            app.deltaTabCyl = uitab(app.tgRadDistCyl);
            app.deltaTabCyl.Title = 'delta';

            % Create gammaTabCyl
            app.gammaTabCyl = uitab(app.tgRadDistCyl);
            app.gammaTabCyl.Title = 'gamma';

            % Create shapeparaEditField_10Label
            app.shapeparaEditField_10Label = uilabel(app.gammaTabCyl);
            app.shapeparaEditField_10Label.HorizontalAlignment = 'right';
            app.shapeparaEditField_10Label.Position = [15 69 66 22];
            app.shapeparaEditField_10Label.Text = 'shape para';

            % Create efCylGammaShape
            app.efCylGammaShape = uieditfield(app.gammaTabCyl, 'numeric');
            app.efCylGammaShape.Limits = [0 Inf];
            app.efCylGammaShape.ValueChangedFcn = createCallbackFcn(app, @gammaValueChanged, true);
            app.efCylGammaShape.Position = [96 69 100 22];
            app.efCylGammaShape.Value = 2;

            % Create scaleparaEditField_10Label
            app.scaleparaEditField_10Label = uilabel(app.gammaTabCyl);
            app.scaleparaEditField_10Label.HorizontalAlignment = 'right';
            app.scaleparaEditField_10Label.Position = [20 38 61 22];
            app.scaleparaEditField_10Label.Text = 'scale para';

            % Create efCylGammaScale
            app.efCylGammaScale = uieditfield(app.gammaTabCyl, 'numeric');
            app.efCylGammaScale.Limits = [0 Inf];
            app.efCylGammaScale.ValueChangedFcn = createCallbackFcn(app, @gammaValueChanged, true);
            app.efCylGammaScale.Position = [96 38 100 22];
            app.efCylGammaScale.Value = 1e-06;

            % Create meanradiusrefSwitch_2Label
            app.meanradiusrefSwitch_2Label = uilabel(app.gammaTabCyl);
            app.meanradiusrefSwitch_2Label.HorizontalAlignment = 'center';
            app.meanradiusrefSwitch_2Label.Position = [9 101 89 22];
            app.meanradiusrefSwitch_2Label.Text = 'mean radius ref';

            % Create swCylGammaRadiusAuto
            app.swCylGammaRadiusAuto = uiswitch(app.gammaTabCyl, 'slider');
            app.swCylGammaRadiusAuto.ValueChangedFcn = createCallbackFcn(app, @swCylGammaRadiusAutoValueChanged, true);
            app.swCylGammaRadiusAuto.Position = [142 101 45 20];

            % Create bgCylGamma
            app.bgCylGamma = uibuttongroup(app.gammaTabCyl);
            app.bgCylGamma.AutoResizeChildren = 'off';
            app.bgCylGamma.SelectionChangedFcn = createCallbackFcn(app, @bgCylGammaSelectionChanged, true);
            app.bgCylGamma.BorderType = 'none';
            app.bgCylGamma.Position = [202 7 20 81];

            % Create rbCylGammaShape
            app.rbCylGammaShape = uiradiobutton(app.bgCylGamma);
            app.rbCylGammaShape.Text = '';
            app.rbCylGammaShape.Position = [3 63 20 22];
            app.rbCylGammaShape.Value = true;

            % Create rbCylGammaScale
            app.rbCylGammaScale = uiradiobutton(app.bgCylGamma);
            app.rbCylGammaScale.Text = '';
            app.rbCylGammaScale.Position = [3 31 20 22];

            % Create gevTabCyl
            app.gevTabCyl = uitab(app.tgRadDistCyl);
            app.gevTabCyl.Title = 'gev';

            % Create shapeparaEditField_11Label
            app.shapeparaEditField_11Label = uilabel(app.gevTabCyl);
            app.shapeparaEditField_11Label.HorizontalAlignment = 'right';
            app.shapeparaEditField_11Label.Position = [15 69 66 22];
            app.shapeparaEditField_11Label.Text = 'shape para';

            % Create efCylGevShape
            app.efCylGevShape = uieditfield(app.gevTabCyl, 'numeric');
            app.efCylGevShape.Limits = [0 Inf];
            app.efCylGevShape.ValueChangedFcn = createCallbackFcn(app, @gevValueChanged, true);
            app.efCylGevShape.Position = [96 69 100 22];
            app.efCylGevShape.Value = 0.8;

            % Create scaleparaEditField_11Label
            app.scaleparaEditField_11Label = uilabel(app.gevTabCyl);
            app.scaleparaEditField_11Label.HorizontalAlignment = 'right';
            app.scaleparaEditField_11Label.Position = [20 38 61 22];
            app.scaleparaEditField_11Label.Text = 'scale para';

            % Create efCylGevScale
            app.efCylGevScale = uieditfield(app.gevTabCyl, 'numeric');
            app.efCylGevScale.Limits = [0 Inf];
            app.efCylGevScale.ValueChangedFcn = createCallbackFcn(app, @gevValueChanged, true);
            app.efCylGevScale.Position = [96 38 100 22];
            app.efCylGevScale.Value = 1e-06;

            % Create locationparaEditField_3Label
            app.locationparaEditField_3Label = uilabel(app.gevTabCyl);
            app.locationparaEditField_3Label.HorizontalAlignment = 'right';
            app.locationparaEditField_3Label.Position = [7 7 74 22];
            app.locationparaEditField_3Label.Text = 'location para';

            % Create efCylGevLocation
            app.efCylGevLocation = uieditfield(app.gevTabCyl, 'numeric');
            app.efCylGevLocation.Limits = [0 Inf];
            app.efCylGevLocation.ValueChangedFcn = createCallbackFcn(app, @gevValueChanged, true);
            app.efCylGevLocation.Position = [96 7 100 22];
            app.efCylGevLocation.Value = 1e-06;

            % Create meanradiusrefSwitchLabel
            app.meanradiusrefSwitchLabel = uilabel(app.gevTabCyl);
            app.meanradiusrefSwitchLabel.HorizontalAlignment = 'center';
            app.meanradiusrefSwitchLabel.Position = [9 101 89 22];
            app.meanradiusrefSwitchLabel.Text = 'mean radius ref';

            % Create swCylGevRadiusAuto
            app.swCylGevRadiusAuto = uiswitch(app.gevTabCyl, 'slider');
            app.swCylGevRadiusAuto.ValueChangedFcn = createCallbackFcn(app, @swCylGevRadiusAutoValueChanged, true);
            app.swCylGevRadiusAuto.Position = [142 101 45 20];

            % Create bgCylGev
            app.bgCylGev = uibuttongroup(app.gevTabCyl);
            app.bgCylGev.AutoResizeChildren = 'off';
            app.bgCylGev.SelectionChangedFcn = createCallbackFcn(app, @bgCylGevSelectionChanged, true);
            app.bgCylGev.BorderType = 'none';
            app.bgCylGev.Position = [202 7 20 81];

            % Create rbCylGevShape
            app.rbCylGevShape = uiradiobutton(app.bgCylGev);
            app.rbCylGevShape.Text = '';
            app.rbCylGevShape.Position = [3 63 20 22];
            app.rbCylGevShape.Value = true;

            % Create rbCylGevScale
            app.rbCylGevScale = uiradiobutton(app.bgCylGev);
            app.rbCylGevScale.Text = '';
            app.rbCylGevScale.Position = [3 31 20 22];

            % Create rbCylGevLocation
            app.rbCylGevLocation = uiradiobutton(app.bgCylGev);
            app.rbCylGevLocation.Text = '';
            app.rbCylGevLocation.Position = [3 -1 20 22];

            % Create NameEditFieldLabel_2
            app.NameEditFieldLabel_2 = uilabel(app.CompartmentselectPanel);
            app.NameEditFieldLabel_2.HorizontalAlignment = 'right';
            app.NameEditFieldLabel_2.FontWeight = 'bold';
            app.NameEditFieldLabel_2.Position = [1 426 38 22];
            app.NameEditFieldLabel_2.Text = 'Name';

            % Create efCmpName
            app.efCmpName = uieditfield(app.CompartmentselectPanel, 'text');
            app.efCmpName.Position = [46 426 100 22];

            % Create bCmpAdd
            app.bCmpAdd = uibutton(app.CompartmentselectPanel, 'push');
            app.bCmpAdd.ButtonPushedFcn = createCallbackFcn(app, @bCmpAddButtonPushed, true);
            app.bCmpAdd.Position = [320 426 44 22];
            app.bCmpAdd.Text = 'Save';

            % Create FractionLabel
            app.FractionLabel = uilabel(app.CompartmentselectPanel);
            app.FractionLabel.HorizontalAlignment = 'right';
            app.FractionLabel.FontWeight = 'bold';
            app.FractionLabel.Position = [153 426 53 22];
            app.FractionLabel.Text = 'Fraction';

            % Create efCmpFraction
            app.efCmpFraction = uieditfield(app.CompartmentselectPanel, 'numeric');
            app.efCmpFraction.Limits = [0 100];
            app.efCmpFraction.ValueDisplayFormat = '%.0f';
            app.efCmpFraction.ValueChangedFcn = createCallbackFcn(app, @efCmpFractionValueChanged, true);
            app.efCmpFraction.Position = [215 426 37 22];

            % Create Label_5
            app.Label_5 = uilabel(app.CompartmentselectPanel);
            app.Label_5.Position = [257 426 25 22];
            app.Label_5.Text = '%';

            % Create Label_4
            app.Label_4 = uilabel(app.SmpTab);
            app.Label_4.HorizontalAlignment = 'right';
            app.Label_4.Position = [232 506 25 22];
            app.Label_4.Text = '';

            % Create ddCmpSelect
            app.ddCmpSelect = uidropdown(app.SmpTab);
            app.ddCmpSelect.Items = {'free', 'spheres', 'cylinders'};
            app.ddCmpSelect.ValueChangedFcn = createCallbackFcn(app, @ddCmpSelectValueChanged, true);
            app.ddCmpSelect.Position = [272 506 100 22];
            app.ddCmpSelect.Value = 'free';

            % Create RadiidistrubutionPanel
            app.RadiidistrubutionPanel = uipanel(app.SmpTab);
            app.RadiidistrubutionPanel.AutoResizeChildren = 'off';
            app.RadiidistrubutionPanel.Title = 'Radii distrubution';
            app.RadiidistrubutionPanel.Position = [564 244 429 283];

            % Create plotRadiiProbDist
            app.plotRadiiProbDist = uiaxes(app.RadiidistrubutionPanel);
            title(app.plotRadiiProbDist, '')
            xlabel(app.plotRadiiProbDist, 'radius [\mu{m}]')
            ylabel(app.plotRadiiProbDist, '')
            app.plotRadiiProbDist.PlotBoxAspectRatio = [1.84112144881646 1 1];
            app.plotRadiiProbDist.XLim = [0 2e-05];
            app.plotRadiiProbDist.Box = 'on';
            app.plotRadiiProbDist.YTickLabel = '';
            app.plotRadiiProbDist.Position = [4 6 419 255];

            % Create TestingPanelvisualizediffusionprocess
            app.TestingPanelvisualizediffusionprocess = uipanel(app.SmpTab);
            app.TestingPanelvisualizediffusionprocess.AutoResizeChildren = 'off';
            app.TestingPanelvisualizediffusionprocess.Title = 'Testing Panel (visualize diffusion process)';
            app.TestingPanelvisualizediffusionprocess.BackgroundColor = [0.902 0.902 0.902];
            app.TestingPanelvisualizediffusionprocess.FontWeight = 'bold';
            app.TestingPanelvisualizediffusionprocess.Position = [564 14 291 221];

            % Create DEditFieldLabel
            app.DEditFieldLabel = uilabel(app.TestingPanelvisualizediffusionprocess);
            app.DEditFieldLabel.HorizontalAlignment = 'right';
            app.DEditFieldLabel.FontWeight = 'bold';
            app.DEditFieldLabel.Position = [58 173 25 22];
            app.DEditFieldLabel.Text = 'D';

            % Create efTestADC
            app.efTestADC = uieditfield(app.TestingPanelvisualizediffusionprocess, 'numeric');
            app.efTestADC.Limits = [0 Inf];
            app.efTestADC.ValueDisplayFormat = '%11.2e';
            app.efTestADC.Position = [98 173 100 22];
            app.efTestADC.Value = 0.0001;

            % Create mmsLabel_2
            app.mmsLabel_2 = uilabel(app.TestingPanelvisualizediffusionprocess);
            app.mmsLabel_2.Position = [208 173 39 22];
            app.mmsLabel_2.Text = 'mm²/s';

            % Create tLabel
            app.tLabel = uilabel(app.TestingPanelvisualizediffusionprocess);
            app.tLabel.HorizontalAlignment = 'right';
            app.tLabel.FontWeight = 'bold';
            app.tLabel.Position = [58 139 25 22];
            app.tLabel.Text = 'ÿt';

            % Create efTestStepWidth
            app.efTestStepWidth = uieditfield(app.TestingPanelvisualizediffusionprocess, 'numeric');
            app.efTestStepWidth.Limits = [0 Inf];
            app.efTestStepWidth.ValueDisplayFormat = '%.0f';
            app.efTestStepWidth.Position = [98 139 100 22];
            app.efTestStepWidth.Value = 1000;

            % Create sLabel_2
            app.sLabel_2 = uilabel(app.TestingPanelvisualizediffusionprocess);
            app.sLabel_2.Position = [208 141 25 22];
            app.sLabel_2.Text = 'ÿs';

            % Create noparticlesEditFieldLabel
            app.noparticlesEditFieldLabel = uilabel(app.TestingPanelvisualizediffusionprocess);
            app.noparticlesEditFieldLabel.HorizontalAlignment = 'right';
            app.noparticlesEditFieldLabel.FontWeight = 'bold';
            app.noparticlesEditFieldLabel.Position = [10 105 73 22];
            app.noparticlesEditFieldLabel.Text = 'no particles';

            % Create efTestNoParticles
            app.efTestNoParticles = uieditfield(app.TestingPanelvisualizediffusionprocess, 'numeric');
            app.efTestNoParticles.Limits = [1 40];
            app.efTestNoParticles.ValueDisplayFormat = '%.0f';
            app.efTestNoParticles.Position = [98 105 100 22];
            app.efTestNoParticles.Value = 10;

            % Create noiterationsEditFieldLabel
            app.noiterationsEditFieldLabel = uilabel(app.TestingPanelvisualizediffusionprocess);
            app.noiterationsEditFieldLabel.HorizontalAlignment = 'right';
            app.noiterationsEditFieldLabel.FontWeight = 'bold';
            app.noiterationsEditFieldLabel.Position = [5 70 78 22];
            app.noiterationsEditFieldLabel.Text = 'no iterations';

            % Create efTestNoIterations
            app.efTestNoIterations = uieditfield(app.TestingPanelvisualizediffusionprocess, 'numeric');
            app.efTestNoIterations.Limits = [1 100000];
            app.efTestNoIterations.ValueDisplayFormat = '%.0f';
            app.efTestNoIterations.Position = [98 70 100 22];
            app.efTestNoIterations.Value = 10000;

            % Create bTestStart
            app.bTestStart = uibutton(app.TestingPanelvisualizediffusionprocess, 'push');
            app.bTestStart.ButtonPushedFcn = createCallbackFcn(app, @bTestStartButtonPushed, true);
            app.bTestStart.Position = [238 6 44 22];
            app.bTestStart.Text = 'Test';

            % Create TextArea_3
            app.TextArea_3 = uitextarea(app.TestingPanelvisualizediffusionprocess);
            app.TextArea_3.Editable = 'off';
            app.TextArea_3.BackgroundColor = [0.9804 0.9059 0.8235];
            app.TextArea_3.Position = [24 6 193 52];
            app.TextArea_3.Value = {'Usage:'; ' [Enter] key = next step'; ' [ESC]  key = skip all steps'};

            % Create lCmpFrac
            app.lCmpFrac = uilabel(app.SmpTab);
            app.lCmpFrac.HorizontalAlignment = 'right';
            app.lCmpFrac.FontWeight = 'bold';
            app.lCmpFrac.FontColor = [1 0 0];
            app.lCmpFrac.Position = [513 17 39 22];
            app.lCmpFrac.Text = '0%';

            % Create SimTab
            app.SimTab = uitab(app.tgControlPanel);
            app.SimTab.AutoResizeChildren = 'off';
            app.SimTab.Title = 'Simulate';

            % Create bStartSimu
            app.bStartSimu = uibutton(app.SimTab, 'push');
            app.bStartSimu.ButtonPushedFcn = createCallbackFcn(app, @bStartSimuButtonPushed, true);
            app.bStartSimu.FontWeight = 'bold';
            app.bStartSimu.Position = [7 12 100 22];
            app.bStartSimu.Text = 'START';

            % Create bExpFig
            app.bExpFig = uibutton(app.SimTab, 'push');
            app.bExpFig.ButtonPushedFcn = createCallbackFcn(app, @bExpFigButtonPushed, true);
            app.bExpFig.Position = [411 11 100 22];
            app.bExpFig.Text = 'Export Plot';

            % Create Panel
            app.Panel = uipanel(app.SimTab);
            app.Panel.AutoResizeChildren = 'off';
            app.Panel.Position = [518 13 834 522];

            % Create plotDiffSignal
            app.plotDiffSignal = uiaxes(app.Panel);
            title(app.plotDiffSignal, '')
            xlabel(app.plotDiffSignal, 'b-value [s/mm²]')
            ylabel(app.plotDiffSignal, 'log signal [a.u.]')
            app.plotDiffSignal.PlotBoxAspectRatio = [1.61620469083156 1 1];
            app.plotDiffSignal.FontSize = 14;
            app.plotDiffSignal.FontWeight = 'bold';
            app.plotDiffSignal.XLim = [0 5000];
            app.plotDiffSignal.YLim = [0 1100000];
            app.plotDiffSignal.Box = 'on';
            app.plotDiffSignal.YMinorTick = 'on';
            app.plotDiffSignal.YScale = 'log';
            app.plotDiffSignal.Position = [1 0 830 518];

            % Create LogViewerPanel
            app.LogViewerPanel = uipanel(app.SimTab);
            app.LogViewerPanel.AutoResizeChildren = 'off';
            app.LogViewerPanel.Title = 'Log Viewer';
            app.LogViewerPanel.FontWeight = 'bold';
            app.LogViewerPanel.Position = [7 94 509 441];

            % Create taLogViewer
            app.taLogViewer = uitextarea(app.LogViewerPanel);
            app.taLogViewer.FontName = 'Consolas';
            app.taLogViewer.FontSize = 11;
            app.taLogViewer.Position = [6 6 498 411];

            % Create PlotfreeADCofCheckBox
            app.PlotfreeADCofCheckBox = uicheckbox(app.SimTab);
            app.PlotfreeADCofCheckBox.Text = 'Plot free ADC of';
            app.PlotfreeADCofCheckBox.Position = [405 70 109 22];

            % Create mmsLabel_3
            app.mmsLabel_3 = uilabel(app.SimTab);
            app.mmsLabel_3.Position = [479 45 39 22];
            app.mmsLabel_3.Text = 'mm²/s';

            % Create efADCglobal_2
            app.efADCglobal_2 = uieditfield(app.SimTab, 'numeric');
            app.efADCglobal_2.Limits = [0 Inf];
            app.efADCglobal_2.ValueDisplayFormat = '%11.2e';
            app.efADCglobal_2.Position = [405 45 68 22];
            app.efADCglobal_2.Value = 0.0004;

            % Create AboutTab
            app.AboutTab = uitab(app.tgControlPanel);
            app.AboutTab.AutoResizeChildren = 'off';
            app.AboutTab.Title = 'About';

            % Create TextArea
            app.TextArea = uitextarea(app.AboutTab);
            app.TextArea.Editable = 'off';
            app.TextArea.HorizontalAlignment = 'center';
            app.TextArea.FontWeight = 'bold';
            app.TextArea.Position = [9 410 196 122];
            app.TextArea.Value = {'DIFfusion SIMulator'; 'DIF'; 'SIM'; ''; 'Developed by'; 'André Döring'; '<andre_doering@hotmail.com>'; '<DoringA@cardiff.ac.uk>'};

            % Create TextArea_2
            app.TextArea_2 = uitextarea(app.AboutTab);
            app.TextArea_2.Position = [220 410 579 121];
            app.TextArea_2.Value = {'This software relies on resource from:'; ''; '= Numerical Optimization of gradient Waveforms (NOW) ='; ''};

            % Create bgMenu
            app.bgMenu = uibuttongroup(app.DIFSIMUIFigure);
            app.bgMenu.SelectionChangedFcn = createCallbackFcn(app, @bgMenuSelectionChanged, true);
            app.bgMenu.Position = [1 536 1359 30];

            % Create bGeneralSettings
            app.bGeneralSettings = uitogglebutton(app.bgMenu);
            app.bGeneralSettings.Text = 'General Settings';
            app.bGeneralSettings.Position = [9 3 105 22];
            app.bGeneralSettings.Value = true;

            % Create bSampleSettings
            app.bSampleSettings = uitogglebutton(app.bgMenu);
            app.bSampleSettings.Text = 'Sample Settings';
            app.bSampleSettings.Position = [220 3 103 22];

            % Create bSimulate
            app.bSimulate = uitogglebutton(app.bgMenu);
            app.bSimulate.Text = 'Simulate';
            app.bSimulate.Position = [322 3 100 22];

            % Create bAbout
            app.bAbout = uitogglebutton(app.bgMenu);
            app.bAbout.Text = 'About';
            app.bAbout.Position = [1249 3 100 22];

            % Create bGradientSettings
            app.bGradientSettings = uitogglebutton(app.bgMenu);
            app.bGradientSettings.Text = 'Gradient Settings';
            app.bGradientSettings.Position = [113 3 108 22];

            % Show the figure after all components are created
            app.DIFSIMUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = mainGUI

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.DIFSIMUIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.DIFSIMUIFigure)
        end
    end
end