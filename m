Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569D4C00140
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Aug 2022 17:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238133AbiHERZu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 5 Aug 2022 13:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiHERZs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 5 Aug 2022 13:25:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F000CE02
        for <fstests@vger.kernel.org>; Fri,  5 Aug 2022 10:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659720345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7NbBZ5SKNWcNCDumNjuDa2oufJ9eaU8saG3vZGkEZFI=;
        b=V5frJW8v9qaKzf/GOhtLh/Lij5KhMGBy6uDpb6VD5x/CoN1xeB5m3eWjdnl7Ffr+qoRDyp
        oa9sLyFLNZ81BosVj0R0jb76+t+nlak8zbrJtkEdXgyqx3s+JM4pbEZjFqA3JueIizwbTP
        smL8hZ5lbGMR7sKDyau9o1U6Pjuknpg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-AwdxmGhuMgm9gCZ-gNe2Jg-1; Fri, 05 Aug 2022 13:25:44 -0400
X-MC-Unique: AwdxmGhuMgm9gCZ-gNe2Jg-1
Received: by mail-ej1-f71.google.com with SMTP id ne41-20020a1709077ba900b00730cde40757so1401411ejc.23
        for <fstests@vger.kernel.org>; Fri, 05 Aug 2022 10:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=7NbBZ5SKNWcNCDumNjuDa2oufJ9eaU8saG3vZGkEZFI=;
        b=fKFMBDIw49XsQypAfRhPDX5aFn0hQAkvJd5U8GtxIIOlYxgqDkL40Xkt4aR+5jpJa5
         xSnZAF2rKHaM1pY/URNjVfVRXWQaRtrxQ2OHbP3cAN8GoAmyszDMMVAlsCE3DEWIs9y5
         ZS4B0zS08OWKKZfoMv8JpvnlhWUUQSKH5+l1FWmghb14peQSNCEWg+5RaOeHPaE8AZZN
         GGXrb2tHQwfuK2yWRPNovmliolJzASLW7PbHq7d9Osz7+Pr0e0j1vzdb+VX0Gx8TXH+r
         7woDIqdLrT3BMRmiOtIrvpYIyfYoRUurevwuPNaePzuIveotw3HvBEL9r+GlTE0MSaMs
         7ilw==
X-Gm-Message-State: ACgBeo3uGjZPbWLBB74QrnbCtNXr0OlHr1YWesqgDwueJA92AjHmyRII
        0B98kGg6OStOLmTBuRPO5WNzmjicKJxkyk7FWMV4kQvTOlotYzBkCS0hartmSXyjuyXUYdr4o9R
        SGQsa9D16smoy4+S9TLv5/CHbVhAEIwLHPg0E0xpL/AdEpH5PW8pLKki+yOVaE5Vxpa/h
X-Received: by 2002:a05:6402:4143:b0:43b:206d:c283 with SMTP id x3-20020a056402414300b0043b206dc283mr7442180eda.381.1659720342512;
        Fri, 05 Aug 2022 10:25:42 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6eyu4jaLSA7hPNZI1aIy9ATbZwrM59yZyhjt5dTmj0IAfwT7k/laEA+WAxE7ep7xqXfi8gTw==
X-Received: by 2002:a05:6402:4143:b0:43b:206d:c283 with SMTP id x3-20020a056402414300b0043b206dc283mr7442162eda.381.1659720342162;
        Fri, 05 Aug 2022 10:25:42 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id la5-20020a170907780500b00730ed9e4ce1sm1109680ejc.198.2022.08.05.10.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:25:41 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     fstests@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v3] xfs: test xfs_quota's 'dump' and 'report' -L/-R range parameters
Date:   Fri,  5 Aug 2022 19:25:31 +0200
Message-Id: <20220805172531.520862-1-aalbersh@redhat.com>
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
Changes from v2:
 - sed expression simplification
 - remove _filter_trailing_spaces() from common/filter
 - easier to read test cases

[1]: https://lore.kernel.org/all/20220328222503.146496-1-aalbersh@redhat.com/

---
 tests/xfs/550     | 169 +++++++++++++++++++++++++++++++++
 tests/xfs/550.out | 232 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 401 insertions(+)
 create mode 100755 tests/xfs/550
 create mode 100644 tests/xfs/550.out

