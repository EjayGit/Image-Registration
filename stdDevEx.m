A = uint8(zeros(200,200));
B = uint8(zeros(200,200));
for x = 1 : 1 : 200
    for y = 1 : 1 : 200
        A(x,y) = 128;
        B(x,y) = 128;
        a = normrnd(128,12.32);
        b = normrnd(128,79.90);
        if a < 1
            a = 1;
        end
        if a > 256
            a = 256;
        end
        if b < 1
            b = 1;
        end
        if b > 256
            b = 256;
        end
        
        A(x,y) = a;
        B(x,y) = b;
    end
end
figure;
imshow(A);
figure;
imshow(B);