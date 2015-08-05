Received: from mx1.redhat.com ([209.132.183.28]:40825 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735AbbHEH0Z (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 5 Aug 2015 03:26:25 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 64410A103F
	for <fstests@vger.kernel.org>; Wed,  5 Aug 2015 07:26:25 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] ext4/005: add missing out file back
Date: Wed,  5 Aug 2015 15:26:02 +0800
Message-Id: <1438759562-7077-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

ext4/005.out is missing, add it back.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---

I forgot git add tests/ext4/005.out before commit at the first place..

 tests/ext4/005.out | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tests/ext4/005.out

diff --git a/tests/ext4/005.out b/tests/ext4/005.out
new file mode 100644
index 0000000..a5027f1
--- /dev/null
+++ b/tests/ext4/005.out
@@ -0,0 +1,2 @@
+QA output created by 005
+Silence is golden
-- 
2.4.3

