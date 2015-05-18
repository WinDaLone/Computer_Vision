% recognition for RGB images
bikeSrc = dir('/Users/wyf920621/Documents/Computer_Vision/Project4/bike/*.bmp');
bikeDir = '/Users/wyf920621/Documents/Computer_Vision/Project4/bike/';
carSrc = dir('/Users/wyf920621/Documents/Computer_Vision/Project4/cars/*.bmp');
carDir = '/Users/wyf920621/Documents/Computer_Vision/Project4/cars/';
personSrc = dir('/Users/wyf920621/Documents/Computer_Vision/Project4/person/*.bmp');
personDir = '/Users/wyf920621/Documents/Computer_Vision/Project4/person/';
noneSrc = dir('/Users/wyf920621/Documents/Computer_Vision/Project4/none/*.bmp');
noneDir = '/Users/wyf920621/Documents/Computer_Vision/Project4/none/';
bikeDescriptor = getCategoryDescriptor(bikeSrc, bikeDir);
carDescriptor = getCategoryDescriptor(carSrc, carDir);
personDescriptor = getCategoryDescriptor(personSrc, personDir);
noneDescriptor = getCategoryDescriptor(noneSrc, noneDir);
descriptor = [bikeDescriptor; carDescriptor; personDescriptor; noneDescriptor];
[idx, C] = kmeans(descriptor, 500, 'Display', 'off');

bikeF = getBagsOfFeatures(bikeSrc, bikeDir, C);
carF = getBagsOfFeatures(carSrc, carDir, C);
personF = getBagsOfFeatures(personSrc, personDir, C);
noneF = getBagsOfFeatures(noneSrc, noneDir, C);
features = [bikeF; carF; personF; noneF];
bike_labels = ones(length(bikeSrc), 1); % bike: 1
car_labels = 2 * ones(length(carSrc), 1); % car: 2
person_labels = 3 * ones(length(personSrc), 1); % person: 3
none_labels = 4 * ones(length(noneSrc),1); % none: 4
labels = [bike_labels; car_labels; person_labels; none_labels];
SVMModel = svmtrain(labels, features);

% Test Part
testBikeSrc = dir('/Users/wyf920621/Documents/Computer_Vision/Project4/test_bikes/*.bmp');
testBikeDir = '/Users/wyf920621/Documents/Computer_Vision/Project4/test_bikes/';
testCarSrc = dir('/Users/wyf920621/Documents/Computer_Vision/Project4/test_cars/*.bmp');
testCarDir = '/Users/wyf920621/Documents/Computer_Vision/Project4/test_cars/';
testPersonSrc = dir('/Users/wyf920621/Documents/Computer_Vision/Project4/test_persons/*.bmp');
testPersonDir = '/Users/wyf920621/Documents/Computer_Vision/Project4/test_persons/';
testNoneSrc = dir('/Users/wyf920621/Documents/Computer_Vision/Project4/test_nones/*.bmp');
testNoneDir = '/Users/wyf920621/Documents/Computer_Vision/Project4/test_nones/';
features = getBagsOfFeatures(testPersonSrc, testPersonDir, C);
personLabels = ones(length(testPersonSrc), 1);
[predicted_person_label, person_accuracy, person_decision_values] = svmpredict(personLabels, features, SVMModel);
