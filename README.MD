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

## Proposed Solution

For Articles suggested I have created a kaggle notebook (https://www.kaggle.com/andresjejen/tf-idf). I only use the documents that has URL because is one requirement for API.

API development
- To acceletate api I leave some high quality actions as
  - define ORM models
  - keep configuration files
  - add cache settings
  - apply a Clean architecture strategy

This API uses FAST API library becaus is simple to create an API.
Also I commect to a remote AWS RDS Database where data created with kaggle was created.

Table bostsrap

```
create table terms (
    term TEXT NOT NULL,
    total REAL NOT NULL,
    doc TEXT NOT NULL,
    doc_total_terms REAL NOT NULL,
    tf REAL NOT NULL
);

-- Now index to improve query performance
create index url_idx on terms(doc);
create index term_idx on terms(term);
```

I decide to create index to improve query system due to high volume of data in table. almos 22MM of rows.

To import csv into RDS I use this comman inside a psql session.
```
\COPY terms FROM '/home/server/Graphite/TechnicalTest/Data/terms_doc.csv' DELIMITER ',' CSV HEADER;
```

### Development process
  - For basic data analisys (extraction of TF) is explained in kaggle notebook.

where length(term) = 1

## How to use in Local
### Requirements
1. Docker
2. You must have port 5555 free

Instalation Process
1. I provide secretly the Database Host.
2. Execute
```
DB_HOST=<VALUE PROVIDED SECRETLY> TestSetup.sh
```
(Mac, Linux or Windows with GIT BASH) script.


3. Go to a terminal and execute this command (this requires that you have installed python) to test the API.

```
python3 test_api.py --url http://www.vox.com/videos/2017/3/24/15049292/kyuk-alaska-public-radio-trump-budget-defunding-publicmedia --limit 10
```

4. Also you can test API using your Terminal but it requires you transform url to URL encoding
```
curl http//localhost:5555/tfidf?url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FTf-idf&limit=10
```

## Things to improve
1. I haven't spent too much time to api, I love clean architectures but for timing limitation.
2. Use some cache tool as redis to improve response from database.
3. Scale database instance size, now takes too much time (almost 5 mins) to calculate values.
4. Maybe use another query tool that works better with indexed fields as NO-SQL or ElasticSearch.

## Second Question
2. No need to actually implement this, just explain how you would do it.
How would you design a system that, in addition to computing TF-IDF counts for the provided URL upon request, updates the IDF statistics whenever TF-IDF for a previously unseen URL is requested? How would you deploy this on AWS or GCP?

For unseen URL's I propose this workaround

1. Scrape Wep page to get BODY.
2. With BOdy text delete punctuation and stop words.
3. Tokenize the article and apply a stemmer to every word to get specific terms.
4. Count Frecuency of all words in the article and calculate TF.
5. per term add a new row in terms table (postgres DB or specific storage system).
6. AS you can see IDF is calculated when we perform query otherwise we should update IDF for all terms in all articles.

```
So as summary (Only take text, clean it, calculate TF and store it in Storage system).
```


This Service can be deployed in several ways.
1. As Single Virtual machine instance with Python and Project Python requirements already installed, run uvicorn as deamon in second plane.
2. As Single Virtual machine instance with Docker already installed and only executing the same steps as this tutorial suggest.
3. If we have a Microservices Environment we can deploy it as a container but we must get a private container Registry (Every cloud provider has its own solution based on docker).
4. Maybe we want to deploy it as a serverless system (In this case FAST API is no needed just connection code to Database or respective storage system)
  - AWS API GATEWAY to LAMBDA with (RDS, Dynamo, Elasticsearch) ACCESS via Security groups.
  - GCP API GATEWAY to CLOUDFunction with Specific Storage Access via firewall.