# 2.1 Patterns

## BEGIN and END

前面已经讲过BEGIN和END分别匹配第一行之前和最后一行之后。
一般BEGIN用于初始化变量，修改内置变量。
BEGIN、END可以出现多次。按出现次数依次执行。

在做实验的时候可以将所有代码放到BEGIN的action里：
```bash
$ awk '
BEGIN {
     a = "abc def"
     b = gensub(/(.+) (.+)/, "\\2 \\1", "g", a)
     print b
}'
def abc
```

## Expressions as Patterns

## String-Matching Patterns

## Regular Expressions

## Compound Patterns

## Range  Patterns

## Summary of Patterns


# 2.2 Actions

## Expressions
## Control-Flow Statements
## Empty Statement
## Arrays


# 2.3 User-Defined Functions

# 2.4 Output

## The `print` statement

两种书写形式
```bash
$ awk '{print expr1, expr2, ... , exprn}' # 无括号
$ awk '{print(expr1, expr2, ... , exprn)}' # 有括号
```

打印空行
```bash
$ awk '{print ""}'
```

## Output Separators

- OFS = The Output Field Separator, a space by default
- ORS = The Output Record Separator, by default a newline

```bash
$ awk 'BEGIN{OFS="->";ORS=";\n"};{print($1, $2)}' emp.data
Beth->4.00;
Dan->3.75;
Kathy->4.00;
Mark->5.00;
Mary->5.50;
Susie->4.25;
```

可以通过`man awk`可以查看内置变量。


# 2.5 Input

```bash
$ awk 'program' data
$ egrep 'Asia' countries | awk 'program'
```

## Input Separators

```bash
$ awk 'BEGIN{ FS="|" }' data
$ awk -F'|' 'program' data
```

## Multiline Records

## The `getline` Function

[ Explicit Input with `getline`](https://www.gnu.org/software/gawk/manual/html_node/Getline.html#Getline)

getline的形式 | 说明 | 解释
---|---|---
getline | Using getline with no arguments | 将下一行读到列变量$0,$1,...$n里。相当于读了两行
getiine var | Using getline into a variable | 将下一行读到某个变量var。相当于读了两行
getline < "file" | Using getline from a file| 从指定文件读取一行到$0
getline var "file" | Using getline into a variable from a file | 从指定文件读取一行放到变量var中
cmd \| getline | Using getline from a pipe | 从命令输出读取一行到$0（行尾有换行）
cmd \| getline var | Using getline into a variable from a pipe | 从命令输出读取一行到变量var（行尾有换行）
print "some query" \|& "db_server"
"db_server" \|& getline | Using getline from a coprocess | 双向管道，输出读到$0
cmd \|& getline var| Using getline into a variable from a coprocess |  双向管道，输出读到变量var


- [Getline Notes: | Important things to know about getline.](https://www.gnu.org/software/gawk/manual/html_node/Getline-Notes.html#Getline-Notes)
Getline Summary | Summary of getline Variants.

### `getline` Summary

Variant|Effect|awk / gawk
---|---|---
getline | Sets $0, NF, FNR, NR, and RT  | awk
getline var | Sets var, FNR, NR, and RT	| awk
getline < file | Sets $0, NF, and RT	| awk
getline var < file	| Sets var and RT	| awk
command \| getline	| Sets $0, NF, and RT	| awk
command \| getline var	| Sets var and RT	| awk
command \|& getline	| Sets $0, NF, and RT	| gawk
command \|& getline var	| Sets var and RT	| gawk

> 注意: 有Pipe的要用close(cmd)关掉对应管道

## Command-Line Variable Assigments

## Command-Line Arguments

# 2.6 Interaction with Other Programs

# 2.7 Summary