#!/bin/bash
set -vx
#find ./ -type f "*.java" -exec perl -p -i -e 's!FBReaderMolitfelnic.ORG!FBReader.ORG!g' {} +
#git clone -b bibliotecaortodoxa --single-branch https://github.com/aplicatii-romanesti/FBReader-Android-2.git
#git checkout -b molitfelnic bibliotecaortodoxa

# SETUP:
NEWAPP_CAMEL=${1:-BibliotecaOrtodoxa}   #Molitfelnic #${NEWAPP_CAMEL} # NO SPACES !!!
NEWAPP_SMALL=$(echo $NEWAPP_CAMEL | tr '[:upper:]' '[:lower:]' )   #molitfelnic #${NEWAPP_SMALL}
NEWAPP_NAME=$NEWAPP_CAMEL
NEWAPP_NAME="Biblioteca Ortodoxa"
NEWAPP_SEARCH_HINT=$NEWAPP_CAMEL
NEWAPP_SEARCH_HINT="Ioan Rusu"
###

# Make sure we are in the right directory:
cd ..
pwd
if [[ ! -r .gitignore ]]; then
	echo "Not in the right directory... ; Call me from scripts directory of the molitfelnic branch "
	exit
fi

# STEP 0: Make sure we have the png icons avaialble
echo " STEP 0: Make sure we have the png icons avaialble"
if [[ ! -r ${ICONS_BASE_DIR}/${NEWAPP_CAMEL}/drawable-hdpi/fbreader.png ]]; then
	echo "Could not find the icons in: ${ICONS_BASE_DIR}/${NEWAPP_CAMEL}/drawable-hdpi/fbreader.png " && exit 1
else
	cp -rpf ${ICONS_BASE_DIR}/${NEWAPP_CAMEL}/drawable-*dpi ./fbreader/app/src/main/res/
fi

# STEP 1: Replace inside files:
echo "STEP 1: Replace inside files:"
ALL_FILES=$(find ./ -type f \( -iname \*.java -o -iname \*.xml -o -iname \*.gradle -o -iname \*.properties \) )

perl -p -i -e "s^molitfelnic^${NEWAPP_SMALL}^g" $ALL_FILES
perl -p -i -e "s^Molitfelnic^${NEWAPP_CAMEL}^g" $ALL_FILES

echo "STEP 2: Replace application name and its search hint"
# STEP 2: Replace application name and its search hint
cat <<EOF >fbreader/app/src/main/res/values/strings.xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
  <string name="app_name">${NEWAPP_NAME}</string>
  <string name="search_hint">${NEWAPP_SEARCH_HINT}</string>
</resources>

EOF

echo "STEP 3: Replace names of files and folders:"
# STEP 3: Replace names of files and folders:
git mv fbreader/app/src/main/java/org/geometerplus/zlibrary/ui/android/aplicatii/romanesti_molitfelnic/ fbreader/app/src/main/java/org/geometerplus/zlibrary/ui/android/aplicatii/romanesti_${NEWAPP_SMALL}/

git mv fbreader/app/src/main/java/org/nicolae/search_molitfelnic/ fbreader/app/src/main/java/org/nicolae/search_${NEWAPP_SMALL}/

git mv fbreader/common/src/main/java/org/geometerplus/zlibrary/ui/android/aplicatii/romanesti_molitfelnic/ fbreader/common/src/main/java/org/geometerplus/zlibrary/ui/android/aplicatii/romanesti_${NEWAPP_SMALL}/

git mv fbreader/app/src/main/java/org/geometerplus/android/fbreader/FBReaderApplicationMolitfelnic.java fbreader/app/src/main/java/org/geometerplus/android/fbreader/FBReaderApplication${NEWAPP_CAMEL}.java

git mv fbreader/app/src/main/java/org/geometerplus/android/fbreader/FBReaderMolitfelnic.java fbreader/app/src/main/java/org/geometerplus/android/fbreader/FBReader${NEWAPP_CAMEL}.java

echo "Sanity 1"
grep Application fbreader/app/src/main/java/org/geometerplus/android/fbreader/FBReaderApplication${NEWAPP_CAMEL}.java

echo "Sanity 2"
grep Application fbreader/app/src/main/java/org/geometerplus/android/fbreader/FBReader${NEWAPP_CAMEL}.java

echo "${0} finished at `date`"
echo "git branch $NEWAPP_SMALL"
############# aplicatii.romanesti to molitfelnic:
# mv fbreader/app/src/main/java/org/geometerplus/android/fbreader/FBReaderApplicationMolitfelnic.java fbreader/app/src/main/java/org/geometerplus/android/fbreader/FBReaderApplication.java
# git mv fbreader/app/src/main/java/org/geometerplus/android/fbreader/FBReaderApplication.java fbreader/app/src/main/java/org/geometerplus/android/fbreader/FBReaderApplicationMolitfelnic.java

# mv fbreader/app/src/main/java/org/geometerplus/android/fbreader/FBReaderMolitfelnic.java fbreader/app/src/main/java/org/geometerplus/android/fbreader/FBReader.java
# git mv fbreader/app/src/main/java/org/geometerplus/android/fbreader/FBReader.java fbreader/app/src/main/java/org/geometerplus/android/fbreader/FBReaderMolitfelnic.java

# rm -rf fbreader/app/src/main/java/org/nicolae/test/
# mv fbreader/app/src/main/java/org/nicolae/search_molitfelnic/ fbreader/app/src/main/java/org/nicolae/test/
# git mv fbreader/app/src/main/java/org/nicolae/test/ fbreader/app/src/main/java/org/nicolae/search_molitfelnic/

# rm -rf fbreader/app/src/main/java/org/geometerplus/zlibrary/ui/android/aplicatii/romanesti/
# mv fbreader/app/src/main/java/org/geometerplus/zlibrary/ui/android/aplicatii/romanesti_molitfelnic/ fbreader/app/src/main/java/org/geometerplus/zlibrary/ui/android/aplicatii/romanesti/
# git mv fbreader/app/src/main/java/org/geometerplus/zlibrary/ui/android/aplicatii/romanesti/ fbreader/app/src/main/java/org/geometerplus/zlibrary/ui/android/aplicatii/romanesti_molitfelnic/

# rm -rf fbreader/common/src/main/java/org/geometerplus/zlibrary/ui/android/aplicatii/romanesti/
# mv fbreader/common/src/main/java/org/geometerplus/zlibrary/ui/android/aplicatii/romanesti_molitfelnic/ fbreader/common/src/main/java/org/geometerplus/zlibrary/ui/android/aplicatii/romanesti/
# git mv fbreader/common/src/main/java/org/geometerplus/zlibrary/ui/android/aplicatii/romanesti/ fbreader/common/src/main/java/org/geometerplus/zlibrary/ui/android/aplicatii/romanesti_molitfelnic/


# ###
# git checkout fbreader/common/src/main/java/org/geometerplus/fbreader/Paths.java
# git checkout fbreader/app/src/main/java/org/geometerplus/android/fbreader/network/BookDownloader.java

