Received: from imap.thunk.org ([74.207.234.97]:53634 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751213AbdGPBbD (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 15 Jul 2017 21:31:03 -0400
Date: Sat, 15 Jul 2017 21:30:58 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [RFC PATCH] check: try to fix the test device if it gets
 corrupted
Message-ID: <20170716013058.r46jceccqmoedkde@thunk.org>
References: <20170302232050.31125-1-tytso@mit.edu>
 <20170303090332.GP14226@eguan.usersys.redhat.com>
 <20170303172157.GA5070@birch.djwong.org>
 <20170303230129.apzqe77r4d5jtf63@thunk.org>
 <20170327014802.wc5as2tdgecy3rzu@thunk.org>
 <20170327085103.GQ14226@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170327085103.GQ14226@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Mar 27, 2017 at 04:51:03PM +0800, Eryu Guan wrote:
> 
> Sorry I lost this thread, I thought I've replied but apparently I didn't..
> 
> I agreed with both of you and Darrick, I think we can try to repair the
> corrupted test fs, and if repair succeeds we can continue the test, and
> stop running the whole test if repair fails.

Sorry for the delay in getting back to this.  Things got busy and this
got dropped on my end.

I've fixed the whitespace nits that you pointed out and am using _log_err.

> I think we should try to fix other filesystems too?

Hmm...  yeah.  The main reason why I hadn't was because xfs has
_scratch_xfs_repair and _scratch_xfs_check, which are very similar.
But _check_xfs_test_fs looks *very* different from _scratch_xfs_check,
and I'm not sure why.

So I've created a _repair_xfs_test_fs which is modelled after the
simpler _scratch_xfs_repair function, but I'm not 100% sure that is
correct.

Anyways, WDYT?

						- Ted

>From 96a13cc22878ee5c016a606d76f8e9a6bd84eb20 Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Wed, 1 Mar 2017 19:54:08 -0500
Subject: [PATCH] check: try to fix the test device if it gets corrupted

If the test device gets corrupted all subsequent tests will fail.  To
prevent this from causing all subsequent tests to be useless, try
repair the file system on TEST_DEV if possible.  We don't need to do
this with the scratch device since that file system gets recreated
each time anyway.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 check      |  7 ++++++-
 common/rc  | 41 +++++++++++++++++++++++++++++++++++++++++
 common/xfs | 12 ++++++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/check b/check
index f8db3cd6..d89d2e91 100755
--- a/check
+++ b/check
@@ -476,7 +476,12 @@ _summary()
 _check_filesystems()
 {
 	if [ -f ${RESULT_DIR}/require_test ]; then
-		_check_test_fs || err=true
+		if ! _check_test_fs ; then
+			err=true
+			echo "Trying to repair broken TEST_DEV file system"
+			_repair_test_fs
+			_test_mount
+		fi
 		rm -f ${RESULT_DIR}/require_test*
 	fi
 	if [ -f ${RESULT_DIR}/require_scratch ]; then
diff --git a/common/rc b/common/rc
index 328b6b07..d37a1611 100644
--- a/common/rc
+++ b/common/rc
@@ -1201,6 +1201,47 @@ _repair_scratch_fs()
     esac
 }
 
+_repair_test_fs()
+{
+	case $FSTYP in
+	xfs)
+		_repair_xfs_test_fs "$@" >$tmp.repair 2>&1
+		res=$?
+		if [ "$res" -ne 0 ]; then
+			echo "xfs_repair returns $res; replay log?" >>$tmp.repair
+			_test_mount
+			res=$?
+			if [ $res -gt 0 ]; then
+				echo "mount returns $res; zap log?" >>$tmp.repair
+				_xfs_repair_test_fs -L >>$tmp.repair 2>&1
+				echo "log zap returns $?" >> $tmp.repair
+			else
+				umount "$TEST_DEV"
+			fi
+			_xfs_repair_test_fs "$@" >>$tmp.repair 2>&1
+			res=$?
+		fi
+		;;
+	*)
+		# Let's hope fsck -y suffices...
+		fsck -t $FSTYP -fy $TEST_DEV >$tmp.repair 2>&1
+		res=$?
+		if test "$res" -lt 4 ; then
+			res=0
+		fi
+		;;
+	esac
+	if [ $res -ne 0 ]; then
+		_log_err "_repair_test_fs: failed, err=$res"
+		echo "*** fsck.$FSTYP output ***"	>>$seqres.full
+		cat $tmp.repair				>>$seqres.full
+		echo "*** end fsck.$FSTYP output"	>>$seqres.full
+
+	fi
+	rm -f $tmp.repair
+	return $res
+}
+
 _get_pids_by_name()
 {
     if [ $# -ne 1 ]
diff --git a/common/xfs b/common/xfs
index a1ee3847..c8f4e46b 100644
--- a/common/xfs
+++ b/common/xfs
@@ -443,6 +443,18 @@ _check_xfs_test_fs()
 	fi
 }
 
+# modeled after _scratch_xfs_repair
+_repair_xfs_test_fs()
+{
+	TEST_OPTIONS=""
+	[ "$USE_EXTERNAL" = yes -a ! -z "$TEST_LOGDEV" ] && \
+		TEST_OPTIONS="-l$TEST_LOGDEV"
+	[ "$USE_EXTERNAL" = yes -a ! -z "$TEST_RTDEV" ] && \
+		TEST_OPTIONS=$TEST_OPTIONS" -r$TEST_RTDEV"
+	[ "$LARGE_TEST_DEV" = yes ] && TEST_OPTIONS=$TEST_OPTIONS" -t"
+	$XFS_REPAIR_PROG $TEST_OPTIONS $* $TEST_DEV
+}
+
 _require_xfs_test_rmapbt()
 {
 	_require_test
-- 
2.11.0.rc0.7.gbe5a750

