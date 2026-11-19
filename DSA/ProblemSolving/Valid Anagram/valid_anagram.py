class Solution:
    def isAnagram(self, s: str, t: str) -> bool:
        if len(s) != len(t):
            return False
        char_freq = {}
        for char in s:
            if char in char_freq:
                char_freq[char] += 1
            else:
                char_freq[char] = 1

        for char in t:
            if char not in char_freq or char_freq[char] == 0:
                return False
            char_freq[char] -= 1
        
        return True

answer = Solution()
print(answer.isAnagram(s="anagram", t="nagaram"))