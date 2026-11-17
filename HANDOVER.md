# Public Sanitised Handover

## Scope

This public repository distributes generic interface code, an empty database schema, and empty exchange files. It is not a populated price library and contains no authoritative commercial data.

## Setup

Run `python3 build_database.py`, then `python3 verify.py`. Open `Price_Library_Search.html` directly in a desktop browser for the offline interface shell.

## Maintenance boundary

The HTML reads embedded JavaScript data, not the SQLite file. A controlled generator must embed authorised sanitised records before the UI will display them. No PDF ingestion or snapshot-generation pipeline is included.

Keep real quotations, costs, personal/contact details, payment details, drawings, and credentials in a separately authorised private location. Never upload the full backup archive to this repository.

## Known limitations

The reference UI requires security hardening before processing untrusted imports or sensitive manual entries. Its browser-local storage is not a database backup, and filtered CSV export cannot be restored through the JSON importer.
