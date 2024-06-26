all: tables

source.pdf:
	wget -O source.pdf https://data.bundesnetzagentur.de/Bundesnetzagentur/SharedDocs/Downloads/DE/Sachgebiete/Telekommunikation/Unternehmen_Institutionen/Frequenzen/Amateurfunk/Rufzeichenliste/rufzeichenliste_afu.pdf

source.txt: source.pdf
	pdftotext source.pdf source.txt

callsigns.txt: source.txt
	grep -Eo "([A-Z]{2,2}[0-9][A-Z]{1,7})" source.txt > callsigns.txt

tables: callsigns.txt table.py
	python3 table.py > table-all.md
	python3 table.py 'DB[1-9]|DC[1-9]|DD[1-9]|DF[1-9]|DG[1-9]|DH[1-9]|DJ[1-9]|DK[1-9]|DL[1-9]|DM[1-9]|DN9|DO[1-9]' > table-personal.md
	python3 table.py 'DB[1-9]|DC[1-9]|DD[1-9]|DF[1-9]|DG[1-9]|DH[1-9]|DJ[1-9]|DK[1-9]|DL[1-9]|DM[1-9]' > table-personal-A.md
	python3 table.py 'DO[1-9]' > table-personal-E.md
	python3 table.py 'DN9' > table-personal-N.md
