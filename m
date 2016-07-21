Received: from aserp1040.oracle.com ([141.146.126.69]:29250 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490AbcGUXq5 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2016 19:46:57 -0400
Subject: [PATCH 05/17] common/reflink: actually test dedupe on scratch device
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Date: Thu, 21 Jul 2016 16:46:48 -0700
Message-ID: <146914480842.11762.9490852645886489605.stgit@birch.djwong.org>
In-Reply-To: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
References: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com, eguan@redhat.com, darrick.wong@oracle.com
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

In _require_scratch_dedupe, test the scratch device, not the testdev.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 common/reflink |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/common/reflink b/common/reflink
index 4ec390d..1363971 100644
--- a/common/reflink
+++ b/common/reflink
@@ -107,7 +107,7 @@ _require_scratch_dedupe()
 	_scratch_mount
 	"$XFS_IO_PROG" -f -c "pwrite -S 0x61 0 65536" "$SCRATCH_MNT/file1" > /dev/null
 	"$XFS_IO_PROG" -f -c "pwrite -S 0x61 0 65536" "$SCRATCH_MNT/file2" > /dev/null
-	testio="$("$XFS_IO_PROG" -f -c "dedupe $TEST_DIR/file1 0 0 65536" "$TEST_DIR/file2" 2>&1)"
+	testio="$("$XFS_IO_PROG" -f -c "dedupe $SCRATCH_MNT/file1 0 0 65536" "$SCRATCH_MNT/file2" 2>&1)"
 	echo $testio | grep -q "Operation not supported" && \
 		_notrun "Dedupe not supported by test filesystem type: $FSTYP"
 	echo $testio | grep -q "Inappropriate ioctl for device" && \

