# Graphite Technical Test

In this Repo you can find my challenge response to technical Test

## Definition
1. Build an API using Python that takes a URL and returns the terms with the highest TF-IDF on the page.
To compute IDF use the articles in this dataset: ```https://www.kaggle.com/snapcrack/all-the-news```
The url parameters are: url and limit Example call:
```/tfidf?url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FTf-idf&limit=10```
*Example response:*
```
{
  "terms": [
    {
      "term": "term1",
      "tf-idf": 2.5
    },
    ...
  ]
}
```
Please provide instructions for running the API locally and let us know how you tested it. You may use standard and open-source libraries and you may consult online materials or books.

2. No need to actually implement this, just explain how you would do it.
How would you design a system that, in addition to computing TF-IDF counts for the provided URL upon request, updates the IDF statistics whenever TF-IDF for a previously unseen URL is requested? How would you deploy this on AWS or GCP?

## Proposed Solution

For Articles suggested I have created a kaggle notebook (https://www.kaggle.com/andresjejen/tf-idf). I only use the documents that has URL because is one requirement for API.

### Development process
  - For basic data analisys (extraction of TF) is explained in kaggle notebook.

where length(term) = 1

## How to use in Local
### Requirements
1. Docker
2. You must have port 5050 free

Instalation Process
1. Execute ```TestSetup.sh``` (Mac, Linux or Windows with GIT BASH) script.
2. Go to a terminal and execute this command (this requires that you have installed python) to test the API
```python3 test_api.py --url http://www.vox.com/videos/2017/3/24/15049292/kyuk-alaska-public-radio-trump-budget-defunding-publicmedia --limit 10```
3. Also you can test API using your Terminal but it requires you transform url to URL encoding
```curl http//localhost:5050/tfidf?url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FTf-idf&limit=10```

## Thigs to improve
1. I haven't spent too much time to api, I love clean architectures but for timing limitation.
2. Use some cache tool as redis to improve response from database.
3. Scale database instance size, now takes too much time to calculate values.
4. Maybe use another query tool that works better with indexed fields as NO-SQL or ElasticSearch.