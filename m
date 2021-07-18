Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74CFC636C8
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Jul 2021 15:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B4E0611AC
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Jul 2021 15:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbhGRPU5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 18 Jul 2021 11:20:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232895AbhGRPU4 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 18 Jul 2021 11:20:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EFDE61179
        for <fstests@vger.kernel.org>; Sun, 18 Jul 2021 15:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626621478;
        bh=73l8uDI+fsSMnln5HFymvuxcA0RleBjX4mxfABpRGAQ=;
        h=From:To:Subject:Date:From;
        b=buzf4rstDDlZW3SQo1mHRuO1reF8LS4bBjgYq7Rp+pjq91+un5yMK7aBIuhG2Le4E
         ePqEZqbUmi/r2gp9sE19qzRCO8jPdJ3bs2mCTOsieQrL8k3U7zoCqbLwYLkO4DBgeD
         ugr20rudy2R1auDKbQT3lunAWElC3w/gKrNQWUUNuDxmD2K5347vzE+aCMwW4m+DC0
         +tHztkC6tQawH+NmPPiy7RYI/Y0MvkAJETXH1MAml/rjXMiZyhzu0jRuXe+abilxKd
         kkWSMdkH/AOPdeqKLcb69G5KAgXl6+jEhjyrMcSlSzP2wwu6Rue8IlGwkBPbvdQ+Qd
         B1V4KyXDW9GvA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     fstests@vger.kernel.org
Subject: [PATCH] generic/423: test stx_size of symlink
Date:   Sun, 18 Jul 2021 10:17:46 -0500
Message-Id: <20210718151746.40010-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Update generic/423 to test that the reported size of a symlink is equal
to the length of the symlink target, as required by POSIX and as
documented in various man pages.

When the test_dummy_encryption mount option is enabled, this serves as a
regression test for the bug that will be fixed by the patch series
"fscrypt: report correct st_size for encrypted symlinks"
(https://lkml.kernel.org/r/20210702065350.209646-1-ebiggers@kernel.org).
However, this test is applicable to all filesystems and mount options.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---

In the past, it's been mentioned that existing xfstests shouldn't be
updated to test new things
(https://lkml.kernel.org/r/20170315093942.GN14226@eguan.usersys.redhat.com).
I personally think this is a dumb policy and that we should make
improvements like this that belong in the existing tests.  But if it's
really preferred I could instead add a new test script just for this...

 tests/generic/423 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/generic/423 b/tests/generic/423
index 3de2f30c..69c1c3bc 100755
--- a/tests/generic/423
+++ b/tests/generic/423
@@ -110,13 +110,15 @@ check_stat $TEST_DIR/$seq-file \
 	   stx_nlink=1
 
 echo "Test statx on a symlink"
-ln -s $TEST_DIR/$seq-nowhere $TEST_DIR/$seq-symlink
+target=$TEST_DIR/$seq-nowhere
+ln -s $target $TEST_DIR/$seq-symlink
 check_stat $TEST_DIR/$seq-symlink \
 	   ts_order \
 	   ref=$TEST_DIR/$seq-file \
 	   ts=B,b \
 	   ts=M,m \
 	   stx_type=sym \
+	   stx_size=${#target} \
 	   stx_rdev_major=0 \
 	   stx_rdev_minor=0 \
 	   stx_nlink=1

base-commit: 623b4ea4082b8be71acaf261435d33fa4488993a
-- 
2.32.0

