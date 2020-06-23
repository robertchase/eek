import string
import random

import click


@click.command()
@click.option('-c', '--count', type=int, default=12)
@click.option('-s', '--special')
def gen(count, special):
    if special is None:
        special = string.punctuation.replace('"', '').replace("'", '').replace(
            '\\', '')
    chars = string.ascii_letters + string.digits + special
    print(''.join(random.choice(chars) for digit in range(count)))


if __name__ == '__main__':
    gen()
