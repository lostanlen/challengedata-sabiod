%% TRAINING SET
% List WAV files
train_files = dir('TRAIN');
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
    % Rename UUID WAV file to its ID
    filepath_in = ['TRAIN/', filename];
    filepath_out = ['TRAIN/', 'ID', num2str(train_file_index, '%0.4d'), '.wav'];
    movefile(filepath_in, filepath_out);
    % Generate CSV line
    id_str = num2str(train_file_index, '%0.4d');
    class_str = train_csv_cells{train_file_index, 2};
    train_csv_line = ['ID', id_str, ',', class_str, line_break];
end
% Write to CSV
train_fid = fopen('train.csv','w');
fprintf(train_fid, '%s', train_csv_lines{:});
fclose(train_fid);

%% Rename test set WAV files
test_files = dir('TEST');
test_bytes = [test_files.bytes];
test_files = test_files(test_bytes~=0);
test_filenames = {test_files.name};
nTest_files = length(test_files);
for test_file_index = 1:nTest_files
    filename = test_filenames{test_file_index};
    filepath_in = ['TEST/', filename];
    filepath_out = ['TEST/', 'ID', num2str(1000+test_file_index, '%0.4d'), '.wav'];
    movefile(filepath_in, filepath_out);
end

%% Rename files in testing set CSV
test_fid = fopen('SABIOD_LIFECLEF_UTLN_BIRD50v2_output_testing.csv');
test_csv_cells = textscan(test_fid, '%s%s', 'delimiter',',');
fclose(test_fid);
test_csv_cells = [test_csv_cells{:}];
test_csv_lines = cell(1, nTest_files);
line_break = char(10);
for test_file_index = 1:nTest_files
    test_csv_lines{test_file_index} = ...
        ['ID', num2str(1000 + test_file_index, '%0.4d'), ...
         ',', ...
         test_csv_cells{test_file_index,2}, ...
         line_break];
end
test_fid = fopen('test.csv','w');
fprintf(test_fid, '%s', test_csv_lines{:});
fclose(test_fid);
