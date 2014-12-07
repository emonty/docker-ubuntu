#!/bin/bash

set -e

dd of=/etc/apt/apt.conf.d/95disable-recommends << _EOF_
APT::Install-Recommends "0";
Apt::Install-Suggests "0";
_EOF_

dd of=/etc/dpkg/dpkg.cfg.d/02apt-speedup << _EOF_
force-unsafe-io
_EOF_

aptGetClean='"rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true";'

dd of=/etc/apt/apt.conf.d/no-cache << _EOF_
DPkg::Post-Invoke { ${aptGetClean} };
APT::Update::Post-Invoke { ${aptGetClean} };
Dir::Cache::pkgcache "";
Dir::Cache::srcpkgcache "";
_EOF_

dd of=/etc/apt/apt.conf.d/no-languages << _EOF_
Acquire::Languages "none";
_EOF_
