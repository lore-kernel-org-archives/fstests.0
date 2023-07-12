Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE30EB64DA
	for <linux-fstests@archiver.kernel.org>; Wed, 12 Jul 2023 16:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjGLQJG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 12 Jul 2023 12:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGLQJG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 12 Jul 2023 12:09:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAC3134
        for <fstests@vger.kernel.org>; Wed, 12 Jul 2023 09:09:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0E0D7227BF;
        Wed, 12 Jul 2023 14:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689173465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Jp3l4lvY5JoJOY1I55HjCRZFzyZ0QgljbHipY1o1/Qo=;
        b=uNzmyT0t0F3qemJITezPJiqlis06QJIS+rHdtEkZisVFtkqdh3KdgM9O0qky8xq72Jrolx
        kevfw8Vfy2djGJmpb3hMOXSjWKHPpWgknxaHUu4IfqwWkvNnAGhXmZRoi6kAFJF2Gr4d/+
        MWoCuNOSJkRX8vdW4fDOy6Bp90ephXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689173465;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Jp3l4lvY5JoJOY1I55HjCRZFzyZ0QgljbHipY1o1/Qo=;
        b=SxIcyWHpxwKUuNCXZ4jjJH0pf2PUs6AniVj+veOYsmif/QvbHXES0v1nhc7Ey5R7fSyTcD
        B9F9Byl/pTdnJ2Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B92D6133DD;
        Wed, 12 Jul 2023 14:51:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 459CKdi9rmRnHAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Wed, 12 Jul 2023 14:51:04 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id d9f8dc66;
        Wed, 12 Jul 2023 14:51:03 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     fstests@vger.kernel.org
Cc:     =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH] common/rc: cleanup old .kmemleak files
Date:   Wed, 12 Jul 2023 15:51:01 +0100
Message-Id: <20230712145101.4286-1-lhenriques@suse.de>
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
 common/rc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/rc b/common/rc
index 741579af82d2..6aa6be704e51 100644
--- a/common/rc
+++ b/common/rc
@@ -4433,6 +4433,8 @@ _capture_kmemleak()
 	local kern_knob="$DEBUGFS_MNT/kmemleak"
 	local leak_file="$1"
 
+	rm -f "$leak_file"
+
 	# Tell the kernel to scan for memory leaks.  Apparently the write
 	# returns before the scan is complete, so do it twice in the hopes
 	# that twice is enough to capture all the leaks.
