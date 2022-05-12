Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9430CC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 12 May 2022 18:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357601AbiELSWU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 May 2022 14:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357587AbiELSWJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 May 2022 14:22:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711CA5AED0
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 11:22:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD17161716
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 18:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6019BC385B8;
        Thu, 12 May 2022 18:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652379727;
        bh=LuezE28Syca9Zrv6Pd2rNwcgIdg2csgjbYkAK6Mv2UM=;
        h=From:To:Cc:Subject:Date:From;
        b=clxZDz/s4VmNgdZmE1ndYlbk6TMYsT5vwbI9adP0ZelPnIQTC3u6Kz9zHAeX/eBzP
         qJn4y4BEqmTX7hjGn8XxspovJaKUKZ+XX72VAF6afpHrbkrPqlgR81TFes7pUo+R2g
         y1SrSqMHwpM/P2L3A0BZA9KXh0szCTVgutTnK07wyvBesKfKj33j7oukq/ZsgUFtBH
         HwbWYHfEMlllcDlx7o1aTqekEOzHLYWUdrbgqqQqCZSt75KzeNULisQLZYdIDZ5Gna
         RDvzSbjG5IHqfwTjfHHI0Dzs+ClpAdtbjD4FuZkY+qW5N7sY6+Jnv9PaY7H1+Im/ei
         8usDwvTlqDiog==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Cc:     djwong@kernel.org
Subject: [PATCH v3 1/2] generic: soft quota limits testing within grace time
Date:   Fri, 13 May 2022 02:22:02 +0800
Message-Id: <20220512182203.2839593-1-zlang@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

After soft limits are exceeded, within the grace time, fs quota
should allow more space allocation before exceeding hard limits,
even if allocating many small files.

This case can cover bc37e4fb5cac (xfs: revert "xfs: actually bump
warning counts when we send warnings"). And will help to expose
later behavior changes on this side.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

According to the review points of:
  https://lore.kernel.org/fstests/20220511163806.uc4z7td2remhdru3@zlang-mailbox/T/#m23940b47261165a0442c7ae1eb4d96a1489a2935
V3 did below changes:
1) fix some comments description
2) add a few hard limit test
3) And bring in [PATCH 2/2], to help g/603 to use the common functions of this
   patch.

Thanks,
Zorro

 common/quota          | 48 +++++++++++++++++++++
 tests/generic/999     | 99 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/999.out |  2 +
 3 files changed, 149 insertions(+)
 create mode 100755 tests/generic/999
 create mode 100644 tests/generic/999.out

diff --git a/common/quota b/common/quota
index 7fa1a61a..67698f74 100644
--- a/common/quota
+++ b/common/quota
@@ -351,5 +351,53 @@ _qsetup()
 	echo "Using type=$type id=$id" >> $seqres.full
 }
 
+# Help to create project quota on directory, works for xfs and other fs.
+# Usage: _create_project_quota <dirname> <projid> [name]
+# Although the [name] is optional, better to specify it if need a fixed name.
+_create_project_quota()
+{
+	local prjdir=$1
+	local id=$2
+	local name=$3
+
+	if [ -z "$name" ];then
+		name=`echo $projdir | tr \/ \_`
+	fi
+
+	rm -rf $prjdir
+	mkdir $prjdir
+	chmod ugo+rwx $prjdir
+
+	if [ -f /etc/projects -a ! -f $tmp.projects.bk ];then
+		cat /etc/projects > $tmp.projects.bk
+		echo >/etc/projects
+	fi
+	if [ -f /etc/projid -a ! -f $tmp.projid.bk ];then
+		cat /etc/projid > $tmp.projid.bk
+		echo >/etc/projid
+	fi
+
+	cat >>/etc/projects <<EOF
+$id:$prjdir
+EOF
+	cat >>/etc/projid <<EOF
+$name:$id
+EOF
+	$XFS_IO_PROG -r -c "chproj $id" -c "chattr +P" $prjdir
+}
+
+# If you've called _create_project_quota, then use this function in _cleanup
+_restore_project_quota()
+{
+	if [ -f $tmp.projects.bk ];then
+		cat $tmp.projects.bk > /etc/projects && \
+			rm -f $tmp.projects.bk
+	fi
+	if [ -f $tmp.projid.bk ];then
+		cat $tmp.projid.bk > /etc/projid && \
+			rm -f $tmp.projid.bk
+	fi
+}
+
 # make sure this script returns success
 /bin/true
