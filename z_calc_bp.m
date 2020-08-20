z = zeros(1,30);


for i = 1:30
    numr = smoothed_data2(i) - normalized_data(i);
    denm = ((normalized_data(i) * (1 - normalized_data(i)) )/ n )^0.5;
    z(i) = numr/denm;
end

p = zeros(1,30);

for s = 1:30
    [val , ind] = maxk(smoothed_data2,s);
    if sum(val) > 0.6
        break
    end
end


for j = 1:30
    if (z(j) > 0) && sum(j == ind)
        intervals = normcdf([z(j) inf]);
        p(j) = intervals(2) - intervals(1);
    else
        p(j) = 1;
    end 
end
