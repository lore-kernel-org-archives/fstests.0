Received: from smtpbg298.qq.com ([184.105.67.102]:46457 "EHLO smtpbg298.qq.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752849AbbFEAea (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 4 Jun 2015 20:34:30 -0400
From: Wang Sheng-Hui <shhuiw@foxmail.com>
Subject: [PATCH] generic/324: fix small typos in comment
Date: Fri,  5 Jun 2015 08:34:09 +0800
Message-Id: <1433464449-21027-1-git-send-email-shhuiw@foxmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

Fix some spelling mistakes in the comment.

Signed-off-by: Wang Sheng-Hui <shhuiw@foxmail.com>
---
 tests/generic/324 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/324 b/tests/generic/324
index 5e642dc..ac2ae8b 100755
--- a/tests/generic/324
+++ b/tests/generic/324
@@ -61,7 +61,7 @@ _workout()
 	# Fill holes for half of range , as result file will contain nr*1.5 fragments
 	$XFS_IO_PROG -c "falloc 0 $((204800*nr))"  \
 	    $SCRATCH_MNT/test.$nr | _filter_xfs_io
-	# Data wrilte will convert extetns to inialized ones
+	# Data write will convert extents to initialized ones
 	for ((i=0;i<nr;i++))
 	do
 		patt=`printf "0x%x" $i`
-- 
1.8.3.2


