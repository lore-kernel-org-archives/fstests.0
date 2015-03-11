Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33168 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751593AbbCKLPv (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 11 Mar 2015 07:15:51 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2BBFoIK024380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Wed, 11 Mar 2015 07:15:51 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 3/4] common: append -d option to XFS_COPY_PROG when testing v5 xfs
Date: Wed, 11 Mar 2015 19:15:33 +0800
Message-Id: <1426072534-12246-4-git-send-email-eguan@redhat.com>
In-Reply-To: <1426072534-12246-1-git-send-email-eguan@redhat.com>
References: <1426072534-12246-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

xfs_copy doesn't work on v5 xfs without -d option, this fails xfs/073
when testing xfs with MKFS_OPTIONS="-m crc=1" set.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 common/rc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/common/rc b/common/rc
index 1ed9df5..ad87a18 100644
--- a/common/rc
+++ b/common/rc
@@ -2926,6 +2926,11 @@ init_rc()
 	# Figure out if we need to add -F ("foreign", deprecated) option to xfs_io
 	xfs_io -c stat $TEST_DIR 2>&1 | grep -q "is not on an XFS filesystem" && \
 	export XFS_IO_PROG="$XFS_IO_PROG -F"
+
+	# xfs_copy doesn't work on v5 xfs yet without -d option
+	if [ "$FSTYP" == "xfs" ] && [[ $MKFS_OPTIONS =~ crc=1 ]]; then
+		export XFS_COPY_PROG="$XFS_COPY_PROG -d"
+	fi
 }
 
 # get real device path name by following link
-- 
2.1.0

