Received: from mx1.redhat.com ([209.132.183.28]:58171 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821AbcCBQ5S (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 2 Mar 2016 11:57:18 -0500
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] common: filter more messages from _scratch_mkfs_ext4
Date: Thu,  3 Mar 2016 00:57:05 +0800
Message-Id: <1456937825-18814-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: yangx.jy@cn.fujitsu.com, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Commit a94334afa2ff ("common: filter warning messages from mkfs.ext4")
filtered warning messages from mke2fs stderr output but missed the
mke2fs version infomation message, and generic/135 still fails because
of this

  QA output created by 135
 +mke2fs 1.42.9 (28-Dec-2013)
  0000000 1212 1212 1212 1212 1212 1212 1212 1212

So also filter out this message in _scratch_mkfs_ext4.

Reported-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 2773b85..a34c387 100644
--- a/common/rc
+++ b/common/rc
@@ -655,7 +655,7 @@ _scratch_mkfs_ext4()
 	fi
 
 	# output stored mkfs output
-	grep -v ^Warning: $tmp_dir.mkfserr >&2
+	grep -v -e ^Warning: -e "^mke2fs " $tmp_dir.mkfserr >&2
 	cat $tmp_dir.mkfsstd
 	rm -f $tmp_dir.mkfserr $tmp_dir.mkfsstd
 
-- 
2.5.0

