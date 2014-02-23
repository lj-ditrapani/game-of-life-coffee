# Author:  Lyall Jonathan Di Trapani -----------------------------------
# Lint checks the CoffeeScript code, compiles the CoffeeScript code, and
# bundles the production files into a .zip for the end-users.

coffeelint coffee/*.coffee
coffee -o js -c coffee/life.coffee coffee/cell.coffee
rm -f life.zip
zip life.zip js/ljd-utils.js js/cell.js js/life.js css/life.css \
    life.html README.markdown
