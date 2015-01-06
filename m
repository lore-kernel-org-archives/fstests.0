Return-Path: <fstests-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:53023 "EHLO
	prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752162AbbAFRUx (ORCPT
	<rfc822;groupwise-fstests@vger.kernel.org:0:0>);
	Tue, 6 Jan 2015 12:20:53 -0500
From: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] fix function _require_batched_discard()
Date: Tue,  6 Jan 2015 17:20:32 +0000
Message-Id: <1420564832-22845-1-git-send-email-fdmanana@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

Commit 01d42b7efe3fcb9169befda3072c41d25a87c920 broke the check
for the success status of running fstrim. The [ ] bracets should
have been killed. This made several tests being skipped even when
the test/scratch devices support trim/discard.

For reference:

$ [ fstrim /mnt/ ] || echo foobar
bash: [: fstrim: unary operator expected
foobar

$ fstrim /mnt/ || echo foobar
$ echo $?
0

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 5ce3322..5770b0a 100644
--- a/common/rc
+++ b/common/rc
@@ -2388,7 +2388,7 @@ _require_batched_discard()
 		exit 1
 	fi
 	_require_fstrim
-	[$FSTRIM_PROG $1 > /dev/null 2>&1] || _notrun "FITRIM not supported on $1"
+	$FSTRIM_PROG $1 > /dev/null 2>&1 || _notrun "FITRIM not supported on $1"
 }
 
 _require_dumpe2fs()
-- 
2.1.3

