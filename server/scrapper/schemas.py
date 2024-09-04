class dataSchemas:
    class Clothe:
        def __init__(self, id: int, type: str):
            self.id = id
            self.type = type

        def update(self, id: int = None, type: str = None):
            if id is not None:
                self.id = id
            if type is not None:
                self.type = type

        def get_id(self) -> int:
            return self.id

        def get_type(self) -> str:
            return self.type

        def get_all_data(self) -> dict:
            return {
                "id": self.id,
                "type": self.type
            }        

    class Credentials:
        def __init__(self, email: str, password: str):
            self.email = email
            self.password = password

        def update(self, email: str = None, password: str = None):
            if email is not None:
                self.email = email
            if password is not None:
                self.password = password

        def get_email(self) -> str:
            return self.email

        def get_password(self) -> str:
            return self.password

        def get_all_data(self) -> dict:
            return {
                "email": self.email,
                "password": self.password
            }


    class Customer:
        def __init__(self, id: int, email: str, name: str, surname: str, birth_date: str, gender: str, description: str, astrological_sign: str, phone_number: str, address: str):
            self.id = id
            self.email = email
            self.name = name
            self.surname = surname
            self.birth_date = birth_date
            self.gender = gender
            self.description = description
            self.astrological_sign = astrological_sign
            self.phone_number = phone_number
            self.address = address

        def update(self, id: int = None, email: str = None, name: str = None, surname: str = None, birth_date: str = None, gender: str = None, description: str = None, astrological_sign: str = None, phone_number: str = None, address: str = None):
            if id is not None:
                self.id = id
            if email is not None:
                self.email = email
            if name is not None:
                self.name = name
            if surname is not None:
                self.surname = surname
            if birth_date is not None:
                self.birth_date = birth_date
            if gender is not None:
                self.gender = gender
            if description is not None:
                self.description = description
            if astrological_sign is not None:
                self.astrological_sign = astrological_sign
            if phone_number is not None:
                self.phone_number = phone_number
            if address is not None:
                self.address = address

        def get_id(self) -> int:
            return self.id

        def get_email(self) -> str:
            return self.email

        def get_name(self) -> str:
            return self.name

        def get_surname(self) -> str:
            return self.surname

        def get_birth_date(self) -> str:
            return self.birth_date

        def get_gender(self) -> str:
            return self.gender

        def get_description(self) -> str:
            return self.description

        def get_astrological_sign(self) -> str:
            return self.astrological_sign

        def get_phone_number(self) -> str:
            return self.phone_number

        def get_address(self) -> str:
            return self.address

        def get_all_data(self) -> dict:
            return {
                "id": self.id,
                "email": self.email,
                "name": self.name,
                "surname": self.surname,
                "birth_date": self.birth_date,
                "gender": self.gender,
                "description": self.description,
                "astrological_sign": self.astrological_sign,
                "phone_number": self.phone_number,
                "address": self.address
            }

    class Employee:
        def __init__(self, id: int, email: str, name: str, surname: str, birth_date: str, gender: str, work: str):
            self.id = id
            self.email = email
            self.name = name
            self.surname = surname
            self.birth_date = birth_date
            self.gender = gender
            self.work = work

        def update(self, id: int = None, email: str = None, name: str = None, surname: str = None, birth_date: str = None, gender: str = None, work: str = None):
            if id is not None:
                self.id = id
            if email is not None:
                self.email = email
            if name is not None:
                self.name = name
            if surname is not None:
                self.surname = surname
            if birth_date is not None:
                self.birth_date = birth_date
            if gender is not None:
                self.gender = gender
            if work is not None:
                self.work = work

        def get_id(self) -> int:
            return self.id

        def get_email(self) -> str:
            return self.email

        def get_name(self) -> str:
            return self.name

        def get_surname(self) -> str:
            return self.surname

        def get_birth_date(self) -> str:
            return self.birth_date

        def get_gender(self) -> str:
            return self.gender

        def get_work(self) -> str:
            return self.work
        
        def get_all_data(self) -> dict:
            return {
                "id": self.id,
                "email": self.email,
                "name": self.name,
                "surname": self.surname,
                "birth_date": self.birth_date,
                "gender": self.gender,
                "work": self.work
            }

    class Encounter:
        def __init__(self, id: int, customer_id: int, date: str, rating: int, comment: str, source: str):
            self.id = id
            self.customer_id = customer_id
            self.date = date
            self.rating = rating
            self.comment = comment
            self.source = source

        def update(self, id: int = None, customer_id: int = None, date: str = None, rating: int = None, comment: str = None, source: str = None):
            if id is not None:
                self.id = id
            if customer_id is not None:
                self.customer_id = customer_id
            if date is not None:
                self.date = date
            if rating is not None:
                self.rating = rating
            if comment is not None:
                self.comment = comment
            if source is not None:
                self.source = source

        def get_id(self) -> int:
            return self.id

        def get_customer_id(self) -> int:
            return self.customer_id

        def get_date(self) -> str:
            return self.date

        def get_rating(self) -> int:
            return self.rating

        def get_comment(self) -> str:
            return self.comment

        def get_source(self) -> str:
            return self.source
        
        def get_all_data(self) -> dict:
            return {
                "id": self.id,
                "customer_id": self.customer_id,
                "date": self.date,
                "rating": self.rating,
                "comment": self.comment,
                "source": self.source
            }

    class Event:
        def __init__(self, id: int, name: str, date: str, duration: int, max_participants: int, location_x: str, location_y: str, type: str, employee_id: int, location_name: str):
            self.id = id
            self.name = name
            self.date = date
            self.duration = duration
            self.max_participants = max_participants
            self.location_x = location_x
            self.location_y = location_y
            self.type = type
            self.employee_id = employee_id
            self.location_name = location_name

        def update(self, id: int = None, name: str = None, date: str = None, duration: int = None, max_participants: int = None, location_x: str = None, location_y: str = None, type: str = None, employee_id: int = None, location_name: str = None):
            if id is not None:
                self.id = id
            if name is not None:
                self.name = name
            if date is not None:
                self.date = date
            if duration is not None:
                self.duration = duration
            if max_participants is not None:
                self.max_participants = max_participants
            if location_x is not None:
                self.location_x = location_x
            if location_y is not None:
                self.location_y = location_y
            if type is not None:
                self.type = type
            if employee_id is not None:
                self.employee_id = employee_id
            if location_name is not None:
                self.location_name = location_name

        def get_id(self) -> int:
            return self.id

        def get_name(self) -> str:
            return self.name

        def get_date(self) -> str:
            return self.date

        def get_duration(self) -> int:
            return self.duration

        def get_max_participants(self) -> int:
            return self.max_participants

        def get_location_x(self) -> str:
            return self.location_x

        def get_location_y(self) -> str:
            return self.location_y

        def get_type(self) -> str:
            return self.type

        def get_employee_id(self) -> int:
            return self.employee_id

        def get_location_name(self) -> str:
            return self.location_name
        
        def get_all_data(self) -> dict:
            return {
                "id": self.id,
                "name": self.name,
                "date": self.date,
                "duration": self.duration,
                "max_participants": self.max_participants,
                "location_x": self.location_x,
                "location_y": self.location_y,
                "type": self.type,
                "employee_id": self.employee_id,
                "location_name": self.location_name
            }

    class HTTPError:
        def __init__(self, detail: str):
            self.detail = detail

        def update(self, detail: str = None):
            if detail is not None:
                self.detail = detail

        def get_detail(self) -> str:
            return self.detail
        
        def get_all_data(self) -> dict:
            return {
                "detail": self.detail
            }

    class HTTPValidationErrorExpand:
        pass

    class PaymentHistory:
        def __init__(self, id: int, date: str, payment_method: str, amount: float, comment: str):
            self.id = id
            self.date = date
            self.payment_method = payment_method
            self.amount = amount
            self.comment = comment

        def update(self, id: int = None, date: str = None, payment_method: str = None, amount: float = None, comment: str = None):
            if id is not None:
                self.id = id
            if date is not None:
                self.date = date
            if payment_method is not None:
                self.payment_method = payment_method
            if amount is not None:
                self.amount = amount
            if comment is not None:
                self.comment = comment

        def get_id(self) -> int:
            return self.id

        def get_date(self) -> str:
            return self.date

        def get_payment_method(self) -> str:
            return self.payment_method

        def get_amount(self) -> float:
            return self.amount

        def get_comment(self) -> str:
            return self.comment

        def get_all_data(self) -> dict:
            return {
                "id": self.id,
                "date": self.date,
                "payment_method": self.payment_method,
                "amount": self.amount,
                "comment": self.comment
            }

    class ShortCustomer:
        def __init__(self, id: int, email: str, name: str, surname: str):
            self.id = id
            self.email = email
            self.name = name
            self.surname = surname

        def update(self, id: int = None, email: str = None, name: str = None, surname: str = None):
            if id is not None:
                self.id = id
            if email is not None:
                self.email = email
            if name is not None:
                self.name = name
            if surname is not None:
                self.surname = surname

        def get_id(self) -> int:
            return self.id

        def get_email(self) -> str:
            return self.email

        def get_name(self) -> str:
            return self.name

        def get_surname(self) -> str:
            return self.surname
        
        def get_all_data(self) -> dict:
            return {
                "id": self.id,
                "email": self.email,
                "name": self.name,
                "surname": self.surname
            }

    class ShortEmployee:
        def __init__(self, id: int, email: str, name: str, surname: str):
            self.id = id
            self.email = email
            self.name = name
            self.surname = surname

        def update(self, id: int = None, email: str = None, name: str = None, surname: str = None):
            if id is not None:
                self.id = id
            if email is not None:
                self.email = email
            if name is not None:
                self.name = name
            if surname is not None:
                self.surname = surname

        def get_id(self) -> int:
            return self.id

        def get_email(self) -> str:
            return self.email

        def get_name(self) -> str:
            return self.name

        def get_surname(self) -> str:
            return self.surname
        
        def get_all_data(self) -> dict:
            return {
                "id": self.id,
                "email": self.email,
                "name": self.name,
                "surname": self.surname
            }

    class ShortEncounter:
        def __init__(self, id: int, customer_id: int, date: str, rating: int):
            self.id = id
            self.customer_id = customer_id
            self.date = date
            self.rating = rating

        def update(self, id: int = None, customer_id: int = None, date: str = None, rating: int = None):
            if id is not None:
                self.id = id
            if customer_id is not None:
                self.customer_id = customer_id
            if date is not None:
                self.date = date
            if rating is not None:
                self.rating = rating

        def get_id(self) -> int:
            return self.id

        def get_customer_id(self) -> int:
            return self.customer_id

        def get_date(self) -> str:
            return self.date

        def get_rating(self) -> int:
            return self.rating

        def get_all_data(self) -> dict:
            return {
                "id": self.id,
                "customer_id": self.customer_id,
                "date": self.date,
                "rating": self.rating
            }

    class ShortEvent:
        def __init__(self, id: int, name: str, date: str, duration: int, max_participants: int):
            self.id = id
            self.name = name
            self.date = date
            self.duration = duration
            self.max_participants = max_participants

        def update(self, id: int = None, name: str = None, date: str = None, duration: int = None, max_participants: int = None):
            if id is not None:
                self.id = id
            if name is not None:
                self.name = name
            if date is not None:
                self.date = date
            if duration is not None:
                self.duration = duration
            if max_participants is not None:
                self.max_participants = max_participants

        def get_id(self) -> int:
            return self.id

        def get_name(self) -> str:
            return self.name

        def get_date(self) -> str:
            return self.date

        def get_duration(self) -> int:
            return self.duration

        def get_max_participants(self) -> int:
            return self.max_participants
        
        def get_all_data(self) -> dict:
            return {
                "id": self.id,
                "name": self.name,
                "date": self.date,
                "duration": self.duration,
                "max_participants": self.max_participants
            }

    class Tip:
        def __init__(self, id: int, title: str, tip: str):
            self.id = id
            self.title = title
            self.tip = tip

        def update(self, id: int = None, title: str = None, tip: str = None):
            if id is not None:
                self.id = id
            if title is not None:
                self.title = title
            if tip is not None:
                self.tip = tip

        def get_id(self) -> int:
            return self.id

        def get_title(self) -> str:
            return self.title

        def get_tip(self) -> str:
            return self.tip
        
        def get_all_data(self) -> dict:
            return {
                "id": self.id,
                "title": self.title,
                "tip": self.tip
            }

    class Token:
        def __init__(self, access_token: str):
            self.access_token = access_token

        def update(self, access_token: str = None):
            if access_token is not None:
                self.access_token = access_token

        def get_access_token(self) -> str:
            return self.access_token
        
        def get_all_data(self) -> dict:
            return {
                "access_token": self.access_token
            }

    class ValidationError:
        def __init__(self, loc: list, msg: str, type: str):
            self.loc = loc
            self.msg = msg
            self.type = type

        def update(self, loc: list = None, msg: str = None, type: str = None):
            if loc is not None:
                self.loc = loc
            if msg is not None:
                self.msg = msg
            if type is not None:
                self.type = type

        def get_loc(self) -> list:
            return self.loc

        def get_msg(self) -> str:
            return self.msg

        def get_type(self) -> str:
            return self.type
        
        def get_all_data(self) -> dict:
            return {
                "loc": self.loc,
                "msg": self.msg,
                "type": self.type
            }