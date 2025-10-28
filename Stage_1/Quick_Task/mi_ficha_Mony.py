# Declarando variables
first_name = 'Monica'
last_name = 'Granados'
age = 40
studyng_apis = True
hobbies = ['studying english', 'studying automation', 'Movies', 'care my son']

print('Name: ', first_name, last_name)
print('Age: ', age)
print('Are you studying Apis? ', studyng_apis)
print('Hobbies: ', hobbies)

print('first_name ->', type(first_name))
print('last_name ->', type(last_name))
print('age ->', type(age))
print('studying apis->', type(studyng_apis))
print('hobbies ->', type(hobbies))

hobby=input('Whats your favorite hobby?')
hobbies.append(hobby)
print('Hobbies: ', hobbies)
print ('Total Hobbies: ', len(hobbies))

new_age = int(age)
print('new age: ', new_age + 1)


