from sqlalchemy.orm import Session
from fastapi import HTTPException

from crud.crud_institution import (
    get_institutions,
    get_institution,
    create_institution,
    update_institution,
    delete_institution
)


def list_institutions(db: Session):
    return get_institutions(db)


def get_one_institution(db: Session, institution_id):
    inst = get_institution(db, institution_id)
    if not inst:
        raise HTTPException(404, "Institution not found")
    return inst


def create_new_institution(db: Session, data):
    return create_institution(db, data)


def update_existing_institution(db: Session, institution_id, data):
    inst = get_institution(db, institution_id)
    if not inst:
        raise HTTPException(404, "Institution not found")

    return update_institution(db, institution_id, data)


def delete_existing_institution(db: Session, institution_id):
    inst = get_institution(db, institution_id)
    if not inst:
        raise HTTPException(404, "Institution not found")

    delete_institution(db, institution_id)
    return {"message": "Deleted successfully"}