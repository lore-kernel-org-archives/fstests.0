Received: from sandeen.net ([63.231.237.45]:56292 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751842AbbHTUOc (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 20 Aug 2015 16:14:32 -0400
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.4])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id 87A1365476E1
	for <fstests@vger.kernel.org>; Thu, 20 Aug 2015 15:14:31 -0500 (CDT)
Message-ID: <55D63527.2050404@sandeen.net>
Date: Thu, 20 Aug 2015 15:14:31 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: [PATCH] xfs/077: fix test for userspace meta_uuid support
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

The current _require_meta_uuid() test looks for a failure return
code from xfs_db -x -c "uuid generate" but in fact this exits
with success.  (In fact uuid_f always exits with success; perhaps
this needs fixing, but that's in the wild now).

So grep for the string(s) stating that it failed, instead.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/common/rc b/common/rc
index 70d2fa8..737a701 100644
--- a/common/rc
+++ b/common/rc
@@ -2720,8 +2720,11 @@ _require_meta_uuid()
 	# This will create a crc fs on $SCRATCH_DEV
 	_require_xfs_crc
 
-	$XFS_DB_PROG -x -c "uuid generate" $SCRATCH_DEV >/dev/null 2>&1 \
-	   || _notrun "Userspace doesn't support meta_uuid feature"
+	$XFS_DB_PROG -x -c "uuid restore" $SCRATCH_DEV 2>&1 \
+	   | grep -q "invalid UUID\|supported on V5 fs" \
+	   && _notrun "Userspace doesn't support meta_uuid feature"
+
+	$XFS_DB_PROG -x -c "uuid generate" $SCRATCH_DEV >/dev/null 2>&1
 
 	_scratch_mount >/dev/null 2>&1 \
 	   || _notrun "Kernel doesn't support meta_uuid feature"
