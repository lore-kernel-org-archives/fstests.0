Received: from mx1.redhat.com ([209.132.183.28]:33577 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618AbbLKIgC (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 11 Dec 2015 03:36:02 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 7F7C9A3D25
	for <fstests@vger.kernel.org>; Fri, 11 Dec 2015 08:36:02 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 4/4] generic/079: _notrun if fs doesn't support ioctl
Date: Fri, 11 Dec 2015 16:35:07 +0800
Message-Id: <1449822907-31197-5-git-send-email-eguan@redhat.com>
In-Reply-To: <1449822907-31197-1-git-send-email-eguan@redhat.com>
References: <1449822907-31197-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Overlayfs directory inode doesn't support ioctl and reports
"Inappropriate ioctl", so grep for this error message and _notrun if the
message is found.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/079 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/079 b/tests/generic/079
index 939c817..041d9c0 100755
--- a/tests/generic/079
+++ b/tests/generic/079
@@ -59,7 +59,7 @@ _scratch_mount || _fail "mount failed"
 
 echo "*** starting up"
 $timmutable -c $SCRATCH_MNT/$seq >$tmp.out 2>&1
-if grep -q 'Operation not supported' $tmp.out; then
+if grep -q -e 'Operation not supported' -e "Inappropriate ioctl" $tmp.out; then
     rm -f $tmp.out
     _notrun "Setting immutable/append flag not supported"
 fi
-- 
2.5.0

