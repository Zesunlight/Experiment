# Python 中的并行

## 进程和线程

### Process

- A process is an instance of a computer program being executed. 
- Each process has its own memory space it uses to store the instructions being run, as well as any data it needs to store and access to execute.

### Thread

- Threads are components of a process, which can run in parallel. 
- There can be multiple threads in a process, and they share the same memory space, i.e. the memory space of the parent process. 
- The code to be executed as well as all the variables declared in the program would be shared by all threads.

### Detail

- 线程间的通信较进程更简单，因为它们共享同一块内存空间
- 线程可看作轻量级的“进程”
- 信号量、互锁

## Python 中的情形

### GIL

- In CPython, the **global interpreter lock**, or **GIL**, is a mutex that protects access to Python objects, preventing multiple threads from executing Python bytecodes at once. 
- This lock is necessary mainly because CPython's memory management is not thread-safe. This design makes memory management thread-safe.
- 无法充分利用多核 CPU，同一时间只能一个线程占据计算资源

### Use Cases for Threading

- GUI programs use threading all the time to make applications responsive. Here, the program has to wait for user interaction, which is the biggest bottleneck. Using multiprocessing won’t make the program any faster.
- Programs that are IO bound or network bound, such as web-scrapers. Multiprocessing doesn’t have any edge over threading. 
- IO 交互、人机交互对程序影响较大时 (IO bound)

### Use Cases for Multiprocessing

- Multiprocessing outshines threading in cases where the program is CPU intensive and doesn’t have to do any IO or user interaction. 
- An example is [Pytorch Dataloader](https://pytorch.org/docs/stable/data.html#torch.utils.data.DataLoader), which uses multiple subprocesses to load the data into GPU.
- 计算资源是程序的瓶颈时 (CPU bound)

### 相关库

- `concurrent.futures.ThreadPoolExecutor` `concurrent.futures.ProcessPoolExecutor` 
- `threading` `multiprocessing` 

## 参考

- [Multiprocessing vs. Threading in Python: What Every Data Scientist Needs to Know](https://blog.floydhub.com/multiprocessing-vs-threading-in-python-what-every-data-scientist-needs-to-know/)
- [The Why, When, and How of Using Python Multi-threading and Multi-Processing](https://medium.com/towards-artificial-intelligence/the-why-when-and-how-of-using-python-multi-threading-and-multi-processing-afd1b8a8ecca)
- [Python多线程与多线程中join()的用法](https://www.cnblogs.com/cnkai/p/7504980.html)
- [[python] ThreadPoolExecutor线程池](https://www.jianshu.com/p/b9b3d66aa0be)



