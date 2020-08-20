DomainNames={'anger','anxiety','attention', 'audition','disgust','execution','fear','gustation','happiness','imagination','inhibition','interoception','learning','mathema','memory','music','observation','olfaction','orthogra','phonolog','preparation','reasoning','sadness','semantic','social','somesthesis','space','speech','syntax','vision'};
DomainNames = string(DomainNames);
top_path='/Users/willsnyder/Documents/FWE_CONTROL_ASD_txt_final/sample/';
extension = '_sample_p001_C05_1k_ALE.nii';
imgdata3 = zeros(size(DomainNames));
lmat2 = zeros(size(DomainNames));
n = 0;
for i = 1:size(DomainNames,2)
    if string(DomainNames(i)) ~= "mathema"
        tmp=char(top_path + "clust2_1mm_" + string(DomainNames(i)) + extension );
        V=spm_vol(tmp);
        [P,XYZ]=spm_read_vols(V);
        imgdata3(i) = sum(P(:));
        lmat2(i) = .5 + (.5/(1+ exp((40-sum(P(:)>0))/10)));
        n = n + sum(P(:));
    else
        imgdata3(i) = 0;
    end
end   
figure
normalized_data3 = imgdata3/(sum(imgdata3(:)));




smoothed_data2 = zeros(size(normalized_data3));
for j = 1:size(normalized_data3,2)
    smoothed_data2(j) = lmat2(j)*normalized_data3(j) + (1 - lmat2(j))*normalized_data(j);
    
end
smoothed_data2 = smoothed_data2/sum(smoothed_data2(:));
smoothed_data2(31) = smoothed_data2(1);
%polar plot is customized below
polarplot(smoothed_data2, 'LineWidth',10)
thetaticks(0:12:360)
%The uneven spacing on the theta tick labels is to make the polar plot look
%better spaced.
smoothed_data_truncated = smoothed_data2([2 6 15 22 25 28 30]);
smoothed_data_truncated(8) = smoothed_data_truncated(1);
smoothed_data_truncated_with_zeros = upsample(smoothed_data_truncated,2);
polarplot(smoothed_data_truncated_with_zeros, 'LineWidth',10)
thetaticks(0:(360/15):360)
thetaticklabels({'anger','anxiety','attention', 'audition','disgust','execution','   fear','               gustation','happiness','      imagination','inhibition','interoception','learning','mathemamatics','memory','music','observation','olfaction','orthography','phonology','preparation','reasoning','sadness','           semantic','social','somesthesis','space','speech','syntax','vision'})
pax=gca;
pax.FontName = "Times New Roman";
pax.LineWidth=2;
pax.FontSize=20;


figure
smoothed_data_truncated = smoothed_data2([3 6 15 22 25 28 30]);
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



