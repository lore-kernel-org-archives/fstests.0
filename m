Received: from mx1.redhat.com ([209.132.183.28]:46396 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759701AbcAKLcd (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 11 Jan 2016 06:32:33 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 8AF3E8E222
	for <fstests@vger.kernel.org>; Mon, 11 Jan 2016 11:32:33 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 2/3] common: no need to parse config file in new
Date: Mon, 11 Jan 2016 19:32:03 +0800
Message-Id: <1452511924-21872-3-git-send-email-eguan@redhat.com>
In-Reply-To: <1452511924-21872-1-git-send-email-eguan@redhat.com>
References: <1452511924-21872-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

I saw "new" failed the TEST_DIR/SCRATCH_MNT validation when TEST_DIR or
SCRATCH_MNT points to directory, which is needed in overlayfs testing.

"new" only generates test template and doesn't need common/config to
parse and validate TEST_DEV/TEST_DIR etc., so just returns after setting
all needed commands.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 common/config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/common/config b/common/config
index cb34fd7..9aa06a3 100644
--- a/common/config
+++ b/common/config
@@ -270,6 +270,11 @@ fi
 rm -f /tmp/crc_check.img
 export XFS_MKFS_HAS_NO_META_SUPPORT
 
+# new doesn't need config file parsed, we can stop here
+if [ "$iam" == "new" ]; then
+	return 0
+fi
+
 _mount_opts()
 {
 	case $FSTYP in
-- 
2.5.0

