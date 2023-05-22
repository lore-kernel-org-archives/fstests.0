Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DA7C7EE29
	for <linux-fstests@archiver.kernel.org>; Mon, 22 May 2023 21:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjEVV1Y (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 22 May 2023 17:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjEVV1X (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 May 2023 17:27:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFFD9D
        for <fstests@vger.kernel.org>; Mon, 22 May 2023 14:27:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3BDBC2203F
        for <fstests@vger.kernel.org>; Mon, 22 May 2023 21:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684790840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=cdQnqk8wY81RjqL2RSSzaEUrS1Jj7I5rpsQ4Z5WboJc=;
        b=Md0NNlNUK/sYtURL9QUGjrzLndWCvRc52wRfNHTfJvbiQV+FzxKa61R5FtR/J0q/kFJClx
        oHaulJw+qEcXSH0bzJk+dd3EKo+cSTSNbMwWDWh+m9w9UUgGHAnBw9Rwk3qgcvAZ6MlJXs
        5v+7tO2xgLq+8UFa/tWuvQHvFLABdGQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C49413336
        for <fstests@vger.kernel.org>; Mon, 22 May 2023 21:27:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6s7wCTjea2SsagAAMHmgww
        (envelope-from <ailiop@suse.com>)
        for <fstests@vger.kernel.org>; Mon, 22 May 2023 21:27:20 +0000
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] fuzzy: skip online scrub and health checks if not supported
Date:   Mon, 22 May 2023 23:27:12 +0200
Message-Id: <20230522212712.97846-1-ailiop@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Commit a27e6e6f4c18 introduced xfs health checking on no-repair fuzz,
which in turn requires scrub to be run before that. The health checks
are done only if scrub returns with an error (which is expected as an
indication that fuzzed metadata errors were picked up), but the code
does not discern between xfs_scrub returning an error because of
uncorrected metadata vs failing because the kernel does not support
scrub at all.

This causes all tests that do fuzzing with no-repair strategy to fail on
kernels compiled without online scrub support (CONFIG_XFS_ONLINE_SCRUB).

Skip scrub and health checks altogether, if the kernel does not support
it, since the tests are still valuable.

Fixes: a27e6e6f4c18 ("common: check xfs health after doing an online scrub")
Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 common/fuzzy | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/common/fuzzy b/common/fuzzy
index 4365e7343e92..a78a354142df 100644
--- a/common/fuzzy
+++ b/common/fuzzy
@@ -422,6 +422,12 @@ __scratch_xfs_fuzz_field_norepair() {
 		return 1
 	fi
 
+	# Skip scrub and health check if scrub is not supported
+	if ! _supports_xfs_scrub $SCRATCH_MNT $SCRATCH_DEV; then
+		__scratch_xfs_fuzz_unmount
+		return 0
+	fi
+
 	# Make sure online scrub will catch whatever we fuzzed
 	__fuzz_notify "++ Detect fuzzed field (online)"
 	_scratch_scrub -n -a 1 -e continue 2>&1
-- 
2.40.0

