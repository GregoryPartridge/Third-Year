import math

import requests
import numpy as np
import matplotlib.pyplot as plt



def query(username):
    url = 'https://api.github.com/users/' + username + '/repos'
    r = requests.get(url)
    data = r.json()
    return data


def how_much_language_used(data):
    all_languages = []
    times_used = []
    found_language = False

    for j in data:
        if j['language'] is not None:
            for i in range(len(all_languages)):
                if j['language'] == all_languages[i]:
                    times_used[i] += 1
                    found_language = True
            if not found_language:
                all_languages.append(j['language'])
                times_used.append(1)
            found_language = False

    return_data = []
    for l in range(len(all_languages)):
        return_data.insert(len(return_data), [all_languages[l], times_used[l]])

    return_data = sort_data(return_data)
    #print(return_data)

    return return_data

def sort_data(data):

    holder = []
    for i in range(len(data)):
        for j in range(i+1, len(data)):
            if data[j][1] > data[i][1]:
                holder = data[j]
                data[j] = data[i]
                data[i] = holder
    return data


def total_languages_used(data):
    all_languages = []
    times_used = []
    found_language = False

    for k in range(len(data)):
        for j in range(len(data[k])):
            for i in range(len(all_languages)):
                if data[k][j][0] == all_languages[i]:
                    times_used[i] += data[k][j][1]
                    found_language = True
            if not found_language:
                all_languages.append(data[k][j][0])
                times_used.append(data[k][j][1])
            found_language = False

    return_data = []
    current_spot = 0
    for l in range(len(all_languages)):
        return_data.insert(current_spot, [all_languages[l], times_used[l]])
        current_spot += 1

    return_data = sort_data(return_data)

    return return_data

def main_language_corolation(new_data, languages):
    correlation_table = [[0 for k in range(len(languages))] for j in range(len(languages))]
    main_lang_correlation_table = correlation_table
    languages_used_by_user = []
    # print(languages)
    for a in range(len(new_data)):
        for b in range(len(new_data[a])):

            for c in range(len(languages)):
                if new_data[a][b][0] == languages[c]:
                    # print(new_data[a][b][0])
                    languages_used_by_user.append(c)
        #print(languages_used_by_user)
        correlation_table = add_to_corrolation_table(correlation_table, languages_used_by_user)

        languages_used_by_user = []

    return main_lang_correlation_table


    return table

def add_to_corrolation_table(table, lang_used):

    for i in range(len(lang_used)):
        for k in range(len(lang_used)):
            if lang_used[i] != lang_used[k]:
                table[lang_used[i]][lang_used[k]] += 1
    return table

def most_connected_lang(table):

    language_connected = []
    counter = 0

    for i in range(len(table)):
        for j in range(len(table[i])):
            if table[i][j] != 0:
                counter += 1
        language_connected.append(counter)
        counter = 0

    return language_connected

def main_table(table):
    most_used_lang_connected_table = []
    most_used = -1
    lang = -1
    holder = []
    for i in range(len(table)):
        for j in range(len(table[i])):
            if table[i][j] > most_used:
                most_used = table[i][j]
                lang = j
        holder.append(most_used)
        holder.append(lang)
        most_used_lang_connected_table.append(holder)
        most_used = -1
        lang = -1
        holder = []
    return most_used_lang_connected_table

def times_main_to_lang(table, languages):

    beta_return_table = [0 for k in range(len(languages))]

    for i in range(len(table)):
        beta_return_table[table[i][1]] += 1

    return_table = []
    holder = []

    for j in range(len(beta_return_table)):
        if beta_return_table[j] != 0:
            holder.append(languages[j])
            holder.append(beta_return_table[j])
            return_table.append(holder)
            holder = []

    return return_table

def all_users():
    list_of_users_data = []
    all_users = open("Users", "r")

    for data in all_users.readlines():
        list_of_users_data.append(query(data.rstrip('\n')))
    all_users.close()

    return list_of_users_data

