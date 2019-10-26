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

awk中只有两种数据类型：
- number
- string

awk读取每行数据，并将每行按空白符分隔成多个`fields`。第一个`field`用`$1`表示,第二个`field`用`$2`表示；第11个`field`用`$11`表示，以此类推。整行用`$0`表示。

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

## Lining Up fields

print是一个statement，不是函数。只用于简单的输出。
printf也会一个statement。可以输出任意格式内容。类似于c语言的printf函数。

```bash
$ awk '{printf("Total pay for %s is $%.2f\n", $1, $2 * $3)}' emp.data
Total pay for Beth is $0.00
Total pay for Dan is $0.00
Total pay for Kathy is $40.00
Total pay for Mark is $100.00
Total pay for Mary is $121.00
Total pay for Susie is $76.50
```

## Sorting the Output
利用sort命令排序。
> 注意：你需要了解sort是如何将输入排序的
```bash
$ awk '{printf("%6.2f   %s\n", $2 * $3, $0)}' emp.data | sort
  0.00   Beth    4.00    0
  0.00   Dan     3.75    0
 40.00   Kathy   4.00    10
 76.50   Susie   4.25    18
100.00   Mark    5.00    20
121.00   Mary    5.50    22
```

# 1.4 Selection

## Selection by Comparison, Computation, Text Content

我们已经知道每个awk程序都是由一组`pattern { action }`语句组成。
用pattern匹配感兴趣的行叫做`select`即`选取`。

```bash
$ awk '$2 > 5 {print $0}' emp.data # by comparison
Mary    5.50    22
$ awk '$2 * $3 > 50 {print $0}' emp.data # by computation
Mark    5.00    20
Mary    5.50    22
Susie   4.25    18
$ awk 'BEGIN{IGNORECASE=1}; /susie|mar/ {print $0}' emp.data # by text matching
Mark    5.00    20
Mary    5.50    22
Susie   4.25    18
```

## Combinations of Patterns

pattern可以通过逻辑运算符结合:
- && = AND
- || = OR
- ! = NOT

## Data Validation

略：就是利用pattern来检查数据是否符合要求

## BEGIN and END

`BEGIN`和`END`是两个特殊的`pattern`。分别匹配第一行之前和最后一行之后。
说白了就是在读入文档之前和结束之后执行某个`action`

```bash
$ awk 'BEGIN{printf("Name\tRate\tHours\n")}; {print}; END{print "Done！"}' emp.data
Name    Rate    Hours
Beth    4.00    0    
Dan     3.75    0    
Kathy   4.00    10   
Mark    5.00    20   
Mary    5.50    22   
Susie   4.25    18  
```


> 注意：awk的正则没有`/regexp/i`这种忽略大小写的开关。需要使用`IGNORECASE`全局开关。

# 1.5 Computing with AWK

- awk中变量不需要事先声明
- 数值变量初始值是0
- 字符串连接是通过空格分隔多个变量：str = s1 s2 s3

```bash
$ awk '{emps = emps $1 " "};END{print emps}' emp.data # string concatenation
Beth Dan Kathy Mark Mary Susie
```

# 1.6 Control-Flow Statements

awk中的`if`,`for`,`while`写法与c语言基本一致。

# 1.7 Arrays

```bash
$ awk '
{lines[NR]=$0}
END {
    for(i=NR;i>=0;i--) print(lines[i])
}' emp.data
Susie   4.25    18
Mary    5.50    22
Mark    5.00    20
Kathy   4.00    10
Dan     3.75    0
Beth    4.00    0
```

# 1.8 A Handful of Useful "One-liner"

```bash
$ awk 'END {print NR}'  #打印行数
$ awk 'NR == 2 {print}'  #打印第2行
$ awk '{field = $NF} END {print field}'  #打印最后一行的最后一列
$ awk 'NF > 4 {print}'  #打印大于4列的行
$ awk '$NF > 4 {print}' #打印最后一列大于四的行
$ awk '{nf = nf + NF} END {print nf}' #打印单元格数
$ awk '/Beth/ {nlines = nlines + 1} END {print nlines}'
$ awk '$1 > max {max = $1; maxline = $0} END {print max, maxline}' #打印第一列最大的行
$ awk 'NF > 0 {print}' #打印至少有一列的行
$ awk 'length($0) > 80 {print}' #打印长度大于80的行
$ awk '{print NF, $0}' #打印每行列数和内容
$ awk '{print $2, $1}' #翻转打印前两列
$ awk '{tmp = $1; $1 = $2; $2 = tmp; print}' #交换前两列并打印整行
$ awk '{$1 = NR; print}' #将第一列换成行号
$ awk '{$2 = ""; print}' #去掉第二列
$ awk '{for(i = NF; i > 0; i--) printf("%s ", $i); printf("\n)}' #翻转列
$ awk '{sum = 0; for(i = 0; i< NF; i++) sum = sum + $i; print sum}' #打印每行的每列之和
$ awk '{for (i = 1; i <= NF; i++) sum = sum + $i;}
END {print sum}
' # 所有单元格之和
$ awk 'function abs(v) {return v < 0 ? -v : v}
{for (i = 1; i <= NF; i++) print abs($i)}' # 打印每列绝对值
```

# 1.9 What's Next?
略