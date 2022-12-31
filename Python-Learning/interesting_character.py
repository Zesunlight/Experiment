# -*- coding: UTF-8 -*-
"""=================================================
内容来自公众号 未闻Code

一日一技：如何移除所有不可见字符？
隐写术：如何正确保护文章的版权？
显隐术：如何阅读由零宽字符写的信息？
=================================================="""

from itertools import cycle


# 使用repr函数显示这个字符串真正的样子，可以看到里面实际上有哪些字符
# 使用字符串的.isprintable()方法，辨别字符是否可见

print(ord('\u2029'))
print(ord('电'), chr(30005))
print(chr(8204), chr(8205))  # invisible

info = '版权所有'
info_unicode = [ord(w) for w in info]
info_unicode_bin = [bin(w)[2:] for w in info_unicode]
text = '一片春愁待酒浇，江上舟摇，楼上帘招。'

mix = ''
for word, sign in zip(text, cycle(info_unicode_bin)):
    mix += word + sign.replace('1', chr(8204)).replace('0', chr(8205))
print(mix)
print(repr(mix))

origin_words = []
hide_word = ''
for char in mix:
    if char in (chr(8204), chr(8205)):
        hide_word += char
    else:
        if hide_word != '':
            bin_word = hide_word.replace(chr(8204), '1').replace(chr(8205), '0')
            origin_words.append(chr(int(bin_word, 2)))
            hide_word = ''
        origin_words.append(char)

print(''.join(origin_words))
