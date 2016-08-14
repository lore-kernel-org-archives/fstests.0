Received: from cn.fujitsu.com ([59.151.112.132]:27838 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752152AbcHQDE1 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 16 Aug 2016 23:04:27 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] xfs/191: skip tests on older xfsprogs
Date: Sun, 14 Aug 2016 21:35:01 +0800
Message-ID: <1471181701-23877-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, jtulak@redhat.com, root <root@localhost.localdomain>
List-ID: <fstests@vger.kernel.org>

From: root <root@localhost.localdomain>

If we don't have /tmp/foo file on xfsprogs 3.2.2, _require_xfs_mkfs_validation
will fail because mkfs.xfs can't create this file.  We need to skip tests
before xfsprogs 4.7.0, so fix it.  the feature has been introduced since
xfsprogs 4.2.0:
commit 20cec860e16b267ea0c71a2f648fa2b26aad2e65
Author: Eric Sandeen <sandeen@sandeen.net>
Date: Fri Jul 31 09:04:11 2015 +1000

  mkfs.xfs: always use underlying fs sector size when mkfs'ing a file

Signed-off-by: root <root@localhost.localdomain>
---
 common/rc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/rc b/common/rc
index b19b698..db99794 100644
--- a/common/rc
+++ b/common/rc
@@ -3889,6 +3889,9 @@ _get_fs_sysfs_attr()
 # number of failed cases.
 _mkfs_validation_check()
 {
+	if [ ! -f /tmp/foo ]; then
+		touch /tmp/foo
+	fi
 	local cmd="$MKFS_XFS_PROG -f -N -d file,name=/tmp/foo,size=$((1024 * 1024 * 1024))"
 	$cmd -s size=2s >/dev/null 2>&1
 	local sum=$?
-- 
1.8.3.1



