Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1980AC38145
	for <linux-fstests@archiver.kernel.org>; Thu,  8 Sep 2022 10:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiIHKhN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 8 Sep 2022 06:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiIHKhM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 8 Sep 2022 06:37:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DD89E2F7
        for <fstests@vger.kernel.org>; Thu,  8 Sep 2022 03:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662633430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VFFSGgEKQyMwpxXZbXWRYUFiExR0rxponepz5a7Dw00=;
        b=Km94Y3K8Pj777b59kgAY8gx6iwt8U7odnHOXiAGLi+twZqZop00yoNM2cTLwfRB5O70bsq
        B4KMelu+tIsZktS2vM1Joc92+zbfdJjtHVt9AeOQMBTzeelOoDStLiXt8IrGxbnXumR/vQ
        hntnYH3GKUBumOPlNBR5WWga0lbgk84=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-256-MhK3OsvMO_On3lwihIPOyQ-1; Thu, 08 Sep 2022 06:37:09 -0400
X-MC-Unique: MhK3OsvMO_On3lwihIPOyQ-1
Received: by mail-ej1-f71.google.com with SMTP id sd6-20020a1709076e0600b0073315809fb5so6165447ejc.10
        for <fstests@vger.kernel.org>; Thu, 08 Sep 2022 03:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VFFSGgEKQyMwpxXZbXWRYUFiExR0rxponepz5a7Dw00=;
        b=Hj91KJ5+nLhJw3+Eb+ve85OUhJ0eMRIA8gojuG54h6lmR7ikNUWMFrEV0yV5lWeEqB
         kxoNTjzLCvhiY+NV4TwWf8tBUPUk+reViwqDH7VF6y4+B6jwGhHJ7i7vJQsvhE5omivh
         pZVsdTeNgoBTvfzflXd77OAhVxBHaXXgxzq7WNIcwsxhUZbA6InvQfIJfRUvsW6k32wE
         ryR2se8wksS/Og/RIK0226lNX9lncIfCXgvsC2s6yB3VWJZ6sWO+z4QENd2gQ7qTxDTT
         PrlwM9mHocBG+9K5lErjQpZGvzyEaTZ8EFlTwwLHos+6wXqF+20ShaSPhNFUmL3N6/lJ
         GarQ==
X-Gm-Message-State: ACgBeo1vuPPzclTYElQx0Q9dTVqUCYjvkflfBGYyBObwvYaelGL7eTW5
        frHlbtGFwIgtjiz1Ina145hBWKtTss57oH2qwjrDpKin6zMd5AyJU5Oahz37CTsXkUJhVxQEVYe
        86VDZrgJdj5iM7KmVgZhNtVUoKwQFsFkT13bkccA2b22VVsBzMBtL+TYr5AhAzkLIWvR3
X-Received: by 2002:a17:907:72c9:b0:770:fbb8:b6d with SMTP id du9-20020a17090772c900b00770fbb80b6dmr3746069ejc.680.1662633427628;
        Thu, 08 Sep 2022 03:37:07 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5TokZ3NpUBLaz1Hi/CHOOUx0OEsS9ls1uneADu7LSqJ8nH4ERQ2vQZtf9HMOmbd8Z/1VCp6Q==
X-Received: by 2002:a17:907:72c9:b0:770:fbb8:b6d with SMTP id du9-20020a17090772c900b00770fbb80b6dmr3746035ejc.680.1662633427121;
        Thu, 08 Sep 2022 03:37:07 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id kz24-20020a17090777d800b006fe0abb00f0sm1055497ejc.209.2022.09.08.03.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 03:37:06 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     fstests@vger.kernel.org
Cc:     david@fromorbit.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v3] xfs: test xfs_quota's 'dump' and 'report' -L/-R range parameters
Date:   Thu,  8 Sep 2022 12:36:29 +0200
Message-Id: <20220908103629.426862-1-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220805172531.520862-1-aalbersh@redhat.com>
References: <20220805172531.520862-1-aalbersh@redhat.com>
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

Ping. Rebased and updated test ID for the newest for-next

---

This is regression test in relation to the patch [1].

Changes from v1:
 - Moved to separate test (initially added to 152)
Changes from v2 [2]:
 - sed expression simplification
 - remove _filter_trailing_spaces() from common/filter
 - easier to read test cases

[1]: https://lore.kernel.org/all/20220328222503.146496-1-aalbersh@redhat.com/
[2]: https://lore.kernel.org/fstests/20220802130554.117320-1-aalbersh@redhat.com/

---
 tests/xfs/554     | 169 +++++++++++++++++++++++++++++++++
 tests/xfs/554.out | 232 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 401 insertions(+)
 create mode 100755 tests/xfs/554
 create mode 100644 tests/xfs/554.out

diff --git a/tests/xfs/554 b/tests/xfs/554
new file mode 100755
index 00000000..7863fded
--- /dev/null
+++ b/tests/xfs/554
@@ -0,0 +1,169 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Andrey Albershteyn <aalbersh@redhat.com>.
+# All Rights Reserved.
+#
+# FS QA Test 554
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
diff --git a/tests/xfs/554.out b/tests/xfs/554.out
new file mode 100644
index 00000000..21069d2d
--- /dev/null
+++ b/tests/xfs/554.out
@@ -0,0 +1,232 @@
+QA output created by 554
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

