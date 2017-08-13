#! /usr/bin/env node
const {resolve} = require('path')

const {
  env: {
    POWERLEVEL9K_CUSTOM_PACKAGE_JSON_NODEVER: nodever = 'true',
    POWERLEVEL9K_CUSTOM_PACKAGE_JSON_NPMVER: npmver = 'true',
    POWERLEVEL9K_CUSTOM_PACKAGE_JSON_PKGVER: packagever = 'true',
    POWERLEVEL9K_NODE_ICON: nodeicon = 'NODE',
    POWERLEVEL9K_NPM_ICON: npmicon = 'NPM',
    POWERLEVEL9K_PACKAGE_ICON: packageicon = 'PKG',
    POWERLEVEL9K_CUSTOM_PACKAGE_JSON_DELIMITER: delimiter = ' ',
    POWERLEVEL9K_CUSTOM_PACKAGE_JSON_SUBDELIMITER: subdelimiter = ' '
  },
  cwd,
  stdout,
  version
} = require('process')

const pkgjson = resolve(cwd(), 'package.json')

require('fs').existsSync(pkgjson) && stdout.write(
  [
    {
      enable: nodever,
      icon: nodeicon,
      get: () => version
    },
    {
      enable: npmver,
      icon: npmicon,
      get: () => require('npm/package.json').version
    },
    {
      enable: packagever,
      icon: packageicon,
      get: () => require(
        require('path').resolve(cwd(), 'package.json')
      ).version
    }
  ]
    .filter(x => x.enable !== 'false')
    .map(({icon, get}) => (icon ? icon + subdelimiter : '') + get())
    .join(delimiter)
)
