# 1.1 Getting Started
实验数据`emp.data`
```
Beth    4.00    0
Dan     3.75    0
Kathy   4.00    10
Mark    5.00    20
Mary    5.50    22
Susie   4.25    18
```
第一个例子:

```bash
$ awk '$3 > 10 {print $1, $2, $3}' emp.data
```
如果当前行的第三列大于10，则打印出前三列

## The structure of an AWK Program

每个awk程序都是由一组`pattern-action`语句组成：

```
pattern { action }
pattern { action }
...
```
awk逐行扫描输入数据，如果数据匹配`pattern`就执行对应的`action`。
如第一个列子，这里的`pattern`是一个条件：“第三列大于10”。

# 1.2 Simple Output

# 1.3 Fancier Output

# 1.4 Selection

# 1.5 Computing with AWK

# 1.6 Control-Flow Statements

# 1.7 Arrays

# 1.8 A Handful of Useful "One-liner"

# 1.9 What's Next?