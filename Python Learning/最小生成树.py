# Minimum Spanning Tree - MST
import sys


# ------------------------------- Prim -------------------------------
# Prim 从一个点出发，逐渐扩展，构造最小生成树
# 与 Dijkstra 有相似的地方，在更新距离的时候处理不一样，同时 Prim 中需要存储边的信息
n = 7  # number of vertex
edge = {0: {1: 7, 3: 5}, 1: {2: 8, 3: 9, 4: 7}, 2: {4: 5}, 
        3: {4: 10, 5: 6}, 4: {5: 8, 6: 9}, 5: {6: 11}}
# u, v, l  u < v

start = 0  # root point
include = {0}
path = []
distance = [[start, sys.maxsize] for _ in range(n)]  # float('inf')
distance[start][1] = 0

while len(include) < n:
    shortest = sys.maxsize
    follow, previous = start, start
    for i in range(n):
        if i in include:
            continue
        u, v = min(i, start), max(i, start)
        # start 属于已访问的点集，i 属于未访问的
        # distance[i][1] 表示 i 与已访问的点集的最短距离，利用新加入的 start 来更新
        if u in edge and v in edge[u]:
            if distance[i][1] > edge[u][v]:
                distance[i][1] = edge[u][v]
                distance[i][0] = start
        if distance[i][1] < shortest:
            shortest = distance[i][1]
            follow = i
            previous = distance[i][0]
    include.add(follow)
    path.append([previous, follow])  # 记录边的信息
    start = follow
print(path)

# ------------------------------- Kruskal -------------------------------
# 每次都选最小权重的边，且该边与已选边不构成环
n = 7  # number of vertex
edge = [[0, 1, 7], [0, 3, 5], [1, 2, 8], [1, 3, 9], [1, 4, 7], [2, 4, 5],
        [3, 4, 10], [3, 5, 6], [4, 5, 8], [4, 6, 9], [5, 6, 11]]
edge.sort(key=lambda x: x[2])


class UnionSet:
    def __init__(self, quantity):
        self.n = quantity
        self.root = list(range(quantity))

    def union(self, x, y):
        root_x = self.find_root(x)
        root_y = self.find_root(y)
        self.root[root_y] = root_x
        return root_x

    def find_root(self, x):
        if self.root[x] != x:
            self.root[x] = self.find_root(self.root[x])
        return self.root[x]

    def same_root(self, x, y):
        return self.find_root(x) == self.find_root(y)


us = UnionSet(n)
include = []
for i in range(len(edge)):
    if not us.same_root(edge[i][0], edge[i][1]):
        us.union(edge[i][0], edge[i][1])
        include.append(i)
        if len(include) == n - 1:
            break
print([[edge[i][0], edge[i][1]] for i in include])
