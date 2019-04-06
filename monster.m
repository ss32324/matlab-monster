broder = [0 20 0 15];

theta = 0:(2 * pi) / 100:2 * pi;

% 大圓
big_circle_r = 5;
big_circle_x0y0 = [6; 6];
big_circle = [cos(theta); sin(theta)] * big_circle_r + big_circle_x0y0;

% 小圓
small_circle_r = 2;
small_circle_x0y0 = [15; 6];
small_circle = [cos(theta); sin(theta)] * small_circle_r + small_circle_x0y0;

while 1

    for th = theta
        hold off;
        % 畫大圓
        plot(big_circle(1, :), big_circle(2, :), 'k'); hold on;
        axis(broder);
        % 畫小圓
        plot(small_circle(1, :), small_circle(2, :), 'k'); hold on;
        axis(broder);

        % 小圓上一點
        A = [cos(th); sin(th)] * small_circle_r + small_circle_x0y0;

        % A,B,C三邊長
        ab = norm(big_circle_x0y0 - A);
        bc = big_circle_r;
        ca = 11.99;

        % 與兩圓心垂直距離
        offset = asin((A(2) - big_circle_x0y0(2)) / ab);

        % 三邊求角度
        B_theta = acos((ab^2 + bc^2 - ca^2) / (2 * ab * bc));

        % C1點位置
        C1 = [cos(B_theta + offset); sin(B_theta + offset)] * big_circle_r + big_circle_x0y0;
        % C2點位置
        C2 = [cos(-B_theta + offset); sin(-B_theta + offset)] * big_circle_r + big_circle_x0y0;

        % 畫 B-> C1-> A-> C2->B
        plot([big_circle_x0y0(1) C1(1) A(1) C2(1) big_circle_x0y0(1)], [big_circle_x0y0(1) C1(2) A(2) C2(2) big_circle_x0y0(2)], 'og-'); hold on;
        axis(broder);

        pause(0.01);
    end

end
