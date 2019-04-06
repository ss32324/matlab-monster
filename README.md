# matlab-monstor

## 單輪軸

![image](https://github.com/ss32324/matlab-monstor/blob/fix/001/%E8%BC%AA%E8%BB%B8.gif)

> 透過餘弦定理計算 (三邊求角度)
>>1. a_b 長度為A點至B點距離
>>2. b_c1 長度為大圓圓半徑
>>3. c1_a 長度為固定 11.99
>>4. __紅色角度線__ ∠A_B_C1 為 arccosine( (b_c1)²+(c1_a)²-(a_b)² / 2*(b_c1)*(c1_a) )
>>5. C2 求法相同


> 透過正弦定理計算與 0° 間的誤差值offset
>>1. a_b 長度為A點至B點距離
>>2. ay_bs 長度為A點到藍線的垂直距離
>>3. **藍色角度線 (黑虛線與藍虛線之間角度)** ∠A_B_S 為 arcsine( ay_bs / a_b )

> 將 ∠A_B_C1 及 offset ~~(∠A_B_S)~~ 相加 則為正確移動角度




## 雙輪軸

![image](https://github.com/ss32324/matlab-monstor/blob/test/double_axle/%E9%9B%99%E8%BC%AA%E8%BB%B8.gif)

> 求得offset需做調整
>>1. 左右圓的起點不同 分別為 0° 跟 180°
>>2. 左右圓的offset會相反


## 單輪軸單隻腿
![image](https://github.com/ss32324/matlab-monstor/blob/test/leg/%E5%96%AE%E8%85%B3%E6%9C%89%E5%9C%93.gif)

> 以C2為圓心的圓  求得C2_offset
>>1. a_b 為 C2_0 到 B點距離;
>>2. b_c c_a 為 C2圓半徑;
>>3. C2_offset 角度為 acos((c_a^2 + b_c^2 - a_b^2) / (2 * c_a * b_c))



> 透過∠C2_B_D 求得E點
>>1. 在B圓上 D點角度與C2角度相減 則為∠C2_B_D度數
>>2. □C2_B_D_E 為平行四邊形 因此∠E等於∠B 而E點在C2圓上的角度為∠B_D_E + C2_offset



## 四腳怪獸完成圖
![image](https://github.com/ss32324/matlab-monstor/blob/test/monstor/%E5%9B%9B%E8%85%B3%E6%80%AA%E7%8D%B8.gif)

