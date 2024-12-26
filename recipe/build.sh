#!/bin/bash

export DISABLE_AUTOBREW=1

mv DESCRIPTION DESCRIPTION.old
grep -va '^Priority: ' DESCRIPTION.old > DESCRIPTION

sed -i 's/-mmacosx-version-min=10.13//g' ${PREFIX}/lib/R/etc/Makeconf
export CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
# Extra configure-arg is neede because configure script expects source
# to be in a folder called "rayrender" - setting ac_unique_file to ""
# just makes it look in $SRC_DIR where the source actually resides
${R} CMD INSTALL --build . ${R_ARGS} --configure-args='ac_unique_file=""'
