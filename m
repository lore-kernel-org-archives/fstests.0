Received: from mx1.redhat.com ([209.132.183.28]:49540 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751251AbcGNMno (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 14 Jul 2016 08:43:44 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E4184315D25
	for <fstests@vger.kernel.org>; Thu, 14 Jul 2016 12:43:43 +0000 (UTC)
From: Jan Tulak <jtulak@redhat.com>
Subject: [PATCH 4/6] xfstests: add _require_xfs_mkfs_validation to common/rc
Date: Thu, 14 Jul 2016 14:43:32 +0200
Message-Id: <1468500214-6237-5-git-send-email-jtulak@redhat.com>
In-Reply-To: <1468500214-6237-1-git-send-email-jtulak@redhat.com>
References: <1468500214-6237-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Tulak <jtulak@redhat.com>
List-ID: <fstests@vger.kernel.org>

Add a simple way to skip a test if it is (or is not) run on mkfs correctly
validating inputs.

Signed-off-by: Jan Tulak <jtulak@redhat.com>
---
 common/rc | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/common/rc b/common/rc
index 0c68e4f..72f9901 100644
--- a/common/rc
+++ b/common/rc
@@ -3843,6 +3843,35 @@ _get_fs_sysfs_attr()
 	cat /sys/fs/${FSTYP}/${dname}/${attr}
 }
 
+# Skip if we are running an older binary without the stricter input checks.
+# Make multiple checks to be sure that there is no regression on the one
+# selected feature check, which would skew the result.
+_require_xfs_mkfs_validation()
+{
+	_require_scratch
+	$MKFS_XFS_PROG -f -N -s size=2s $SCRATCH_DEV >/dev/null 2>&1
+	sum=$?
+	$MKFS_XFS_PROG -f -N -l version=2,su=$((256 * 1024 + 4096)) $SCRATCH_DEV >/dev/null 2>&1
+	sum=`expr $sum + $?`
+
+	if [ "$sum" -eq 0 ]; then
+		_notrun "Requires newer mkfs with stricter input checks."
+	fi
+}
+
+# The oposite of _require_xfs_mkfs_validation.
+_require_xfs_mkfs_without_validation()
+{
+	_require_scratch
+	$MKFS_XFS_PROG -f -N -s size=2s $SCRATCH_DEV >/dev/null 2>&1
+	sum=$?
+	$MKFS_XFS_PROG -f -N -l version=2,su=$((256 * 1024 + 4096)) $SCRATCH_DEV >/dev/null 2>&1
+	sum=`expr $sum + $?`
+
+	if [ "$sum" -eq 2 ]; then
+		_notrun "Requires older mkfs without stricter input checks."
+	fi
+}
 init_rc
 
 ################################################################################
-- 
2.5.5

