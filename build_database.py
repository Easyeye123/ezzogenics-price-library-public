from pathlib import Path
import sqlite3

root = Path(__file__).resolve().parent
database = root / "Contractor_Price_Library.sqlite"
if database.exists():
    raise SystemExit("Refusing to overwrite an existing database. Move it aside first.")
with sqlite3.connect(database) as connection:
    connection.executescript((root / "schema.sql").read_text(encoding="utf-8"))
    connection.execute("PRAGMA foreign_keys = ON")
    assert connection.execute("PRAGMA integrity_check").fetchone()[0] == "ok"
print(f"Created empty database: {database.name}")
