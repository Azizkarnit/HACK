def can_access_institution(user, institution_id):
    role = user["role"]

    if role in ["super_admin", "agent"]:
        return True

    if role == "admin":
        return user["institution_id"] == institution_id

    return False


def can_write(user):
    return user["role"] in ["admin", "super_admin"]


def is_agent(user):
    return user["role"] == "agent"