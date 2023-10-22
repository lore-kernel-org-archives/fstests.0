Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E591DC0032E
	for <linux-fstests@archiver.kernel.org>; Sun, 22 Oct 2023 21:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjJVVzn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 22 Oct 2023 17:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVVzm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 22 Oct 2023 17:55:42 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F1EE8
        for <fstests@vger.kernel.org>; Sun, 22 Oct 2023 14:55:40 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-143.bstnma.fios.verizon.net [173.48.111.143])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 39MLtX9w015863
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Oct 2023 17:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1698011735; bh=bIJxKYYWEvmzrPBJlBztzLXBM/0djAnLErdIMoAc4O0=;
        h=From:Subject:Date:Message-Id:MIME-Version;
        b=mF9/nVe2eFwLqjvd2kCMCG2mbO6JQ37Ot5KZYcanRr3kez/xmBVR9XDAP4VKE4Udv
         IueTSptAIcKje/btiQlAfDRLtM95khZx4ahsEbhbrscG8eLh9USsENFiMlFtJsaQpU
         EiQGN0ICuQJWtZVcmZKi1DxWuVjqGWt5Dit+GaUc3MBx4y9Qw8LQShT/b2OiqiHYGb
         ezLSqE4MrSHcxVmMoc82/Wmbwv+enHGxknU5y+K3Uov7gRi6S0J/XFJIX+pa66snJX
         drvyFLzeP4/Ffs92ZnWHZnTasc5Rxk5YiKi0LvGb1ABKGw7kCc2pTxF+5KQwYj3jzJ
         9NXdw8Pzhqv3w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 887C015C029A; Sun, 22 Oct 2023 17:55:33 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/2] generic/563: create the loop dev with the same block size as the scratch dev
Date:   Sun, 22 Oct 2023 17:55:29 -0400
Message-Id: <20231022215529.2202150-3-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20231022215529.2202150-1-tytso@mit.edu>
References: <20231022215529.2202150-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The generic/563 test creates the loop device using $SCRATCH_DEV
directly.  We need to create the loop device with the same logical
block size.  Otherwise, the loop device will always be created with
the default logical block size of 512, and if its underlying backing
store has a different logical block size, then mkfs may create a file
system in the loop device that will fail to mount.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/rc         | 10 ++++++++--
 tests/generic/563 |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index 8d7179567..01f065a9f 100644
--- a/common/rc
+++ b/common/rc
@@ -4246,9 +4246,15 @@ _require_userns()
 
 _create_loop_device()
 {
-	local file=$1 dev
-	dev=`losetup -f --show $file` || _fail "Cannot assign $file to a loop device"
+	local file=$1
+	local blocksize=$2
+	local dev
+
+	if [ -n "$blocksize" ]; then
+		blocksize="-b $blocksize"
+	fi
 
+	dev=`losetup -f $blocksize --show $file` || _fail "Cannot assign $file to a loop device"
 	# Try to enable asynchronous directio mode on the loopback device so
 	# that writeback started by a filesystem mounted on the loop device
 	# won't be throttled by buffered writes to the lower filesystem.  This
diff --git a/tests/generic/563 b/tests/generic/563
index f98c6e42b..7e6bab49e 100755
--- a/tests/generic/563
+++ b/tests/generic/563
@@ -89,7 +89,7 @@ reset()
 
 # cgroup I/O accounting doesn't work on partitions. Use a loop device to rule
 # that out.
-LOOP_DEV=$(_create_loop_device $SCRATCH_DEV)
+LOOP_DEV=$(_create_loop_device $SCRATCH_DEV $(blockdev --getss $SCRATCH_DEV))
 smajor=$((0x`stat -L -c %t $LOOP_DEV`))
 sminor=$((0x`stat -L -c %T $LOOP_DEV`))
 
-- 
2.31.0

