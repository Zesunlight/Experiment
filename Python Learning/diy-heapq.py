import heapq


class Test():
    def __init__(self, a, b):
        self.a = a
        self.b = b

    def __lt__(self, other):
        # 自定义比较函数 （小于）
        # 在heapq模块的内部，比较是通过对象的 < 比较实现的
        if self.a == other.a:
            return self.b < other.b
        else:
            return self.a < other.a
    
    def __repr__(self):
        return f"({self.a}, {self.b})"


heap = []
heapq.heappush(heap, Test(1, 5))
heapq.heappush(heap, Test(1, 3))
heapq.heappush(heap, Test(2, 2))
heapq.heappush(heap, Test(2, 7))
heapq.heappush(heap, Test(2, 3))
heapq.heappush(heap, Test(4, 3))
heapq.heappush(heap, Test(10, 1))

print([heapq.heappop(heap) for i in range(len(heap))])
# [(1 , 3), (1 , 5), (2 , 2), (2 , 3), (2 , 7), (4 , 3), (10 , 1)]