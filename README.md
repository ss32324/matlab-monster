# matlab-monstor

## 單輪軸

![image](https://github.com/ss32324/matlab-monstor/blob/test/double_axle/%E8%BC%AA%E8%BB%B8.gif)

### 透過餘弦定理計算 (三邊求角度)
1. a_b 長度為A點至B點距離
2. b_c1 長度為大圓圓半徑
3. c1_a 長度為固定 11.99
4. ***紅色角度線*** ∠A_B_C1 為 arccosine( (b_c1)²+(c1_a)²-(a_b)² / 2*(b_c1)*(c1_a) )
5. C2 求法相同


### 透過正弦定理計算與 0° 間的誤差值offset
1. a_b 長度為A點至B點距離
2. ay_bs 長度為A點到藍線的垂直距離
3. ***藍色角度線 (黑虛線與藍虛線之間角度)*** ∠A_B_S 為 arcsine( ay_bs / a_b )

### 將 ∠A_B_C1 及 ∠A_B_S 相加 則為正確移動角度



## 雙輪軸

![image](https://github.com/ss32324/matlab-monstor/blob/test/double_axle/%E9%9B%99%E8%BC%AA%E8%BB%B8.gif)

### 求得offset需做調整
1. 左右圓的起點不同 分別為 0° 跟 180°
2. 左右圓的offset會相反