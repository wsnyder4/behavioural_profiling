DomainNames={'anger','anxiety','attention', 'audition','disgust','execution','fear','gustation','happiness','imagination','inhibition','interoception','learning','mathema','memory','music','observation','olfaction','orthogra','phonolog','preparation','reasoning','sadness','semantic','social','somesthesis','space','speech','syntax','vision'};
DomainNames = string(DomainNames);
prefix = "/Users/willsnyder/Downloads/T-maps/wholetxt_2/";
deleted_array = [];
total_exps = 0;
for s = 1:size(DomainNames,2)
    [~,~, RAW] = xlsread(prefix + DomainNames(s) + ".xlsx");
    new_file = cell(size(RAW));
    next_space = 1;
    exp_count = 0;
     for i = 1:size(RAW,1)
        if contains(string(RAW(i,1)),"//") && ~contains(string(RAW(i,1)), "Subjects=0") && ~contains(string(RAW(i,1)), "Reference") && ( ismissing(string(RAW(i-1,1))) || contains(string(RAW(i-1,1)), "Reference") )
            exp_count = exp_count + 1;
        end
     end
    total_exps = total_exps + exp_count;
    num_exps = exp_count;
    r = [ zeros(1,round(num_exps/2))  ones(1,num_exps - round(num_exps/2)) ];
    r = r(randperm(length(r)));
    exp_count_2 = 0;
    for i = 1:size(RAW,1)
        if contains(string(RAW(i,1)),"//") && ~contains(string(RAW(i,1)), "Subjects=0") && ~contains(string(RAW(i,1)), "Reference") && ( ismissing(string(RAW(i-1,1))) || contains(string(RAW(i-1,1)), "Reference") )
            %exp_count = exp_count + 1;
            exp_count_2 = exp_count_2 + 1;
            %disp(exp_count)
            %disp(string(RAW(i,1)))
            for k = i:size(RAW,1)
                if ismissing(string(RAW(k,1)))
                    break
                end
            end
            %disp(RAW(i:(k-1),1:3))
            if (k ~= size(RAW,1)) && r(exp_count_2)
                new_file(next_space:(next_space + k  - 1 - i), 1:3) = RAW(i:(k -1),1:3);
                next_space = next_space + k - i + 1;
            elseif r(exp_count_2)
                new_file(next_space:(next_space + k - i), 1:3) = RAW(i:(k),1:3);
            elseif ~r(exp_count_2)
                deleted_array = [ deleted_array RAW(i:(i+2),1) ];
            end
        end
    end
    %TODO: CHANGE 4 DECIMALS TO TWO WHEN DECIMALS ARE PRESENT
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