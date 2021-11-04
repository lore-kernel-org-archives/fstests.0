Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A73C433F5
	for <linux-fstests@archiver.kernel.org>; Thu,  4 Nov 2021 20:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D9816124F
	for <linux-fstests@archiver.kernel.org>; Thu,  4 Nov 2021 20:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbhKDUmm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 4 Nov 2021 16:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbhKDUml (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 4 Nov 2021 16:42:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFBCC061714
        for <fstests@vger.kernel.org>; Thu,  4 Nov 2021 13:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=P1vs8wKNgTx/hkFc3Ny3Hz4vEk28DrmwsgpzQAfBh40=; b=1jNvLQxV8fUr+WUeFgak2TDo4H
        7QLrL1hIC8gh64wR76N6fazWqAx4k2mhXN6wfD7I0XsTD8LTtNX15rpJw4U9SeBQqX3//rYW6fr3z
        Zc6nFgLiIFyCIfk30I3iaTr6DKQKQTNz1TWfomM2Tyjth+SPLma1ZlqqaY7QVKGn7S4zjJFD9r+T3
        7Bb/sdFFNktzirSkqj8dRiSZhW8OPmQdtTl192HxoXEZb//NfYlE0QQ+XS5fqWmxqOmvwN7cOReCf
        KSrz7iRDIogb7Q54oydZiXFz9/0QZEEP8wLsdYIoHCCy56av/muG+O6jLjoLeMOM4MvZ4fcMldAQJ
        f0IrXT+g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mijWl-009wxy-7L; Thu, 04 Nov 2021 20:40:03 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Cc:     fdmanana@gmail.com, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] common/btrfs: source module file
Date:   Thu,  4 Nov 2021 13:39:58 -0700
Message-Id: <20211104203958.2371523-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

btrfs/249 fails with:

QA output created by 249
./common/btrfs: line 425: _require_loadable_fs_module: command not found
./common/btrfs: line 432: _reload_fs_module: command not found
ERROR: not a btrfs filesystem: /media/scratch

Fix this by sourcing common/module in the btrfs common file.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 common/btrfs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index 5d938c19..4dc4f75d 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -2,6 +2,8 @@
 # Common btrfs specific functions
 #
 
+source common/module
+
 _btrfs_get_subvolid()
 {
 	mnt=$1
-- 
2.33.0