diff --git a/tests/xfs/550 b/tests/xfs/550
new file mode 100755
index 00000000..1fc1d37c
--- /dev/null
+++ b/tests/xfs/550
@@ -0,0 +1,169 @@
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
+	_filter_scratch | sed -e 's/^[0-9]\+/#ID/' -e 's/\s*$//'
+}
+
+filter_report()
+{
+	_filter_quota | sed -e '/^root/d' \
+				-e '/^#0/d' \
+				-e 's/^#[0-9]\+/#ID/' \
+				-e 's/\s*$//'
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
+	local description=$1 ; shift
+	local opt="$*"
+
+	echo "Options: $description"
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
+	local description=$1 ; shift
+	local opt="$*"
+
+	echo "Options: $description"
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
+	test_dump "no options (full range)"
+	test_dump "-L option" -L $id
+	test_dump "-U option" -U $id
+	test_dump "-L/-U options (one element range)" -L $id -U $id
+	test_dump "-L/-U options (multiple elements range)" -L $id -U $id2
+	test_dump "-L/-U options (empty range)" -L $id2 -U $id
+	test_dump "-L/-U options (full range)" -L 0 -U 0
+
+	echo "report options test (type=$type)"
+	test_report "no options (full range)"
+	test_report "-L options" -L $id
+	test_report "-U options" -U $id
+	test_report "-L/-U options (one element range)" -L $id -U $id
+	test_report "-L/-U options (multiple elements range)" -L $id -U $id2
+	test_report "-L/-U options (empty range)" -L $id2 -U $id
+	test_report "-L/-U options (full range)" -L 0 -U 0
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
index 00000000..d98166c4
--- /dev/null
+++ b/tests/xfs/550.out
@@ -0,0 +1,232 @@
+QA output created by 550
+Checking User quota
+dump options test (type=u)
+Options: no options (full range)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
+Options: -L option
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
+Options: -U option
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+Options: -L/-U options (one element range)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+Options: -L/-U options (multiple elements range)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
+Options: -L/-U options (empty range)
+Options: -L/-U options (full range)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
+report options test (type=u)
+Options: no options (full range)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+fsgqa 0 512 2048 00 [--------] 0 10 20 00 [--------]
+fsgqa2 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+Options: -L options
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+Options: -U options
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+
+Options: -L/-U options (one element range)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+
+Options: -L/-U options (multiple elements range)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+Options: -L/-U options (empty range)
+Options: -L/-U options (full range)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+Checking Group quota
+dump options test (type=g)
+Options: no options (full range)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
+Options: -L option
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
+Options: -U option
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+Options: -L/-U options (one element range)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+Options: -L/-U options (multiple elements range)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
+Options: -L/-U options (empty range)
+Options: -L/-U options (full range)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
+report options test (type=g)
+Options: no options (full range)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+fsgqa 0 512 2048 00 [--------] 0 10 20 00 [--------]
+fsgqa2 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+Options: -L options
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+Options: -U options
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+
+Options: -L/-U options (one element range)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+
+Options: -L/-U options (multiple elements range)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+Options: -L/-U options (empty range)
+Options: -L/-U options (full range)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+Checking Project quota
+dump options test (type=p)
+Options: no options (full range)
+fs = SCRATCH_DEV
+#ID            1024    4096      10      20
+fs = SCRATCH_DEV
+#ID            2048    8192      10      20
+Options: -L option
+fs = SCRATCH_DEV
+#ID            1024    4096      10      20
+fs = SCRATCH_DEV
+#ID            2048    8192      10      20
+Options: -U option
+fs = SCRATCH_DEV
+#ID            1024    4096      10      20
+Options: -L/-U options (one element range)
+fs = SCRATCH_DEV
+#ID            1024    4096      10      20
+Options: -L/-U options (multiple elements range)
+fs = SCRATCH_DEV
+#ID            1024    4096      10      20
+fs = SCRATCH_DEV
+#ID            2048    8192      10      20
+Options: -L/-U options (empty range)
+Options: -L/-U options (full range)
+fs = SCRATCH_DEV
+#ID            1024    4096      10      20
+fs = SCRATCH_DEV
+#ID            2048    8192      10      20
+report options test (type=p)
+Options: no options (full range)
+Project quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+Project ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+fsgqa 0 512 2048 00 [--------] 0 10 20 00 [--------]
+fsgqa2 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+Options: -L options
+Project quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+Project ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+Options: -U options
+Project quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+Project ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+
+Options: -L/-U options (one element range)
+Project quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+Project ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+
+Options: -L/-U options (multiple elements range)
+Project quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+Project ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+Options: -L/-U options (empty range)
+Options: -L/-U options (full range)
+Project quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes
+Project ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
+---------- -------------------------------------------------- --------------------------------------------------
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
-- 
2.31.1

