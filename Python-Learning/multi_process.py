from concurrent.futures import ProcessPoolExecutor, as_completed
import time
from functools import reduce
import multiprocessing as mp
import numpy as np


def func(scope, amount, index):
    print(f'--- start func of index {index} ---')
    random_list = np.random.randint(-scope, scope, size=(amount, 8, 8))
    reduce(lambda x, y: np.matmul(x, y), random_list)
    print(f'+++ end func of index {index} +++')
    return index


def multi_process_1(scope, amount, number, start):
    executor = ProcessPoolExecutor(number)
    pool = []
    for i in range(number):
        pool.append(executor.submit(func, scope, amount, i))
    for p in as_completed(pool):
        print(f'*** in multi process 1 - result get - index {p.result()} ***')
    return time.time() - start


def multi_process_2(scope, amount, number, start):
    # 无法直接获取函数的返回值，可通过设置共享变量的方式获取
    # 定义存储池结果的字典： return_dict = mp.Manager().dict()
    # 在进程化的函数中，字典作为参数传入，再把结果存进去： return_dict[func] = func_return

    pool = []
    for i in range(number):
        pool.append(mp.Process(target=func, args=(scope, amount, i,)))
    for i in range(number):
        pool[i].start()
    for i in range(number):
        pool[i].join()
    return time.time() - start


def multi_process_3(scope, amount, number, start):
    pool = mp.Pool(number)
    tasks = [pool.apply_async(func, args=(scope, amount, i)) for i in range(number)]
    for t in tasks:
        print(f'*** in multi process 3 - result get - index {t.get()} ***')
    return time.time() - start


def func_wrap(args):
    return func(*args)


def multi_process_4(scope, amount, number, start):
    pool = mp.Pool(number)
    func_args = [(scope, amount, i) for i in range(number)]
    results = pool.imap(func_wrap, func_args)
    for r in results:
        print(f'*** in multi process 4 - result get - index {r} ***')
    return time.time() - start


if __name__ == '__main__':
    print(multi_process_4(8, 3000000, 4, time.time()))
