"""tools for google authenticator account export data"""
import base64
import hashlib
import hmac
import struct
import time


def read(input):
    """convert input to list of dicts"""
    result = []
    item = {}
    for line in input.readlines():
        line = line.strip()
        if len(line):
            key, val = line.split(":")
            if key == "Name":
                if len(item):
                    result.append(item)
                    item = {}
            item[key] = val.strip()
    if len(item):
        result.append(item)

    return result


def index(input):
    """display input as a numbered list"""
    for idx, item in enumerate(read(input), start=1):
        print(f"{idx}. {item['Issuer']}-{item['Name']}")


# https://stackoverflow.com/questions/8529265/google-authenticator-implementation-in-python
def get_hotp_token(secret, intervals_no=None):
    """generate totp given secret and time"""
    if not intervals_no:
        intervals_no = int(time.time())//30
    key = base64.b32decode(secret, True)
    msg = struct.pack(">Q", intervals_no)
    h = hmac.new(key, msg, hashlib.sha1).digest()
    o = h[19] & 15
    h = (struct.unpack(">I", h[o:o+4])[0] & 0x7fffffff) % 1000000
    h = ('000000' + str(h))[-6:]
    return h


def secret(input, index):
    """produce TOTP for the index-th (starts with 1) item in input"""
    print(get_hotp_token(read(input)[index - 1]["Secret"]))


if __name__ == "__main__":
    import argparse
    import sys

    parser = argparse.ArgumentParser()
    parser.add_argument("--choice", type=int)
    parser.add_argument("--secret")
    args = parser.parse_args()

    if args.choice:
        secret(sys.stdin, args.choice)
    elif args.secret:
        print(get_hotp_token(args.secret))
    else:
        index(sys.stdin)
