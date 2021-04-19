# -*- coding: UTF-8 -*-
"""=================================================
@Project: how_to_do
@File   : segment_tree
@IDE    : PyCharm
@Author : Zhao Yongze
@Date   : 21/4/17
@Des    : in vain
=================================================="""
from math import log2, pow, ceil


class SegTree:
    def __init__(self, data, tree):
        self.data = data
        self.tree = tree
        self.num = len(data)

    def find_pos(self, index, start, end, pos=1):
        # index: data中某一元素的下标
        if start == end:
            return pos

        mid = (start + end) // 2
        if index <= mid:
            return self.find_pos(index, start, mid, 2 * pos)
        else:
            return self.find_pos(index, mid + 1, end, 2 * pos + 1)

    def build_sum(self, start, end, pos=1):
        if start == end:
            self.tree[pos] = self.data[start]
        else:
            mid = (start + end) // 2
            self.build_sum(start, mid, 2*pos)
            self.build_sum(mid+1, end, 2*pos+1)
            self.tree[pos] = self.tree[2*pos] + self.tree[2*pos+1]

    def get_sum(self, start, end, left, right, pos):
        # [l, r]为查询区间, [s, e]为当前节点包含的区间, p为当前节点的编号
        if (left <= start) and (end <= right):
            return tree[pos]

        mid = (start + end) // 2
        s = 0
        if left <= mid:
            s += self.get_sum(start, mid, left, right, 2*pos)
        if right > mid:
            s += self.get_sum(mid + 1, end, left, right, 2*pos+1)
        return s

    def update_sum(self, index, value, start, end, pos):
        # 下标为index的元素变为value, 当前所在线段树的位置为pos, 覆盖范围[s, e]
        # 保证index在[s, e]中
        if start == end:
            self.tree[pos] = value
        else:
            mid = (start + end) // 2
            if index <= mid:
                self.update_sum(index, value, start, mid, 2*pos)
            else:
                self.update_sum(index, value, mid + 1, end, 2*pos+1)
            self.tree[pos] = self.tree[2*pos] + self.tree[2*pos+1]

    def build_max(self, start, end, pos=1):
        pass

    def get_max(self, start, end, left, right, pos):
        pass

    def update_max(self, index, value, start, end, pos):
        pass


if __name__ == '__main__':
    data = list(range(10))
    n = len(data)
    tree = [-1] * int(pow(2, ceil(log2(n)) + 1))
    st = SegTree(data, tree)
    st.build_sum(0, n - 1)
    print(st.tree)
    print(st.get_sum(0, n - 1, 1, 3, 1))
    print(tree[st.find_pos(9, 0, 9)])
    st.update_sum(1, 5, 0, n - 1, 1)
    print(st.tree)
