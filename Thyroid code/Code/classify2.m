function [] = classify2()
    data = jsondecode(fileread('features.json'));
    
    [num,~,raw] = xlsread('../Data/labels1.xlsx','A1:C480');
    map = containers.Map(raw(:,1),[1:480]);
    
    [r,~] = size(data.names);
    ben = [];
    mal = [];
    
    for i = 1:r
        %out = [map(string(data.names(i)));out];
        idx = map(string(data.names(i)));
        if num(idx,1) == 1
           ben = [ben;i,idx];
        elseif num(idx,1) == 2
           mal = [mal;i,idx];
        end
    end
    
    %Benign
        benout = [];
        [r,~] = size(ben);
        for i = 1:r
            benout = [benout;num(ben(i,2),2)-1];
        end
        
    
         %HOG
            %databen = data.HOG_featurevectors(ben(:,1),:);
            %sensitivity,specificity,precision,FPR,Accuracy,recall,F1
            %res = helper(databen,benout,10, 100);
         
            %PLOT
            %plotter(res,'Benign HOT');

    
        %DCT
            %databen = data.DCT_featurevectors(ben(:,1),:);
            %sensitivity,specificity,precision,FPR,Accuracy,recall,F1
            %res = helper(databen,benout, 10, 100);
            
            %PLOT
            %plotter(res,'Benign DCT');


        %DWT
        databen = data.DWT_featurevectors(ben(:,1),:);

        res = helper(databen,benout, 10);
        
        
        %SURP

        %databen = data.SURP_featurevectors(ben(:,1),:);

        %res = helper(databen,benout, 10);
        
        %SIFT

        %databen = data.SIFT_featurevectors(ben(:,1),:);

        %res = helper(databen,benout, 10);



    
    
    %Malignant
        malout = [];
        [r,~] = size(mal);
        for i = 1:r
            malout = [malout;num(mal(i,2),2)-3];
        end

    
        %HOG
            %datamal = data.HOG_featurevectors(mal(:,1),:);
           
            %sensitivity,specificity,precision,FPR,Accuracy,recall,F1
            %[res] = helper(datamal, malout, 10, 100);
            %PLOT
            %plotter(res,'Malignant HOT');


        %DCT
            %datamal = data.DCT_featurevectors(mal(:,1), :);
            %sensitivity,specificity,precision,FPR,Accuracy,recall,F1
            %[res] = helper(datamal,malout,10, 100);
            
            %PLOT
            %plotter(res,'Malignant DCT');


%DWT

        datamal = data.DWT_featurevectors(mal(:,1), :);

        [res] = helper(datamal,malout,10);



       %SURP
        %datamal = data.SURP_featurevectors(mal(:,1), :);

        %[res] = helper(datamal,malout,10);

        %SIFT

        %datamal = data.SIFT_featurevectors(mal(:,1), :);

        %[res] = helper(datamal,malout,10);

        %plot
        %hold on
        %plot(res(:,1),res(:,2)*100,':b', 'LineWidth',2)
        %plot(res(:,1),res(:,3)*100,':g', 'LineWidth',2)
        %plot(res(:,1),res(:,6)*100,':r', 'LineWidth',2)
            

        %grid on

        %title('STAGE-2 DWT-Malignant')
        %xlabel('Number of Features')
        %ylabel( 'Percentage(%)');
        %legend('Sensitivity','Specificity','Accuracy',  'Location','best')

        %plot
        hold on
        plot(res(:,1),res(:,2)*100,':b', 'LineWidth',2)
        plot(res(:,1),res(:,3)*100,':g', 'LineWidth',2)
        plot(res(:,1),res(:,6)*100,':r', 'LineWidth',2)
            

        grid on

        title('STAGE-2 DWT-Malignant')
        xlabel('Number of Features')
        ylabel( 'Percentage(%)');
        legend('Sensitivity','Specificity','Accuracy',  'Location','best')

             
            

end