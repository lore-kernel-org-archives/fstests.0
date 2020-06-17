Return-Path: <SRS0=zehT=76=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F68BC433E0
	for <linux-fstests@archiver.kernel.org>; Wed, 17 Jun 2020 09:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A27E208B3
	for <linux-fstests@archiver.kernel.org>; Wed, 17 Jun 2020 09:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="I0L85cFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgFQJrb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:47:31 -0400
Received: from mail-m974.mail.163.com ([123.126.97.4]:57974 "EHLO
        mail-m974.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgFQJrb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 17 Jun 2020 05:47:31 -0400
X-Greylist: delayed 909 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jun 2020 05:47:31 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/L9Ks
        Ng/ZKtyFQwZGBbkQTXho4O54NivimK024/w26E=; b=I0L85cFTIfvPPWoZb2GEt
        xK1CNNz6GI3hNeVpKJTmxRlWjtuo0H2sGqTI55WnO0mZG5ia06iYrClKEUbQkJWZ
        ZYyrEkXwpYgHSfyUo7rmfIJzniRHH8zXPCjPLKlY4gvbkAqBdW6ikjko0gTAeHzj
        QihUkEliL33UKSCqhflqqI=
Received: from localhost.localdomain (unknown [122.96.44.138])
        by smtp4 (Coremail) with SMTP id HNxpCgDH8VsW4+leg8edAw--.16498S4;
        Wed, 17 Jun 2020 17:32:09 +0800 (CST)
From:   Xiao Yang <ice_yangxiao@163.com>
To:     fstests@vger.kernel.org
Cc:     darrick.wong@oracle.com, ira.weiny@intel.com,
        ross.zwisler@linux.intel.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2 2/6] fstests: Use _require_scratch_dax_mountopt() and _require_scratch_dax_iflag()
Date:   Wed, 17 Jun 2020 17:32:00 +0800
Message-Id: <20200617093204.20838-3-ice_yangxiao@163.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200617093204.20838-1-ice_yangxiao@163.com>
References: <20200617093204.20838-1-ice_yangxiao@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgDH8VsW4+leg8edAw--.16498S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF13Aw1xWF1xuw1kJw18Zrb_yoW5ArWrpa
        y8XFyakrWxJ3WjyrWxCFnrZay0grs8uF4ayr1Fg397XF4kW3W8tFyxKF1xJF18XrZIgrWS
        vw4vqryrWrsxKFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j30edUUUUU=
X-Originating-IP: [122.96.44.138]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/xtbB0hpGXlUMW8jYBgAAsE
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Xiao Yang <yangx.jy@cn.fujitsu.com>

Make related tests use _require_scratch_dax_mountopt() and _require_scratch_dax_iflag()

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/ext4/030    | 2 +-
 tests/ext4/031    | 4 ++--
 tests/generic/413 | 2 +-
 tests/generic/462 | 2 +-
 tests/xfs/260     | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/ext4/030 b/tests/ext4/030
index 93bbca86..fb5cf451 100755
--- a/tests/ext4/030
+++ b/tests/ext4/030
@@ -33,7 +33,7 @@ rm -f $seqres.full
 # Modify as appropriate.
 _supported_os Linux
 _supported_fs ext4
-_require_scratch_dax
+_require_scratch_dax_mountopt "dax"
 _require_test_program "t_ext4_dax_journal_corruption"
 _require_command "$CHATTR_PROG" chattr
 
diff --git a/tests/ext4/031 b/tests/ext4/031
index dc58214e..20e2fab7 100755
--- a/tests/ext4/031
+++ b/tests/ext4/031
@@ -37,7 +37,7 @@ MOUNT_OPTIONS=""
 # Modify as appropriate.
 _supported_os Linux
 _supported_fs ext4
-_require_scratch_dax
+_require_scratch_dax_mountopt "dax"
 _require_test_program "t_ext4_dax_inline_corruption"
 _require_scratch_ext4_feature "inline_data"
 
@@ -56,7 +56,7 @@ _scratch_unmount >> $seqres.full 2>&1
 _try_scratch_mount "-o dax" >> $seqres.full 2>&1
 
 if [[ $? != 0 ]]; then
-	# _require_scratch_dax already verified that we could mount with DAX.
+	# _require_scratch_dax_mountopt already verified that we could mount with DAX.
 	# Failure here is expected because we have inline data.
 	echo "Silence is golden"
 	status=0
diff --git a/tests/generic/413 b/tests/generic/413
index 1ce89aff..19e1b926 100755
--- a/tests/generic/413
+++ b/tests/generic/413
@@ -31,7 +31,7 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 _require_test
-_require_scratch_dax
+_require_scratch_dax_mountopt "dax"
 _require_test_program "feature"
 _require_test_program "t_mmap_dio"
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/462 b/tests/generic/462
index 1ab6cadc..4a940239 100755
--- a/tests/generic/462
+++ b/tests/generic/462
@@ -37,7 +37,7 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 _require_test
-_require_scratch_dax
+_require_scratch_dax_mountopt "dax"
 _require_test_program "t_mmap_write_ro"
 # running by unpriviliged user is not necessary to reproduce
 # this bug, just trying to test more.
diff --git a/tests/xfs/260 b/tests/xfs/260
index 3464ffef..fbdc4cd8 100755
--- a/tests/xfs/260
+++ b/tests/xfs/260
@@ -30,10 +30,10 @@ rm -f $seqres.full
 
 _supported_fs xfs
 _supported_os Linux
-_require_scratch_dax
+_require_scratch_dax_mountopt "dax"
 _require_test_program "feature"
 _require_test_program "t_mmap_dio"
-_require_xfs_io_command "chattr" "x"
+_require_scratch_dax_iflag
 _require_xfs_io_command "falloc"
 
 prep_files()
-- 
2.21.0

