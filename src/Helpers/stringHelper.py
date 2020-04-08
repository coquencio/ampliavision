class StringHelper:

    @staticmethod
    def __special_characters(word):
        escaped_word = ""
        for letter in word:
            if letter == "'":
                letter = letter + "'"
            escaped_word = escaped_word + letter

        return escaped_word

    def build_string(self, word):
        if "'" in word:
            word = self.__special_characters(word)
        word = "'"+word+"'"

        return word
