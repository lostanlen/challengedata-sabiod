training_folder_path = 'trainlegn_data';
training_files = dir(training_folder_path);
training_files = training_files(3:end); % remove .. and . references
nTraining_files = length(training_files);
lengths = zeros(nTraining_files,1);

for training_index = 1:nTraining_files
    training_index
    training_file = training_files(training_index);
    training_name = training_file.name;
    training_path = [training_folder_path, '/', training_name];
    training_waveform = audioread(training_path);
    lengths(training_index) = length(training_waveform);
end