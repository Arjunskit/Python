def selectionSort(arr):
    for index in range(len(arr)):
        min_index = index
        for j in range(index + 1, len(arr)):
            if arr[min_index] > arr[j]:
                min_index = j
        arr[min_index], arr[index] = arr[index], arr[min_index]

    return arr

arr = [20,40,30,10,50]

print(selectionSort(arr))