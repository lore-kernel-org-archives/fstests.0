Received: from mail.kernel.org ([198.145.29.136]:56870 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085AbcCVMJt (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 22 Mar 2016 08:09:49 -0400
From: fdmanana@kernel.org
Subject: [PATCH] fstests: overlay/001, change supported fs from generic to overlay
Date: Tue, 22 Mar 2016 12:09:31 +0000
Message-Id: <1458648571-4468-1-git-send-email-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

The supported fs was set to generic by mistake, so fix it by setting it
to the proper type 'overlay'.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/overlay/001 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/overlay/001 b/tests/overlay/001
index 6eae737..7be9ae5 100755
--- a/tests/overlay/001
+++ b/tests/overlay/001
@@ -47,7 +47,7 @@ _cleanup()
 rm -f $seqres.full
 
 # real QA test starts here
-_supported_fs generic
+_supported_fs overlay
 _supported_os Linux
 _require_scratch
 
-- 
2.7.0.rc3

