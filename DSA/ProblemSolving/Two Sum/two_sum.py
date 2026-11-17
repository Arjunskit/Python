class Solution:
    def twoSum(self, nums: list[int], target: int) -> list[int]:
        seen = {}
        for i, num in enumerate(nums):
            complement = target - num
            if complement in seen:
                return [seen[complement], i]
            else:
                seen[num] = i
        return []
    
answer = Solution()
print(answer.twoSum([3,2,4], 6)) # [1, 2]