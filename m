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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523F4C433DF
	for <linux-fstests@archiver.kernel.org>; Wed, 17 Jun 2020 09:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2297D20739
	for <linux-fstests@archiver.kernel.org>; Wed, 17 Jun 2020 09:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="N69Wm3GC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgFQJsX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:48:23 -0400
Received: from mail-m974.mail.163.com ([123.126.97.4]:58384 "EHLO
        mail-m974.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgFQJsX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 17 Jun 2020 05:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=A41RD
        fIksxPj8kv3he29Psk8KVfs6wjJONLxd/XNtX8=; b=N69Wm3GCuLdHw2yvmMtUb
        ikpTZ3bc6rn/EvFUPone+H+51qNxEBVpZNMmYuYQrDo8PYN5b7z9HquEQgL2A+OF
        z0crV/WgUt1OihgH5WFq8GlKDXtFrTmCpFjxBW2B3+OpxZJk6oRvsVeKU8tCrg2W
        F+xINf71V2lDQJ7V594Lgg=
Received: from localhost.localdomain (unknown [122.96.44.138])
        by smtp4 (Coremail) with SMTP id HNxpCgDH8VsW4+leg8edAw--.16498S3;
        Wed, 17 Jun 2020 17:32:08 +0800 (CST)
From:   Xiao Yang <ice_yangxiao@163.com>
To:     fstests@vger.kernel.org
Cc:     darrick.wong@oracle.com, ira.weiny@intel.com,
        ross.zwisler@linux.intel.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2 1/6] common/rc: Introduce new helpers for DAX mount options and FS_XFLAG_DAX
Date:   Wed, 17 Jun 2020 17:31:59 +0800
Message-Id: <20200617093204.20838-2-ice_yangxiao@163.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200617093204.20838-1-ice_yangxiao@163.com>
References: <20200617093204.20838-1-ice_yangxiao@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgDH8VsW4+leg8edAw--.16498S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr1UGr18KFW8Gw45Zr43KFg_yoW8WryrpF
        yjqr9xurWxJFy3Z34fGF1rZ34YgF4F9F1ayryxWrWfJFn8XF13Z348KF1UX3Wqqr13J34v
        93yvgFW8Ww1UAwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jg_-9UUUUU=
X-Originating-IP: [122.96.44.138]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiFhhGXl44LbH2RQAAsf
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Xiao Yang <yangx.jy@cn.fujitsu.com>

1) _require_scratch_dax_mountopt() checks both old and new DAX mount option
2) _require_scratch_dax_iflag() checks FS_XFLAG_DAX

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/common/rc b/common/rc
index a6967831..ec7c19e4 100644
--- a/common/rc
+++ b/common/rc
@@ -3188,6 +3188,41 @@ _require_scratch_dax()
 	_scratch_unmount
 }
 
+_require_scratch_dax_mountopt()
+{
+	local mountopt=$1
+	local output
+
+	_require_scratch
+	_scratch_mkfs > /dev/null 2>&1
+	_try_scratch_mount -o "$mountopt" || \
+		_notrun "mount $SCRATCH_DEV with $mountopt failed"
+
+	output=$(_fs_options $SCRATCH_DEV)
+
+	# For new dax mount option, /proc/mounts shows different outputs if we
+	# mount with -o dax=inode on ext4 and xfs so skip checking it.
+	# /proc/mounts shows 'dax=inode' on ext4 but shows nothing on xfs.
+	if [ "$mountopt" != "dax=inode" ]; then
+		echo $output | grep -qw "$mountopt" || \
+			_notrun "$SCRATCH_DEV $FSTYP does not support -o $mountopt"
+	fi
+
+	# For new dax mount option, /proc/mounts shows "dax=never" if we
+	# mount with -o dax on xfs and underlying device doesn't support dax.
+	if [ "$mountopt" = "dax" ]; then
+		echo $output | grep -qw "dax=never" && \
+			_notrun "$SCRATCH_DEV $FSTYP does not support -o $mountopt"
+	fi
+
+	_scratch_unmount
+}
+
+_require_scratch_dax_iflag()
+{
+	_require_xfs_io_command "chattr" "x"
+}
+
 # Does norecovery support by this fs?
 _require_norecovery()
 {
-- 
2.21.0

