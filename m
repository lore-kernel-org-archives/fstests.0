Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C67C38142
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Jan 2023 10:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjASKyW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 Jan 2023 05:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjASKyO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Jan 2023 05:54:14 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B17683C2
        for <fstests@vger.kernel.org>; Thu, 19 Jan 2023 02:54:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 153395CC7B;
        Thu, 19 Jan 2023 10:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674125652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=500ErLsOCmMZwXc7G02TVzE1AfTmTJ4w1cbpZ350qno=;
        b=WDZviCHt0OBsjHn7p6cU14i3lbsae9oF/vWtuYIdlignxWWZX6FG7WXpuZ4eX6OC7pnZ8o
        puVjaWJ/q6xEeq6u4qx0/rlTqjGzZjUUDXUCHI6GxVSMv3jmZ69BXThcumDoKDrsFVrD4V
        SuWNVIZhg+ocTr87+AlFX20z0BAGHfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674125652;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=500ErLsOCmMZwXc7G02TVzE1AfTmTJ4w1cbpZ350qno=;
        b=o7xYvamJjpyuoq5t6YP0ByLnSESjv/4l+YukQv7xBkFzFDwYCme9akwfWuTeBwWi+pzQzk
        dw5hVbR6PZAaQACg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06BDE139ED;
        Thu, 19 Jan 2023 10:54:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XZSyAVQhyWPmKwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 19 Jan 2023 10:54:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D0491A06B4; Thu, 19 Jan 2023 11:54:10 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <fstests@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] common: Provide blocksize and ecclength to udf fsck
Date:   Thu, 19 Jan 2023 11:54:02 +0100
Message-Id: <20230119105410.9236-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230119104618.28701-1-jack@suse.cz>
References: <20230119104618.28701-1-jack@suse.cz>
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
index 8060c03b7d18..de94e5a4cde4 100644
--- a/common/rc
+++ b/common/rc
@@ -3075,9 +3075,13 @@ _check_udf_filesystem()
     fi
 
     local device=$1
-    local opt_arg=""
+    local blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`
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

