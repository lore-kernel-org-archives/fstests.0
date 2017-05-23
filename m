Received: from mx2.suse.de ([195.135.220.15]:36550 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966481AbdEWOQo (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 23 May 2017 10:16:44 -0400
From: Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2] xfs: Make 'man' hard requirement for xfs/293
Date: Tue, 23 May 2017 17:16:40 +0300
Message-Id: <1495549000-30608-1-git-send-email-nborisov@suse.com>
In-Reply-To: <20170523140156.GD7250@eguan.usersys.redhat.com>
References: <20170523140156.GD7250@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org, Nikolay Borisov <nborsiov@suse.com>, Nikolay Borisov <nborisov@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Nikolay Borisov <nborsiov@suse.com>

If xfs/293 is run on a system which doesn't have 'man' installed
it will hang the due to $CAT waiting for input indefinitely. Also
create an entry for $MAN_PROG and use the cached $MANPAGE instead
of repeatedy calling $MAN_PROG --page

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 common/config | 1 +
 tests/xfs/293 | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/common/config b/common/config
index 8211356c..eb5b36b0 100644
--- a/common/config
+++ b/common/config
@@ -196,6 +196,7 @@ export XZ_PROG="`set_prog_path xz`"
 export FLOCK_PROG="`set_prog_path flock`"
 export LDD_PROG="`set_prog_path ldd`"
 export TIMEOUT_PROG="`set_prog_path timeout`"
+export MAN_PROG="`set_prog_path man`"
 
 # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
 # newer systems have udevadm command but older systems like RHEL5 don't.
diff --git a/tests/xfs/293 b/tests/xfs/293
index df44e98e..24b0a992 100755
--- a/tests/xfs/293
+++ b/tests/xfs/293
@@ -40,15 +40,18 @@ _cleanup()
 . ./common/rc
 . ./common/filter
 
+
 # real QA test starts here
 
 # Modify as appropriate.
 _supported_fs xfs
 _supported_os IRIX Linux
 
+_require_command man man
+
 echo "Silence is golden"
 
-MANPAGE=`man --path xfs_io`
+MANPAGE=`$MAN_PROG --path xfs_io`
 
 case "$MANPAGE" in
 *.gz|*.z\|*.Z)	CAT=zcat;;
@@ -60,7 +63,7 @@ esac
 _require_command `which $CAT` $CAT
 
 for COMMAND in `$XFS_IO_PROG -c help | awk '{print $1}' | grep -v "^Use"`; do
-  $CAT `man --path xfs_io` | egrep -q "^\.B.*$COMMAND" || \
+  $CAT "$MANPAGE" | egrep -q "^\.B.*$COMMAND" || \
 	echo "$COMMAND not documented in the xfs_io manpage"
 done
 
-- 
2.12.3

