import requests
import json
from pprint import pprint


def save_ys_handbook():
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36',
        'Referer': 'https://bbs.mihoyo.com/',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': ''
    }
    url = 'https://api-static.mihoyo.com/common/blackboard/ys_obc/v1/home/content/list?app_sn=ys_obc&channel_id=189'
    request = requests.get(url, headers=headers, allow_redirects=True)
    text = request.text

    with open('ys.json', 'w') as f:
        json.dump(json.loads(text)['data']['list'][0]['children'], f, ensure_ascii=False)


if __name__ == '__main__':
    # save_ys_handbook()

    relic = {}
    with open('ys.json', 'r') as f:
        handbook = json.load(f)
        for item in handbook:
            if item['name'] == '圣遗物':
                for equip in item['list']:
                    extend = json.loads(equip['ext'])[f"c_{item['id']}"]
                    text = json.loads(extend['filter']['text'])
                    level = [i[3:] for i in text if i.startswith('星级')]
                    if '五星' not in level:
                        continue

                    relic[equip['title']] = {
                        'effect': [i[5:] for i in text if i.startswith('套装效果')],
                        # 'level': [i[3:] for i in text if i.startswith('星级')],
                        # 'acquire': [i[5:] for i in text if i.startswith('获取方式')],
                        'icon': equip['icon']
                    }
                    for suit in extend['table']['list']:
                        key = 'suit'
                        if suit['key'].startswith('两') or suit['key'].startswith('二'):
                            key = 'two'
                        elif suit['key'].startswith('四'):
                            key = 'four'
                        elif suit['key'].startswith('一'):
                            key = 'one'
                        relic[equip['title']][key] = suit['value']

    pprint(relic)
    print(len(relic))
