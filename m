Received: from mx1.redhat.com ([209.132.183.28]:57378 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756532AbbLARgB (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 1 Dec 2015 12:36:01 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 73F61A81
	for <fstests@vger.kernel.org>; Tue,  1 Dec 2015 17:36:01 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tB1Ha0Zx027692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <fstests@vger.kernel.org>; Tue, 1 Dec 2015 12:36:01 -0500
From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] make sure to _require_attrs when necessary
Date: Tue, 01 Dec 2015 12:36:00 -0500
Message-ID: <x49two2kr5r.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

xfs/073 and xfs/295 forgot to _require_attrs.  Fix it.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/tests/xfs/073 b/tests/xfs/073
index 32faffd..9def3c6 100755
--- a/tests/xfs/073
+++ b/tests/xfs/073
@@ -33,6 +33,7 @@ status=1	# failure is the default!
 # get standard environment, filters and checks
 . ./common/rc
 . ./common/filter
+. ./common/attr
 
 # don't put fs images in /tmp
 imgs=$TEST_DIR/$$
@@ -127,6 +128,7 @@ _verify_copy()
 _supported_fs xfs
 _supported_os Linux
 _require_test
+_require_attrs
 
 [ "$USE_EXTERNAL" = yes ] && _notrun "Cannot xfs_copy with external devices"
 [ -n "$XFS_COPY_PROG" ] || _notrun "xfs_copy binary not yet installed"
diff --git a/tests/xfs/295 b/tests/xfs/295
index 79f27bd..2325537 100755
--- a/tests/xfs/295
+++ b/tests/xfs/295
@@ -39,6 +39,7 @@ _cleanup()
 # get standard environment, filters and checks
 . ./common/rc
 . ./common/filter
+. ./common/attr
 
 # real QA test starts here
 
@@ -46,6 +47,7 @@ _cleanup()
 _supported_fs xfs
 _supported_os IRIX Linux
 _require_scratch
+_require_attrs
 
 rm -f $seqres.full
 
