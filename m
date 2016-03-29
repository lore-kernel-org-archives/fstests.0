Received: from mx1.redhat.com ([209.132.183.28]:57057 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751658AbcC2MRd (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 29 Mar 2016 08:17:33 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 8FA157108D
	for <fstests@vger.kernel.org>; Tue, 29 Mar 2016 12:17:32 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] generic/244: avoid creating too large random ID
Date: Tue, 29 Mar 2016 20:17:19 +0800
Message-Id: <1459253839-17197-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

ppc64 hosts are generating too large random IDs like 725294314141253632,
which causes all sorts of errors in test.

Fix it by using format "-t uI" for 'int' size and it works fine on all
platforms.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---

TBH, I'm not quite clear why "-t uL" behaves differently on ppc64 (even ppc64le
works fine), and I didn't dig too deep into it. "-t uI" just works :)

 tests/generic/244 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/244 b/tests/generic/244
index eb5a5ab..0b50438 100755
--- a/tests/generic/244
+++ b/tests/generic/244
@@ -83,7 +83,7 @@ ITERATIONS=100
 
 # A few extra on the off chance we get dups
 for I in `seq 1 $(($ITERATIONS+10))`; do
-	ID=`od -N 4 -t uL -An /dev/urandom | tr -d " "`
+	ID=`od -N 4 -t uI -An /dev/urandom | tr -d " "`
 	echo $ID >> $tmp.1
 done
 
-- 
2.5.5

