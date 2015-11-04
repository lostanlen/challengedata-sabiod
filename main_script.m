train_prefix = 'BIRD50_TRAIN_LifeClefSABIOD2015_ID';

train_files = dir('TRAIN');
train_bytes = [train_files.bytes];
train_files = train_files(train_bytes~=0);
train_filenames = {train_files.name};

nTrain_files = length(train_files);
train_uuids = cell(1,nTrain_files);

for train_file_index = 1:nTrain_files
    train_uuids{train_file_index} = ...
        train_filenames{train_file_index}((length(train_prefix)+1):(length(train_prefix)+8));
end

uuid_decimals = hex2dec(train_uuids)