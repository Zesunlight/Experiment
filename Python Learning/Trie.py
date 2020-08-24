# -*- coding: UTF-8 -*-
from typing import List


class Trie:
    def __init__(self):
        self.lookup = {}

    def insert(self, word: str) -> None:
        tree = self.lookup
        for a in word:
            if a not in tree:
                tree[a] = {}
            tree = tree[a]
        tree["#"] = "#"  # 单词结束标志

    def search(self, word: str) -> bool:
        # Returns if the word is in the trie.
        tree = self.lookup
        for a in word:
            if a not in tree:
                return False
            tree = tree[a]
        return "#" in tree

    def start_with(self, prefix: str) -> bool:
        # Returns if there is any word in the trie that starts with the given prefix.
        tree = self.lookup
        for a in prefix:
            if a not in tree:
                return False
            tree = tree[a]
        return True

    def words(self) -> List:
        # Return all words in the trie (alphabetical order)
        tree = self.lookup
        word_list = []

        def dfs(layer: dict, character: str):
            dict_order = sorted(layer.keys())
            for c in dict_order:
                if c == '#':
                    word_list.append(character)
                else:
                    dfs(layer[c], character + c)

        dfs(tree, '')
        return word_list


if __name__ == '__main__':
    t = Trie()
    t.insert('paper')
    t.insert('people')
    t.insert('person')
    t.insert('children')
    t.insert('child')
    print(t.words())
