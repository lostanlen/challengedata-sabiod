%% TRAINING SET
% List WAV files
train_prefix = 'BIRD50_TRAIN_LifeClefSABIOD2015_';
extension = '.wav';
train_files = dir('TRAIN');
mkdir('TRAIN_out')
% Remove zero-byte files
train_bytes = [train_files.bytes];
train_files = train_files(train_bytes~=0);
% Get file names
train_filenames = {train_files.name};
nTrain_WAV_files = length(train_files);
% Load CSV lines
train_fid = fopen('SABIOD_LIFECLEF_UTLN_BIRD50_output_training.csv');
train_csv_cells = textscan(train_fid, '%s%s', 'delimiter',',');
fclose(train_fid);
% Check that there are as many CSV lines as WAV files
nCSV_lines = size(train_csv_cells, 1);
assert(nTrain_WAV_files == nCSV_lines);
nTrain_files = nTrain_WAV_files;
% Initialize new CSV file
train_csv_lines = cell(1, nTrain_files);
line_break = char(10);
for train_file_index = 1:nTrain_files
    % Get UUID
    train_uuid = train_csv_cells{train_file_index, 1};
    % Generate ID
    train_id = num2str(train_file_index, '%0.4d');
    % Rename WAV file
    train_filepath_in = ['TRAIN/', train_prefix, train_uuid, extension];
    train_filepath_out = ['TRAIN_out/', 'ID', train_id, extension]
    movefile(train_filepath_in, train_filepath_out);
    % Generate CSV line
    train_class = train_csv_cells{train_file_index, 2};
    train_csv_line = ['ID', train_id, ',', train_class, line_break];
end
% Write to CSV
train_fid = fopen('train.csv','w');
fprintf(train_fid, '%s', train_csv_lines{:});
fclose(train_fid);


%% TEST SET
% List WAV files
test_prefix = 'BIRD50_TESTdev_LifeClefSABIOD2015_';
test_files = dir('TEST');
mkdir('TEST_out')
% Remove zero-byte files
test_bytes = [test_files.bytes];
test_files = test_files(test_bytes~=0);
% Get file names
test_filenames = {test_files.name};
ntest_WAV_files = length(test_files);
% Load CSV lines
test_fid = fopen('SABIOD_LIFECLEF_UTLN_BIRD50_output_testing.csv');
test_csv_cells = textscan(test_fid, '%s%s', 'delimiter',',');
fclose(test_fid);
% Check that there are as many CSV lines as WAV files
nCSV_lines = size(test_csv_cells, 1);
assert(ntest_WAV_files == nCSV_lines);
ntest_files = ntest_WAV_files;
% Initialize new CSV file
test_csv_lines = cell(1, ntest_files);
line_break = char(10);
for test_file_index = 1:ntest_files
    % Get UUID
    test_uuid = test_csv_cells{test_file_index, 1};
    % Generate ID
    test_id = num2str(test_file_index, '%0.4d');
    % Rename WAV file
    test_filepath_in = ['TEST/', test_prefix, test_uuid, extension];
    test_filepath_out = ['TEST_out/', 'ID', test_id, extension]
    movefile(test_filepath_in, test_filepath_out);
    % Generate CSV line
    test_class = test_csv_cells{test_file_index, 2};
    test_csv_line = ['ID', test_id, ',', test_class, line_break];
end
% Write to CSV
test_fid = fopen('test.csv','w');
fprintf(test_fid, '%s', test_csv_lines{:});
fclose(test_fid);
