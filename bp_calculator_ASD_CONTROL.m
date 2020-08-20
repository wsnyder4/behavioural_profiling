top_path='/Users/willsnyder/Documents/FWE_ASD_CONTROL_txt_final/sample/';
imgdata2 = zeros(size(DomainNames));
lmat1 = zeros(size(DomainNames));
obs_mat = zeros(size(DomainNames));
n = 0;
for i = 1:size(DomainNames,2)
    if string(DomainNames(i)) ~= "space"
        tmp=char(top_path + "clust2_1mm_" + string(DomainNames(i)) + extension );
        V=spm_vol(tmp);
        [P,XYZ]=spm_read_vols(V);
        imgdata2(i) = sum(P(:));
        obs_mat(i) = sum(P(:)>0);
        n = n + sum(P(:)>0);
        lmat1(i) = .5 + (.5/(1+ exp((25-sum(P(:)>0))/10)));
    else
        imgdata2(i) = 0;
    end
end   
figure
normalized_data2 = imgdata2/(sum(imgdata2(:)));


smoothed_data = zeros(size(normalized_data2));
for j = 1:size(normalized_data2,2)
    smoothed_data(j) = lmat1(j)*normalized_data2(j) + (1 - lmat1(j))*normalized_data(j);
    
end
smoothed_data = smoothed_data/sum(smoothed_data(:));
smoothed_data(31) = smoothed_data(1);
%polar plot is customized below
polarplot(smoothed_data, 'LineWidth',10)
thetaticks(0:12:360)
%The uneven spacing on the theta tick labels is to make the polar plot look
%better spaced.
thetaticklabels({'anger','anxiety','attention', 'audition','disgust','execution','   fear','               gustation','happiness','      imagination','inhibition','interoception','learning','mathemamatics','memory','music','observation','olfaction','orthography','phonology','preparation','reasoning','sadness','           semantic','social','somesthesis','space','speech','syntax','vision'})
pax=gca;
pax.FontName = "Times New Roman";
pax.LineWidth=2;
pax.FontSize=20;


figure
smoothed_data_truncated = smoothed_data([3 6 15 22 25 28 30]);
smoothed_data_truncated(8) = smoothed_data_truncated(1);
smoothed_data_truncated_with_zeros = upsample(smoothed_data_truncated,2);
smoothed_data_truncated_with_zeros = smoothed_data_truncated_with_zeros(1:15);
%smoothed_data_truncated_with_zeros(1) = 0;
polarplot(smoothed_data_truncated_with_zeros, 'LineWidth',10)
thetaticks(0:(360/14):(360-(360/14)))
thetaticklabels({'attention','' , 'execution','', 'memory','','reasoning','', 'social','', 'speech','', 'vision'})
pax2 = gca;
pax2.FontName = "Times New Roman";
pax2.LineWidth=1.5;
pax2.FontSize=30;

