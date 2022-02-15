Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F95C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Feb 2022 01:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiBOBs6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Feb 2022 20:48:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbiBOBsz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Feb 2022 20:48:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED8B135707
        for <fstests@vger.kernel.org>; Mon, 14 Feb 2022 17:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=628EGDw13z7gL6+45vp0Bg6PT/nuFaBuD7uFRY5ibiU=; b=qV/SPApv6o891KhU7R04LM0Z+Z
        NkUImMj5SveZ9CeCNahuBbo8JawGOneq0mUd9umj9NfUIBW4kT3NpGH+lpYRC8qmfQ8Sbfk8Adtdm
        icojqqVkUhJhg/w+B6xcWHzTIRAF8rxKPuIhNZMuklHeAMU+RPH+JPSYORAaNn6ggLWtpGvHY/2kn
        tioeguA/HceOW4ktpYueuTgCkVOTtRbtDXyKTPbXLdVaIMa+2YQ/UpoTCeG8p/N0cJx7qJRgMaCoa
        Rpx/ti6/CJZqlbY4Kh+KYUZ2qhj4vDk9915aIpVlzYOuwJ0mHdduFrz7zAVu/gQrMwsNLSarHeKRg
        YbiVLFmw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJmxS-00HTRt-0I; Tue, 15 Feb 2022 01:48:46 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org, johannes.thumshirn@wdc.com
Cc:     a.manzanares@samsung.com, p.raghav@samsung.com,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 2/3] common/btrfs: use $AWK_PROG
Date:   Mon, 14 Feb 2022 17:48:44 -0800
Message-Id: <20220215014845.4164719-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220215014845.4164719-1-mcgrof@kernel.org>
References: <20220215014845.4164719-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Use $AWK_PROG instead of just awk in case the preferred awk
program is different.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 common/btrfs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index 5de926dd..2fdefb18 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -9,7 +9,7 @@ _btrfs_get_subvolid()
 	mnt=$1
 	name=$2
 
-	$BTRFS_UTIL_PROG sub list $mnt | egrep "\s$name$" | awk '{ print $2 }'
+	$BTRFS_UTIL_PROG sub list $mnt | egrep "\s$name$" | $AWK_PROG '{ print $2 }'
 }
 
 # _require_btrfs_command <command> [<subcommand>|<option>]
@@ -418,7 +418,7 @@ _run_btrfs_balance_start()
 _scratch_btrfs_sectorsize()
 {
 	$BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV |\
-		grep sectorsize | awk '{print $2}'
+		grep sectorsize | $AWK_PROG '{print $2}'
 }
 
 _btrfs_supports_forget()
@@ -460,7 +460,7 @@ _require_btrfs_sysfs_fsid()
 	local fsid
 
 	fsid=$($BTRFS_UTIL_PROG filesystem show $TEST_DIR |grep uuid: |\
-	       awk '{print $NF}')
+	       $AWK_PROG '{print $NF}')
 
 	# Check if the kernel has sysfs fsid support.
 	# Following kernel patch adds it:
-- 
2.34.1

