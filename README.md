# Ezzogenics Contractor Price Library — Public Code Distribution

This repository contains the **sanitised public code and database schema** for an offline contractor price-library interface.

## Included

- `Price_Library_Search.html`: offline browser UI with no embedded supplier records.
- `schema.sql`: SQLite tables, views, indexes, and FTS5 search definition.
- `build_database.py`: creates a new empty `Contractor_Price_Library.sqlite` database.
- `quote_items.csv` / `quote_items.json`: empty exchange formats retaining their headers/structure.
- `quote_reconciliation.csv`: empty reconciliation format.
- `verify.py`: baseline structural and asset checks.
- `HANDOVER.md`: operating boundaries and setup instructions.

## Quick start

1. Run `python3 build_database.py` once to create the empty SQLite database.
2. Run `python3 verify.py` to check the empty baseline.
3. Open `Price_Library_Search.html` in a desktop browser.

## Data and security boundary

No original quotations, supplier prices, drawings, contact details, payment details, or bank information are included. Do not commit those materials to this public repository.

This is a reference snapshot, not a production-hardened multi-user application. The HTML does not query SQLite directly; authorised data must be embedded by a separate controlled generator. Manual records are browser-local. CSV export is not a restorable backup. Do not import untrusted JSON or use the manual-entry workflow for sensitive data until import validation, output encoding, and backup/restore controls are strengthened.
