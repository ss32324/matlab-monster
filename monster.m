broder = [0 30 0 25];
theta = 0:(2 * pi) / 50:2 * pi;

% 兩圓x0y0位移
displacement = [10; 15];

% 大圓
big_circle_r = 5;
big_circle_x0y0 = [0; 0] + displacement;
big_circle = [cos(theta); sin(theta)] * big_circle_r + big_circle_x0y0;

% 小圓
small_circle_r = 2;
small_circle_x0y0 = [6; 0] + displacement;
small_circle = [cos(theta); sin(theta)] * small_circle_r + small_circle_x0y0;

long = 8.2;

while 1

    for th = theta
        hold off;
        % 畫大圓
        % plot(big_circle(1,:), big_circle(2,:), 'k');hold on;
        % axis(broder);
        % 畫小圓
        plot(small_circle(1, :), small_circle(2, :), 'k'); hold on;
        axis(broder);

        % 小圓上一點
        A = [cos(th); sin(th)] * small_circle_r + small_circle_x0y0;

        % A,B,C三邊長
        ab = norm(big_circle_x0y0 - A);
        bc = big_circle_r;
        ca = long;

        % 與兩圓心垂直距離
        offset = asin((A(2) - big_circle_x0y0(2)) / ab);

        % 三邊求角度
        B_theta = acos((ab^2 + bc^2 - ca^2) / (2 * ab * bc));

        % C1點位置
        C1 = [cos(B_theta + offset); sin(B_theta + offset)] * big_circle_r + big_circle_x0y0;
        % C2點位置
        C2 = [cos(2 * pi - B_theta + offset); sin(2 * pi - B_theta + offset)] * big_circle_r + big_circle_x0y0;

        % 畫 B-> C1-> A-> C2->B
        plot([big_circle_x0y0(1) C1(1) A(1) C2(1) big_circle_x0y0(1)], [big_circle_x0y0(2) C1(2) A(2) C2(2) big_circle_x0y0(2)], 'og-'); hold on;
        axis(broder);

        % 找出點 D = C1 + pi/2 (構成big_circle圓邊上直角等腰三角形)
        D = [cos(B_theta + offset + pi / 2); sin(B_theta + offset + pi / 2)] * big_circle_r + big_circle_x0y0;
        plot([C1(1) D(1) big_circle_x0y0(1)], [C1(2) D(2) big_circle_x0y0(2)], 'o-'); hold on;
        axis(broder);

        % 以C2 為圓心的圓
        %% C2_circle = [cos(theta); sin(theta)] * big_circle_r + C2;
        %% plot(C2_circle(1, :), C2_circle(2, :), 'k'); hold on;

        % 以C2 為圓心的0度位置
        C2_0 = [cos(0); sin(0)] * big_circle_r + C2;

        % 以C2 為圓心的圓 圓邊 與 big_circle_x0y0 構成的三角形
        ab = norm(big_circle_x0y0 - C2_0);
        bc = big_circle_r;
        ca = big_circle_r;

        % big_circle_x0y0 對於 C2_0 的偏移量
        C2_offset = acos((ca^2 + bc^2 - ab^2) / (2 * ca * bc));

        % 找出點 E = (2*pi - ((3/2 * pi) - (2 * B_theta))*2)/2 + C2_offset = (2 * B_theta - 1/2 * pi) + C2_offset
        E = [cos((2 * B_theta - 1/2 * pi) + C2_offset); sin((2 * B_theta - 1/2 * pi) + C2_offset)] * big_circle_r + C2;
        plot([D(1) E(1) C2(1)], [D(2) E(2) C2(2)], 'o-'); hold on;

        % 找出點 F
        F = [cos((2 * B_theta) + C2_offset); sin((2 * B_theta) + C2_offset)] * long + C2;
        plot([E(1) F(1) C2(1)], [E(2) F(2) C2(2)], 'oc-');

        axis(broder);

        pause(0.01);
    end

end
