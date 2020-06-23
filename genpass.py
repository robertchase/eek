import string
import random

import click


def gen_from_parts(count, *parts):
    """generate a string containing random characters from parts"""
    chars = ''.join(parts)
    return ''.join(random.choice(chars) for digit in range(count))


def check_all(test, *parts):
    """check to make sure test has at least one char from each part"""
    for part in parts:
        found = sum((1 for char in part if char in test))
        if found == 0:
            return False
    return True


@click.command()
@click.option('-c', '--count', type=int, default=12)
@click.option('-s', '--special')
def gen(count, special):
    """generate a random password"""
    if special is None:
        special = string.punctuation.replace('"', '').replace("'", '').replace(
            '\\', '')
    parts = (string.ascii_uppercase, string.ascii_lowercase, string.digits,
             special)

    for loop in range(1000):
        result = gen_from_parts(count, *parts)
        if check_all(result, *parts):
            break
    print(result)


if __name__ == '__main__':
    gen()
