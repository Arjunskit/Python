# def find_min(arr):
#     if not arr:
#         return "Array is empty!"
    
#     min = arr[0]

#     for i in range(len(arr)):
#         if arr[i] < min:
#             min = arr[i]
    
#     return min

# arr = [7, 2, 9, 1, 5]

# print(find_min(arr))

a = [1, 2, 3, 4, 6, 9, 5]
largest = 0
for item in a:
    if item > largest:
        largest = item
print(largest)
second_largest = 0
for item in a:
    if item == largest:
        continue
    if item > second_largest:
        second_largest = item
print(second_largest)