Received: from userp2130.oracle.com ([156.151.31.86]:49990 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbfDPWfE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 Apr 2019 18:35:04 -0400
Date: Tue, 16 Apr 2019 15:34:59 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH 1/2] check: remove require_{test,scratch}* after a test fails
Message-ID: <20190416223459.GA22015@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Darrick J. Wong <darrick.wong@oracle.com>

Remove the require_{test,scratch]* sentinel files after a test fails.
This eliminates false fsck corruption reports such as the following:

1. Test A calls _require_scratch, which creates the sentinel file
$RESULT_DIR/require_scratch to facilitate fsck after the test completes.

2. Test A runs some test, which corrupts the scratch filesystem due to
kernel bug or something.

3. Test A calls _fail because of the errors in (2).  Note that the test
case returned 1, so ./check unmounts the test and scratch filesystems
without checking them or removing $RESULT_DIR/require_scratch

4. Test B starts up, but does not call _require_scratch.  The
$RESULT_DIR/require_scratch file is still there.

5. Test B completes successfully.

6. ./check calls _check_filesystems, which sees the
$RESULT_DIR/require_scratch file and runs fsck.

7. fsck reports the corrupt scratch device (which is associated with
test B) even though B did not ever touch the scratch device and it was
actually test A that corrupted the filesystem.

Note that with the "check: wipe scratch devices between tests" patch
applied, we can also reproduce this problem by running xfs/172 and
xfs/195 with a scratch device small enough that the files created in 172
span multiple AGs and therefore cause 172 to fail.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 check |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/check b/check
index 1ddb2e8b..5670e13b 100755
--- a/check
+++ b/check
@@ -788,6 +788,8 @@ for section in $HOST_OPTIONS_SECTIONS; do
 			_dump_err_cont "[failed, exit status $sts]"
 			_test_unmount 2> /dev/null
 			_scratch_unmount 2> /dev/null
+			rm -f ${RESULT_DIR}/require_test*
+			rm -f ${RESULT_DIR}/require_scratch*
 			err=true
 		else
 			# the test apparently passed, so check for corruption
