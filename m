Received: from mx1.redhat.com ([209.132.183.28]:36430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750713AbdAXKfa (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 24 Jan 2017 05:35:30 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com [10.5.11.28])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3EC513D95E
        for <fstests@vger.kernel.org>; Tue, 24 Jan 2017 10:35:31 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] tools/nextid: pad 0 in next test id seq number
Date: Tue, 24 Jan 2017 18:35:26 +0800
Message-Id: <20170124103526.8639-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

nextid returns the next available seq number, but it doesn't pad id
number with 0, e.g.

./tools/nextid ext4
23

After the fix it returns:

./tools/nextid ext4
023

This eases the process of moving tests around in a script.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tools/sort-group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sort-group b/tools/sort-group
index 84944ed..6fcaad7 100755
--- a/tools/sort-group
+++ b/tools/sort-group
@@ -103,7 +103,7 @@ def nextid_main():
 		xid = startid
 		while xid in xkeys:
 			xid += 1
-		print('%s/%d' % (group, xid))
+		print('%s/%03d' % (group, xid))
 
 if __name__ == '__main__':
 	if 'nextid' in sys.argv[0]:
-- 
2.9.3

