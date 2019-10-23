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

# 2.6 Interaction with Other Programs

# 2.7 Summary