Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF8BC25B4E
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Jan 2023 15:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjATPur (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 Jan 2023 10:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjATPup (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 Jan 2023 10:50:45 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6A49742
        for <fstests@vger.kernel.org>; Fri, 20 Jan 2023 07:50:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 190483370B;
        Fri, 20 Jan 2023 15:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674229837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FWM9wNPl53Di8xEtU8vKG3Ig/nLHgoGbPLgo+jprM0s=;
        b=h4D5SjuQdxKNY9t8HD8WFPGZ7HiMTsZjAxGkiDlUJMFJOlGSuzibGbHRwjX/7sCxxSniFp
        Z4XpT25O2D7TLy24XL8Hk+3N76GM+NECJ87PEw4GH3QfP3V+H8Lhah/WbLrcXlCpRuN+L+
        Mvww0hJjGC0o6uRWBeAc9l0B2/PhOt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674229837;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FWM9wNPl53Di8xEtU8vKG3Ig/nLHgoGbPLgo+jprM0s=;
        b=59lpzhQgdlZ9k2RtmLxnw/HWUQX5jI+Kwa+WXgivF/Uy4jkFeOusKgx4VpNXJsJlDrqQ5m
        KaYqT624PLSf/oDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C3E913251;
        Fri, 20 Jan 2023 15:50:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MDH+Ak24ymNvEwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 20 Jan 2023 15:50:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9331BA06B5; Fri, 20 Jan 2023 16:50:36 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <fstests@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH v2 1/2] common: Provide blocksize and ecclength to udf fsck
Date:   Fri, 20 Jan 2023 16:50:29 +0100
Message-Id: <20230120155034.22349-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230120154944.25573-1-jack@suse.cz>
References: <20230120154944.25573-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

udf_test program used for verifying filesystem is not able to determine
filesystem blocksize. Provide it in the options together with disabling
ecclength as it is not used on harddrives.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 common/rc | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 8060c03b7d18..bf3effa4c1ed 100644
--- a/common/rc
+++ b/common/rc
@@ -3075,9 +3075,13 @@ _check_udf_filesystem()
     fi
 
     local device=$1
-    local opt_arg=""
+    local blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*(-b|--blocksize)[ =]?+([0-9]+).*/\2/p'`
+    if [ -z "$blksz" ]; then
+	blksz=512
+    fi
+    local opt_arg="-ecclength 1 -blocksize $blksz"
     if [ $# -eq 2 ]; then
-	opt_arg="-lastvalidblock $(( $2 - 1 ))"
+	opt_arg+=" -lastvalidblock $(( $2 - 1 ))"
     fi
 
     rm -f $seqres.checkfs
-- 
2.35.3

