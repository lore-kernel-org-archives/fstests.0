Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6097CC4338F
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Aug 2021 13:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3830961101
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Aug 2021 13:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhHSNOd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 Aug 2021 09:14:33 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55026 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbhHSNOd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Aug 2021 09:14:33 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 97D87220B9;
        Thu, 19 Aug 2021 13:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629378836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=LIkK1X92CFU0guH3K26g3TjRZR1pluN2O2IPdzW0u2A=;
        b=khifoEzjirheXXqdyxFDq2EqsKDq/PMJQ4xFVGbDc2skVdwjr/uUPoaBFr27rytAkUtoPT
        16IvFtN3l6A27sT31qD6S/IoAkrF/Z63h6ZWGgBngV4WuDbTVkbygNHCX/6kdmNGewzkDz
        cK8WG9hySXxC01F7G78aY8vJFCcK6NQ=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 61E721340C;
        Thu, 19 Aug 2021 13:13:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id fKLYFBRZHmEqdQAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 19 Aug 2021 13:13:56 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     fstests@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] generic/70: Use scratch device instead of test.
Date:   Thu, 19 Aug 2021 16:13:55 +0300
Message-Id: <20210819131355.304528-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

At the end of the test the fsstress work dir is deleted, this suggests
the test really requires a scratch device and not a test device. Change
it accordingly.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tests/generic/070 | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/generic/070 b/tests/generic/070
index 678344fa011d..c98f445ae4b8 100755
--- a/tests/generic/070
+++ b/tests/generic/070
@@ -13,7 +13,6 @@ _begin_fstest attr udf auto quick stress
 _cleanup()
 {
     cd /
-    rm -rf $TEST_DIR/fsstress
     rm -f $tmp.*
 }
 
@@ -24,11 +23,14 @@ _cleanup()
 # real QA test starts here
 _supported_fs generic
 
-_require_test
+_require_scratch
 _require_attrs
 
+_scratch_mkfs >/dev/null 2>&1
+_scratch_mount
+
 FSSTRESS_ARGS=`_scale_fsstress_args \
-	-d $TEST_DIR/fsstress \
+	-d $SCRATCH_MNT \
 	-f allocsp=0 \
 	-f freesp=0 \
 	-f bulkstat=0 \
@@ -40,5 +42,7 @@ FSSTRESS_ARGS=`_scale_fsstress_args \
         -p 1 -n 10000 -S c`
 $FSSTRESS_PROG $FSSTRESS_ARGS >$seqres.full 2>&1
 
+_scratch_unmount
+
 status=$?
 exit
-- 
2.17.1

