bundle exec jekyll build --future
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
rm index.json doc.json
rm -rf _site
git add assets/js/index.js
git commit -m 'add index.js'
git push
