Received: from sandeen.net ([63.231.237.45]:53564 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753862AbdFWQMp (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 23 Jun 2017 12:12:45 -0400
Subject: [PATCH] generic/401: Test mountpoint not subdir for filetype support
References: <8b64d345-4dbd-cf14-bf57-58b67c8115cd@redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <63bb7dca-e407-abea-e432-2e946a8fd435@sandeen.net>
Date: Fri, 23 Jun 2017 11:12:41 -0500
MIME-Version: 1.0
In-Reply-To: <8b64d345-4dbd-cf14-bf57-58b67c8115cd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

With pending changes for xfs_info/xfs_growfs, the tool
now requires an actual mount point to work properly.

Change this test to test $SCRATCH_MNT not the subdir
beneath it.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

Sorry, forgot [PATCH], adding to make sure Eryu sees it.

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

