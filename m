Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:29304 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401AbaFXNhE (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 24 Jun 2014 09:37:04 -0400
From: Lukas Czerner <lczerner@redhat.com>
Subject: [PATCH 2/2] xfstests: Check fs consistency on TEST_DEV only when needed
Date: Tue, 24 Jun 2014 15:36:54 +0200
Message-Id: <1403617014-17870-2-git-send-email-lczerner@redhat.com>
In-Reply-To: <1403617014-17870-1-git-send-email-lczerner@redhat.com>
References: <1403617014-17870-1-git-send-email-lczerner@redhat.com>
Sender: xfstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com, Lukas Czerner <lczerner@redhat.com>
List-ID: <fstests@vger.kernel.org>

Currently we're checking file system consistency on TEST_DEV after every
successful test run even though the TEST_DEV might not even be used in
that test.

Fix it by checking for number of write io on TEST_DEV device before the
test and compare it with the value after the test.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 check     |  6 +++++-
 common/rc | 11 +++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/check b/check
index 40f99d7..66d0f72 100755
--- a/check
+++ b/check
@@ -544,6 +544,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		rm -f core $seqres.notrun
 
 		scratch_atime=`stat -c %X $SCRATCH_DEV`
+		test_write_io=`_get_write_io_count $TEST_DEV`
 		start=`_wallclock`
 		$timestamp && echo -n "	["`date "+%T"`"]"
 		[ ! -x $seq ] && chmod u+x $seq # ensure we can run it
@@ -626,7 +627,10 @@ for section in $HOST_OPTIONS_SECTIONS; do
 	    then
 		try="$try $seqnum"
 		n_try=`expr $n_try + 1`
-		_check_test_fs
+		write_io=`_get_write_io_count $TEST_DEV`
+		if [ -z $test_write_io ] || [ $write_io -ne $test_write_io ]; then
+			_check_test_fs
+		fi
 		atime=`stat -c %X $SCRATCH_DEV`
 		if [ $atime -ne $scratch_atime ]; then
 			_check_scratch_fs
diff --git a/common/rc b/common/rc
index 95030ae..83e8734 100644
--- a/common/rc
+++ b/common/rc
@@ -2165,6 +2165,17 @@ _scale_fsstress_args()
     echo $args
 }
 
+_get_write_io_count()
+{
+	if [ -z $1 ]; then
+		echo "Missing device argument for _get_write_io_count"
+		exit 1
+	fi
+	major_minor=$(printf "%d:%d" `stat -c "0x%t" $1` `stat -c "0x%T" $1`)
+	sync
+	cat /sys/dev/block/${major_minor}/stat 2> /dev/null | awk '{print $5}'
+}
+
 #
 # Return the logical block size if running on a block device,
 # else substitute the page size.
-- 
1.8.3.1

