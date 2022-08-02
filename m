Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED273C00140
	for <linux-fstests@archiver.kernel.org>; Tue,  2 Aug 2022 13:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbiHBNG2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 2 Aug 2022 09:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiHBNG1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 2 Aug 2022 09:06:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2617125F
        for <fstests@vger.kernel.org>; Tue,  2 Aug 2022 06:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659445585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3YRHwlwVgFBHdfzGspqSabdM65LauGhJEKlOGmOlNTY=;
        b=HpzqeqqGy3bqDcszq1AVXEFAXWS4dI2+wM9sc+OqNh1EIuPrfV8adfI0tTyYv6qgbP5O3t
        K81SfwoAXCTPx8w99CdyB99zZl2nxJyGAUCqiUbSDs+ai4rQ+cvt5roh4ISaEO76nPSVkz
        8GF0qHuZgVBSkx5lrSLyc0UeSCJYgX4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-vIcGSCY8NUWuoElSICdf3g-1; Tue, 02 Aug 2022 09:06:24 -0400
X-MC-Unique: vIcGSCY8NUWuoElSICdf3g-1
Received: by mail-wr1-f72.google.com with SMTP id e14-20020adfa44e000000b0021f15a9f984so2519960wra.20
        for <fstests@vger.kernel.org>; Tue, 02 Aug 2022 06:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3YRHwlwVgFBHdfzGspqSabdM65LauGhJEKlOGmOlNTY=;
        b=B6WBWJNJxc76nAtiHtYATdgSSekNYWkH2Gy7gyMPUaovYOa+NkZPvE2hiFO/VPONHh
         3DSWh8fAZkucz/a6ugLjMebkv/5ut26vV+yZfPYmN6dAxoDROotz6v9KkMlLVtMO8YV5
         yIGZcuYs7oODCWzWAsDK6BkE+RhxD0NFn7OzmsZuiIMa2FDslz3kX95r56DnGuqGpuKe
         ZBrPn4KOrFy4Lpl5N/uxlTBMTtcOMdsSR9mFanrYi8vxLMHuy480xacC/ck9HP/qLPAd
         +4aIlmcd9cdHaRM7SnExys7AcPgJI2KyZMRFZaE9ZSxkJ6wQ1FPyrPxv1p/U3abm/p25
         6lSw==
X-Gm-Message-State: AJIora/lv3kG75GwQBhsPIqgvAlmfrgrPynmEr6UWIV9QIXjj7ht6Rq/
        J7L8aJsPdJoT/W0WdBk532Cw5Ztx5S5kvfZWkESZj4KmF3m+AZi49BfktLzsaVnldLNqzHQmJ7R
        RsG/U4VETWnfl6PtIC3Th0NUfQ7QlKAy95h0rYteuLSzfv8aHtfI0GqN48/+DtYr4+BP3
X-Received: by 2002:a05:600c:3d1a:b0:3a3:7d4b:edc5 with SMTP id bh26-20020a05600c3d1a00b003a37d4bedc5mr14512658wmb.156.1659445582494;
        Tue, 02 Aug 2022 06:06:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uAdHl0P6YV0QgDb9l1mhCy75EnHnoTIJXclF37ErRF6Gg8u+POyQuSYWyTk4YCKfQ+PkpV6A==
X-Received: by 2002:a05:600c:3d1a:b0:3a3:7d4b:edc5 with SMTP id bh26-20020a05600c3d1a00b003a37d4bedc5mr14512618wmb.156.1659445582040;
        Tue, 02 Aug 2022 06:06:22 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id k13-20020a5d6d4d000000b0021d7ad6b9fdsm14939444wri.57.2022.08.02.06.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 06:06:21 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     fstests@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2] xfs: test xfs_quota's 'dump' and 'report' -L/-R range parameters
Date:   Tue,  2 Aug 2022 15:05:55 +0200
Message-Id: <20220802130554.117320-1-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

These parameters define ID range of users/groups/projects to show.
This test adds more checks for wider coverage (e.g. empty range,
full range, open range).

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---

This is regression test in relation to the patch [1].

Changes from v1:
 - Moved to separate test (initially added to 152)

[1]: https://lore.kernel.org/all/20220328222503.146496-1-aalbersh@redhat.com/

