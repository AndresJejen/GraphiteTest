create table terms (
    term TEXT NOT NULL,
    total REAL NOT NULL,
    doc TEXT NOT NULL,
    doc_total_terms REAL NOT NULL,
    tf REAL NOT NULL
);

create index url_idx on terms(doc);
create index term_idx on terms(term);

---
-- Now using psql client I load all generated data via Kaggle
-- \COPY terms FROM '/home/server/Graphite/TechnicalTest/Data/terms_doc.csv' DELIMITER ',' CSV HEADER;