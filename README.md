# RufzeichenNachSuffix

Mit diesem Code kann eine Übersicht der zugeteilten Amateurfunkrufzeichen in Deutschland, aggregiert nach Suffix, erstellt werden.

Beispielhafter Auszug aus der Tabelle für Klasse A:
| suffix  | DA         | DB         | DC         | DD         | DF         | DG         | DH         | DJ         | DK         | DL         | DM         |
| ------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- |
| AA      |  1         |  1 345 7 9 |  1 3456  9 | 01 3456789 |  1234  78  |  1 3 5678  | 012    7   |  1 3 5     |  1234 6 89 |  123456789 |  123 567   |
| AB      |  1         |  1234567   | 01234  789 | 01 345 789 |  1 345 789 |  12345678  |  123456  9 |  12345 78  |  123456789 |  123456789 |  1234    9 |
| AC      |  1         |  123  6 8  | 01234567 9 | 0  34  7   |   2345 78  | 012 4  78  |  1      89 | 01 34 6    |  1  456789 |  1 3456789 |  1  45     |
...
| ZZM     |            |            |            |            |            |            |            |            |            |   2        |            |
| ZZW     |            |            |            |            |            |            |            |            |            |       6    |            |
| ZZZ     |            |            |            |            |            |            |            |          9 |            |            |            |

## Idee

Die Idee dabei ist, eine effiziente Suche nach freien Wunschrufzeichen zu ermöglichen. Man prüft die Belegung, indem man sich einen Suffix ausdenkt, zu der entsprechenden Zeile geht und dann in die Spalte(n) schaut, die der angestrebten Klasse entsprechen. Alle Ziffern, die in der eingekreisten Zelle stehen, sind bereits zugeteilt. Beispielsweise ist `DD2AA` das einzige freie Delta Delta (`DD`) Rufzeichen, das auf `AA` endet.

Alternativ oder ergänzend hierzu kann [die Amateurfunkrufzeichensuche der Bundesnetzagentur](https://ans.bundesnetzagentur.de/Amateurfunk/Rufzeichen.aspx) genutzt werden.

## Format

Es werden Markdown-Tabellen erstellt. In den Zeilen sind die Suffixe der zugeteilten Rufzeichen aufgeführt. Die Spalten entsprechen den Präfixen der Rufzeichen. Die Zellen beinhalten die Ziffern von 0 bis 9, falls das Rufzeichen `<Präfix><Ziffer><Suffix>` zugeteilt ist.

Die Tabellen lassen sich auch leicht in z.B. Excel importieren und bequemer anzeigen, wenn man die erste Zeile "fixiert".

## Ergebnisse

Es liegt das [Verzeichnis mit Stand vom 1. Juni 2024](https://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/Telekommunikation/Unternehmen_Institutionen/Frequenzen/Amateurfunk/Rufzeichenliste/rufzeichenliste_afu.html) zu Grunde.
Die Filterung nach Rufzeichenklassen basiert auf dem [Rufzeichenplan](https://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/Telekommunikation/Unternehmen_Institutionen/Frequenzen/Amateurfunk/AmtsblattverfuegungenAFu/Rufzeichenplan_06-24_Auszug_aus_Vfg_61_2024.pdf?__blob=publicationFile&v=6), der seit 24. Juni 2024 gilt.
Die Ergebnisse für personengebundene Rufzeichen sind hier zu sehen:
* [Klasse A](https://gist.github.com/byteneumann/4097795728b19b13be2b4df8ae5355e4)
* [Klasse E](https://gist.github.com/byteneumann/59321bddf85b3edab364c07f8ef9af10)
* ~~Klasse N~~ folgt, sobald das Verzeichnis aktualisiert wurde.

## Ausführung

Der Code nutzt das ["Verzeichnis der zugeteilten deutschen Amateurfunkrufzeichen und ihrer Inhaber (Rufzeichenliste)"](https://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/Telekommunikation/Unternehmen_Institutionen/Frequenzen/Amateurfunk/Rufzeichenliste/rufzeichenliste_afu.html) im PDF-Format als Datenbasis. Für die weitere Verarbeitung wird zuerst der Text mit `pdftotext` extrahiert. Mit einem regulären Ausdruck werden die Rufzeichen gesucht und dann in einem Python-Skript nach Filterung anhand vom Rufzeichenplan zu mehreren Tabellen im Markdown-Format aufgearbeitet. Es muss lediglich
```
make
```
ausgeführt werden.

Zur Ausführung werden `make`, `wget`, `pdftotext`, `grep` und Python 3 benötigt.
