def permutation(elements):
    if len(elements) == 1:
        return elements
    else:
        new_res = []
        for p in range(len(elements)):
            temp = elements[:p] + elements[p+1:]
            result = permutation(temp)
            for item in result:
                new_res.append(elements[p] + item)
        return new_res

def permute2(nums):
    if len(nums) == 0:
        return []
    elif len(nums) == 1:
        return [[nums[0]]]

    res = []
    insert = [nums[0]]
    small = self.permute2(nums[1:])

    for item in small:
        for i in range(len(item) + 1):
            res.append(item[:i] + insert + item[i:])

    return res

def permute3(items):
    from itertools import permutations

    return list(permutations(items, len(items)))


if __name__ == '__main__':
    e = [str(i) for i in range(3)]
    r = permutation(e)
    print(r)
