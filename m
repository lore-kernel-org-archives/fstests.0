Return-Path: <SRS0=bQ1U=2S=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63078C2D0C8
	for <linux-fstests@archiver.kernel.org>; Sat, 28 Dec 2019 22:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCD4207E0
	for <linux-fstests@archiver.kernel.org>; Sat, 28 Dec 2019 22:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDL7QdyL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfL1WNZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 28 Dec 2019 17:13:25 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37858 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfL1WNZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 28 Dec 2019 17:13:25 -0500
Received: by mail-pl1-f193.google.com with SMTP id c23so13168527plz.4
        for <fstests@vger.kernel.org>; Sat, 28 Dec 2019 14:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oZ8h5OpCKXQC2vCJzChYsTM5Ww/i/WXow7LH9SIfHbc=;
        b=MDL7QdyLx6tYv/cFx6K1ikEyEcg12By5spdMbLdq+o6sm2iidrvgwu5jHAT72HhbY8
         tB6VazhhYl6QKdYAg7LldEQxa2lADFBfjM3skte9NElovnfO1CAFcJ2Lx2zi6dyb7pju
         bVnIdI60p7VfcspBeM3j3oVr2v94LuwZLLgA0XCrM5xLnlb8gI++v/ZyetIgexf7jxqE
         +E4hapr1VtGOxNBFHEnRQLyZlPQgnrpShjd2t4/mgqL8P9zjimE8jH+sHoCUe954iRRf
         v0/ifdFRP6WpMMwFJ/LkI8G5Y4/VX2hhOD75+nR4N+kv+fjkNMmWGRkrvJKhMOMAfQcG
         L4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oZ8h5OpCKXQC2vCJzChYsTM5Ww/i/WXow7LH9SIfHbc=;
        b=n3fp4EwpKM8+Y6UZx5ydadKZUa9U8Sbm5SW78BoKHzTigzfn0oZUKSZvq+w0UYL6fE
         0JVA++OHAvIOryHKxWKmlr8J7wjyfS6Y+nIjaL6fhTHfJ0OJi2Ch76kYF8moBYRHl7yE
         g3aIcy71untoUPkq2BHQIed630f+9Dhq4s6fj8v86JMV1/EPVwznNcYYp0Kzq98fPoPF
         dNO4wjKRUZSQQEvzcgqabP0luKpNy5heNOeFb3eMPonJS6vY0XG44o0GVlu27yaN+MEF
         oHKVBXTlyevm5V/dEHLZwOGCDemTu7RS/9Q0yhwBm10ouVQ4SAgCGPchS4r2Ies40939
         DjEw==
X-Gm-Message-State: APjAAAX0liOZgyIzpo0l3YUiF5BvxcLFijqznycXdzfx5DSTPZ/i9VW+
        mrBT+9B0hpU0h8YSm5ORrSCgxt4C
X-Google-Smtp-Source: APXvYqzvIXtC05TUEQd8BDQDZHC36WX/Mg0m3W9BTVWVPHtDgilltOfAjI4CYUW1OmFv+/o9fevMVg==
X-Received: by 2002:a17:90a:9f84:: with SMTP id o4mr36021285pjp.88.1577571204421;
        Sat, 28 Dec 2019 14:13:24 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id i127sm47041522pfe.54.2019.12.28.14.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 14:13:23 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     fstests@vger.kernel.org
Cc:     amir73il@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        guaneryu@gmail.com, sashal@kernel.org, y2038@lists.linaro.org
Subject: [PATCH v2] generic/402: Make timestamp range check conditional
Date:   Sat, 28 Dec 2019 14:13:17 -0800
Message-Id: <20191228221317.16654-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CABeXuvr74C0DS-K4_us4CdPPFxp=7RHmCHAZQQmJrh=PZfux-w@mail.gmail.com>
References: <CABeXuvr74C0DS-K4_us4CdPPFxp=7RHmCHAZQQmJrh=PZfux-w@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Addition of fs-specific timestamp range checking was added
in 188d20bcd1eb ("vfs: Add file timestamp range support").

Add a check for whether the kernel supports the limits check
before running the associated test.

ext4 has been chosen to test for the presence of kernel support
for this feature. If there is a concern that ext4 could be built
out of the kernel, I can include a _require_ext4() along the
lines of _require_ext2().

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
* Changes since v1:
  used loopback device instead of mkfs scratch dev

 common/rc         | 26 ++++++++++++++++++++++++++
 tests/generic/402 |  3 +++
 2 files changed, 29 insertions(+)

diff --git a/common/rc b/common/rc
index 816588d6..6248adf7 100644
--- a/common/rc
+++ b/common/rc
@@ -1981,6 +1981,32 @@ _run_aiodio()
     return $status
 }
 
+_require_kernel_timestamp_range()
+{
+	LOOP_FILE=$SCRATCH_MNT/loop_file
+	LOOP_MNT=$SCRATCH_MNT/loop_mnt
+
+	dd if=/dev/zero of=$LOOP_FILE bs=1M count=2 2>&1 | _filter_dd || _fail "loopback prep failed"
+
+	# Use ext4 with 128-byte inodes, which do not have room for extended timestamp
+	FSTYP=ext4 MKFS_OPTIONS=-I128 \
+	_mkfs_dev $LOOP_FILE >> $seqres.full 2>&1 || _fail "ext4 mkfs failed"
+
+	LOOP_DEV=$(_create_loop_device $LOOP_FILE)
+	mkdir -p $LOOP_MNT >> $seqres.full 2>&1 || _fail "failed to create $LOOP_MNT"
+	mount -t ext4 ${LOOP_DEV} ${LOOP_MNT} >> $seqres.full 2>&1 || _fail "ext4 mount failed"
+	notrun=false
+	_check_dmesg_for "ext4 filesystem being mounted at ${LOOP_MNT} supports timestamps until 2038" || \
+		notrun=true
+
+	umount ${LOOP_MNT} >> $seqres.full 2>&1 ||_fail "failed to umount $LOOP_MNT"
+	_destroy_loop_device ${LOOP_DEV} >> $seqres.full 2>&1
+
+	if $notrun; then
+		_notrun "Kernel does not support timestamp limits"
+	fi
+}
+
 _require_timestamp_range()
 {
 	local device=${1:-$TEST_DEV}
diff --git a/tests/generic/402 b/tests/generic/402
index 0392c258..2be94c54 100755
--- a/tests/generic/402
+++ b/tests/generic/402
@@ -30,6 +30,7 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_check_dmesg
 _require_xfs_io_command utimes
 
 # Compare file timestamps obtained from stat
@@ -79,6 +80,8 @@ run_test()
 	done
 }
 
+_require_kernel_timestamp_range
+
 _scratch_mkfs &>> $seqres.full 2>&1 || _fail "mkfs failed"
 _require_timestamp_range $SCRATCH_DEV
 
-- 
2.17.1

