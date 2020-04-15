#
# INPUT CONVERTERS
#

# csv -> glm
dist_pkgdata_DATA += gldcore/converters/csv2glm.py
dist_pkgdata_DATA += gldcore/converters/csv-ceus2glm-ceus.py
dist_pkgdata_DATA += gldcore/converters/csv-ami2glm-rbsa.py
dist_pkgdata_DATA += gldcore/converters/csv-ami2glm-ceus.py
dist_pkgdata_DATA += gldcore/converters/csv-scada2glm-rbsa.py
dist_pkgdata_DATA += gldcore/converters/csv-scada2glm-ceus.py
dist_pkgdata_DATA += gldcore/converters/csv-ica2glm-ica.py

# mdb -> glm
dist_pkgdata_DATA += gldcore/converters/mdb2glm.py
dist_pkgdata_DATA += gldcore/converters/mdb-cyme2glm.py

# omd -> glm
dist_pkgdata_DATA += gldcore/converters/omd2glm.py

# txt -> glm
dist_pkgdata_DATA += gldcore/converters/txt2glm.py
dist_pkgdata_DATA += gldcore/converters/txt-cyme2glm.py

# zip -> glm
dist_pkgdata_DATA += gldcore/converters/zip2glm.py

#
# OUTPUT CONVERTERS
#

# glm-> omd
dist_pkgdata_DATA += gldcore/converters/glm2omd.py

# json -> csv
dist_pkgdata_DATA += gldcore/converters/json2csv.py
dist_pkgdata_DATA += gldcore/converters/json2csv-profile.py

# json -> glm
dist_pkgdata_DATA += gldcore/converters/json2glm.py

# json -> png
dist_pkgdata_DATA += gldcore/converters/json2png.py
dist_pkgdata_DATA += gldcore/converters/json2png-oneline.py

# json -> txt
dist_pkgdata_DATA += gldcore/converters/json2txt.py

# json -> zip
dist_pkgdata_DATA += gldcore/converters/json2zip.py
