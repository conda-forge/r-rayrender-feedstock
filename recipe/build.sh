#!/bin/bash
export DISABLE_AUTOBREW=1

autoconf --force --verbose

${R} CMD INSTALL --build . ${R_ARGS}
