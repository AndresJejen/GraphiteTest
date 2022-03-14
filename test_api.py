import argparse
import traceback
import requests

def main(url, limit):
    params = {'url': url, 'limit': limit}
    result=requests.get(url="http://localhost:5050/tfidf",params=params)
    print(result.json())

if __name__ == "__main__":
    try:
        parser = argparse.ArgumentParser()
        parser.add_argument("--url", type=str, default=None,
                            help="URL to evaluate")

        parser.add_argument("--limit", type=int, default=10,
                            help='Select number of element I want to fetch from database')

        args = parser.parse_args()

        if args.url is None:
            print("url is needed")
        else:
            main(args.url, args.limit)
    except Exception as e:
        traceback.print_exc()