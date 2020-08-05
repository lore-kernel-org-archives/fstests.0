Return-Path: <SRS0=/czi=BP=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9793BC433E3
	for <linux-fstests@archiver.kernel.org>; Wed,  5 Aug 2020 20:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DF4C22D03
	for <linux-fstests@archiver.kernel.org>; Wed,  5 Aug 2020 20:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596658518;
	bh=zfG4sPJqMKjYQqd0IqvOAj+s63MBeFClDuUy/b7fIQw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=E4y+ZhgXGgJN/OsQpc2/9JZB112GVLwweYACh/ICTVlnRgMhYhhtvrt87kNsIf6vA
	 MAkckSA6UEkQ/83jdX4gN7ySIKcHjMU0CkfHP4/kLPHo3aq/GT1HaJih9Nvu2CxUU1
	 YJoWAntvin4u90yHTn3I5oeVQejawdYaLx+qofpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgHEUPR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbgHEQUR (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 5 Aug 2020 12:20:17 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CF2E2075A;
        Wed,  5 Aug 2020 13:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596635590;
        bh=zfG4sPJqMKjYQqd0IqvOAj+s63MBeFClDuUy/b7fIQw=;
        h=From:To:Cc:Subject:Date:From;
        b=iGAEoCEU+jU5XUAE96RO82CdrpH+NnSV1F4NNpo6iVavAWL4rxM3GQ7pXg3adJML9
         g1vUaUxBYm2ZYxOn6Q72PJj9pqzy72R8qDIPphMrWeSOtYB9Bq9Wc1IxMvom0+kaZI
         rr0N1VFzYBBSamL11PO7YnNeuytHNMFw520n+CMM=
From:   Jeff Layton <jlayton@kernel.org>
To:     fstests@vger.kernel.org
Cc:     Eryu Guan <guaneryu@gmail.com>
Subject: [PATCH RESEND 1/2] generic/377: filter out xattrs that don't start with 'user.'
Date:   Wed,  5 Aug 2020 09:53:07 -0400
Message-Id: <20200805135308.14540-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Most hosts that I've been testing on seem to display security.selinux in
listxattr. 377.out doesn't account for that so it routinely fails for me
in testing.

When testing the output of listxattr in generic/377, filter out any xattr
names that don't start with 'user.'. That should help ensure consistent
output on SELinux-enabled hosts.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 tests/generic/377 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/377 b/tests/generic/377
index f7835ee8ff9e..f08abdca60a6 100755
--- a/tests/generic/377
+++ b/tests/generic/377
@@ -48,7 +48,7 @@ $SETFATTR_PROG -n user.ping -v pong $testfile
 $SETFATTR_PROG -n user.hello -v there $testfile
 
 # 1. Call listxattr without buffer length argument. This should succeed.
-$listxattr $testfile | sort
+$listxattr $testfile | grep '^xattr: user\.' | sort
 
 # 2. Calling listxattr on nonexistant file should fail with -ENOENT.
 $listxattr ""
@@ -66,7 +66,7 @@ $listxattr $testfile 9
 $listxattr $testfile 11
 
 # 6. Calling listxattr with buffersize bigger than needed should succeed.
-$listxattr $testfile 500 | sort
+$listxattr $testfile 500 | grep '^xattr: user\.' | sort
 
 status=0
 exit
-- 
2.26.2

