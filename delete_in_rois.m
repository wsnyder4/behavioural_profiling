DomainNames={'anger','anxiety','attention', 'audition','disgust','execution','fear','gustation','happiness','imagination','inhibition','interoception','learning','mathema','memory','music','observation','olfaction','orthogra','phonolog','preparation','reasoning','sadness','semantic','social','somesthesis','space','speech','syntax','vision'};
DomainNames = string(DomainNames);
prefix = "/Users/willsnyder/Downloads/FWE_CONTROL_ASD_txt_final/";  
total_deleted = 0;
total_exps_roi = 0;
for s = 1:size(DomainNames,2)
    [~,~, RAW] = xlsread(prefix + DomainNames(s) + ".xlsx");
    num_deleted = 0;
    exp_count = 0;
    new_file = cell(size(RAW));
    next_space = 1;
    for i = 1:size(RAW,1)
        if contains(string(RAW(i,1)),"//") && ~contains(string(RAW(i,1)), "Subjects=0") && ~contains(string(RAW(i,1)), "Reference") && ( ismissing(string(RAW(i-1,1))) || contains(string(RAW(i-1,1)), "Reference") )
            exp_count = exp_count + 1;
            include_exp = 1;
            for j = 1:size(deleted_array,2)
                if string(RAW(i:(i+2),1)) == string(deleted_array(1:3,j))
                    num_deleted = num_deleted + 1;  
                    include_exp = 0;
                end
            end
         for k = i:size(RAW,1)
                if ismissing(string(RAW(k,1)))
                    break
                end
         end
         if (k ~= size(RAW,1)) && include_exp
                new_file(next_space:(next_space + k  - 1 - i), 1:3) = RAW(i:(k -1),1:3);
                next_space = next_space + k - i + 1;
            elseif include_exp
                new_file(next_space:(next_space + k - i), 1:3) = RAW(i:(k),1:3);
         end

        end
    end
    total_deleted = total_deleted + num_deleted;
    total_exps_roi = total_exps_roi + exp_count;
    new_file_2 = cell(size(new_file,1)+1, size(new_file,2));
    new_file_2(2:end,:) = new_file(:,:);
    new_file_2(1,1) = RAW(1,1);
    for j = 1:size(new_file_2,1)
        if isempty(cell2mat(new_file_2(j,1))) && isempty(cell2mat(new_file_2(j + 1,1))) && isempty(cell2mat(new_file_2(j + 2,1)))
            break
        end
    end
    new_file_3 = cell(j-1,3);
    new_file_3(1:end, :) = new_file_2(1:(j-1),:);
    fname = prefix + DomainNames(s) + "_sample.txt";
    writecell(new_file_3,fname, 'Delimiter', 'tab');
end