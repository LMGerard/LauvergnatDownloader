#original code, now using dart to make the executable lighter

from requests import get
from os import makedirs, startfile, environ
from os.path import join, exists
from re import findall

target_dir = join(join(environ['USERPROFILE']), 'Desktop', 'math')
if not exists(target_dir):
    makedirs(target_dir)

main_url, sub_url = open('url.txt', 'r').read().split('\n')

documents = findall("<a href=\"([^\"]*)\".*class=\"doc\".*>", get(main_url).text)
for href in documents:
    
    print('Downloading {}'.format(href))
    dir_name = href.split('/')
    sub_target_dir = join(target_dir, *dir_name[:-1])

    makedirs(sub_target_dir, exist_ok=True)
    r = get(sub_url + href, allow_redirects=True)
    open(join(sub_target_dir, dir_name[-1]), 'wb').write(r.content)
startfile(target_dir)
