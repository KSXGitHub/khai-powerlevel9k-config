#! /usr/bin/env node
const {resolve, dirname} = require('path')
const {existsSync} = require('fs')

const {
  env: {
    POWERLEVEL9K_CUSTOM_PACKAGE_JSON_NODEVER: nodever = 'true',
    POWERLEVEL9K_CUSTOM_PACKAGE_JSON_NPMVER: npmver = 'true',
    POWERLEVEL9K_CUSTOM_PACKAGE_JSON_PKGVER: packagever = 'true',
    POWERLEVEL9K_NODE_ICON: nodeicon = 'NODE',
    POWERLEVEL9K_NPM_ICON: npmicon = 'NPM',
    POWERLEVEL9K_PACKAGE_ICON: packageicon = 'PKG',
    POWERLEVEL9K_CUSTOM_PACKAGE_JSON_DELIMITER: delimiter = ' ',
    POWERLEVEL9K_CUSTOM_PACKAGE_JSON_SUBDELIMITER: subdelimiter = ' ',
    POWERLEVEL9K_CUSTOM_PACKAGE_JSON_CHECK_PARENT: checkparent = '0'
  },
  cwd,
  stdout,
  version
} = require('process')

function getpkgjson (current, previous, steps) {
  const pkgjson = resolve(current, 'package.json')
  if (existsSync(pkgjson)) return pkgjson
  if (current !== previous && steps > 0) return getpkgjson(dirname(current), current, steps - 1)
  return null
}

const pkgjson = getpkgjson(cwd(), null, checkparent >> 0)

pkgjson && stdout.write(
  [
    {
      enable: nodever,
      icon: nodeicon,
      get: () => version
    },
    {
      enable: npmver,
      icon: npmicon,
      get: () => String(
        require('child_process').spawnSync('npm', ['--version']).stdout
      ).trim()
    },
    {
      enable: packagever,
      icon: packageicon,
      get: () => require(pkgjson).version
    }
  ]
    .filter(x => x.enable !== 'false')
    .map(({icon, get}) => (icon ? icon + subdelimiter : '') + get())
    .join(delimiter)
)
