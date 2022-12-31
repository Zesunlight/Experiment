import unittest


class Person():
    def __init__(self, name='Anonymous', age=0, gender='Unknown'):
        self.name = name
        self.age = age
        self.gender = gender
        self.praise = ''
        
    def show_information(self):
        print(f'{self.name.title()}, age {self.age}, {self.gender}')
        
    def description(self):
        if self.age < 15:
            self.praise = 'kid'
        elif self.age < 35:
            self.praise = 'young'
        elif self.age < 60:
            self.praise = 'mature'
        else:
            self.praise = 'aged'


class TestPerson(unittest.TestCase):
    def setUp(self):
        self.my_person = Person('zyz', 23, 'male')
        self.response = 'young'
        
    def test_description(self):
        self.my_person.description()
        self.assertEqual(self.response, self.my_person.praise)
        # self.assertNotEqual(a, b)
        # self.assertIn(item, list)
        # self.assertNotIn(item, list)
        # self.assertTrue(x)
        # self.assertFalse(x)


unittest.main()

"""
output:

.
----------------------------------------------------------------------
Ran 1 test in 0.000s

OK
"""