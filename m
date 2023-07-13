Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CF7EB64DD
	for <linux-fstests@archiver.kernel.org>; Thu, 13 Jul 2023 08:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbjGMIfP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 13 Jul 2023 04:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbjGMIel (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 13 Jul 2023 04:34:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F07358A
        for <fstests@vger.kernel.org>; Thu, 13 Jul 2023 01:26:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CA1E81F855;
        Thu, 13 Jul 2023 08:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689236793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kHzRGZ7rUnfC8XKOwXUCvUYUGVG3ukQlRh9Zi8x7M+o=;
        b=E/klTTlhji02B+p3kLlNpWWvOLglqKcrVPtvqGfts9XHWmUj74/Y3HHGtc5zG7nQXoSFTw
        0CMt6bjcd+KlQu4dohxMng5BMqx0TmyOJvG6Is4OaDHpLIG1rQ3zFNYF9Wm7xno1LQpE02
        645tx+xCF7LukIl45LJmaWtNMxxqdsY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689236793;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kHzRGZ7rUnfC8XKOwXUCvUYUGVG3ukQlRh9Zi8x7M+o=;
        b=brRBQNkK/FIWROhXynUvX0IK/oM6DXBPrTODE2hf8HHExlrbgBWmx2JMx2OHQCgsRTzUN1
        TxZI/sa+BJCLtYBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 882ED133D6;
        Thu, 13 Jul 2023 08:26:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eGLqHTm1r2RwLQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 13 Jul 2023 08:26:33 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id c72b5c9d;
        Thu, 13 Jul 2023 08:26:32 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     fstests@vger.kernel.org
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH v3] common/rc: cleanup old .kmemleak files
Date:   Thu, 13 Jul 2023 09:26:31 +0100
Message-Id: <20230713082631.10666-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

I've spent a non-negligible amount of time looking into a kmemleak that
didn't exist in the code I was testing because there was an old .kmemleak
file in the results directory.  I don't think this is an intended behaviour,
so I'm proposing to remove these files everytime we capture the result of a
new scan.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 common/rc | 4 ++++
 1 file changed, 4 insertions(+)

Changes since v2:
Incorporated comment from Darrick to explain the usage of '-f' in the test

Changes since v1:
I realised that _capture_kmemleak() is called with /dev/null as argument, so
this version is probably better.

diff --git a/common/rc b/common/rc
index 741579af82d2..5c4429ed0425 100644
--- a/common/rc
+++ b/common/rc
@@ -4433,6 +4433,10 @@ _capture_kmemleak()
 	local kern_knob="$DEBUGFS_MNT/kmemleak"
 	local leak_file="$1"
 
+	# Some callers pass in /dev/null when they want to clear the
+	# kernel's leak report file and do not care what was in that.
+	[ -f "$leak_file" ] && rm -f "$leak_file"
+
 	# Tell the kernel to scan for memory leaks.  Apparently the write
 	# returns before the scan is complete, so do it twice in the hopes
 	# that twice is enough to capture all the leaks.
