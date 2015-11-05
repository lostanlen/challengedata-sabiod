extension = '.wav';

%% Get UUIDS of training set
train_prefix = 'BIRD50_TRAIN_LifeClefSABIOD2015_ID';
train_files = dir('TRAIN');
train_bytes = [train_files.bytes];
train_files = train_files(train_bytes~=0);
train_filenames = {train_files.name};
nTrain_files = length(train_files);
train_uuids = cell(1,nTrain_files);
for train_file_index = 1:nTrain_files
    filename = train_filenames{train_file_index};
    range = (length(train_prefix)+1):(length(filename)-length(extension));
    train_uuids{train_file_index} = train_filenames{train_file_index}(range);
end
