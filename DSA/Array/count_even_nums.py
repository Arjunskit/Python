def count_even_nums(arr):
    if not arr:
        return 0
    c = 0
    for i in range(len(arr)):
        if arr[i] % 2 == 0:
            c += 1
    return c


arr = [4, 7, 2, 9, 8, 5]

print(count_even_nums(arr))