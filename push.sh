bundle exec jekyll build
if [[ $? -ne 0 ]]; then
    echo "Jekyll build failed, check"
    exit 1
fi
node gen_index.js
if [[ $? -ne 0 ]]; then
    echo "Jekyll build failed, check"
    exit 1
fi
echo -n "data = " > assets/js/index.js
cat index.json >> assets/js/index.js
echo "" >> assets/js/index.js
echo -n "documents = " >> assets/js/index.js
cat doc.json >> assets/js/index.js
