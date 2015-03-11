Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58369 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561AbbCKLPr (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 11 Mar 2015 07:15:47 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2BBFlia028017
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Wed, 11 Mar 2015 07:15:47 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 2/4] generic/027: discard mkdir error message
Date: Wed, 11 Mar 2015 19:15:32 +0800
Message-Id: <1426072534-12246-3-git-send-email-eguan@redhat.com>
In-Reply-To: <1426072534-12246-1-git-send-email-eguan@redhat.com>
References: <1426072534-12246-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

mkdir fails due to ENOSPC occasionally and will fail the whole test.
Redirect stdout and stderr to /dev/null.

Also fix the code style in _cleanup to use single tab.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/027 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/generic/027 b/tests/generic/027
index 8dab117..d2e59d6 100755
--- a/tests/generic/027
+++ b/tests/generic/027
@@ -36,8 +36,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    cd /
-    rm -f $tmp.*
+	cd /
+	rm -f $tmp.*
 }
 
 create_file()
@@ -46,7 +46,7 @@ create_file()
 	local direct=$2
 	local i=0
 
-	mkdir -p $dir
+	mkdir -p $dir >/dev/null 2>&1
 	while $XFS_IO_PROG -f $direct -c "pwrite 0 1k" $dir/file_$i >/dev/null 2>&1; do
 		let i=$i+1
 	done
-- 
2.1.0

