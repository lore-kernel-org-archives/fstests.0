Received: from mx1.redhat.com ([209.132.183.28]:54550 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933756AbcALIb5 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 12 Jan 2016 03:31:57 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id CFFEB4C38D
	for <fstests@vger.kernel.org>; Tue, 12 Jan 2016 08:31:56 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v2] common: no need to parse config file in new
Date: Tue, 12 Jan 2016 16:31:46 +0800
Message-Id: <1452587506-26383-1-git-send-email-eguan@redhat.com>
In-Reply-To: <1452511924-21872-3-git-send-email-eguan@redhat.com>
References: <1452511924-21872-3-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

I saw "new" failed the TEST_DEV/SCRATCH_DEV validation when TEST_DEV or
SCRATCH_DEV points to directory, which is needed in overlayfs testing.

"new" only generates test template and doesn't need common/config to
parse and validate TEST_DEV/SCRATCH_DEV etc., so just returns after
setting all needed commands.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
v2:
- update commit log, s/_DIR/_DEV/

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

