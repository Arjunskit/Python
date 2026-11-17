def merge(left, right):

    result = []

    i = 0
    j = 0
    

    while i < len(left) and j < len(right):
        if len(arr) <= 1:
            return arr
        if left[i] < right[j]:
            result.append(left[i])
            i += 1
        else:
            result.append(right[j])
            j += 1
    result.extend(left[i:])
    result.extend(right[j:])

    return result



def mergeSort(arr):

    mid = len(arr) // 2

    left = mergeSort(arr[:mid])
    right = mergeSort(arr[mid:])

    return merge(left, right)


arr = [38, 27, 43, 3, 9, 82, 10]

print(mergeSort(arr))