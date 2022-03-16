from sqlalchemy import create_engine
import os

DB_INFO="test_graphite"
DB_HOST=os.getenv("DB_HOST")

QUERY = """
with tf as (
	select
		term,
		tf
	from terms
	where doc = '{url}'
)
, docs as (
	select
		count(distinct doc) as total_docs
	from terms
	where 1=1
)
, idf as (
	select
		term,
		count(1) as total
	from terms
	where 1=1
		and term in (select term from tf)
	group by 1
)
select
	tf.term
	,tf.tf*log(docs.total_docs/idf.total) as tf_idf
from tf
	left join idf
		on idf.term = tf.term
	left join docs
		on 1=1
order by 2 DESC
LIMIT {limit}
"""

def execute_query(url, limit):
    engine = create_engine(f"postgresql+psycopg2://{DB_INFO}:{DB_INFO}@{DB_HOST}/{DB_INFO}")
    with engine.connect() as con:
        rs = con.execute(QUERY.format(url=url, limit=limit))
        #rs = con.execute(text("select 'Hello' as term, 1 as value"))
        results = []
        for row in rs:
            results.append({"term": row["term"], "tf-idf": row["tf_idf"]})
        return {"terms": results}

