#!/bin/bash

cat <<'EOF' >> /etc/profile
# add lmod support
module () { 
  eval `lmod bash $*`
}
export MODULEPATH=/opt/apps/easybuild/modules/all:/opt/apps/easybuild/modules
EOF
