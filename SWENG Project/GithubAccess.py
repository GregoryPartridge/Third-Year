import requests
import json

def query(username):

    r = requests.get('https://api.github.com/users/' + username + '/repos')
    data = r.json()
    return data

def all_projects(username):

    data = query(username)

    for j in data:
        print(j['name'])
    return

def language_used(username):

    data = query(username)

    for j in data:
        if(j['language'] is not None):
            print(j['language'])

    return


def largest_project(username):
    data = query(username)

    max_size = 0

    for j in data:
        if(j['size'] > max_size):
            max_size = j['size']
    return max_size


def smallest_project(username):
    data = query(username)

    min_size = -1

    for j in data:
        if (j['size'] < min_size or min_size < 0):
            min_size = j['size']
    return min_size



#TESTING

print(query('GregoryPartridgeSweng'))

all_projects('GregoryPartridgeSweng')

language_used('GregoryPartridgeSweng')

print(largest_project('GregoryPartridgeSweng'))

print(smallest_project('GregoryPartridgeSweng'))