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
