import re

regex = '^[a-z0-9]+[\._]?[a-z0-9]+[@]\w+[.]\w{2,3}$'


custom_regex = '^[a-z0-9]+[\._]?[a-z0-9]+[@]\w+[.]\w+$'

# Define a function for
# for validating an Email
def is_email_valid(email):
    return re.search(regex, email) or re.search(custom_regex, email)
