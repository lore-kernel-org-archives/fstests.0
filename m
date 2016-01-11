Received: from mx1.redhat.com ([209.132.183.28]:46494 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759389AbcAKLci (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 11 Jan 2016 06:32:38 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 99036C0BF2A3
	for <fstests@vger.kernel.org>; Mon, 11 Jan 2016 11:32:38 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 3/3] new: create a default .out file
Date: Mon, 11 Jan 2016 19:32:04 +0800
Message-Id: <1452511924-21872-4-git-send-email-eguan@redhat.com>
In-Reply-To: <1452511924-21872-1-git-send-email-eguan@redhat.com>
References: <1452511924-21872-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Creating a default .out file in "new" to ease the new test creation
process.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 new | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/new b/new
index ab2af69..c21d8db 100755
--- a/new
+++ b/new
@@ -228,6 +228,12 @@ echo ""
 chmod 755 $tdir/$id
 ${EDITOR-vi} $tdir/$id
 
+# Create default .out file
+cat <<End-of-File >$tdir/$id.out
+QA output created by $id
+Silence is golden
+End-of-File
+
 if [ $# -eq 0 ]
 then
 
-- 
2.5.0

