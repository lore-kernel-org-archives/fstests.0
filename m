Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C481CC433EF
	for <linux-fstests@archiver.kernel.org>; Thu,  3 Mar 2022 13:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiCCN3t (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 3 Mar 2022 08:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiCCN3t (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 3 Mar 2022 08:29:49 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C14015E6C3
        for <fstests@vger.kernel.org>; Thu,  3 Mar 2022 05:29:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0D3E71F384;
        Thu,  3 Mar 2022 13:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646314142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s/wo6O9vHKKo+ybpEHclo6WOisTJq7VbP0mNFMD07wk=;
        b=aj67o+Ek51G/wCIlC4uGnyvsXQ8IYLwiWtQuCbqKx2T7tPUFw0h72XAbbsjq7sf0M2uihQ
        RgVRvF7BD8arNugJM235Md2Ek65UfhdSBYo/IHmYRxw88AbqTyGOKZl0yBL+QKuVT2Dzep
        /yjb6skuT0wPbEXoI9CLEZjSQUOWHTY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF08213C23;
        Thu,  3 Mar 2022 13:29:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QCylNJ3CIGKHWwAAMHmgww
        (envelope-from <gniebler@suse.com>); Thu, 03 Mar 2022 13:29:01 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     fstests@vger.kernel.org
Cc:     Gabriel Niebler <gniebler@suse.com>
Subject: [PATCH 4/4] README: Fix indentation to be consistent
Date:   Thu,  3 Mar 2022 14:28:04 +0100
Message-Id: <20220303132804.4151-5-gniebler@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303132804.4151-1-gniebler@suse.com>
References: <20220303132804.4151-1-gniebler@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Fix two lines that were indented with TABS when everything around them uses spaces

Signed-off-by: Gabriel Niebler <gniebler@suse.com>
---
 README | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 657fb2f6..f43a5a8c 100644
--- a/README
+++ b/README
@@ -83,9 +83,9 @@ Preparing system for tests:
              - setenv TAPE_DEV "tape device for testing xfsdump"
              - setenv RMT_TAPE_DEV "remote tape device for testing xfsdump"
              - setenv RMT_IRIXTAPE_DEV "remote IRIX tape device for testing xfsdump"
-	     - setenv SCRATCH_LOGDEV "device for scratch-fs external log"
+             - setenv SCRATCH_LOGDEV "device for scratch-fs external log"
              - setenv SCRATCH_RTDEV "device for scratch-fs realtime data"
-	     - setenv TEST_LOGDEV "device for test-fs external log"
+             - setenv TEST_LOGDEV "device for test-fs external log"
              - setenv TEST_RTDEV "device for test-fs realtime data"
              - if TEST_LOGDEV and/or TEST_RTDEV, these will always be used.
              - if SCRATCH_LOGDEV and/or SCRATCH_RTDEV, the USE_EXTERNAL
-- 
2.35.1

