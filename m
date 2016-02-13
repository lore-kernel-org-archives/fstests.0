Received: from imap.thunk.org ([74.207.234.97]:34536 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932AbcBMRlP (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 13 Feb 2016 12:41:15 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 04/16] generic: use mount point instead of device name
Date: Sat, 13 Feb 2016 12:40:57 -0500
Message-Id: <1455385269-26319-5-git-send-email-tytso@mit.edu>
In-Reply-To: <1455385269-26319-1-git-send-email-tytso@mit.edu>
References: <1455385269-26319-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: hughd@google.com, Junho Ryu <jayr@google.com>, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

A tmpfs mount does not involve any block device, its $SCRATCH_DEV is
nothing but a place-holder, so apply 'df' or 'stat' to its mount point
$SCRATCH_MNT instead of to $SCRATCH_DEV.

Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Junho Ryu <jayr@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/273 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/273 b/tests/generic/273
index e5af7f1..0a4a600 100755
--- a/tests/generic/273
+++ b/tests/generic/273
@@ -68,7 +68,7 @@ _file_create()
 
 	cd $SCRATCH_MNT/origin
 
-	_disksize=`$DF_PROG -B 1 $SCRATCH_DEV | tail -1 | $AWK_PROG '{ print $5 }'`
+	_disksize=`$DF_PROG -B 1 $SCRATCH_MNT | tail -1 | $AWK_PROG '{ print $5 }'`
 	_disksize=$(($_disksize / 3))
 	_num=$(($_disksize / $count / $threads / 4096))
 	_count=$count
-- 
2.5.0

