Received: from mx1.redhat.com ([209.132.183.28]:44252 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751807AbcFQRyp (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 17 Jun 2016 13:54:45 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BED7E2641
	for <fstests@vger.kernel.org>; Fri, 17 Jun 2016 17:54:44 +0000 (UTC)
Received: from [IPv6:::1] (ovpn03.gateway.prod.ext.phx2.redhat.com [10.5.9.3])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u5HHshLU005689
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <fstests@vger.kernel.org>; Fri, 17 Jun 2016 13:54:44 -0400
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] xfs/186: fix test for crc=0, ftype=1
Message-ID: <cf27c5c1-65ea-ef8b-c06c-cf4af1520d39@redhat.com>
Date: Fri, 17 Jun 2016 12:54:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Test 186 won't run when crcs are enabled, because
attrv1 is not allowed with crc=1.

However, ftype is still allowed with crc=0, so
this creates v3 directories, and xfs_db prints
them as such (along with the filetype), which
breaks the test output.

We can filter & replace to fix up the test in
this case.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/xfs/186 b/tests/xfs/186
index 8e18975..cf66623 100755
--- a/tests/xfs/186
+++ b/tests/xfs/186
@@ -76,12 +76,17 @@ _rmv_eas()
 	done
 }
 
+# If filetype is available (-n ftype=1) will get v3 dirs;
+# just filter/replace to make this look teh same as if we
+# had v2 dirs, as we are not interested in this info.
 _filter_inode()
 {
 	tee -a $seqres.full | \
 		sed -e "s/core.forkoff/forkoff/g" | \
-		egrep '^u.sfdir2|^a.sfattr|forkoff' | \
-		egrep -v 'inumber|parent'
+		egrep '^u.sfdir2|^u.sfdir3|^a.sfattr|forkoff' | \
+		egrep -v 'inumber|parent' | \
+		sed -e s/sfdir3/sfdir2/g | \
+		grep -v filetype
 }
 
 _filter_version()


