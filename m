Received: from mx1.redhat.com ([209.132.183.28]:53410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932217AbcLSPXz (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 19 Dec 2016 10:23:55 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E8F4384B
        for <fstests@vger.kernel.org>; Mon, 19 Dec 2016 15:23:55 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uBJFNsOh003236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <fstests@vger.kernel.org>; Mon, 19 Dec 2016 10:23:55 -0500
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] generic/395: test GETNEXTQUOTA near INT_MAX
Message-ID: <a3c43ff2-c641-aba4-b10e-781a3f3c86e3@redhat.com>
Date: Mon, 19 Dec 2016 09:23:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

XFS kernel code had a bug where GETNEXTQUOTA-type
quotactls requesting an ID near UINT_MAX could overflow
and return 0 as the "next" active ID.

This test checks that by creating an active quota near
UINT_MAX, then asking for the next one after it.

The proper answer is ENOENT, but if we wrap we'll return
ID 0.

This also changes test-nextquota.c so that it checks
both GETNEXTQUOTA and XGETNEXTQUOTA even if one fails;
it stores the failure conditions and returns 1 if either
of them fails.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/src/test-nextquota.c b/src/test-nextquota.c
index ba4de27..73c63d8 100644
--- a/src/test-nextquota.c
+++ b/src/test-nextquota.c
@@ -73,6 +73,7 @@ int main(int argc, char *argv[])
 	int cmd;
 	int type = -1, typeflag = 0;
 	int verbose = 0;
+	int retval = 0;
 	uint id = 0, idflag = 0;
 	char *device = NULL;
 	char *tmp;
@@ -140,30 +141,32 @@ int main(int argc, char *argv[])
 	cmd = QCMD(Q_GETNEXTQUOTA, type);
 	if (quotactl(cmd, device, id, (void *)&dqb) < 0) {
 		perror("Q_GETNEXTQUOTA");
-		return 1;
+		retval = 1;
+	} else {
+		/*
+		 * We only print id and inode limits because
+		 * block count varies depending on fs block size, etc;
+		 * this is just a sanity test that we can retrieve the quota,
+		 * and inode limits have the same units across both calls.
+		 */
+		printf("id        %u\n", dqb.dqb_id);
+		printf("ihard     %llu\n",
+				  (unsigned long long)dqb.dqb_ihardlimit);
+		printf("isoft     %llu\n",
+				  (unsigned long long)dqb.dqb_isoftlimit);
 	}
 
-	/*
-	 * We only print id and inode limits because
-	 * block count varies depending on fs block size, etc;
-	 * this is just a sanity test that we can retrieve the quota,
-	 * and inode limits have the same units across both calls.
-	 */
-	printf("id        %u\n", dqb.dqb_id);
-	printf("ihard     %llu\n", (unsigned long long)dqb.dqb_ihardlimit);
-	printf("isoft     %llu\n", (unsigned long long)dqb.dqb_isoftlimit);
-
 	if (verbose)
 		printf("====Q_XGETNEXTQUOTA====\n");
 	cmd = QCMD(Q_XGETNEXTQUOTA, USRQUOTA);
 	if (quotactl(cmd, device, id, (void *)&xqb) < 0) {
 		perror("Q_XGETNEXTQUOTA");
-		return 1;
+		retval = 1;
+	} else {
+		printf("id        %u\n", xqb.d_id);
+		printf("ihard     %llu\n", xqb.d_ino_hardlimit);
+		printf("isoft     %llu\n", xqb.d_ino_softlimit);
 	}
 
-	printf("id        %u\n", xqb.d_id);
-	printf("ihard     %llu\n", xqb.d_ino_hardlimit);
-	printf("isoft     %llu\n", xqb.d_ino_softlimit);
-
-	return 0;
+	return retval;
 }
diff --git a/tests/generic/395 b/tests/generic/395
new file mode 100755
index 0000000..c0cfc31
--- /dev/null
+++ b/tests/generic/395
@@ -0,0 +1,99 @@
+#! /bin/bash
+# FS QA Test 394
+#
+# test out high quota ids retrieved by Q_GETNEXTQUOTA
+# Request for next ID near 2^32 should not wrap to 0
+#
+# Designed to use the new Q_GETNEXTQUOTA quotactl
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#-----------------------------------------------------------------------
+#
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/quota
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+_supported_fs generic
+_supported_os Linux
+_require_quota
+_require_scratch
+
+scratch_unmount 2>/dev/null
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount "-o usrquota,grpquota"
+quotacheck -u -g $SCRATCH_MNT 2>/dev/null
+quotaon $SCRATCH_MNT 2>/dev/null
+_scratch_unmount
+
+TYPES="u g"
+MOUNT_OPTIONS="-o usrquota,grpquota"
+
+_qmount
+quotaon $SCRATCH_MNT 2>/dev/null
+
+# Ok, do we even have GETNEXTQUOTA?  Querying ID 0 should work.
+$here/src/test-nextquota -i 0 -u -d $SCRATCH_DEV &> $seqres.full || \
+	_notrun "No GETNEXTQUOTA support"
+
+echo "Launch all quotas"
+
+# We want to create a block of quotas for an id very near
+# 2^32, then ask for the next quota after it.  The returned
+# ID should not overflow to 0.
+
+# Populate  with 2^32-4
+ID=4294967292
+setquota -u $ID $ID $ID $ID $ID $SCRATCH_MNT
+touch ${SCRATCH_MNT}/${ID}
+chown ${ID} ${SCRATCH_MNT}/${ID}
+
+# remount just for kicks, make sure we get it off disk
+_scratch_unmount
+_qmount
+quotaon $SCRATCH_MNT 2>/dev/null
+
+# Ask for the next quota after $ID; should get nothing back
+# If kernelspace wraps, we'll get 0 back.
+for TYPE in u g; do
+	let NEXT=ID+1
+	echo "Ask for ID after $NEXT expecting nothing"
+	$here/src/test-nextquota -i $NEXT -${TYPE} -d $SCRATCH_DEV
+done
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/395.out b/tests/generic/395.out
new file mode 100644
index 0000000..bcd87ec
--- /dev/null
+++ b/tests/generic/395.out
@@ -0,0 +1,8 @@
+QA output created by 395
+Launch all quotas
+Ask for ID after 4294967293 expecting nothing
+Q_GETNEXTQUOTA: No such file or directory
+Q_XGETNEXTQUOTA: No such file or directory
+Ask for ID after 4294967293 expecting nothing
+Q_GETNEXTQUOTA: No such file or directory
+Q_XGETNEXTQUOTA: No such file or directory
diff --git a/tests/generic/group b/tests/generic/group
index 20b31ef..e9d3e4a 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -397,3 +397,4 @@
 392 auto quick metadata
 393 auto quick rw
 394 auto quick
+395 auto quick quota


