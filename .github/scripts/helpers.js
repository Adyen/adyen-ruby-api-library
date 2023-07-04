exports.getRubyVersion = () => {
    const fs = require('fs');
    const re = /VERSION = '(\d+.\d+.\d+)'/;
    data = fs.readFileSync("lib/adyen/version.rb", 'utf-8');
    version = data.match(re)[1];
    return version;
}

// Update version in settings 
exports.updateRubyVersion = async (version) => {
  const fs = require('fs');
  data = fs.readFileSync('lib/adyen/version.rb', 'utf-8');
  newVersion = data.replace(/(VERSION = )'(\d+.\d+.\d+)'/, "$1" + "'" + version +"'");
  fs.writeFileSync('lib/adyen/version.rb', newVersion, 'utf-8');
}