%list_thous = xlsread('Users/willsnyder/Downloads/over_thous_list.xlsx');

list_thous = {
'ASD_CONTROL_FWE_chunk_10.nii.gz',
'ASD_CONTROL_FWE_chunk_11.nii.gz',
'ASD_CONTROL_FWE_chunk_14.nii.gz',
'ASD_CONTROL_FWE_chunk_15.nii.gz',
'ASD_CONTROL_FWE_chunk_20.nii.gz',
'ASD_CONTROL_FWE_chunk_21.nii.gz',
'ASD_CONTROL_FWE_chunk_23.nii.gz',
'ASD_CONTROL_FWE_chunk_24.nii.gz',
'ASD_CONTROL_FWE_chunk_26.nii.gz',
'ASD_CONTROL_FWE_chunk_35.nii.gz',
'ASD_CONTROL_FWE_chunk_36.nii.gz',
'ASD_CONTROL_FWE_chunk_43.nii.gz',
'ASD_CONTROL_FWE_chunk_50.nii.gz',
'ASD_CONTROL_FWE_chunk_51.nii.gz',
'ASD_CONTROL_FWE_chunk_52.nii.gz',
'ASD_CONTROL_FWE_chunk_55.nii.gz',
'ASD_CONTROL_FWE_chunk_56.nii.gz',
'ASD_CONTROL_FWE_chunk_68.nii.gz',
'ASD_CONTROL_FWE_chunk_7.nii.gz',
'ASD_CONTROL_FWE_chunk_72.nii.gz',
'ASD_CONTROL_FWE_chunk_75.nii.gz',
'ASD_CONTROL_FWE_chunk_76.nii.gz',
'ASD_CONTROL_FWE_chunk_87.nii.gz',
'ASD_CONTROL_FWE_chunk_89.nii.gz',
'ASD_CONTROL_FWE_chunk_90.nii.gz'};



fname = char("/Users/willsnyder/Downloads/T-maps/ASD_CONTROL_chunks/" + (list_thous{1}));
V = spm_vol( fname );
[P,XYZ] = spm_read_vols(V);

C = mat2cell(P, [9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 2], [9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 2], [9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 2]);


nonzero_count = 0;

%for d = 1:size(list_thous,1)
    fname = char("/Users/willsnyder/Downloads/T-maps/ASD_CONTROL_chunks/" + (list_thous{4}));
    V = spm_vol( fname );
    [P,XYZ] = spm_read_vols(V);
    for i = 1:size(C,1)
        for j = 1:size(C,2)
            for k = 1:size(C,3)
                C_temp = C{i,j,k};
                if sum(C_temp(:)) > 0
                   %tmp_cell = mat2cell(zeros(size(P)), [9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 2], [9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 2], [9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 2]);
                   %tmp_cell{i,j,k} = C_temp;
                   %roi_img = cell2mat(tmp_cell);
                   nonzero_count = nonzero_count + 1;
                   disp(nonzero_count);
                   %disp("d")
                   %disp(d)
                   fname = char("/Users/willsnyder/Downloads/T-maps/ASD_CONTROL_FWE_small_chunk" + nonzero_count + ".nii");
                   V.fname = fname;
                   V.dt(1) = 16;
                   %spm_write_vol(V,roi_img);
                end

            end
        end
    end
%
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
