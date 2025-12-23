#!/bin/bash

export DISABLE_AUTOBREW=1

mv DESCRIPTION DESCRIPTION.old
grep -va '^Priority: ' DESCRIPTION.old > DESCRIPTION

# Don't hard-code mmacosx-version-min and add define _LIBCPP_DISABLE_AVAILABILITY
# to support newer C++ features
sed -i 's/-mmacosx-version-min=10.13//g' ${PREFIX}/lib/R/etc/Makeconf
sed -i 's/@PKG_CPPFLAGS@/@PKG_CPPFLAGS@ -D_LIBCPP_DISABLE_AVAILABILITY/' src/Makevars.in

mkdir -p ~/.R
echo -e "CC=$CC
FC=$FC
CXX=$CXX
CXX98=$CXX
CXX11=$CXX
CXX14=$CXX
CXX17=$CXX
CXX20=$CXX
CC17=$CC" > ~/.R/Makevars

# Extra configure-arg is needed because configure script expects source
# to be in a folder called "rayrender" - setting ac_unique_file to ""
# just makes it look in $SRC_DIR where the source actually resides
${R} CMD INSTALL --build . ${R_ARGS} --configure-args='ac_unique_file=""'
