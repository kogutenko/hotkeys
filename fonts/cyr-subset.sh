#!/bin/sh

echo "Removing old subsets..."
rm -f ./ttf/*.subset.ttf

for i in  ./ttf/*.ttf; do
    echo "Generating subset for $i"
    pyftsubset --unicodes=U+0020-007E,U+0410-44F,U+0401,U+0451 $i
done

for i in ./ttf/*.subset.ttf; do
    echo "Generating WOFF for $i"
    sfnt2woff $i
    echo "Generating WOFF2 for $i"
    woff2_compress $i > /dev/null 2>&1
done

echo "Cleaning WOFF directory..."
rm -f ./woff/*.woff

echo "Moving WOFF fonts to target directory..."
mv ./ttf/*.woff ./woff/

echo "Cleaning WOFF2 directory..."
rm -f ./woff2/*.woff2

echo "Moving WOFF2 fonts to target directory..."
mv ./ttf/*.woff2 ./woff2/

echo "Cleaning subset cache..."
rm -f ./ttf/*.subset.ttf
