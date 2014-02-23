# Author:  Lyall Jonathan Di Trapani -----------------------------------
# Lint checks the CoffeeScript code, compiles the CoffeeScript code, and
# bundles the production files into a .zip for the end-users.

coffeelint coffee/*.coffee
coffee -o js -c coffee/life.coffee
rm -f game-of-life.zip
zip game-of-life.zip js/ljd-utils.js js/life.js css/life.css \
    life.html README.markdown
