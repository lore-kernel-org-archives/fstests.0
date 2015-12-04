Received: from mx1.redhat.com ([209.132.183.28]:37406 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756665AbbLDWCP (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 4 Dec 2015 17:02:15 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 538CFC803
	for <fstests@vger.kernel.org>; Fri,  4 Dec 2015 22:02:15 +0000 (UTC)
Received: from liberator.sandeen.net (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tB4M2E8L013314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <fstests@vger.kernel.org>; Fri, 4 Dec 2015 17:02:15 -0500
Subject: [PATCH V2] xfs/242: remove open-coded check for "zero" command
References: <56620046.7060101@redhat.com>
From: Eric Sandeen <sandeen@redhat.com>
Message-ID: <56620D66.9070108@redhat.com>
Date: Fri, 4 Dec 2015 16:02:14 -0600
MIME-Version: 1.0
In-Reply-To: <56620046.7060101@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

We have helpers for this, no need to open-code it.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

v2: clarify subject w/ "xfs/242"

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
 


