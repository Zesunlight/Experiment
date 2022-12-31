import sys


n = 7  # number of vertex
edge = {0: {1: 7, 3: 5}, 1: {2: 8, 3: 9, 4: 7}, 2: {4: 5}, 
        3: {4: 10, 5: 6}, 4: {5: 8, 6: 9}, 5: {6: 11}}
# u, v, l  u < v


# ------------------------------- Dijkstra -------------------------------
# Dijkstra 求一个点到其他点的最短距离

start = 0  # root point
include = {0}
distance = [sys.maxsize] * n  # float('inf')
distance[start] = 0  # 到自身的距离为 0

follow = start  # 用于寻找下一个点
while len(include) < n:
    shortest = sys.maxsize
    # 每次 while 都会增加一个点进来，这个点会带来 root 到其他点的距离变化
    # start 是最新加入 include 的点，用于更新 root 到其他点的距离

    for i in range(n):
        if i in include:
            continue
        u, v = min(i, start), max(i, start)
        # 方便 edge 取长度，如果用邻接矩阵存边长就不用这样了

        if u in edge and v in edge[u]:
            if distance[i] > distance[start] + edge[u][v]:
                distance[i] = distance[start] + edge[u][v]
        if distance[i] < shortest:
            shortest = distance[i]
            follow = i
    
    # 在不在 include 里的点中，每次选择最短距离的点加入 include
    include.add(follow)
    start = follow

print(distance)
