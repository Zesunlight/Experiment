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


if __name__ == '__main__':
    e = [str(i) for i in range(3)]
    r = permutation(e)
    print(r)