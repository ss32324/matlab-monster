broder = [0 30 0 25];
theta = 0:(2 * pi) / 25:2 * pi;

%%% 兩圓x0y0位移
displacement = [10; 15];

%%% 左圓
left_circle_r = 5;
left_circle_x0y0 = [0; 0] + displacement;
left_circle = [cos(theta); sin(theta)] * left_circle_r + left_circle_x0y0;

%%% 右圓
right_circle_r = 5;
right_circle_x0y0 = [12; 0] + displacement;
right_circle = [cos(theta); sin(theta)] * right_circle_r + right_circle_x0y0;

%%% 小圓
small_circle_r = 2;
small_circle_x0y0 = [6; 0] + displacement;
small_circle = [cos(theta); sin(theta)] * small_circle_r + small_circle_x0y0;

while 1

    for th = theta
        hold off;
        %%% 畫左圓
        %% plot(left_circle(1,:), left_circle(2,:), 'k');hold on;
        %% axis(broder);
        %%% 畫右圓
        %% plot(right_circle(1,:), right_circle(2,:), 'k');hold on;
        %% axis(broder);
        %%% 畫小圓

        %%% 小圓上一點
        A1 = [cos(th); sin(th)] * small_circle_r + small_circle_x0y0;
        A2 = [cos(th + (120/360) * 2 * pi); sin(th + (120/360) * 2 * pi)] * small_circle_r + small_circle_x0y0;

        leg(left_circle_x0y0, left_circle_r, A2, "left", [0.4 0.4 0]);
        leg(right_circle_x0y0, right_circle_r, A2, "right", [0 0.4 0.4]);
        leg(left_circle_x0y0, left_circle_r, A1, "left", [0.2 0.2 0.4]);
        leg(right_circle_x0y0, right_circle_r, A1, "right", [0.2 0.4 0.2]);

        plot([A1(1) small_circle_x0y0(1) A2(1)], [A1(2) small_circle_x0y0(2) A2(2)], '--k');
        %% plot(small_circle(1,:), small_circle(2,:), 'k');hold on;
        h = fill(small_circle(1, :), small_circle(2, :), 'y'); hold on;
        set(h, 'edgealpha', 1, 'facealpha', 0.3);

        plot([0 30], [2 2], '--b'); hold on;
        axis(broder);
        pause(0.0001);
    end

end

function leg(circle_x0y0, circle_r, A, rl, fill_color)
    %% plot_type = '-ok';
    broder = [0 30 0 25];
    long = 8.2;

    %%% A,B,C三邊長
    ab = norm(circle_x0y0 - A);
    bc = circle_r;
    ca = long;

    %%% 與兩圓心垂直距離
    offset = asin((A(2) - circle_x0y0(2)) / ab);
    %%% 三邊求角度
    B_theta = acos((ab^2 + bc^2 - ca^2) / (2 * ab * bc));

    if rl == "right"
        offset = pi - offset;
        B_theta = 0 - B_theta;
    end

    %%% C1點位置
    C1 = [cos(B_theta + offset); sin(B_theta + offset)] * circle_r + circle_x0y0;
    %%% C2點位置
    C2 = [cos(-B_theta + offset); sin(-B_theta + offset)] * circle_r + circle_x0y0;

    %%% 畫 B-> C1-> A-> C2->B
    %% plot([circle_x0y0(1) C1(1) A(1) C2(1) circle_x0y0(1)], [circle_x0y0(2) C1(2) A(2) C2(2) circle_x0y0(2)], plot_type);
    h = fill([circle_x0y0(1) C1(1) A(1) C2(1)], [circle_x0y0(2) C1(2) A(2) C2(2)], fill_color); hold on;
    set(h, 'edgealpha', 1, 'facealpha', 0.8);
    axis(broder);

    %%% 找出點 D = C1 + pi/2 (構成circle圓邊上直角等腰三角形)
    D_offset = pi / 2;

    if rl == "right"
        D_offset = 0 - D_offset;
    end

    D = [cos(B_theta + offset + D_offset); sin(B_theta + offset + D_offset)] * circle_r + circle_x0y0;
    %% plot([C1(1) D(1) circle_x0y0(1)], [C1(2) D(2) circle_x0y0(2)], plot_type); hold on;
    h = fill([C1(1) D(1) circle_x0y0(1)], [C1(2) D(2) circle_x0y0(2)], fill_color * 1.25); hold on;
    set(h, 'edgealpha', 1, 'facealpha', 0.8);
    axis(broder);

    %%% 以C2 為圓心的圓
    %% theta = 0:(2 * pi) / 25:2 * pi;
    %% C2_circle = [cos(theta); sin(theta)] * circle_r + C2;
    %% plot(C2_circle(1, :), C2_circle(2, :), 'k'); hold on;

    %%% 以C2 為圓心的0度位置
    C2_0 = [cos(0); sin(0)] * circle_r + C2;
    %% plot(C2_0(1), C2_0(2), 'o');hold on;

    %%% 以C2 為圓心的圓 圓邊 與 circle_x0y0 構成的三角形
    ab = norm(circle_x0y0 - C2_0);
    bc = circle_r;
    ca = circle_r;

    %%% circle_x0y0 對於 C2_0 的偏移量
    C2_offset = acos((ca^2 + bc^2 - ab^2) / (2 * ca * bc));

    %%% 找出點 E = (2*pi - ((3/2 * pi) - (2 * B_theta))*2)/2 + C2_offset = (2 * B_theta - 1/2 * pi) + C2_offset
    E_offset = 1/2 * pi;

    if rl == "right"
        E_offset = 0 - E_offset;
    end

    E = [cos((2 * B_theta - E_offset) + C2_offset); sin((2 * B_theta - E_offset) + C2_offset)] * circle_r + C2;
    %% plot([D(1) E(1) C2(1)], [D(2) E(2) C2(2)], plot_type); hold on;
    h = fill([D(1) E(1) C2(1) circle_x0y0(1)], [D(2) E(2) C2(2) circle_x0y0(2)], fill_color * 1.5); hold on;
    set(h, 'edgealpha', 1, 'facealpha', 0.8);

    %%% 找出點 F
    F = [cos((2 * B_theta) + C2_offset); sin((2 * B_theta) + C2_offset)] * long + C2;
    %% plot([E(1) F(1) C2(1)], [E(2) F(2) C2(2)], plot_type); hold on;
    h = fill([E(1) F(1) C2(1)], [E(2) F(2) C2(2)], fill_color * 1.75); hold on;
    set(h, 'edgealpha', 1, 'facealpha', 0.8);

    axis(broder);
    %% plot([C2(1)-circle_r C2(1)+circle_r], [C2(2) C2(2)], '--b'); hold on;
end