---

 common/filter     |   5 +
 tests/xfs/550     | 163 ++++++++++++++++++++++++++++++++
 tests/xfs/550.out | 232 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 400 insertions(+)
 create mode 100755 tests/xfs/550
 create mode 100644 tests/xfs/550.out

diff --git a/common/filter b/common/filter
index 28dea646..5abe884a 100644
--- a/common/filter
+++ b/common/filter
@@ -278,6 +278,11 @@ _filter_spaces()
 	sed -e "s/\s\+/ /g"
 }
 
+_filter_trailing_spaces()
+{
+	sed -e "s/\s*$//g"
+}
+
 _filter_quota()
 {
 	# Long dev name might be split onto its own line; last
diff --git a/tests/xfs/550 b/tests/xfs/550
new file mode 100755
index 00000000..a420b1fd
--- /dev/null
+++ b/tests/xfs/550
@@ -0,0 +1,163 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Andrey Albershteyn <aalbersh@redhat.com>.
+# All Rights Reserved.
+#
+# FS QA Test 550
+#
+# Test xfs_quota -L/-U range parameters for report and dump commands. These
+# parameters define ID range of users/groups/projects with non-zero quota to
+# show.
+#
+. ./common/preamble
+_begin_fstest quick quota
+
+# Override the default cleanup function.
+_cleanup()
+{
+	_scratch_unmount >/dev/null 2>&1
+	cd /
+	rm -f $tmp.*
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/quota
+
+# real QA test starts here
+_supported_fs xfs
+_require_test
+_require_scratch
+_require_xfs_quota
+_require_user fsgqa
+_require_user fsgqa2
+_require_group fsgqa
+_require_group fsgqa2
+
+_scratch_mkfs_xfs >>$seqres.full || _fail "mkfs failed"
+
+uqid=`id -u fsgqa`
+gqid=`id -g fsgqa`
+
+uqid2=`id -u fsgqa2`
+gqid2=`id -g fsgqa2`
+
+[ $uqid -ge $uqid2 ] && _notrun \
+	"ID of fsgqa user ($uqid) expected to be lower than fsgqa2 ($uqid2)"
+[ $gqid -ge $gqid2 ] && _notrun \
+	"ID of fsgqa group ($gqid) expected to be lower than fsgqa2 ($gqid2)"
+
+pqid=10
+pqid2=42
+cat >$tmp.projects <<EOF
+$pqid:$SCRATCH_MNT
+$pqid2:$SCRATCH_MNT
+EOF
+
+cat >$tmp.projid <<EOF
+root:0
+fsgqa:$pqid
+fsgqa2:$pqid2
+EOF
+
+filter_dump()
+{
+	_filter_scratch| _filter_trailing_spaces | \
+		sed -E '/^[0-9]+/s/^[0-9]+/#ID/g'
+}
+
+filter_report()
+{
+	_filter_quota | _filter_trailing_spaces | grep -v "^root \|^\#0 " \
+		| sed -e '/^#[0-9]*/s/^#[0-9]*/#ID/g'
+}
+
+set_quota_limit()
+{
+	local bs=$1
+	local bh=$2
+	local is=$3
+	local ih=$4
+	local user=$5
+
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+			-c "limit -$type bsoft=$bs bhard=$bh $user" \
+			-c "limit -$type isoft=$is ihard=$ih $user" \
+			$SCRATCH_MNT
+}
+
+test_dump()
+{
+	local opt="$*"
+
+	rm -f $tmp.backup 2>>/dev/null
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+			-c "dump -$type $opt -f $tmp.backup" \
+			$SCRATCH_MNT | _filter_scratch
+	cat $tmp.backup | filter_dump
+}
+
+test_report()
+{
+	local opt="$*"
+
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+			-c "report -$type $opt -bi" \
+			$SCRATCH_MNT | filter_report
+}
+
+test_xfs_quota()
+{
+	set_quota_limit 512k 2048k 10 20 $id
+	set_quota_limit 1024k 4096k 10 20 $id2
+
+	echo "dump options test (type=$type)"
+	echo "no options (full range)"; test_dump
+	echo "-L option"; test_dump -L $id
+	echo "-U option"; test_dump -U $id
+	echo "-L/-U options (one element range)"; test_dump -L $id -U $id
+	echo "-L/-U options (multiple elements range)"; test_dump -L $id -U $id2
+	echo "-L/-U options (empty range)"; test_dump -L $id2 -U $id
+	echo "-L/-U options (full range)"; test_dump -L 0 -U 0
+
+	echo "report options test (type=$type)"
+	echo "no options (full range)"; test_report
+	echo "-L options"; test_report -L $id
+	echo "-U options"; test_report -U $id
+	echo "-L/-U options (one element range)"; test_report -L $id -U $id
+	echo "-L/-U options (multiple elements range)"; test_report -L $id \
+		-U $id2
+	echo "-L/-U options (empty range)"; test_report -L $id2 -U $id
+	echo "-L/-U options (full range)"; test_report -L 0 -U 0
+}
+
+echo "Checking User quota"
+_scratch_unmount >/dev/null 2>&1
+_qmount_option "uquota"
+_try_scratch_mount || _fail "qmount failed"
+type=u
+id=$uqid
+id2=$uqid2
+test_xfs_quota
+
+echo "Checking Group quota"
+_scratch_unmount >/dev/null 2>&1
+_qmount_option "gquota"
+_try_scratch_mount || _fail "qmount failed"
+type=g
+id=$gqid
+id2=$gqid2
+test_xfs_quota
+
+echo "Checking Project quota"
+_scratch_unmount >/dev/null 2>&1
+_qmount_option "pquota"
+_try_scratch_mount || _fail "qmount failed"
+type=p
+id=$pqid
+id2=$pqid2
+test_xfs_quota
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/550.out b/tests/xfs/550.out
new file mode 100644
index 00000000..2b73c5cc
--- /dev/null
+++ b/tests/xfs/550.out
@@ -0,0 +1,232 @@
+QA output created by 550
+Checking User quota
+dump options test (type=u)
+no options (full range)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
+-L option
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
+-U option
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+-L/-U options (one element range)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+-L/-U options (multiple elements range)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
+-L/-U options (empty range)
+-L/-U options (full range)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
+report options test (type=u)
+no options (full range)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+fsgqa 0 512 2048 00 [--------] 0 10 20 00 [--------]
+fsgqa2 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+-L options
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+-U options
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+
+-L/-U options (one element range)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+
+-L/-U options (multiple elements range)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+-L/-U options (empty range)
+-L/-U options (full range)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+Checking Group quota
+dump options test (type=g)
+no options (full range)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
+-L option
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
+-U option
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+-L/-U options (one element range)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+-L/-U options (multiple elements range)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
+-L/-U options (empty range)
+-L/-U options (full range)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
+report options test (type=g)
+no options (full range)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+fsgqa 0 512 2048 00 [--------] 0 10 20 00 [--------]
+fsgqa2 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+-L options
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+-U options
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+
+-L/-U options (one element range)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+
+-L/-U options (multiple elements range)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+-L/-U options (empty range)
+-L/-U options (full range)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+Checking Project quota
+dump options test (type=p)
+no options (full range)
+fs = SCRATCH_DEV
+#ID            1024    4096      10      20
+fs = SCRATCH_DEV
+#ID            2048    8192      10      20
+-L option
+fs = SCRATCH_DEV
+#ID            1024    4096      10      20
+fs = SCRATCH_DEV
+#ID            2048    8192      10      20
+-U option
+fs = SCRATCH_DEV
+#ID            1024    4096      10      20
+-L/-U options (one element range)
+fs = SCRATCH_DEV
+#ID            1024    4096      10      20
+-L/-U options (multiple elements range)
+fs = SCRATCH_DEV
+#ID            1024    4096      10      20
+fs = SCRATCH_DEV
+#ID            2048    8192      10      20
+-L/-U options (empty range)
+-L/-U options (full range)
+fs = SCRATCH_DEV
+#ID            1024    4096      10      20
+fs = SCRATCH_DEV
+#ID            2048    8192      10      20
+report options test (type=p)
+no options (full range)
+Project quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+Project ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+fsgqa 0 512 2048 00 [--------] 0 10 20 00 [--------]
+fsgqa2 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+-L options
+Project quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+Project ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+-U options
+Project quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+Project ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+
+-L/-U options (one element range)
+Project quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+Project ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+
+-L/-U options (multiple elements range)
+Project quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+Project ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+-L/-U options (empty range)
+-L/-U options (full range)
+Project quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+Project ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
-- 
2.31.1

