# Regex

## Character sets

**Character Sets match characters.**

- `.` will match any character (except a new line).
- `[a-z]` (or `[abcd]` or `[0–9]`) will match any character specified in between the brackets.

## Modifiers

**Modifiers modify the meaning of the preceding character.**

- `*` will match the directly preceding character 0 or more times.

- `+` will match the directly preceding character 1 or more times. 

- `?` will match the directly preceding character 0 or 1 times. 

- `\` escapes the meaning of special characters.

the characters ‘+’, ‘?’, and ‘*’ meanings are altered inside of square brackets: generally, once they are inside the brackets, they will not have a special meaning, but rather, will stand for the characters themselves to be matched.

## Anchors

**Anchors tell the regex where to look for a match.**

- `^` will match the start of the string.
- `$` will match the end of the string.

## Other

- `{m}`, where m is an integer, will match only exactly *m* repetitions of the preceding character.
- `{m, n}` will match as little as *m* and as many as *n* repetitions, being as greedy as possible (matching as many strings as possible).
- `{m, n}?` will match as little as *m* and as many as *n* repetitions, but is *not* greedy, and therefore will match as few strings as possible.
- `|` is used for ‘or’
- `\d` will match all digits
- `\D` will match all non-digits
- `\s` will match all white space characters (space, tab, etc.)
- `\S` will match all non-whitespace characters
-  `\w`：匹配字母，数字，下划线
- 若要查找不在列表或范围内的所有字符，请将插入符号 `^` 放在列表的开头

## Examples

```
cat matches cat 
ca+t matches caaaaaaaaaaaat but not ct 
ca*t matches caaaaaaaaaaaat and also ct 
ca{2,4} matches caat, caaat and caaaat 
c(at)+ matches catatatatatat 
c(at|orn) matches cat and corn 
c[ea]t matches cat and cet
c[ea]+t matches caaaat and ceeet
c[A-C0-9]t matches cAt, cBt, cCt, c8t etc. 
c.t matches cat, c&t, c2t (any char between c and t) 
c.+t matches c3%x4t (any number of any chars) 
c.*t matches c3%x4t and as well as ct 
^a+cat matches aaacat in aaacat but not in bbaaacat 
cat$ matches cat in aaacat but not in aaacats 
^cat$ matches only and only this string i.e. cat 
c\d+t matches c2784t 
c\s+t matches c       t 
c\D+t matches cxxxt ca2t
```


## Reference

- https://www.runoob.com/regexp/regexp-example.html
- https://medium.com/@hparker5/the-hitchhikers-guide-to-regular-expressions-and-python-s-re-library-1342444900d2
- https://github.com/ziishaned/learn-regex



