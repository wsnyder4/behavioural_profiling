%%

tmp = '/Users/willsnyder/Downloads/T-maps/ASD_CONTROL_FWE_bin.nii.gz';
V=spm_vol(tmp);
[P,XYZ]=spm_read_vols(V);


C = mat2cell(P, [17 17 17 17 17 17 17 17 17 17 12], [17 17 17 17 17 17 17 17 17 17 17 17 14], [[17 17 17 17 17 17 17 17 17 17 12]]);
%C = mat2cell(P, [9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 2], [9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 2], [9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 2]);
%stored_rois = [];



nonzero_count = 0;
split_count = 0;
thous_count = 0;
for i = 1:size(C,1)
    for j = 1:size(C,2)
        for k = 1:size(C,3)
            C_temp = C{i,j,k};
            if sum(C_temp(:)) > 0
               nonzero_count = nonzero_count + 1;
               disp(nonzero_count);
               tmp_cell = mat2cell(zeros(size(P)), [17 17 17 17 17 17 17 17 17 17 12], [17 17 17 17 17 17 17 17 17 17 17 17 14], [[17 17 17 17 17 17 17 17 17 17 12]]);
               %tmp_cell = mat2cell(zeros(size(P)), [9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 2], [9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 2], [9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 2]);
               tmp_cell{i,j,k} = C_temp;
               roi_img = cell2mat(tmp_cell);
               %if (sum(roi_img(:)) > 999)
                  % split_img(P,roi_img, nonzero_count, V, split_count);
               %end
               %if (sum(roi_img(:)) <= 999)
                  fname = char("/Users/willsnyder/Downloads/T-maps/ASD_CONTROL_FWE_chunk" + nonzero_count + ".nii");
                  V.fname = fname;
                  V.dt(1) = 16;
                  spm_write_vol(V,roi_img);
               %end
            end
            
        end
    end
end


%% test

three_d_img = zeros(182,218,182);
for i = 1:94
    three_d_img = three_d_img + stored_rois(:,:,:,i);
    disp(i)
end
    
%%
V = spm_vol('/Users/willsnyder/Downloads/T-maps/ASD_CONTROL_FWE.nii.gz');
V.fname = '/Users/willsnyder/Downloads/T-maps/ASD_CONTROL_FWE_reconstructed.nii';
spm_write_vol(V,three_d_img);

%%
for i = 1:94
    fname = char("/Users/willsnyder/Downloads/T-maps/ASD_CONTROL_FWE_chunk_" + i + ".nii");
    V.fname = fname;
    chunk_img = stored_rois(:,:,:,i);
    spm_write_vol(V,chunk_img);
end





%%

function split_img(P,roi_img, nonzero_count, V, split_count)
    split_count = split_count + 1;
    ind = find(roi_img);
    [i1,~,~] = ind2sub(size(P), ind);
    x_cutoff = round(mean(i1));
    roi_img2 = zeros(size(P));
    roi_img3 = zeros(size(P));
    roi_img2(1:x_cutoff, :, :) = roi_img(1:x_cutoff, :, :);
    roi_img3((x_cutoff + 1):end, :,:) = roi_img((x_cutoff + 1):end, :,:);
    if sum(roi_img2(:)) > 999
        %split_img(P, roi_img2, nonzero_count, V, split_count)
    end
    if sum(roi_img2(:)) <= 999
        fname = char("/Users/willsnyder/Downloads/T-maps/CONTROL_ASD_FWE_chunk" + nonzero_count + "_" + split_count + "_L" + ".nii");
        V.fname = fname;
        V.dt(1) = 16;
        spm_write_vol(V, roi_img2);
    end
    
    if sum(roi_img3(:)) > 999
        %split_img(P, roi_img3, nonzero_count, V, split_count)
    end
    if sum(roi_img2(:)) <= 999
        fname = char("/Users/willsnyder/Downloads/T-maps/CONTROL_ASD_FWE_chunk" + nonzero_count + "_" + split_count + "_R" + ".nii");
        V.fname = fname;
        V.dt(1) = 16;
        spm_write_vol(V, roi_img3);
    end
end