diff --git a/tests/generic/999 b/tests/generic/999
new file mode 100755
index 00000000..76d68df5
--- /dev/null
+++ b/tests/generic/999
@@ -0,0 +1,99 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Red Hat Inc.  All Rights Reserved.
+#
+# FS QA Test No. 999
+#
+# Make sure filesystem quota works well, after soft limits are exceeded. The
+# fs quota should allow more space allocation before exceeding hard limits
+# and with in grace time.
+#
+# But different with other similar testing, this case tries to write many small
+# files, to cover bc37e4fb5cac (xfs: revert "xfs: actually bump warning counts
+# when we send warnings"). If there's a behavior change some day, this case
+# might help to detect that too.
+#
+. ./common/preamble
+_begin_fstest auto quota
+
+# Override the default cleanup function.
+_cleanup()
+{
+	_restore_project_quota
+	cd /
+	rm -r -f $tmp.*
+}
+
+# Import common functions.
+. ./common/quota
+
+# real QA test starts here
+_supported_fs generic
+_require_scratch
+_require_quota
+_require_user
+_require_group
+
+# Make sure the kernel supports project quota
+_scratch_mkfs >$seqres.full 2>&1
+_scratch_enable_pquota
+_qmount_option "prjquota"
+_qmount
+_require_prjquota $SCRATCH_DEV
+
+exercise()
+{
+	local type=$1
+	local file=$SCRATCH_MNT/testfile
+
+	echo "= Test type=$type quota =" >>$seqres.full
+	_scratch_unmount
+	_scratch_mkfs >>$seqres.full 2>&1
+	if [ "$1" = "P" ];then
+		_scratch_enable_pquota
+	fi
+	_qmount
+	if [ "$1" = "P" ];then
+		_create_project_quota $SCRATCH_MNT/t 100 $qa_user
+		file=$SCRATCH_MNT/t/testfile
+	fi
+
+	setquota -${type} $qa_user 1M 200M 0 0 $SCRATCH_MNT
+	setquota -${type} -t 86400 86400 $SCRATCH_MNT
+	repquota -v -${type} $SCRATCH_MNT | grep -v "^root" >>$seqres.full 2>&1
+	# Exceed the soft quota limit a bit at first
+	su $qa_user -c "$XFS_IO_PROG -f -t -c 'pwrite 0 2m' -c fsync ${file}.0" >>$seqres.full 2>&1
+	# Write more data more times under soft quota limit exhausted condition,
+	# but not reach hard limit. To make sure each write won't trigger EDQUOT.
+	for ((i=1; i<=100; i++));do
+		su "$qa_user" -c "$XFS_IO_PROG -f -c 'pwrite 0 1m' -c fsync ${file}.$i" >>$seqres.full 2>&1
+		if [ $? -ne 0 ];then
+			echo "Unexpected error (type=$type)!"
+			break
+		fi
+	done
+	repquota -v -${type} $SCRATCH_MNT | grep -v "^root" >>$seqres.full 2>&1
+
+	# As we've tested soft limit, now exceed the hard limit and give it a
+	# test in passing.
+	su $qa_user -c "$XFS_IO_PROG -f -t -c 'pwrite 0 100m' -c fsync ${file}.hard.0" >>$seqres.full 2>&1
+	for ((i=1; i<=10; i++));do
+		su "$qa_user" -c "$XFS_IO_PROG -f -c 'pwrite 0 1m' -c fsync ${file}.hard.$i" >>$seqres.full 2>&1
+		if [ $? -eq 0 ];then
+			echo "Unexpected success (type=$type)!"
+			break
+		fi
+	done
+}
+
+_qmount_option "usrquota"
+exercise u
+_qmount_option "grpquota"
+exercise g
+_qmount_option "prjquota"
+exercise P
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/generic/999.out b/tests/generic/999.out
new file mode 100644
index 00000000..3b276ca8
--- /dev/null
+++ b/tests/generic/999.out
@@ -0,0 +1,2 @@
+QA output created by 999
+Silence is golden
-- 
2.31.1

