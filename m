Received: from mx1.redhat.com ([209.132.183.28]:54519 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754725AbbLDVGP (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 4 Dec 2015 16:06:15 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 9D828354195
	for <fstests@vger.kernel.org>; Fri,  4 Dec 2015 21:06:15 +0000 (UTC)
Received: from liberator.sandeen.net (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tB4L6E55026611
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <fstests@vger.kernel.org>; Fri, 4 Dec 2015 16:06:15 -0500
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] 242: remove open-coded check for "zero" command
Message-ID: <56620046.7060101@redhat.com>
Date: Fri, 4 Dec 2015 15:06:14 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

We have helpers for this, no need to open-code it.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/xfs/242 b/tests/xfs/242
index 304e69f..4e1a8b4 100755
--- a/tests/xfs/242
+++ b/tests/xfs/242
@@ -47,14 +47,7 @@ _supported_fs xfs
 _supported_os Linux
 _require_test
 
-_test_io_zero()
-{
-	$XFS_IO_PROG -c "zero help" 2>&1 | \
-			grep 'command "zero" not found' > /dev/null
-	echo $?
-}
-
-[ $(_test_io_zero) -eq 0 ] && _notrun "zero command not supported"
+_require_xfs_io_command "zero"
 
 testfile=$TEST_DIR/242.$$
 

