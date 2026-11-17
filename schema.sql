CREATE TABLE quotations(quote_id TEXT PRIMARY KEY,project TEXT NOT NULL,quote_date TEXT,currency TEXT NOT NULL CHECK(currency IN ('USD','RMB')),original_filename TEXT NOT NULL,source_type TEXT NOT NULL,supplier_subtotal_minor INTEGER,packaging_minor INTEGER,quoted_total_minor INTEGER,subtotal_notes TEXT);

CREATE TABLE configurations(configuration_id TEXT PRIMARY KEY,category TEXT,series TEXT,operation TEXT,thermal_break TEXT,glass TEXT,width_mm INTEGER,height_mm INTEGER);

CREATE TABLE line_items(item_id TEXT PRIMARY KEY,quote_id TEXT NOT NULL,configuration_id TEXT NOT NULL,source_item TEXT,source_page INTEGER,product TEXT NOT NULL,location TEXT,technical_specifications TEXT,original_partial_specifications TEXT,spec_note TEXT,thickness TEXT,finish TEXT,hardware TEXT,width_mm INTEGER,height_mm INTEGER,unit_area_sqm REAL,quantity INTEGER,total_area_sqm REAL,unit_price_minor INTEGER,amount_minor INTEGER,currency TEXT NOT NULL,price_status TEXT NOT NULL,review_flag TEXT,FOREIGN KEY (quote_id) REFERENCES quotations(quote_id),FOREIGN KEY (configuration_id) REFERENCES configurations(configuration_id));

CREATE TABLE drawings(drawing_id TEXT PRIMARY KEY,item_id TEXT NOT NULL UNIQUE,relative_path TEXT NOT NULL,source_filename TEXT,source_page INTEGER,FOREIGN KEY (item_id) REFERENCES line_items(item_id));

CREATE INDEX idx_price_config ON line_items(configuration_id,quote_id);

CREATE INDEX idx_price_search ON line_items(product,width_mm,height_mm);

CREATE INDEX idx_quote_date ON quotations(quote_date);

CREATE VIEW unpriced_or_zero_items AS SELECT l.*,q.project,q.quote_date FROM line_items l JOIN quotations q USING(quote_id) WHERE l.unit_price_minor IS NULL OR l.unit_price_minor=0;

CREATE VIEW price_history AS SELECT l.configuration_id,l.item_id,l.product,l.currency,l.unit_price_minor,l.width_mm,l.height_mm,q.quote_date,q.quote_id,l.source_item FROM line_items l JOIN quotations q USING(quote_id) ORDER BY l.configuration_id,q.quote_date;

CREATE VIRTUAL TABLE price_keyword_search USING fts5(item_id UNINDEXED,product,location,technical_specifications,series,operation,glass);
