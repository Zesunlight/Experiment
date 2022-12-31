# !/usr/bin/env python
# -*- coding: utf-8 -*-
# File: ford_circles
# Author: 一朵深渊
# Date: 2022/12/31
import math
from fractions import Fraction


def farey_sum(a: Fraction, b: Fraction) -> Fraction:
    # 法里和
    return Fraction(a.numerator + b.numerator, a.denominator + b.denominator)


if __name__ == '__main__':
    # 给定一个实数，用分数去近似该实数
    number = math.pi
    # 小数部分，整数部分
    fractional, integer = math.modf(number)
    # 精度
    alpha = 1e-5
    # 渐进序列
    asymptotic = []

    # 左右端点（只近似小数部分）
    left = Fraction(0, 1)
    right = Fraction(1, 1)

    while True:
        middle = farey_sum(left, right)
        asymptotic.append(str(middle + Fraction(integer)))
        if math.fabs(middle - fractional) < alpha:
            break

        if middle > fractional:
            right = middle
        else:
            left = middle

    print(asymptotic[-1])
    print(', '.join(asymptotic))

    # 参考资料
    # 福特圆与怪异的分数加法（上） https://www.bilibili.com/video/BV16U4y1Y7aF/
    # 福特圆与怪异的分数加法（下） https://www.bilibili.com/video/BV1ha41137oW/
