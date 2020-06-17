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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D5EC433DF
	for <linux-fstests@archiver.kernel.org>; Wed, 17 Jun 2020 09:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF8520739
	for <linux-fstests@archiver.kernel.org>; Wed, 17 Jun 2020 09:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lL9Ib3rm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgFQJrw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:47:52 -0400
Received: from mail-m974.mail.163.com ([123.126.97.4]:58168 "EHLO
        mail-m974.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgFQJrw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 17 Jun 2020 05:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=DW5M7
        1g3DyuCXDwsZ6KNEjKgau4jM4wv2Pr1w7vM3xw=; b=lL9Ib3rmgh6bW9lNF5po1
        I/Bn+JrD4fr/Hys4Bs3wNuPHPffEJI7pyd2sU2/96MCfjlT3Eqxbis8jbLt9fKpI
        8OmtrA4H+YOvj8taFBdE1NcG0GrHyv7E1CY2QsvVdRXIZRUlATF3Z71eE+e4234y
        NhfpVcZFSShuVD+mrV3QrU=
Received: from localhost.localdomain (unknown [122.96.44.138])
        by smtp4 (Coremail) with SMTP id HNxpCgDH8VsW4+leg8edAw--.16498S7;
        Wed, 17 Jun 2020 17:32:10 +0800 (CST)
From:   Xiao Yang <ice_yangxiao@163.com>
To:     fstests@vger.kernel.org
Cc:     darrick.wong@oracle.com, ira.weiny@intel.com,
        ross.zwisler@linux.intel.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2 5/6] generic/413, xfs/260: Improve format operation for PMD fault testing
Date:   Wed, 17 Jun 2020 17:32:03 +0800
Message-Id: <20200617093204.20838-6-ice_yangxiao@163.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200617093204.20838-1-ice_yangxiao@163.com>
References: <20200617093204.20838-1-ice_yangxiao@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgDH8VsW4+leg8edAw--.16498S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4fAr15ur1rZw47GF43trb_yoW8ur47pF
        yfKa45C3W8try2gr17G3Z0qw1fGwn5GrW7GrWSqa42yFs8JFy2grW2ga1UX34rCrWSgw4f
        Z3yvyryv9r1qq3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jkMa8UUUUU=
X-Originating-IP: [122.96.44.138]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiFhpGXl44LbH2eQAAsh
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Xiao Yang <yangx.jy@cn.fujitsu.com>

1) Simple code and fix the wrong value of stripe_width by _scratch_mkfs_geom().
2) Get hugepage size by _get_hugepagesize() and replace fixed 2M with
   hugepage size because hugepage size/PMD_SIZE is not 2M on some
   arches.(e.g. hugepage size/PMD_SIZE is 512M on arm64)
3) For debugging, redirect the output of mkfs to $seqres.full.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc         |  7 +++++++
 tests/generic/413 | 10 ++--------
 tests/xfs/260     |  4 ++--
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/common/rc b/common/rc
index bde26010..4852b21b 100644
--- a/common/rc
+++ b/common/rc
@@ -170,6 +170,13 @@ _get_filesize()
     stat -c %s "$1"
 }
 
+# get hugepagesize in bytes
+_get_hugepagesize()
+{
+	local hugepgsz=$(awk '/Hugepagesize/ {print $2}' /proc/meminfo)
+	echo $((hugepgsz * 1024))
+}
+
 _mount()
 {
     $MOUNT_PROG `_mount_ops_filter $*`
diff --git a/tests/generic/413 b/tests/generic/413
index 19e1b926..dfe2912b 100755
--- a/tests/generic/413
+++ b/tests/generic/413
@@ -111,14 +111,8 @@ do_tests()
 	t_mmap_dio_dax $((64 * 1024 * 1024))
 }
 
-# make fs 2Mb aligned for PMD fault testing
-mkfs_opts=""
-if [ "$FSTYP" == "ext4" ]; then
-	mkfs_opts="-E stride=512,stripe_width=1"
-elif [ "$FSTYP" == "xfs" ]; then
-	mkfs_opts="-d su=2m,sw=1"
-fi
-_scratch_mkfs "$mkfs_opts" > /dev/null 2>&1
+# make fs aligned for PMD fault testing
+_scratch_mkfs_geom $(_get_hugepagesize) 1 >> $seqres.full 2>&1
 
 # mount SCRATCH_DEV with dax option, TEST_DEV not
 export MOUNT_OPTIONS=""
diff --git a/tests/xfs/260 b/tests/xfs/260
index fbdc4cd8..7afc20f1 100755
--- a/tests/xfs/260
+++ b/tests/xfs/260
@@ -121,8 +121,8 @@ do_tests()
 	t_dax_flag_mmap_dio $((64 * 1024 * 1024))
 }
 
-# make xfs 2Mb aligned for PMD fault testing
-_scratch_mkfs "-d su=2m,sw=1" > /dev/null 2>&1
+# make xfs aligned for PMD fault testing
+_scratch_mkfs_geom $(_get_hugepagesize) 1 >> $seqres.full 2>&1
 
 # mount with dax option
 _scratch_mount "-o dax"
-- 
2.21.0

