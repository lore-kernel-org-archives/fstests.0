Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43A0C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 28 Oct 2021 20:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC3CF61106
	for <linux-fstests@archiver.kernel.org>; Thu, 28 Oct 2021 20:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhJ1UUH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 28 Oct 2021 16:20:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230323AbhJ1UUH (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 28 Oct 2021 16:20:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB58F61039;
        Thu, 28 Oct 2021 20:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635452259;
        bh=zGAi+YEhMu16ZU3drkHCF97eDaflWxqwtB9a+yJ9xQ4=;
        h=Date:From:To:Cc:Subject:From;
        b=c2Z8jAsISArgkMWVYcVDwArDCaJL8LsYd39jPjce8ISfzCORvJ+xg8pxgMPW+VLsM
         4i392aUZIqRMVbuAjsEPGtq+QJRrhLX3QNxTOBgsljaRCqttvv8WPuSO9lVyfDHLq6
         B6dT3bl+/ZN0QxBsNtiV0PtWJW/r6ER46BZJ2bfJm+AOf2jgYoGuvLeRW36USQ+qcx
         sn4kR4p6X9/VeZ865ryuHdY5ShtrBaT6kP37E8hjNqtraj+sdFuAQR4QOsHQ8L1Lhc
         ZJxhzGC7N7/ATG/8BbD9d0zk6VVhPbfF2SUMBhniftecYvf+HzNdvCqAvlqiqhu0b3
         0bhSMpHXVZkkA==
Date:   Thu, 28 Oct 2021 13:17:39 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Brian Foster <bfoster@redhat.com>,
        fstests <fstests@vger.kernel.org>
Subject: [PATCH v2] dmflakey: fix environment-destroying mistakes in
 _cleanup_flakey
Message-ID: <20211028201739.GQ24282@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

_cleanup_flakey can be called even when _init_flakey hasn't been called.
For example, _require_flakey_with_error_writes does this.

Unfortunately, the patch to add support for external logs and rt devices
will "reset" the SCRATCH_LOGDEV/SCRATCH_RTDEV variables without noticing
that _init_flakey hasn't been called yet.  When this happens, those two
variables will be set to the empty string, with the result that the rest
of the test doesn't use those devices.

To fix this, only reset SCRATCH_LOGDEV/RTDEV to the "NON_FLAKEY" value
if we actually set one.

Fixes: 9c1f3149 ("dmflakey: support external log and realtime devices")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Brian Foster <bfoster@redhat.com>
---
v2: Add review, actually send to list this time
v1: Note: I observed this problem when running Brian Foster's new test
    "[PATCH v2] tests/xfs: test COW writeback failure when overlapping
     non-shared blocks" with an external xfs log.
---
 common/dmflakey |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/common/dmflakey b/common/dmflakey
index af4371a3..52da3b10 100644
--- a/common/dmflakey
+++ b/common/dmflakey
@@ -84,11 +84,15 @@ _cleanup_flakey()
 	test -n "$NON_FLAKEY_LOGDEV" && _dmsetup_remove flakey-logtest
 	test -n "$NON_FLAKEY_RTDEV" && _dmsetup_remove flakey-rttest
 
-	SCRATCH_LOGDEV="$NON_FLAKEY_LOGDEV"
-	unset NON_FLAKEY_LOGDEV
+	if [ -n "$NON_FLAKEY_LOGDEV" ]; then
+		SCRATCH_LOGDEV="$NON_FLAKEY_LOGDEV"
+		unset NON_FLAKEY_LOGDEV
+	fi
 
-	SCRATCH_RTDEV="$NON_FLAKEY_RTDEV"
-	unset NON_FLAKEY_RTDEV
+	if [ -n "$NON_FLAKEY_RTDEV" ]; then
+		SCRATCH_RTDEV="$NON_FLAKEY_RTDEV"
+		unset NON_FLAKEY_RTDEV
+	fi
 }
 
 # _load_flakey_table <table> [lockfs]
