def find_min(arr):
    if not arr:
        return "Array is empty!"
    
    min = arr[0]

    for i in range(len(arr)):
        if arr[i] < min:
            min = arr[i]
    
    return min

arr = [7, 2, 9, 1, 5]

print(find_min(arr))