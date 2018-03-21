%% Exercise 3 : verification
% In this exercise, we will obtain our first verification results answering
% the question "Is he/she the person he/she claims to be ?"
close all
addpath /datas/teaching/courses/image/TpBiometry/public/Matlab
pathTrainA='/datas/teaching/courses/image/TpBiometry/public/Images/train_A/';
pathTestA='/datas/teaching/courses/image/TpBiometry/public/Images/test_A/';

%% Part A : computing client and imposter scores
disp('Part A : computing client and imposter scores')
% Projecting images of Test A into Space A
images_TrainA=loadImagesInDirectory(pathTrainA);
images_TestA=loadImagesInDirectory(pathTestA);
TestA=projectImages(images_TestA,MeansA,SpaceA);
TrainA= projectImages(images_TrainA, MeansA, SpaceA);


% Computing client and imposter scores
[DistanceClients, DistanceImpostors]= verify(TrainA, TestA, 5);
save('DistanceClients','DistanceClients');
save('DistanceImpostors','DistanceImpostors');


% Plot histograms of client and imposter scores
[YClients, XClients]=hist(DistanceClients);
[YImpostors, XImpostors]=hist(DistanceImpostors);
figure;
hold on;
histClientImp=plot(XClients, YClients, 'b', XImpostors,(YImpostors/19),'r');
title('Client and Impostors scores')
legend('Clients','Impostors');
save('histClientImp', 'histClientImp');
% In order to better interpret the results, we rescale the histogram:

[YClients, XClients]=hist(-log(DistanceClients),10);
[YImpostors, XImpostors]=hist(-log(DistanceImpostors),10);
figure;
hold on;
histClientImpRescaled=plot(XClients, YClients, 'b', XImpostors,(YImpostors/19),'r');
title('Client and Impostors scores rescaled')
legend('Clients','Impostors');
save('histClientImpRescaled', 'histClientImpRescaled');


%% Part B : plotting the Receiver Operating Characteristic (ROC) curve
disp('Part B : plotting the Receiver Operating Characteristic (ROC) curve')
% In this part, we will plot the ROC with the same fixed number of
% eigenfaces. First, we need to compute the False Rejection Rate (FRR) and
% False Acceptance Rate (FAR)

[FRR, FAR] = computeVerificationRates(DistanceClients, DistanceImpostors);

%Plotting the results
figure;
ROC = plot(FRR,FAR);
title('ROC curve based on FRR and FAR');
xlabel('False Rejection Rate (FRR)');
ylabel('False Acceptance Rate (FAR)');
save('ROC', 'ROC');

%% Part C : drawing the Equal Error Rate (ERR) curve
disp('Part C : drawing the Equal Error Rate (ERR) curve')
% We will now compute the Equal Error Rate (EER) for various numbers of
% eigenfaces.
n_Eigenfaces=zeros(length(50));
EER=zeros(length(50));
for i=1:100
    [DistanceClients, DistanceImpostors]= verify(TrainA, TestA, i);
    n_Eigenfaces(i)=i;
    EER(i)=computeEER(DistanceClients, DistanceImpostors);
end

figure;
EERplot=plot(n_Eigenfaces, EER);
title('EER curve as a function of the number of eigenfaces');
xlabel('Eigenfaces');
ylabel('Equal Error Rate (EER)');
save('EERplot','EERplot');
    
