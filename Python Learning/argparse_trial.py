# -*- coding: utf-8 -*
import argparse


def argparse_test():
    parse = argparse.ArgumentParser()

    parse.add_argument("--bool", help="Whether to pirnt sth")
    parse.add_argument("--rate", type=float, default=0.01, help="initial rate")
    parse.add_argument("--choice", choices=(0, 1), help="you can only input 0 or 1.")
    parse.add_argument("--need", required=True, help="give it a value")

    args = parse.parse_args()
    if args.bool:
        print("bool: ", args.bool)
    if args.rate:
        print("rate: ", args.rate)
    if args.choice:
        print("choice: ", args.choice)
    if args.need:
        print("need: ", args.need)

    # http://vra.github.io/2017/12/02/argparse-usage/


if __name__ == '__main__':
    print(float(1 < 2))

