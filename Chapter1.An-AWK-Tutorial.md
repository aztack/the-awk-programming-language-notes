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

## Running an AWK Program

> 注意：bash的参数用单引号。双引号会尝试扩展`$1`等变量！
```bash
$ awk 'program' file1.dat file2 dat # run 'program' on file1 and file2
$ awk -f code.awk file1.dat # run program in code.awk on file1
$ awk 'program' # run 'program' on standard input
```

## Errors
略

# 1.2 Simple Output

AWK中只有两种数据类型：
- number
- string

AWK读取每行数据，并将每行按空白符分隔成多个`fields`。第一个`field`用`$1`表示,第二个`field`用`$2`表示；第11个`field`用`$11`表示，以此类推。整行用`$0`表示。

## Printing Every Line
```awk
{ print } #print current line
{ print $0 } #print $0
```

## Print curtain fields
```awk
{print $1, $3}
```

## NF = Number of Fields

`$`后面不光可以跟数字来表示第几个`field`。它后面可以跟一个表达式。表达式最终的值便是对应的`field`。

> 注意：AWK中的`$`并不是变量前缀，而是`列`前缀。后面的表达式的值应该是一个正整数
> AWK变量多是全大写。比如`FILENAME`表示当前文件名。可以`print FILENAME`。

```bash
# Print line number, first field, last field
$ awk { print NR, $1, $NF } emp.data
```

## Computing and Printing

```bash
$ awk '{ print $1, $2 * $3}' emp.data
Beth 0
Dan 0
Kathy 40
Mark 100
Mary 121
Susie 76.5
```
## Printing Line Numbers

NR = Number of lines Read so far

```bash
$ awk `{print NR, $0}` emp.data
```

## Putting Text in the output

> 注意: AWK函数调用是有括号的，且括号与函数名之间不能有空白符。
> print、printf不是函数，是一个`statement`。括号是可选的。
> 类似PHP中的[`echo`](https://www.php.net/manual/en/function.echo.php) (a language construct)。

```bash
$ awk '{print("Total pay for ", $1, "is", $2 * $3)}' emp.data
Total pay for  Beth is 0
Total pay for  Dan is 0
Total pay for  Kathy is 40
Total pay for  Mark is 100
Total pay for  Mary is 121
Total pay for  Susie is 76.5
```

# 1.3 Fancier Output

# 1.4 Selection

# 1.5 Computing with AWK

# 1.6 Control-Flow Statements

# 1.7 Arrays

# 1.8 A Handful of Useful "One-liner"

# 1.9 What's Next?