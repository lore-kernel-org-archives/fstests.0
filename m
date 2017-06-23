Received: from mx1.redhat.com ([209.132.183.28]:57799 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752776AbdFWP6J (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 23 Jun 2017 11:58:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 20C7DC04D31B
        for <fstests@vger.kernel.org>; Fri, 23 Jun 2017 15:58:09 +0000 (UTC)
Received: from Liberator-5.local (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA88A5DD65
        for <fstests@vger.kernel.org>; Fri, 23 Jun 2017 15:58:08 +0000 (UTC)
From: Eric Sandeen <sandeen@redhat.com>
Subject: generic/401: Test mountpoint not subdir for filetype support
Message-ID: <8b64d345-4dbd-cf14-bf57-58b67c8115cd@redhat.com>
Date: Fri, 23 Jun 2017 10:58:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

With pending changes for xfs_info/xfs_growfs, the tool
now requires an actual mount point to work properly.

Change this test to test $SCRATCH_MNT not the subdir
beneath it.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---


diff --git a/tests/generic/401 b/tests/generic/401
index 04bd1a5..74f2bea 100755
--- a/tests/generic/401
+++ b/tests/generic/401
@@ -79,7 +79,7 @@ mknod $testdir/p p
 src/t_dir_type $testdir d | grep -F '.' | sort
 
 # Test that either all file types are unknown or all are correct
-if _supports_filetype $testdir; then
+if _supports_filetype $SCRATCH_MNT; then
 	# print real file types
 	src/t_dir_type $testdir | grep -vF '.' | sort
 else

