% Project 4
truthSrc = dir('/Users/wyf920621/Documents/Computer_Vision/Project4/groundtruth_GRAZ_02_900_images/*.jpg');
truthDir = '/Users/wyf920621/Documents/Computer_Vision/Project4/groundtruth_GRAZ_02_900_images/';
descriptor = getCategoryDescriptor(truthSrc, truthDir);
% Dictionary Computation
[idx, C] = kmeans(descriptor, 500, 'Display', 'off');

features = getBagsOfFeatures(truthSrc, truthDir, C);
bike_labels = ones(300, 1); % bike: 1
car_labels = 2 * ones(300, 1); % car: 2
person_labels = 3 * ones(300, 1); % person: 3
labels = [bike_labels; car_labels; person_labels];
clear bike_labels;
clear car_labels;
clear person)labels;
SVMModel = svmtrain(labels, features);
clear truthDir;
clear truthSrc;

% Test part
bikeSrc = dir('/Users/wyf920621/Documents/Computer_Vision/Project4/test_bikes/*.jpg');
bikeDir = '/Users/wyf920621/Documents/Computer_Vision/Project4/test_bikes/';
carSrc = dir('/Users/wyf920621/Documents/Computer_Vision/Project4/test_cars/*.jpg');
carDir = '/Users/wyf920621/Documents/Computer_Vision/Project4/test_cars/';
personSrc = dir('/Users/wyf920621/Documents/Computer_Vision/Project4/test_persons/*.jpg');
personDir = '/Users/wyf920621/Documents/Computer_Vision/Project4/test_persons/';

features = getBagsOfFeatures(bikeSrc, bikeDir, C);
bikeLabels = ones(length(bikeSrc), 1);
[predicted_bike_label, bike_accuracy, bike_decision_values] = svmpredict(bikeLabels, features, SVMModel);

features = getBagsOfFeatures(carSrc, carDir, C);
carLabels = 2 * ones(length(carSrc), 1);
[predicted_car_label, car_accuracy, car_decision_values] = svmpredict(carLabels, features, SVMModel);

features = getBagsOfFeatures(personSrc, personDir, C);
personLabels = 3 * ones(length(personSrc), 1);
[predicted_person_label, person_accuracy, person_decision_values] = svmpredict(personLabels, features, SVMModel);
