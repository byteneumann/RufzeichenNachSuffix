# RufzeichenNachSuffix

Mit diesem Code kann eine Übersicht der zugeteilten Amateurfunkrufzeichen in Deutschland, aggregiert nach Suffix, erstellt werden.

Beispielhafter Auszug aus der Tabelle für Klasse A:
| suffix  | DB         | DC         | DD         | DF         | DG         | DH         | DJ         | DK         | DL         | DM         |
| ------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- |
| A       |            |     4      |  1  4      |      5 7   |            |            |            |  123 5     |  12 456789 |  123 567   |
| B       |            |            |            |            |            |            |            |            |            |      5     |
| C       |            |            |            |        7   |            |            |            |        7   |  1   5 7   |   2345 7   |
...
| ZZM     |            |            |            |            |            |            |            |            |   2        |            |
| ZZW     |            |            |            |            |            |            |            |            |       6    |            |
| ZZZ     |            |            |            |            |            |            |          9 |            |            |            |

## Idee

Die Idee dabei ist, eine effiziente Suche nach freien Wunschrufzeichen zu ermöglichen. Man prüft die Belegung, indem man sich einen Suffix ausdenkt, zu der entsprechenden Zeile geht und dann in die Spalte(n) schaut, die der angestrebten Klasse entsprechen. Alle Ziffern, die in der eingekreisten Zelle stehen, sind bereits zugeteilt. Beispielsweise ist `DL3A` das einzige freie Delta Lima (DL) Rufzeichen, das auf `A` endet.

Alternativ oder ergänzend hierzu kann [die Amateurfunkrufzeichensuche der Bundesnetzagentur](https://ans.bundesnetzagentur.de/Amateurfunk/Rufzeichen.aspx) genutzt werden.

## Format

Es werden Markdown-Tabellen erstellt. In den Zeilen sind die Suffixe der zugeteilten Rufzeichen aufgeführt. Die Spalten entsprechen den Präfixen der Rufzeichen. Die Zellen beinhalten die Ziffern von 0 bis 9, falls das Rufzeichen `<Präfix><Ziffer><Suffix>` zugeteilt ist.

Die Tabellen lassen sich auch leicht in z.B. Excel importieren und bequemer anzeigen, wenn man die erste Zeile "fixiert".

## Ergebnisse

Die Ergebnisse **Stand 1. Juni 2024** sind hier zu sehen:
* [Klasse A](https://gist.github.com/byteneumann/4097795728b19b13be2b4df8ae5355e4)
* [Klasse E](https://gist.github.com/byteneumann/59321bddf85b3edab364c07f8ef9af10)
* ~~Klasse N~~ folgt, sobald die Quelle aktualisiert wurde.

## Ausführung

Der Code nutzt das ["Verzeichnis der zugeteilten deutschen Amateurfunkrufzeichen und ihrer Inhaber (Rufzeichenliste)"](https://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/Telekommunikation/Unternehmen_Institutionen/Frequenzen/Amateurfunk/Rufzeichenliste/rufzeichenliste_afu.html) im PDF-Format als Datenbasis. Für die weitere Verarbeitung wird zuerst der Text mit `pdftotext` extrahiert. Mit einem regulären Ausdruck werden die Rufzeichen gesucht und dann in einem Python-Skript zu mehreren Tabellen im Markdown-Format aufgearbeitet. Es muss lediglich
```
make
```
ausgeführt werden.

Zur Ausführung werden `make`, `wget`, `pdftotext`, `grep` und Python 3 benötigt.
