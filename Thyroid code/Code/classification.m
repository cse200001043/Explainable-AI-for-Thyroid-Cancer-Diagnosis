function [] = classification()
    data = jsondecode(fileread('features.json'));
    
    [~,~,raw] = xlsread('../Data/labels.xlsx','A1:C480');
    map = containers.Map(raw(:,1),raw(:,2));
    
    [r,~] = size(data.names);
        
    out = [];
    for i = 1:r
        out = [map(string(data.names(i)));out];
    end
    
    %HOG
        %in = data.HOG_featurevectors(:,:);
        %sensitivity,specificity,precision,FPR,Accuracy,recall,F1
        %[ res ] = helper(in, out, 10, 100);

        %PLOT
        %plotter(res,'HOT');
   
    
    %DCT
        %in = data.DCT_featurevectors(:,:);
        %sensitivity,specificity,precision,FPR,Accuracy,recall,F1
        %[ res ] = helper(in,out,10, 100);

        %PLOT
        %plotter(res,'DCT');

    %DWT
        in = data.DWT_featurevectors(:,:);
        %sensitivity,specificity,precision,FPR,Accuracy,recall,F1
        [ res ] = helper(in,out,10);

    %DWT
        %in = data.DWT_featurevectors(:,:);
        %sensitivity,specificity,precision,FPR,Accuracy,recall,F1
        %[ res ] = helper(in,out,10);

     % Hot-dwt
        %in = data.HOT_DWT_featurevector(:,:);
        %[ res ] = helper(in,out,10);

        %PLOT
        %plotter(res,'DWT');
        %hold on
        %plot(res(:,1),res(:,2)*100,':b', 'LineWidth',2)
        %plot(res(:,1),res(:,3)*100,':g', 'LineWidth',2)
        %plot(res(:,1),res(:,6)*100,':r', 'LineWidth',2)
            

        %grid on

        %title('STAGE-1 DWT')
        %xlabel('Number of Features')
        %ylabel( 'Percentage(%)');
        %legend('Sensitivity','Specificity','Accuracy',  'Location','best')

       %SURP

       %in = data.SURP_featurevectors(:,:);

       %sensitivity,specificity,precision,FPR,Accuracy,recall,F1

      % [ res ] = helper(in,out,50);

       %PLOT
       %plotter(res,'DWT');
        %hold on
        %plot(res(:,1),res(:,2)*100,':b', 'LineWidth',2)
        %plot(res(:,1),res(:,3)*100,':g', 'LineWidth',2)
        %plot(res(:,1),res(:,6)*100,':r', 'LineWidth',2)
            

        %grid on

        %title('STAGE-1 SURP')
        %xlabel('Number of Features')
        %ylabel( 'Percentage(%)');
        %legend('Sensitivity','Specificity','Accuracy',  'Location','best')


       %in = data.SIFT_featurevectors(:,:);

       %sensitivity,specificity,precision,FPR,Accuracy,recall,F1

       %[ res ] = helper(in,out,50);

       %PLOT
       %plotter(res,'DWT');
       %hold on
       %plot(res(:,1),res(:,2)*100,':b', 'LineWidth',2)
       %plot(res(:,1),res(:,3)*100,':g', 'LineWidth',2)
       %plot(res(:,1),res(:,6)*100,':r', 'LineWidth',2)
            

       %grid on

       %title('STAGE-1 HOT-DWT')
       %xlabel('Number of Features')
       %ylabel( 'Percentage(%)');
       %legend('Sensitivity','Specificity','Accuracy',  'Location','best')

end