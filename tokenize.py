"""Tokenize lines into args and kwargs

   Given this line:
        a b c d='1 2 3' e=12 z
   Return:
    [
        ['a', 'b', 'c', 'z'],
        {'d': '1 2 3', 'e': 12}
    ]
"""
import re


def tokenize(lin):
    """Tokenize a single line"""
    kwargs = {}
    args = []

    # pull out the k=v pairs that look like a='b' or a="b"
    pat = r"(\S+)=(?P<tick>'|\")(.*?)(?P=tick)"
    while True:
        res = re.search(pat, lin)
        if not res:
            break
        kwargs[res.group(1)] = res.group(3)
        lin = lin[:res.start()] + lin[res.end():]

    # look for non-quoted k=v pairs, else arg
    for tok in lin.split():
        try:
            key, value = tok.split('=', 1)
            kwargs[key] = value
        except ValueError:
            args.append(tok)

    return args, kwargs


def cli():
    """tokenize lines from stdin"""
    parser = argparse.ArgumentParser()
    parser.add_argument('type', nargs='?', default='k', choices=('a', 'k'))
    parser.add_argument('-k', '--key')
    cargs = parser.parse_args()

    for line in sys.stdin.readlines():
        args, kwargs = tokenize(line)
        args = ' '.join(str(a) for a in args)
        if cargs.type == 'a':
            print(args)
        else:
            if cargs.key:
                print(kwargs.get(cargs.key, ''))
            else:
                kwargs = ' '.join('%s=*' % k for k in kwargs)
                print(args + ' ' + kwargs)


if __name__ == '__main__':
    import argparse
    import sys
    cli()
