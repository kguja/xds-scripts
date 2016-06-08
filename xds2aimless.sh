#!/bin/sh
[ -f XDS_ASCII.HKL ] && pointless xdsin XDS_ASCII.HKL hklout XDS_ASCII.mtz | tee pointless.log
#[ -f XDS_ASCII.HKL ] && pointless -copy xdsin XDS_ASCII.HKL hklout XDS_ASCII.mtz | tee pointless.log
wait
[ -f XDS_ASCII.mtz ] && aimless hklin XDS_ASCII.mtz hklout data_scaled.mtz | tee aimless.log
wait
[ -f data_scaled.mtz ] && truncate hklin data_scaled.mtz hklout data_truncated.mtz > truncate.log <<EOF
anomalous yes
nresidue   1049
labout  F=FP SIGF=SIGFP DANO=DANO SIGDANO=SIGDANO
EOF
wait
[ -f FRAME.cbf ] && xds-viewer FRAME.cbf
[ -f pointless.log ] && logview pointless.log
[ -f aimless.log ] && logview aimless.log
[ -f truncate.log ] && logview truncate.log
[ -f data_truncated.mtz ] && viewhkl data_truncated.mtz
