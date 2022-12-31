from collections import defaultdict
from itertools import product


def fuzzy_tone(pinyin: str, dictionary: dict):
    pre, suf = [], []

    def candidate(container: list, value: str):
        container.append(value)
        container.extend(list(dictionary[value]))

    def start(double, single):
        if pinyin.startswith(double):
            candidate(pre, double)
            s = pinyin[2:]
            candidate(suf, s)
        elif pinyin.startswith(single):
            candidate(pre, single)
            s = pinyin[1:]
            candidate(suf, s)

    start('zh', 'h')
    start('ch', 'h')
    start('sh', 'h')

    if pinyin.startswith('r') or pinyin.startswith('l') or pinyin.startswith('n'):
        pre.extend(['r', 'l', 'n'])
        candidate(suf, pinyin[1:])

    rest = ['b', 'p', 'm', 'f', 'd', 't', 'g', 'k', 'h', 'j', 'q', 'x']
    if pinyin[0] in rest:
        pre.append(pinyin[0])
        candidate(suf, pinyin[1:])

    result = set(''.join(i) for i in product(pre, suf))

    if (pinyin[0] in {'z', 's', 'c'}) and ('uan' in pinyin):
        result.remove(pinyin[0] + 'uang')
        # 若匹配 zhuang，得到的是 {'zuan', 'zhuang', 'zhuan', 'zuang'}
        # 其实 zuang 这个拼音是不存在的，这里是为了处理这种情况

    if pinyin[0] in {'r', 'l', 'n'}:
        # 去除不存在的声母、韵母组合
        if 'uan' in pinyin:
            result.remove('ruang')
            result.remove('luang')
            result.remove('nuang')
        if 'ian' in pinyin:
            result.remove('rian')
            result.remove('riang')

    # return {pinyin} if len(result) == 0 else result
    return result


def add_rules(dictionary):
    dictionary['ang'].add('an')
    dictionary['an'].add('ang')
    dictionary['eng'].add('en')
    dictionary['en'].add('eng')
    dictionary['ing'].add('in')
    dictionary['in'].add('ing')
    dictionary['ung'].add('un')
    dictionary['un'].add('ung')
    dictionary['ong'].add('on')
    dictionary['on'].add('ong')

    dictionary['uan'].add('uang')
    dictionary['uang'].add('uan')
    dictionary['ian'].add('iang')
    dictionary['iang'].add('ian')

    dictionary['zh'].add('z')
    dictionary['z'].add('zh')
    dictionary['ch'].add('c')
    dictionary['c'].add('ch')
    dictionary['sh'].add('s')
    dictionary['s'].add('sh')


if __name__ == '__main__':
    # prefix = ['b', 'p', 'm', 'f', 'd', 't', 'n', 'l', 'g', 'k', 'h', 'j', 'q', 'x', 'zh', 'ch', 'sh', 'r', 'z', 'c', 's']
    fuzzy = defaultdict(set)
    add_rules(fuzzy)
    py = input().strip()
    tone = fuzzy_tone(py, fuzzy)
    print(tone)
