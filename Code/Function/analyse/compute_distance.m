function [delta_d,distance] = compute_distance(X,Y,X10,Y10,X_C,Y_C,X10_C,Y10_C)

distance = zeros(length(X10_C(1,:)),length(X10_C(1,:)));
d = zeros(length(X(:,1)),length(X10_C(1,:)));
d10 = zeros(length(X(:,1)),length(X10_C(1,:)));
d_c = zeros(length(X(:,1)),length(X10_C(1,:)));
d10_c = zeros(length(X(:,1)),length(X10_C(1,:)));
d_ref = zeros(length(X(:,1)),1);

for j=1:length(X10_C(1,:))
    for i=2:length(X(:,1))
        d(i,j) = d(i-1,j) + sqrt((X(i,j)-X(i-1,j)).^2+(Y(i,j)-Y(i-1,j)).^2);
        d10(i,j) = d(i-1,j) + sqrt((X10(i,j)-X10(i-1,j)).^2+(Y10(i,j)-Y10(i-1,j)).^2);
        d_c(i,j) = d(i-1,j) + sqrt((X_C(i,j)-X_C(i-1,j)).^2+(Y_C(i,j)-Y_C(i-1,j)).^2);
        d10_c(i,j) = d(i-1,j) + sqrt((X10_C(i,j)-X10_C(i-1,j)).^2+(Y10_C(i,j)-Y10_C(i-1,j)).^2);
        d_ref(i,1) = d_ref(i-1,1) + sqrt((X(i,5)-X(i-1,5)).^2+(Y(i,5)-Y(i-1,5)).^2);
    end
end

distance(1,:) = d(end,:);
distance(2,:) = d10(end,:);
distance(3,:) = d_c(end,:);
distance(4,:) = d10_c(end,:);
distance(5,:) = d_ref(end,:);

delta_d(1,:) = sqrt((X(end,5)-X(end,1:4)).^2+ (Y(end,5)-Y(end,1:4)).^2);
delta_d(2,:) = sqrt((X(end,5)-X10(end,1:4)).^2+ (Y(end,5)-Y10(end,1:4)).^2);
delta_d(3,:) = sqrt((X(end,5)-X_C(end,1:4)).^2+ (Y(end,5)-Y_C(end,1:4)).^2);
delta_d(4,:) = sqrt((X(end,5)-X10_C(end,1:4)).^2+ (Y(end,5)-Y10_C(end,1:4)).^2);
end

