from pathlib import Path
import csv, json, sqlite3
p=Path(__file__).resolve().parent
rows=list(csv.DictReader((p/'quote_items.csv').open(encoding='utf-8-sig')))
js=json.loads((p/'quote_items.json').read_text())
with sqlite3.connect(p/'Contractor_Price_Library.sqlite') as c:
    assert c.execute('PRAGMA integrity_check').fetchone()[0]=='ok'
    assert not c.execute('PRAGMA foreign_key_check').fetchall()
    assert c.execute('SELECT count(*) FROM line_items').fetchone()[0]==len(rows)==len(js)
    assert c.execute('SELECT count(*) FROM quotations').fetchone()[0]==len({r['quote_id'] for r in rows})
    assert c.execute('SELECT count(*) FROM drawings').fetchone()[0]==len(rows)
    assert c.execute('SELECT count(*) FROM configurations').fetchone()[0]==len({r['configuration_id'] for r in rows})
    assert {x[0] for x in c.execute('SELECT item_id FROM line_items')}=={r['id'] for r in rows}
for r in rows:
    assert (p/r['drawing_file']).is_file(),r['id']
    assert (p/'original_quotes'/r['source_file']).is_file(),r['id']
print(f'PASS: {len(rows)} records; database integrity, foreign keys and source/drawing paths verified.')
