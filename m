Received: from mx2.suse.de ([195.135.220.15]:58925 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034329AbeEXSbC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 24 May 2018 14:31:02 -0400
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 06CB0AF16
        for <fstests@vger.kernel.org>; Thu, 24 May 2018 18:31:01 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH] Make ./new work for non-root user
Date: Thu, 24 May 2018 20:30:55 +0200
Message-Id: <20180524183055.16031-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Currently 'new' script sources common/config which tries to find mkfs
and fails if not found (which is likely for non-root user). This is
inconvenient as development usually does not happen as root. In fact the
vast majority of setup in common/config and common/rc is not necessary
for 'new'. Split out the necessary bits into new common/config-base and
use it in 'new'. Cleanup common/rc and common/config now that it's only
used from 'check'.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 check              | 16 +++++-----------
 common/config      | 16 ++--------------
 common/config-base | 21 +++++++++++++++++++++
 common/rc          | 27 ++-------------------------
 new                |  2 +-
 5 files changed, 31 insertions(+), 51 deletions(-)
 create mode 100644 common/config-base

diff --git a/check b/check
index 96198ac4714e..4c6e8285bc16 100755
--- a/check
+++ b/check
@@ -331,10 +331,11 @@ while [ $# -gt 0 ]; do
 	shift
 done
 
-# we need common/config, source it after processing args, overlay needs FSTYP
-# set before sourcing common/config
-if ! . ./common/config; then
-	echo "$iam: failed to source common/config"
+# we need common/rc, that also sources common/config. We need to source it
+# after processing args, overlay needs FSTYP set before sourcing common/config
+if ! . ./common/rc
+then
+	echo "check: failed to source common/rc"
 	exit 1
 fi
 
@@ -374,13 +375,6 @@ elif [ -z "$GROUP_LIST" ]; then
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
index af360cefc804..fa07a6799824 100644
--- a/common/config
+++ b/common/config
@@ -47,6 +47,8 @@
 #   validity or mountedness.
 #
 
+. common/config-base
+
 # all tests should use a common language setting to prevent golden
 # output mismatches.
 export LANG=C
@@ -88,12 +90,6 @@ export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
 
 export RECREATE_TEST_DEV=false
 
-# $1 = prog to look for
-set_prog_path()
-{
-	type -P $1
-}
-
 # Handle mkfs.$fstyp which does (or does not) require -f to overwrite
 set_mkfs_prog_path_with_opts()
 {
@@ -132,9 +128,6 @@ export FSSTRESS_PROG="./ltp/fsstress"
 export PERL_PROG="`set_prog_path perl`"
 [ "$PERL_PROG" = "" ] && _fatal "perl not found"
 
-export AWK_PROG="`set_prog_path awk`"
-[ "$AWK_PROG" = "" ] && _fatal "awk not found"
-
 export SED_PROG="`set_prog_path sed`"
 [ "$SED_PROG" = "" ] && _fatal "sed not found"
 
@@ -271,11 +264,6 @@ fi
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
diff --git a/common/config-base b/common/config-base
new file mode 100644
index 000000000000..5d8a858160af
--- /dev/null
+++ b/common/config-base
@@ -0,0 +1,21 @@
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
+
+# $1 = prog to look for
+set_prog_path()
+{
+	type -P $1
+}
+
+export AWK_PROG="`set_prog_path awk`"
+[ "$AWK_PROG" = "" ] && _fatal "awk not found"
diff --git a/common/rc b/common/rc
index ffe5323603eb..7368e2e12988 100644
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
@@ -3560,10 +3541,6 @@ _disable_dmesg_check()
 
 init_rc()
 {
-	if [ "$iam" == new ]
-	then
-		return
-	fi
 	# make some further configuration checks here
 	if [ "$TEST_DEV" = ""  ]
 	then
diff --git a/new b/new
index 4eacccd3bf8b..2b322b2fdfb3 100755
--- a/new
+++ b/new
@@ -23,7 +23,7 @@
 
 # generic initialization
 iam=new
-. ./common/rc
+. ./common/config-base
 
 trap "rm -f /tmp/$$.; exit" 0 1 2 3 15
 
-- 
2.13.6

