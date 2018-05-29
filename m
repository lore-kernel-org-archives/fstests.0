Received: from mx2.suse.de ([195.135.220.15]:38876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936850AbeE2Qve (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 May 2018 12:51:34 -0400
From: Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] Make ./new work for non-root user
Date: Tue, 29 May 2018 18:51:19 +0200
Message-Id: <20180529165119.31961-2-jack@suse.cz>
In-Reply-To: <20180529165119.31961-1-jack@suse.cz>
References: <20180529165119.31961-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Currently 'new' script sources common/config which tries to find mkfs
and fails if not found (which is likely for non-root user). This is
inconvenient as development usually does not happen as root. In fact the
vast majority of setup in common/config and common/rc is not necessary
for 'new'. Split out the necessary bits into new common/config-base and
use it in 'new'. Cleanup common/rc and common/config now that they're
only used from 'check' and 'setup'.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 check             | 15 ++++-----------
 common/config     |  7 ++-----
 common/rc         | 27 ++-------------------------
 common/test_names | 12 ++++++++++++
 new               |  5 ++++-
 5 files changed, 24 insertions(+), 42 deletions(-)
 create mode 100644 common/test_names

diff --git a/check b/check
index f6fb352bcbb9..a8cb7289b320 100755
--- a/check
+++ b/check
@@ -331,10 +331,10 @@ while [ $# -gt 0 ]; do
 	shift
 done
 
-# we need common/config, source it after processing args, overlay needs FSTYP
-# set before sourcing common/config
-if ! . ./common/config; then
-	echo "$iam: failed to source common/config"
+# we need common/rc, that also sources common/config. We need to source it
+# after processing args, overlay needs FSTYP set before sourcing common/config
+if ! . ./common/rc; then
+	echo "check: failed to source common/rc"
 	exit 1
 fi
 
@@ -374,13 +374,6 @@ elif [ -z "$GROUP_LIST" ]; then
 	GROUP_LIST="auto"
 fi
 
-# we need common/rc
-if ! . ./common/rc
-then
-    echo "check: failed to source common/rc"
-    exit 1
-fi
-
 if [ `id -u` -ne 0 ]
 then
     echo "check: QA must be run as root"
diff --git a/common/config b/common/config
index ccfb066ebe95..51380231aed3 100644
--- a/common/config
+++ b/common/config
@@ -47,6 +47,8 @@
 #   validity or mountedness.
 #
 
+. common/test_names
+
 # all tests should use a common language setting to prevent golden
 # output mismatches.
 export LANG=C
@@ -268,11 +270,6 @@ fi
 rm -f /tmp/crc_check.img
 export XFS_MKFS_HAS_NO_META_SUPPORT
 
-# new doesn't need config file parsed, we can stop here
-if [ "$iam" == "new" ]; then
-	return 0
-fi
-
 _mount_opts()
 {
 	case $FSTYP in
diff --git a/common/rc b/common/rc
index 52b128982e98..9273ff75c9dc 100644
--- a/common/rc
+++ b/common/rc
@@ -20,18 +20,9 @@
 #  Mountain View, CA 94043, USA, or: http://www.sgi.com
 #-----------------------------------------------------------------------
 
-BC=$(which bc 2> /dev/null) || BC=
+. common/config
 
-# Valid test names start with 3 digits "NNN":
-#  "[0-9]\{3\}"
-# followed by an optional "-":
-#  "-\?"
-# followed by an optional combination of alphanumeric and "-" chars:
-#  "[[:alnum:]-]*"
-# e.g. 999-the-mark-of-fstests
-#
-VALID_TEST_ID="[0-9]\{3\}"
-VALID_TEST_NAME="$VALID_TEST_ID-\?[[:alnum:]-]*"
+BC=$(which bc 2> /dev/null) || BC=
 
 # Some tests are not relevant or functional when testing XFS realtime
 # subvolumes along with the rtinherit=1 mkfs option.  In these cases,
@@ -110,16 +101,6 @@ _ls_l()
 	ls -l $* | sed "s/\(^[-rwxdlbcpsStT]*\)\. /\1 /" | grep -v 'lost+found'
 }
 
-# we need common/config
-if [ "$iam" != "check" ]
-then
-    if ! . ./common/config
-        then
-        echo "$iam: failed to source common/config"
-        exit 1
-    fi
-fi
-
 _dump_err()
 {
     _err_msg="$*"
@@ -3574,10 +3555,6 @@ _disable_dmesg_check()
 
 init_rc()
 {
-	if [ "$iam" == new ]
-	then
-		return
-	fi
 	# make some further configuration checks here
 	if [ "$TEST_DEV" = ""  ]
 	then
diff --git a/common/test_names b/common/test_names
new file mode 100644
index 000000000000..98af40cdbd85
--- /dev/null
+++ b/common/test_names
@@ -0,0 +1,12 @@
+##/bin/bash
+
+# Valid test names start with 3 digits "NNN":
+#  "[0-9]\{3\}"
+# followed by an optional "-":
+#  "-\?"
+# followed by an optional combination of alphanumeric and "-" chars:
+#  "[[:alnum:]-]*"
+# e.g. 999-the-mark-of-fstests
+#
+VALID_TEST_ID="[0-9]\{3\}"
+VALID_TEST_NAME="$VALID_TEST_ID-\?[[:alnum:]-]*"
diff --git a/new b/new
index 4eacccd3bf8b..112a63d5b9f8 100755
--- a/new
+++ b/new
@@ -23,7 +23,7 @@
 
 # generic initialization
 iam=new
-. ./common/rc
+. ./common/test_names
 
 trap "rm -f /tmp/$$.; exit" 0 1 2 3 15
 
@@ -81,6 +81,9 @@ line=0
 eof=1
 [ -f "$tdir/group" ] || usage
 
+export AWK_PROG="$(type -P awk)"
+[ "$AWK_PROG" = "" ] && { echo "awk not found"; exit; }
+
 for found in `cat $tdir/group | tr - ' ' | $AWK_PROG '{ print $1 }'`
 do
     line=$((line+1))
-- 
2.13.6

