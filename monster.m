broder = [0 30 0 25];
theta = 0:(2 * pi) / 100:2 * pi;

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
        plot(left_circle(1,:), left_circle(2,:), 'k');hold on;
        axis(broder);
        %%% 畫右圓
        plot(right_circle(1,:), right_circle(2,:), 'k');hold on;
        axis(broder);
        %%% 畫小圓

        %%% 小圓上一點
        A1 = [cos(th); sin(th)] * small_circle_r + small_circle_x0y0;

        axle(left_circle_x0y0, left_circle_r, A1, "left");
        axle(right_circle_x0y0, right_circle_r, A1, "right");

        plot(small_circle(1,:), small_circle(2,:), 'k');hold on;
        plot(small_circle_x0y0(1), small_circle_x0y0(2), 'ok');

        axis(broder);
        pause(0.0001);
    end

end

function axle(circle_x0y0, circle_r, A, rl)
    plot_type = '-ok';
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
        offset =  pi - offset;
        B_theta = 0 - B_theta;
    end

    %%% C1點位置
    C1 = [cos(B_theta + offset); sin(B_theta + offset)] * circle_r + circle_x0y0;
    %%% C2點位置
    C2 = [cos(-B_theta + offset); sin(-B_theta + offset)] * circle_r + circle_x0y0;

    %%% 畫 B-> C1-> A-> C2->B
    plot([circle_x0y0(1) C1(1) A(1) C2(1) circle_x0y0(1)], [circle_x0y0(2) C1(2) A(2) C2(2) circle_x0y0(2)], plot_type);

    axis(broder);
end
