Return-Path: <SRS0=3sLM=AM=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3614DC433E0
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Jul 2020 17:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F16E0207E8
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Jul 2020 17:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593625928;
	bh=DEBT7iYZXwwI2EGHfESXZ59bQ2dhEM04u7hoUagj3eM=;
	h=From:To:Subject:Date:List-ID:From;
	b=YgqTvLjL9SzsovLIrNK+1tpq+bDLZgdo1atPljsyO0rEB32pnBhhYVT1yMbPKWlm9
	 V8D42fqFGHIXdPka4eh0KZ8yU3FACFef+kXw0u2VwCHTz2+7ehgnbQ7I7r6o4TXODR
	 xuZ79yIdG3PBC6jNbW+RFs5HA1Qxl9YD7mZBjiDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbgGARwH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jul 2020 13:52:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbgGARwH (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 1 Jul 2020 13:52:07 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C297D20771
        for <fstests@vger.kernel.org>; Wed,  1 Jul 2020 17:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593625927;
        bh=DEBT7iYZXwwI2EGHfESXZ59bQ2dhEM04u7hoUagj3eM=;
        h=From:To:Subject:Date:From;
        b=W429ZfdbyYlhl6FagOa4XRGZF6PnJN0zrjYWKyxpotfgQlLwiFyRFSemFAWCiA4KC
         +zUYVSINALSFOW4HFKcuq+nsLhp7QhyXsIW3B4He51Oy7uFDsJe7r/gW1ZfbbB7dV1
         RbupMop96HWFHRdr/a6kECcOF5c9XkZ5DxWWWs/0=
From:   Jeff Layton <jlayton@kernel.org>
To:     fstests@vger.kernel.org
Subject: [PATCH] generic/377: filter out xattrs that don't start with 'user.'
Date:   Wed,  1 Jul 2020 13:52:05 -0400
Message-Id: <20200701175205.342650-1-jlayton@kernel.org>
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

I'm not sure why this doesn't fail for most people, unless most are
turning off SELinux. Is this the right approach?

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

