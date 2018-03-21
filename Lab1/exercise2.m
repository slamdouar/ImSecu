%% Exercise 2: Identification
% In this exercise, we will obtain our first identification and cumulative
% indentification results.
close all
addpath /datas/teaching/courses/image/TpBiometry/public/Matlab
pathTrainA='/datas/teaching/courses/image/TpBiometry/public/Images/train_A/';
pathTestA='/datas/teaching/courses/image/TpBiometry/public/Images/test_A/';
%% Part A : projecting and plotting Test A
disp('Part A : projecting and plotting Test A');
% Projecting the images of Test A on Space A
imagesA=loadImagesInDirectory(pathTrainA);
TestA=projectImages(imagesA,MeansA,SpaceA);
save('TestA','TestA');

% Plotting the location of the first test points of the five first
% individuals in the space spanned by the first 3 eigenvectors of SpaceA
locationPlot=plotFirst3Coordinates(TestA,5,5);
title('Projected test images on SpaceA');
save('locationPlotTestA', 'locationPlot');

%% Part B : approximating s1_6.jpg
disp('Part B : approximating s1_6.jpg');
% Rebuilding the first test face of the first person using a varying number
% of eigenfaces
for i=1:30:100
    approximateImage([pathTestA 's1_6.jpg'], MeansA, SpaceA, i);
end

%% Part C : computing the identification rates (first face)
disp('Part C : computing the identification rates');
% Compute the identification rates by comparing the test identities
% (Part A)angainst the enrolled identities (Ex1).

% We will take the first training face of each individual as a reference
% point
firstTrainA=TrainA(1:5:end,:);
save('firstTrainA','firstTrainA');
Rates=zeros(length(50));
n_EigenFaces=zeros(length(50));
maxRate=0;
for i=1:100
    Rates(i)=identify(firstTrainA,TestA,i,1);
    n_EigenFaces(i)=i;
    maxRate=max(Rates);
    if Rates(i)==maxRate
        optimalEigenfaces=n_EigenFaces(i);
    end
end
fprintf('The best identification Rate is %d which is obtained using %d eigenfaces \n', maxRate, optimalEigenfaces);


figure;
idRate=plot(n_EigenFaces,Rates);
title('The identification rate as a function of the number of eigenfaces');
xlabel('eigenfaces');
ylabel('identification rate');
save('IdRateEigenFaces', 'idRate');

%% Part D : more identification rates (mean face)
disp('Part D : more identification rates (mean face)')
% In this part, we will repeat Part C only this time, we will use the
% average of the points used as reference for each individuals.
% First, we have to calculate the mean of the five projected images of
% TrainA of each individual (we have 20 individuals here)

RefPoints=zeros(20,100);
for i=1:20
    
    firstTrainAm=TrainA((i-1)*5+1:i*5,:);
    RefPoints(i,:)=mean(firstTrainAm);
end
save ('RefPoints','firstTrainAm');

% Now we will compute the identification rates
RatesM=zeros(length(50));
n_EigenFacesM=zeros(length(50));
maxRateM=0;
for i=1:100
    RatesM(i)=identify(RefPoints,TestA,i,1);
    n_EigenFacesM(i)=i;
    maxRateM=max(RatesM);

end

fprintf('The best identification Rate is %d \n', maxRateM);
figure;
idRateAv=plot(n_EigenFacesM,RatesM);
title('The identification rate as a function of the number of eigenfaces using averages');
xlabel('eigenfaces');
ylabel('identification rate');
save('idRateAv', 'idRateAv');

%% Part E : drawing identification rates as a function of N-Best
disp('Part E : drawing identification rates as a function of N-Best')
% From now on, we will always use the reference points as in Part D

save('RefPoints','RefPoints');

% Project the images of Test A into Space A (Same as in Part A, we can use TestA)
% For a fixed number of eigenfaces (e.g. 5), we will compute the N-Best
% identification rates, for various N
TotalN=zeros(length(50));
Rates=zeros(length(50));
for i=1:20
    Rates(i)=identify(RefPoints, TestA, i, 5);
    TotalN(i)=i;
    maxRate=max(Rates);
    if Rates(i)== maxRate
        optimalN=TotalN(i);
    end
end
fprintf('The best identification rate is %d for N=%d \n', maxRate, optimalN); 
figure;
idRateN=plot(TotalN,Rates);
title('The identification rate as a function of N');
xlabel('N');
ylabel('identification rate');
save('idRateN','idRateN');
