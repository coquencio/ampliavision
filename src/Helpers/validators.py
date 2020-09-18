def is_email_valid(email):
    if not "@" in email or not "." in email:
        return False

    if len(email.split("@"))> 2:
        return False

    return True
