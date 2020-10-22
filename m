Return-Path: <SRS0=0eua=D5=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5186C4363A
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Oct 2020 18:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 740C124640
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Oct 2020 18:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2902360AbgJVSt2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Oct 2020 14:49:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:49020 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2900128AbgJVSt2 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 22 Oct 2020 14:49:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 18D7EAD2D
        for <fstests@vger.kernel.org>; Thu, 22 Oct 2020 18:49:27 +0000 (UTC)
Date:   Thu, 22 Oct 2020 13:49:24 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     fstests@vger.kernel.org
Subject: [PATCH] common/config: Allow environment defined btrfs mkfs options
Message-ID: <20201022184924.42kt4pqgngfclc6x@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

btrfs does not have options of defining mkfs options via the
environment. Use BTRFS_MKFS_OPTIONS environment variable to set
MKFS_OPTIONS for btrfs.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 common/config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/config b/common/config
index 285b7d1f..d83dfb28 100644
--- a/common/config
+++ b/common/config
@@ -410,6 +410,9 @@ _mkfs_opts()
 	f2fs)
 		export MKFS_OPTIONS="$F2FS_MKFS_OPTIONS"
 		;;
+	btrfs)
+		export MKFS_OPTIONS="$BTRFS_MKFS_OPTIONS"
+		;;
 	*)
 		;;
 	esac
-- 
2.26.2
