Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945D8C2BB41
	for <linux-fstests@archiver.kernel.org>; Tue, 16 Aug 2022 11:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbiHPL3c (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 16 Aug 2022 07:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbiHPL3H (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 Aug 2022 07:29:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FD7BA157
        for <fstests@vger.kernel.org>; Tue, 16 Aug 2022 03:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660646741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iyY12bIDIkxdAC45Eh2dTf1vKg/kxUNeeEbHNWPMido=;
        b=VNWEBhd06c36kDG2Wn4OJz0ROJoTxNwXY4VZp6D/9HpS8Ue8M5LBn6zUiWGFhIIf+6vkFz
        3a9elOG7Nf5gtIuVY+CYQjD5CJw8AL2YzAREsrt/1evxcUuJv44lqPZUSYLVUN3zVaDUsP
        vz8zyXYFnr+klnp6ptK4KqkGzBcXh6A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-661-84haxTnpP1WqVnYSgM5tjw-1; Tue, 16 Aug 2022 06:45:40 -0400
X-MC-Unique: 84haxTnpP1WqVnYSgM5tjw-1
Received: by mail-wm1-f69.google.com with SMTP id ay27-20020a05600c1e1b00b003a5bff0df8dso366512wmb.0
        for <fstests@vger.kernel.org>; Tue, 16 Aug 2022 03:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=iyY12bIDIkxdAC45Eh2dTf1vKg/kxUNeeEbHNWPMido=;
        b=YmyCX4IZkkkUt4qlNB7pNjOCcUOkHz6or7OVrn/TZBgn/xhxYzYCRrq7kXpmMEW+wY
         tDq+dB4zuE2pE7u79jitCamHWGtXhC3X6doG50T8G+8DWGwmalZ8VYAnqxgftDr4iPA4
         GQGA706M8uC0GVlMweFMtXwHLR9liksIPf5kG8OSYs+9EnoFvrdrYjWD3uZCjn1vT2Dw
         ElpCjRZAdTxmtT7pndbfIOEf+4s1jpSPt5DI6M+2UTxOcrmYX/Keh9v2XgEexXaRdJLv
         1KAxIsQVYZomXf4wo7RNBtTHu2AZUxVqNn3920rim7rrCinBrdAcVJuqgbzsMUHNikyy
         sg3g==
X-Gm-Message-State: ACgBeo2eGWyGBst8mowpwtIL1q4NpBu0vMBiQC8Bakz8cepHWa031McR
        PSRmruosO7R9SpVIYgAu07AXUOTHNWtQWkcKRH2xj4p+iWCVkLn7T20boDaJGnRy0DmqWgghen+
        pITT4StDrZk4hYfUlY1j+ITT3j3qq4+Mwf3R+TU1k89Rt28mzOm76ycR4rAZYVEV5NkjS
X-Received: by 2002:a7b:cb4e:0:b0:3a2:f3b0:4233 with SMTP id v14-20020a7bcb4e000000b003a2f3b04233mr12697754wmj.50.1660646739174;
        Tue, 16 Aug 2022 03:45:39 -0700 (PDT)
X-Google-Smtp-Source: AA6agR70UyaOCke0n1p44mn9yXZIQjtH72pcH+M7lR1A5bvgh1R4iwg0UHoKhnkoERqt7th++Hpq3g==
X-Received: by 2002:a7b:cb4e:0:b0:3a2:f3b0:4233 with SMTP id v14-20020a7bcb4e000000b003a2f3b04233mr12697738wmj.50.1660646738816;
        Tue, 16 Aug 2022 03:45:38 -0700 (PDT)
Received: from localhost.localdomain.com (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id u4-20020a5d5144000000b00220606afdf4sm9741802wrt.43.2022.08.16.03.45.37
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 03:45:38 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v2] generic: test i_blocks for large files
Date:   Tue, 16 Aug 2022 12:45:36 +0200
Message-Id: <20220816104536.273937-1-preichl@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220813054438.ghygw23t6phvuwos@zlang-mailbox>
References: <20220813054438.ghygw23t6phvuwos@zlang-mailbox>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This is a regression test for an incorrect
computation of i_blocks for files larger than
4 GiB. Bug was filed for exFAT.

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 common/rc             | 10 ++++++++++
 tests/generic/693     | 46 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/693.out |  2 ++
 3 files changed, 58 insertions(+)
 create mode 100755 tests/generic/693
 create mode 100644 tests/generic/693.out

diff --git a/common/rc b/common/rc
index 197c9415..06cbdee5 100644
--- a/common/rc
+++ b/common/rc
@@ -1980,6 +1980,16 @@ _require_test()
     touch ${RESULT_DIR}/require_test
 }
 
+# require a test dev of a minimum size (in kb)
+_require_test_size()
+{
+	[ $# -eq 1 ] || _fail "_require_test_size: expected size param"
+
+	_require_test
+	local devsize=`_get_device_size $TEST_DEV`
+	[ $devsize -lt $1 ] && _notrun "test dev too small"
+}
+
 _has_logdev()
 {
 	local ret=0
diff --git a/tests/generic/693 b/tests/generic/693
new file mode 100755
index 00000000..a6d1abff
--- /dev/null
+++ b/tests/generic/693
@@ -0,0 +1,46 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022  Red Hat Inc. All Rights Reserved.
+#
+# FS QA Test 693
+#
+# Verify that i_blocks for files larger than 4 GiB have correct
+# values.
+#
+# This test verifies the problem fixed in kernel with commit
+# 0c336d6e33f4 exfat: fix incorrect loading of i_blocks for large files
+#
+. ./common/preamble
+_begin_fstest auto
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.* $junk_dir
+}
+
+_supported_fs generic
+_require_test_size $((4 * 1024 * 1024)) #kB
+
+echo "Silence is golden"
+
+junk_dir=$TEST_DIR/$seq
+junk_file=$junk_dir/junk
+mkdir -p $junk_dir
+
+$XFS_IO_PROG -f -c "pwrite -W 0 4G" $junk_file > /dev/null
+
+iblocks=`stat -c '%b' $junk_file`
+
+_test_cycle_mount
+
+iblocks_after_remount=`stat -c '%b' $junk_file`
+
+if [ "$iblocks" != "$iblocks_after_remount" ]; then
+	echo "Number of blocks needs to be same: $iblocks, $iblocks_after_remount"
+fi
+
+status=0
+
+exit
diff --git a/tests/generic/693.out b/tests/generic/693.out
new file mode 100644
index 00000000..01884ea5
--- /dev/null
+++ b/tests/generic/693.out
@@ -0,0 +1,2 @@
+QA output created by 693
+Silence is golden
-- 
2.37.2

