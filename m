Received: from mx1.redhat.com ([209.132.183.28]:34774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729333AbfILQPu (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 12 Sep 2019 12:15:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 76A781DA3
        for <fstests@vger.kernel.org>; Thu, 12 Sep 2019 16:15:50 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F2F94502
        for <fstests@vger.kernel.org>; Thu, 12 Sep 2019 16:15:50 +0000 (UTC)
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] generic/564: fix copy_range -f availability test
Message-ID: <5003d229-a168-a7bb-96b7-db4eb096806b@redhat.com>
Date: Thu, 12 Sep 2019 11:15:49 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

generic/564 wants to test for copy_range -f, but as it's implemented
it calls copy_range with a length of zero which will silently return
success from the VFS (at least on some kernels) even if the underlying
fs doesn't support it.

So patch this up 2 ways; perform the test with an explicit length
so it's not a no-op, and go ahead test copy_range w/o -f in the test
first just to be on the safe side (and for clearer failure messages.)

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/common/rc b/common/rc
index e0b087c1..66c7fd4d 100644
--- a/common/rc
+++ b/common/rc
@@ -2109,7 +2109,7 @@ _require_xfs_io_command()
 		if [ "$param" == "-f" ]; then
 			# source file is the open destination file
 			testcopy=$testfile
-			copy_opts="0 -d 4k"
+			copy_opts="0 -d 4k -l 4k"
 		fi
 		$XFS_IO_PROG -F -f -c "pwrite 0 4k" $testfile > /dev/null 2>&1
 		testio=`$XFS_IO_PROG -F -f -c "copy_range $param $copy_opts" $testcopy 2>&1`
diff --git a/tests/generic/564 b/tests/generic/564
index ee1786cc..4958b3b5 100755
--- a/tests/generic/564
+++ b/tests/generic/564
@@ -49,6 +49,8 @@ _require_loop
 # copy source, as an indication that the test can run without hanging
 # with large size argument and to avoid opening pipe in blocking mode.
 #
+# Test both basic copy_range and copy_range -f availability
+_require_xfs_io_command "copy_range"
 _require_xfs_io_command "copy_range" "-f"
 
 testdir="$TEST_DIR/test-$seq"
