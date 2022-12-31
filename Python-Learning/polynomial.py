# -*- coding: utf-8 -*-

import re
from collections import defaultdict
from typing import List, DefaultDict
from functools import cmp_to_key


def init(discrete: List) -> DefaultDict[str, int]:
    dictionary = defaultdict(int)
    for (k, v) in discrete:
        dictionary[k] += v
    return dictionary


def multiply(left: DefaultDict[str, int], right: DefaultDict[str, int]) -> DefaultDict[str, int]:
    result = defaultdict(int)
    for lk in left:
        for rk in right:
            factor = factor_multiply(lk, rk)
            result[factor] += left[lk] * right[rk]
            if result[factor] == 0:
                result.pop(factor)
    return result


def factor_multiply(left: str, right: str) -> str:

    def split(string):
        sl = re.split("([a-zC])", string)
        sl = list(filter(None, sl))
        assert len(sl) % 2 == 0

        sd = defaultdict(int)
        for i in range(0, len(sl), 2):
            sd[sl[i]] = int(sl[i + 1])
        return sd

    rd = add(split(left), split(right))
    result = ""
    for k in sorted(rd.keys()):
        if k == 'C':
            continue
        result += k
        result += str(rd[k])
    if result == "":
        result += "C1"
    return result


def add(left: DefaultDict[str, int], right: DefaultDict[str, int]) -> DefaultDict[str, int]:
    result = left.copy()
    for k in right:
        result[k] += right[k]
        if result[k] == 0:
            result.pop(k)
    return result


def poly_print(poly: DefaultDict[str, int]) -> str:

    def power(k1, k2):
        sk1 = sum([int(x) for x in list(filter(None, re.split("[a-zC]", k1)))])
        sk2 = sum([int(x) for x in list(filter(None, re.split("[a-zC]", k2)))])
        if sk1 > sk2:
            return 1
        elif sk1 == sk2:
            if k1 > k2:
                return 1
            elif k1 == k2:
                return 0
            else:
                return -1
        return -1

    result = []
    for k in sorted(poly.keys(), key=cmp_to_key(power)):
        sl = list(filter(None, re.split("([a-zA-Z])", k)))
        temp = ""
        if poly[k] != 1:
            if poly[k] == -1:
                temp += '-'
            else:
                temp += str(poly[k])
        for i in range(0, len(sl), 2):
            if sl[i] == 'C':
                temp += str(poly[k])
                continue
            temp += sl[i]
            if sl[i + 1] != '1':
                temp += '^' + sl[i + 1]
        result.append(temp)
    res = '+'.join(result)
    res = res.replace("+-", "-")
    print(res)
    return res


if __name__ == '__main__':
    a = init([("a1", 1)])
    b = init([("b1", 1)])
    c = init([("c1", 1)])
    _a1 = init([("a1", -1), ("C1", 1)])
    _b1 = init([("b1", -1), ("C1", 1)])
    _c1 = init([("c1", -1), ("C1", 1)])
    ab1 = init([("a1", 1), ("b1", 1), ("C1", 1)])
    bc1 = init([("b1", 1), ("c1", 1), ("C1", 1)])
    ca1 = init([("c1", 1), ("a1", 1), ("C1", 1)])

    right_poly = multiply(multiply(ab1, bc1), ca1)
    left_one = multiply(c, multiply(bc1, ca1))
    left_two = multiply(a, multiply(ab1, ca1))
    left_thr = multiply(b, multiply(ab1, bc1))
    left_fou = multiply(right_poly.copy(), multiply(multiply(_a1, _b1), _c1))
    left_poly = add(add(left_one, left_two), add(left_thr, left_fou))

    # for p in right_poly:
    #     right_poly[p] *= -1
    # poly_print(add(right_poly, left_poly))

    three_left = add(add(left_one, left_two), left_thr)
    poly_print(three_left)
    poly_print(multiply(_a1, multiply(_b1, _c1)))
    helper = init([("a1", 1), ("b1", 1), ("c1", 1), ("a1b1", -1), ("b1c1", -1), ("c1a1", -1), ("a1b1c1", 1)])
    poly_print(right_poly)
    two_right = multiply(helper, right_poly)
    poly_print(two_right)

    for p in three_left:
        three_left[p] *= -1
    poly_print(add(three_left, two_right))

