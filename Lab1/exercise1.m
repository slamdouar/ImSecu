%% Exercise 1: Building the eigenspace
% In this Introductory exercise, we will build our first eigenspace and
% compute the location of faces in this space

addpath /datas/teaching/courses/image/TpBiometry/public/Matlab

%% Part A: computing the eigenspaceA
disp('Part A: computing the eigenspaceA')
pathTrainA='/datas/teaching/courses/image/TpBiometry/public/Images/train_A/';
imagesA=loadImagesInDirectory(pathTrainA);
[MeansA, SpaceA, EigenValuesA] = buildSpace(imagesA);
save('SpaceA', 'SpaceA');
save('MeansA', 'MeansA');
save('EigenValuesA', 'EigenValuesA');

%% Part B : plotting the cimulative sum of eigenvalues
disp('Part B : plotting the cumulative sum of eigenvalues')
figure;
eigencumsum=plot(cumsum(EigenValuesA));
title('Cumulative sum of Eigenvalues')
xlabel('EigenFaces');
ylabel('CumulativeInfo');
save('cumulative sum of eigenvalues', 'eigencumsum');




%% Part C : approximating s1_1.jpg
disp('Part C : approximating s1_1.jpg')
eigenfaces=80;
approximateImage([pathTrainA 's1_1.jpg'], MeansA, SpaceA, eigenfaces);



%% Part D : projecting and plotting in face space
disp('Part D : projecting and plotting in face space')
TrainA= projectImages(imagesA, MeansA, SpaceA);
save('TrainA', 'TrainA');
plotFirst3Coordinates(TrainA, 5, 5); 

