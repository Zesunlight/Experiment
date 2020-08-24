# -*- coding: UTF-8 -*-

from typing import List


class UnionFind:
    def __init__(self, students: List):
        n = len(students)

        self.count = 0
        self.school = [-1] * n
        self.rank = [0] * n

        for i in range(n):
            if students[i] == 1:
                self.school[i] = i
                self.count += 1

    def find(self, i):
        if self.school[i] != i:
            self.school[i] = self.find(self.school[i])
        return self.school[i]

    def same_school(self, x, y):
        return self.find(x) == self.find(y)

    def union(self, x, y):
        rootx = self.find(x)
        rooty = self.find(y)

        # if rootx != rooty:
        #     if self.rank[rootx] < self.rank[rooty]:
        #         rootx, rooty = rooty, rootx
        #     self.school[rooty] = rootx
        #
        #     if self.rank[rootx] == self.rank[rooty]:
        #         self.rank[rootx] += 1
        #     self.count -= 1

        if rootx != rooty:
            self.school[rooty] = rootx
            self.count -= 1


if __name__ == '__main__':
    uf = UnionFind([1] * 10)
    uf.union(1, 5)
    uf.union(5, 8)
    uf.union(2, 6)
    print(uf.find(8))
    print(list(range(10)))
    print(uf.school)
