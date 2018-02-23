Received: from ipmailnode02.adl6.internode.on.net ([150.101.137.148]:53827
        "EHLO ipmailnode02.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750995AbeBWDy6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Feb 2018 22:54:58 -0500
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1ep4Rj-0000Z3-26
        for fstests@vger.kernel.org; Fri, 23 Feb 2018 14:54:55 +1100
Received: from dave by discord.disaster.area with local (Exim 4.90_1)
        (envelope-from <david@fromorbit.com>)
        id 1ep4Ri-0000NN-Un
        for fstests@vger.kernel.org; Fri, 23 Feb 2018 14:54:55 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH] common/xfs: Initialise OPTIND for getopts calls
Date: Fri, 23 Feb 2018 14:54:54 +1100
Message-Id: <20180223035454.1406-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

According to the bash man page:

	OPTIND is initialized to 1 each time the shell or a shell
	script is invoked.

This doesn't appear to be true - in tests scripts with no other
getopts calls, I'm seeing the getopts loop in _xfs_check to fail
to parse input parameters correctly. Tracing shows the parameters
are being passed to _xfs_check correctly, but on occassion getopts
simply doesn't see the,

Hence when running tests with both external log and real time
devices, tests are failing at random because xfs_check is
mis-parsing the parameters passed to it and not configuring the
external log correctly:

_check_xfs_filesystem: filesystem on /dev/sdg is inconsistent (c)
*** xfs_check output ***
aborting - no external log specified for FS with an external log
*** end xfs_check output

Fix this by ensuring OPTIND is correctly initialised before using
getopts. Do it for all places that call getopts that don't already
set OPTIND=1 before starting their parsing loop.

Signed-Off-By: Dave Chinner <dchinner@redhat.com>
---
 common/xfs        | 1 +
 tests/generic/074 | 1 +
 tests/generic/075 | 1 +
 tests/generic/112 | 1 +
 4 files changed, 4 insertions(+)

diff --git a/common/xfs b/common/xfs
index 2cb77778831a..2aff1b3bcb5c 100644
--- a/common/xfs
+++ b/common/xfs
@@ -119,6 +119,7 @@ _xfs_check()
 	DBOPTS=" "
 	USAGE="Usage: xfs_check [-fsvV] [-l logdev] [-i ino]... [-b bno]... special"
 
+	OPTIND=1
 	while getopts "b:fi:l:stvV" c; do
 		case $c in
 			s) OPTS=$OPTS"-s ";;
diff --git a/tests/generic/074 b/tests/generic/074
index 5f205b509eb6..d39f9a3d4309 100755
--- a/tests/generic/074
+++ b/tests/generic/074
@@ -87,6 +87,7 @@ _usage()
 
 _process_args()
 {
+    OPTIND=1
     while getopts "f:l:n:?" c $@
     do
         case $c
diff --git a/tests/generic/075 b/tests/generic/075
index 321c72177618..e9dd4a5c5dcd 100755
--- a/tests/generic/075
+++ b/tests/generic/075
@@ -98,6 +98,7 @@ _usage()
 
 _process_args()
 {
+    OPTIND=1
     while getopts "l:n:N:?" c $@
     do
         case $c
diff --git a/tests/generic/112 b/tests/generic/112
index 0ab1c8c87907..5ab1cb3ad4ca 100755
--- a/tests/generic/112
+++ b/tests/generic/112
@@ -94,6 +94,7 @@ _usage()
 
 _process_args()
 {
+    OPTIND=1
     while getopts "l:n:N:?" c $@
     do
         case $c
-- 
2.16.1