users_data = []
language_data = []
new_data = []
corresponding_users_to_data = []

users_data = all_users()


for i in range(len(users_data)):
    language_data.insert(len(language_data), how_much_language_used(users_data[i]))
    corresponding_users_to_data.insert(len(corresponding_users_to_data), users_data[i])

for p in range(len(language_data)):
    string = language_data[p]
    #print(corresponding_users_to_data[p]+": "+(str)(string))

for i in range(len(language_data)):
    new_data.insert(i, language_data[i])
total_data = (total_languages_used(new_data))

languages = []
times_languages_used = []

for p in range(len(total_data)):
    languages.append(total_data[p][0])
    times_languages_used.append(total_data[p][1])

table = (main_language_corolation(new_data, languages))

most_connected_language = most_connected_lang(table)

main_table = main_table(table)

for j in range(len(table)):
    print(languages[j])
    for k in range(len(table[j])):
        if j != k:
            print("     "+(str)(languages[k])+": "+(str)(table[j][k]))
    print("\n")

for i in range(len(main_table)):
    print(languages[i])
    print("Most used: "+(str)(languages[main_table[i][1]]))
    print("Times Used: "+(str)(main_table[i][0]))
    print("---")


main_to_lang_table = (times_main_to_lang(main_table, languages))

lang = []
times_used = []
for z in range(len(main_to_lang_table)):
    times_used.append(main_to_lang_table[z][0])
    lang.append(main_to_lang_table[z][1])

tally = 0
for a in range(len(times_languages_used)):
    tally += times_languages_used[a]

# PLOTTING
plt.style.use('seaborn-darkgrid')

plt.rcParams.update({
    "figure.facecolor": "xkcd:wheat",
    "figure.edgecolor": "xkcd:wheat",
    "savefig.facecolor": "xkcd:wheat",
    "savefig.edgecolor": "xkcd:wheat"})

fig, ax = plt.subplots(figsize=(6, 4), subplot_kw=dict(aspect="equal"))

wedges, texts = ax.pie(times_languages_used, wedgeprops=dict(width=0.6, edgecolor = 'black'), startangle=45)

bbox_props = dict(boxstyle="square,pad=0.3", fc="w", ec="k", lw=0.72)
kw = dict(arrowprops=dict(arrowstyle="-"), bbox=bbox_props, zorder=0, va="center")

for i, p in enumerate(wedges):
    ang = (p.theta2 - p.theta1)/2. + p.theta1
    y = np.sin(np.deg2rad(ang))
    x = np.cos(np.deg2rad(ang))
    horizontalalignment = {-1: "right", 1: "left"}[int(np.sign(x))]
    connectionstyle = "angle,angleA=0,angleB={}".format(ang)
    kw["arrowprops"].update({"connectionstyle": connectionstyle})
    if tally < 50 or times_languages_used[i] > math.floor(tally/50):
        ax.annotate(languages[i]+" :"+(str)(times_languages_used[i]), xy=(x, y), xytext=(1.35*np.sign(x), 1.4*y), horizontalalignment=horizontalalignment, **kw)

ax.set_title("Languages and their proportional use")

plt.show()


plt.rcdefaults()
fig, ax = plt.subplots()

languages_used = languages
y_pos = np.arange(len(languages_used))
performance = most_connected_language

ax.barh(y_pos, performance, align='center')
ax.set_yticks(y_pos)
ax.set_yticklabels(languages_used)
ax.set_xlabel('Languages Connected To')
ax.set_title('How connected are languages to other listed languages')


plt.show()

plt.show()


plt.rcdefaults()
fig, ax = plt.subplots()

languages_used = times_used
y_pos = np.arange(len(times_used))
performance = lang

ax.barh(y_pos, performance, align='center')
ax.set_yticks(y_pos)
ax.set_yticklabels(languages_used)
ax.set_xlabel('Languages Tied To as Main Language')
ax.set_title('How many languages that are the main language to a connected language')


plt.show()
