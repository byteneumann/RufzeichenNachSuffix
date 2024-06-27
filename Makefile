all: tables

source.pdf:
	wget -O source.pdf https://data.bundesnetzagentur.de/Bundesnetzagentur/SharedDocs/Downloads/DE/Sachgebiete/Telekommunikation/Unternehmen_Institutionen/Frequenzen/Amateurfunk/Rufzeichenliste/rufzeichenliste_afu.pdf

source.txt: source.pdf
	pdftotext source.pdf source.txt

callsigns.txt: source.txt
	grep -Eo "([A-Z]{2,2}[0-9][A-Z]{1,7})" source.txt > callsigns.txt

tables: callsigns.txt table.py
	python3 table.py '(DA[1,2,6]|DB[1-9]|DC[0-9]|DD[0-9]|DF[1-9]|DG[0-9]|DH[0-9]|DJ[0-9]|DK[1-9]|DL[1-9]|DM[1-9])[A-Z]{2,3}' > table-personal-A.md
	python3 table.py '(DA6|DO[1-9])[A-Z]{2,3}' > table-personal-E.md
	python3 table.py 'DN9[A-Z]{2,3}' > table-personal-N.md
