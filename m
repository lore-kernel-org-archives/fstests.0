Received: from userp2130.oracle.com ([156.151.31.86]:51338 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbfDPWge (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 Apr 2019 18:36:34 -0400
Date: Tue, 16 Apr 2019 15:36:28 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH 2/2] check: wipe scratch devices between tests
Message-ID: <20190416223628.GB22015@magnolia>
References: <20190416223459.GA22015@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416223459.GA22015@magnolia>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Darrick J. Wong <darrick.wong@oracle.com>

Wipe the scratch devices in between each test to ensure that tests are
formatting them and not making assumptions about previous contents.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 check      |    6 ++++--
 common/rc  |    9 +++++++++
 common/xfs |    1 +
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/check b/check
index 5670e13b..6271d573 100755
--- a/check
+++ b/check
@@ -493,9 +493,8 @@ _check_filesystems()
 	if [ -f ${RESULT_DIR}/require_scratch ]; then
 		_check_scratch_fs || err=true
 		rm -f ${RESULT_DIR}/require_scratch*
-	else
-		_scratch_unmount 2> /dev/null
 	fi
+	_scratch_unmount 2> /dev/null
 }
 
 _expunge_test()
@@ -635,6 +634,8 @@ for section in $HOST_OPTIONS_SECTIONS; do
 	      echo "check: failed to mount \$SCRATCH_DEV using specified options"
 	      status=1
 	      exit
+	  else
+	      _scratch_unmount
 	  fi
 	fi
 
@@ -753,6 +754,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
 			# _check_dmesg depends on this log in dmesg
 			touch ${RESULT_DIR}/check_dmesg
 		fi
+		_try_wipe_scratch_devs > /dev/null 2>&1
 		if [ "$DUMP_OUTPUT" = true ]; then
 			./$seq 2>&1 | tee $tmp.out
 			# Because $? would get tee's return code
diff --git a/common/rc b/common/rc
index 6cbd6040..e0dd3797 100644
--- a/common/rc
+++ b/common/rc
@@ -3991,6 +3991,15 @@ _require_fibmap()
 	rm -f $file
 }
 
+_try_wipe_scratch_devs()
+{
+	test -x "$WIPEFS_PROG" || return 0
+
+	for dev in $SCRATCH_DEV_POOL $SCRATCH_DEV $SCRATCH_LOGDEV $SCRATCH_RTDEV; do
+		test -b $dev && $WIPEFS_PROG -a $dev
+	done
+}
+
 init_rc
 
 ################################################################################
diff --git a/common/xfs b/common/xfs
index 178acefc..4f2ead55 100644
--- a/common/xfs
+++ b/common/xfs
@@ -295,6 +295,7 @@ _require_xfs_db_command()
 	fi
 	command=$1
 
+	_scratch_mkfs_xfs >/dev/null 2>&1
 	_scratch_xfs_db -x -c "help" | grep $command > /dev/null || \
 		_notrun "xfs_db $command support is missing"
 }
