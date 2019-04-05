
broder = [0 20 0 15];

theta = 0:(2*pi)/100:2*pi;

% 大圓
big_circle_r = 5;
big_circle_x0y0 = [6;6];
big_circle = [ cos(theta) ; sin(theta) ] * big_circle_r + big_circle_x0y0;

% 小圓
small_circle_r = 2;
small_circle_x0y0 = [15;6];
small_circle = [ cos(theta) ; sin(theta) ] * small_circle_r + small_circle_x0y0;


while 1
    for th= theta
        hold off;
        plot(big_circle(1,:), big_circle(2,:), 'k');hold on;
        axis(broder);
        plot(small_circle(1,:), small_circle(2,:), 'k');hold on;
        axis(broder);
        
        % 小圓上一點
        A = [ cos(th) ; sin(th) ] * small_circle_r + small_circle_x0y0;
        
        ab = norm(big_circle_x0y0 - A);
        bc = big_circle_r;
        ca = 11.99;
        
        offset = asin((A(2)-big_circle_x0y0(2))/ab);
        B_theta = acos((ab^2+bc^2-ca^2)/(2*ab*bc));
        C1 = [ cos(B_theta+offset) ; sin(B_theta+offset)] * big_circle_r + big_circle_x0y0;
        C2 = [ cos(-B_theta+offset) ; sin(-B_theta+offset)] * big_circle_r + big_circle_x0y0;
        plot([big_circle_x0y0(1) C1(1) A(1) C2(1) big_circle_x0y0(1)], [big_circle_x0y0(1) C1(2) A(2) C2(2) big_circle_x0y0(2)],'og-');hold on;
        axis(broder);
        
        % 註解
        C1_theta = offset:(2*pi)/100:B_theta+offset;
        C1_ps = [ cos(C1_theta) ; sin(C1_theta)] * 1 + big_circle_x0y0;
        plot(C1_ps(1,:), C1_ps(2,:), 'r');hold on;
        
        C2_theta = offset:-(2*pi)/100:-B_theta+offset;
        C2_ps = [ cos(C2_theta) ; sin(C2_theta)] * 1 + big_circle_x0y0;
        plot(C2_ps(1,:), C2_ps(2,:), 'c');hold on;
        
        offset_theta = 0:offset/10:offset;
        offset_ps = [ cos(offset_theta) ; sin(offset_theta)] * 2 + big_circle_x0y0;
        plot(offset_ps(1,:), offset_ps(2,:), 'b');hold on;

        plot([small_circle_x0y0(1) big_circle_x0y0(1)], [small_circle_x0y0(2) big_circle_x0y0(2)], '--b');hold on;
        plot([A(1) big_circle_x0y0(1)], [A(2) big_circle_x0y0(2)], '--k');hold on;
        
        text(A(1)+0.5, A(2),'A', 'HorizontalAlignment', 'center');
        text(big_circle_x0y0(1)-0.5, big_circle_x0y0(2),'B', 'HorizontalAlignment', 'center');
        text(big_circle_x0y0(1)+3, big_circle_x0y0(2)+offset,'offset', 'HorizontalAlignment', 'center');
        text(C1(1)-0.5, C1(2),'C1', 'HorizontalAlignment', 'center');
        text(C2(1)-0.5, C2(2),'C2', 'HorizontalAlignment', 'center');
        axis(broder);
        pause(0.01);
    end
end

