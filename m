Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:23365 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751430AbaEWDoB (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 22 May 2014 23:44:01 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v2] xfs/005: filter _scratch_mount output to match golden image
Date: Fri, 23 May 2014 11:43:23 +0800
Message-Id: <1400816603-2263-1-git-send-email-eguan@redhat.com>
Sender: xfstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Failure message of mount has been changed since util-linux v2.21, to
something like:

mount: mount /dev/sda5 on /mnt/scratch failed: Structure needs cleaning

Filter the output to match the golden image for newer mount binary so
that both old and new version of mount work correctly.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
v2: filter the mount error message instead of changing the golden image

 tests/xfs/005 | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/xfs/005 b/tests/xfs/005
index 94157c4..509ac61 100755
--- a/tests/xfs/005
+++ b/tests/xfs/005
@@ -40,6 +40,11 @@ _cleanup()
     rm -f $tmp.*
 }
 
+filter_mount()
+{
+	sed -e "s/mount .* failed: //"
+}
+
 # get standard environment, filters and checks
 . ./common/rc
 . ./common/filter
@@ -59,7 +64,7 @@ _scratch_mkfs_xfs -m crc=1 >> $seqres.full 2>&1 || _fail "mkfs failed"
 $XFS_IO_PROG -c "pwrite 224 4" $SCRATCH_DEV | _filter_xfs_io
 
 # should FAIL, the crc is bad; golden output contains mount failure
-_scratch_mount
+_scratch_mount 2>&1 | filter_mount
 
 # success, all done
 status=0
-- 
1.9.0

