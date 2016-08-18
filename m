Received: from cn.fujitsu.com ([59.151.112.132]:27520 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753542AbcHRDMe (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 17 Aug 2016 23:12:34 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v3] xfs/191: skip tests on older xfsprogs
Date: Thu, 18 Aug 2016 11:09:16 +0800
Message-ID: <1471489756-7659-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20160818010410.GB22388@dastard>
References: <20160818010410.GB22388@dastard>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com
Cc: fstests@vger.kernel.org, jtulak@redhat.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

If we don't have temp file used to test on xfsprogs 3.2.2,
_require_xfs_mkfs_validation will fail because mkfs.xfs can't
create this file.  We need to skip tests before xfsprogs 4.7.0,
so fix it.  the feature has been introduced since xfsprogs 4.2.0:
  Commit 20cec860e16b267ea0c71a2f648fa2b26aad2e65
  Author: Eric Sandeen <sandeen@sandeen.net>
  Date: Fri Jul 31 09:04:11 2015 +1000
    mkfs.xfs: always use underlying fs sector size when mkfs'ing a file

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/common/rc b/common/rc
index b19b698..b716d26 100644
--- a/common/rc
+++ b/common/rc
@@ -3887,21 +3887,25 @@ _get_fs_sysfs_attr()
 #
 # At first, make a common function that runs the tests and returns
 # number of failed cases.
-_mkfs_validation_check()
+_xfs_mkfs_validation_check()
 {
-	local cmd="$MKFS_XFS_PROG -f -N -d file,name=/tmp/foo,size=$((1024 * 1024 * 1024))"
+	local tmpfile=`mktemp`
+	local cmd="$MKFS_XFS_PROG -f -N -d file,name=$tmpfile,size=1g"
+
 	$cmd -s size=2s >/dev/null 2>&1
 	local sum=$?
-	$cmd -l version=2,su=$((256 * 1024 + 4096)) >/dev/null 2>&1
+
+	$cmd -l version=2,su=260k >/dev/null 2>&1
 	sum=`expr $sum + $?`
-	rm -f /tmp/foo
+
+	rm -f $tmpfile
 	return $sum
 }
 
 # Skip the test if all calls passed - mkfs accepts invalid input
 _require_xfs_mkfs_validation()
 {
-	_mkfs_validation_check
+	_xfs_mkfs_validation_check
 	if [ "$?" -eq 0 ]; then
 		_notrun "Requires newer mkfs with stricter input checks: the oldest supported version of xfsprogs is 4.7."
 	fi
@@ -3910,7 +3914,7 @@ _require_xfs_mkfs_validation()
 # The oposite of _require_xfs_mkfs_validation.
 _require_xfs_mkfs_without_validation()
 {
-	_mkfs_validation_check
+	_xfs_mkfs_validation_check
 	if [ "$?" -ne 0 ]; then
 		_notrun "Requires older mkfs without strict input checks: the last supported version of xfsprogs is 4.5."
 	fi
-- 
1.8.3.1



