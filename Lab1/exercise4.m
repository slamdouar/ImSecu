%% Exercise 4 : mismatch between the eigenspace and test individuals
% In this exercise, we will try to evaluate the influence of a mismatch
% when the individuals used to build the eigenspace are different from the
% test individuals

%% Part A : computing identification rates for set B
disp('Part A : computing identification rates for set B')
% In this part, we will enroll the images of set Train B into SpaceA and
% project the images of the set Test B into Space A

% Loading images from Train B
pathTrainB='/datas/teaching/courses/image/TpBiometry/public/Images/train_B/';
images_TrainB=loadImagesInDirectory(pathTrainB);

% Loading images from Test B
pathTestB='/datas/teaching/courses/image/TpBiometry/public/Images/test_B/';
images_TestB=loadImagesInDirectory(pathTestB);

% Project images of Train B into Space A
TrainB=projectImages(images_TrainB,MeansA,SpaceA);
save('TrainB', 'TrainB');
% Project images of Test B into Space A
TestB=projectImages(images_TestB,MeansA,SpaceA);
save('TestB','TestB');
% We will now draw the location of the 5 faces of the first five individual
% of Test B in the space spanned by the first 3 eigenfaces of Space A

plotFirst3Coordinates(TestB, 5, 5);
title('Projected images from Test B into Space A');

% We will now compute the identification rate for a varying number of
% eigenfaces and we will plot the identification rate
Rates=zeros(length(50));
n_EigenFaces=zeros(length(50));
maxRate=0;
for i=1:100
    Rates(i)=identify(TrainB,TestB,i,1);
    n_EigenFaces(i)=i;
    maxRate=max(Rates);
    if Rates(i)==maxRate
        optimalEigenfacesB=n_EigenFaces(i);
    end
end
fprintf('The best identification Rate is %d which is obtained using %d eigenfaces \n', maxRate, optimalEigenfaces);

figure;
idRate4A=plot(n_EigenFaces,Rates);
title('The identification rate as a function of the number of eigenfaces');
xlabel('eigenfaces');
ylabel('identification rate');
save('idRate4A','idRate4A');

%% Part B : computing the eigenspace B
disp('Part B : computing the eigenspace B')
% In this part, we will enroll the images of set Train B into Space B and
% the images of the set Test B into Space B.

% We first need to build the Space B
[MeansB, SpaceB, EigenValuesB] = buildSpace(images_TrainB);
save('SpaceB', 'SpaceB');
save('MeansB', 'MeansB');
save('EigenValuesB', 'EigenValuesB');

% Project images of Train B into Space B
TrainB_SpaceB=projectImages(images_TrainB,MeansB,SpaceB);
save('TrainB_SpaceB', 'TrainB_SpaceB');
% Project images of Test B into Space B
TestB_SpaceB=projectImages(images_TestB,MeansB,SpaceB);
save('TestB_SpaceB','TestB_SpaceB');

% We will now draw the location of the 5 faces of the first five individual
% of Test B in the space spanned by the first 3 eigenfaces of Space B

plotFirst3Coordinates(TestB_SpaceB, 5, 5);
title('Projected images from Test B into Space B');

% We will now compute the identification rate for a varying number of
% eigenfaces and we will plot the identification rate
RatesB=zeros(length(50));
n_EigenFacesB=zeros(length(50));
maxRateB=0;
for i=1:100
    RatesB(i)=identify(TrainB_SpaceB,TestB_SpaceB,i,1);
    n_EigenFacesB(i)=i;
    maxRateB=max(RatesB);
    if RatesB(i)==maxRateB
        optimalEigenfacesB=n_EigenFacesB(i);
    end
end
fprintf('The best identification Rate is %d which is obtained using %d eigenfaces \n', maxRateB, optimalEigenfacesB);

figure;
idRate4B=plot(n_EigenFacesB,RatesB);
title('The identification rate as a function of the number of eigenfaces');
xlabel('eigenfaces');
ylabel('identification rate');
save('idRate4B','idRate4B');
