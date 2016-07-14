Received: from mx1.redhat.com ([209.132.183.28]:36348 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149AbcGNP5L (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 14 Jul 2016 11:57:11 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AAA92D4D76
	for <fstests@vger.kernel.org>; Thu, 14 Jul 2016 15:57:10 +0000 (UTC)
From: Jan Tulak <jtulak@redhat.com>
Subject: [PATCH v2] xfstests: add _require_xfs_mkfs_validation to common/rc
Date: Thu, 14 Jul 2016 17:57:03 +0200
Message-Id: <1468511823-16184-1-git-send-email-jtulak@redhat.com>
In-Reply-To: <1468500214-6237-5-git-send-email-jtulak@redhat.com>
References: <1468500214-6237-5-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, Jan Tulak <jtulak@redhat.com>
List-ID: <fstests@vger.kernel.org>

Add a simple way to skip a test if it is (or is not) run on mkfs correctly
validating inputs.

Signed-off-by: Jan Tulak <jtulak@redhat.com>
---
UPDATE:
  * Use tmp file instead of scratch - we are using -N flag, so it doesn't
    really matter.
  * Make both _requires to use the same function for testing, so if it is ever
    changed, the change will be reflected in both.
---
 common/rc | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/common/rc b/common/rc
index 0c68e4f..c66d31d 100644
--- a/common/rc
+++ b/common/rc
@@ -3843,6 +3843,39 @@ _get_fs_sysfs_attr()
 	cat /sys/fs/${FSTYP}/${dname}/${attr}
 }
 
+# Skip if we are running an older binary without the stricter input checks.
+# Make multiple checks to be sure that there is no regression on the one
+# selected feature check, which would skew the result.
+#
+# At first, make a common function that runs the tests and returns
+# number of failed cases.
+mkfs_validation_check()
+{
+	local cmd="$MKFS_XFS_PROG -f -N -d file,name=/tmp/foo,size=$((1024 * 1024 * 1024))"
+	$cmd -s size=2s >/dev/null 2>&1
+	local sum=$?
+	$cmd -l version=2,su=$((256 * 1024 + 4096))  >/dev/null 2>&1
+	sum=`expr $sum + $?`
+	return $sum
+}
+# Skip the test if all calls passed - mkfs accepts invalid input
+_require_xfs_mkfs_validation()
+{
+	mkfs_validation_check
+	if [ "$?" -eq 0 ]; then
+		_notrun "Requires newer mkfs with stricter input checks: the oldest supported version of xfsprogs is 4.7."
+	fi
+}
+
+# The oposite of _require_xfs_mkfs_validation.
+_require_xfs_mkfs_without_validation()
+{
+	mkfs_validation_check
+	if [ "$?" -ne 0 ]; then
+		_notrun "Requires older mkfs without strict input checks: the last supported version of xfsprogs is 4.5."
+	fi
+}
+
 init_rc
 
 ################################################################################
-- 
2.5.5

