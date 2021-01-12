Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6FEC43381
	for <linux-fstests@archiver.kernel.org>; Tue, 12 Jan 2021 21:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF49A23121
	for <linux-fstests@archiver.kernel.org>; Tue, 12 Jan 2021 21:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437159AbhALVhc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:32 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60899 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437142AbhALVSi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 12 Jan 2021 16:18:38 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 357585C05BC;
        Tue, 12 Jan 2021 16:17:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 12 Jan 2021 16:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=McQAZ1d1YIQ7Gq2Hr693Q3ytj/
        km7azp9MwKVSE343Q=; b=WBBi+PPgtm0qIxtBaw5gKfhJWILpNMySFpiGbrld4D
        HDaUiYCne57DqOG8GzdUq4xzRMU7kRPc8GCW/VVMnzCxY8D//Do6pPNqQ4rg12Dg
        m1rqS52dcVnN5LYOGYlFht+d2F3pS8G8YsPT7fOKC45FcnI66vf0wOcmWPpUX+nF
        rwftjXDTLozOdsZcVJmLjosfcA5ibl3sTB1k6EHCVepy4+dh/55OLUSgCgGm+kiD
        FKT++VYqTIcNPZ6emD/5TmvjrvEex/9jT9lxlWJlD1xVkQ1h6E50ekt44oDj9OHF
        c/LL1u0cYoSGi9nBIeFAl4D3qTUXMw+7d0BOtl+ioVUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=McQAZ1d1YIQ7Gq2Hr
        693Q3ytj/km7azp9MwKVSE343Q=; b=ogDP1EJHLdUBjpubrj8/DZs9q49bYu2zB
        oZoU53mXzW0jRyZYqmszXkkc9QXK40jqlca/ZwFs09YGjrz9zkFmCjk0H6dTQ/e8
        NkZVvTvPqULrPeKNpG7SzR29/pEIVWuuyWTyraMt8kB8Wp/2QoDZ6hI85tyj1CN0
        wcCljvjVbSzGNGKOkizXk0enGSUw0IH7ozU7fuRciiX6p4rcn+SoJeLxedM0EfOD
        oF8hdY25ELOJeJpAMZE+fw+VJftdJlI9nIAMz91Jd6ev3Bm5n5S0VrXpoZjI1ZuG
        k91V7LCp5j4YlM0ln524F9z09bg7fO8oSWnifoP5P1NFx9qXsC5sw==
X-ME-Sender: <xms:_RH-XyRcazqd2Dk3xxo3eJw0F_9XU8frB0aKGnYe3nvAkbT2zIhbiA>
    <xme:_RH-X3sUJObj_ZS7SQYVk1JUVm0t9uphqnT04yMM3uTobTf3M5Fi_T6elVWN9Si0G
    Z1rNsPf2CDZoC_kor0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddtgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucfkphepudeifedruddugedrudefvddrfeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrd
    hioh
X-ME-Proxy: <xmx:_RH-X8svTJRYvPnrH5e-W9FwBLXxZqyNq3nTPu2CgFk1Fl87tXycdQ>
    <xmx:_RH-X1yoL3KjJ6U1W1eEAODHPw7ZUGhySHrWLktNBYTSE3ACU7GBoQ>
    <xmx:_RH-X6hgXHs7VZ7qmBOMZMI2a1lXHPaklezQ3UY72sIm8KFDexEcGA>
    <xmx:_hH-X64my0-t18JDgvVyLDAi9eSTrZ8xUaY34PlmbG-tuolHuKBSVA>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id A4AAF240057;
        Tue, 12 Jan 2021 16:17:49 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     fstests@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs/220: fix clear_cache and inode_cache option tests
Date:   Tue, 12 Jan 2021 13:17:47 -0800
Message-Id: <409e4c73fefce666d151b043d6b2a0d821f8ef85.1610485406.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

I recently changed clear_cache to not appear in mount options, as it has
one shot semantics, which was breaking this test. Test explicitly that
it _doesn't_ appear, which properly fails on old filesystems and passes
on misc-next.

The patch that changed this behavior was:
8b228324a8ce btrfs: clear free space tree on ro->rw remount

Separately, inode_cache is deprecated and will never appear in mount
options; remove it entirely.

Signed-off-by: Boris Burkov
---
 tests/btrfs/220 | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/220 b/tests/btrfs/220
index c84c7065..1242460f 100755
--- a/tests/btrfs/220
+++ b/tests/btrfs/220
@@ -215,11 +215,8 @@ test_optional_kernel_features()
 
 test_non_revertible_options()
 {
-	test_mount_opt "clear_cache" "clear_cache"
 	test_mount_opt "degraded" "degraded"
 
-	test_mount_opt "inode_cache" "inode_cache"
-
 	# nologreplay should be used only with
 	test_should_fail "nologreplay"
 	test_mount_opt "nologreplay,ro" "ro,rescue=nologreplay"
@@ -238,6 +235,11 @@ test_non_revertible_options()
 	test_mount_opt "rescue=nologreplay,ro" "ro,rescue=nologreplay"
 }
 
+test_one_shot_options()
+{
+	test_mount_opt "clear_cache" ""
+}
+
 # All these options can be reverted (with their "no" counterpart), or can have
 # their values set to default on remount
 test_revertible_options()
@@ -321,6 +323,8 @@ test_optional_kernel_features
 
 test_non_revertible_options
 
+test_one_shot_options
+
 test_revertible_options
 
 test_subvol
-- 
2.24.1

