Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A8CC38142
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Jan 2023 12:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjAaMkI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 31 Jan 2023 07:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjAaMkH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 Jan 2023 07:40:07 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2122640FE
        for <fstests@vger.kernel.org>; Tue, 31 Jan 2023 04:40:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D803222880;
        Tue, 31 Jan 2023 12:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675168805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mie2Jhj5jsAKJjiWzt8cPvTBTjsRWLS2A69Zu/HH/T0=;
        b=igDTPsT4XvgaDZO1gts25PPlXCfnr+jJ5YfSmeI2oMSGYI3kY4C1z1F+oSTyb40DU7J+PT
        EM6J0wXd1yo6TEWfu2vkKzwg5E0wyt60ksqr71QgxTUUI8zELxM4HHRPEusKMcnayaYBvQ
        7AvSbUPM40rmeEP86vlqVowuqc3JH30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675168805;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mie2Jhj5jsAKJjiWzt8cPvTBTjsRWLS2A69Zu/HH/T0=;
        b=tyMOa/BAmWbXy/cerb0p699dK2fsq6vrAo6SGg3q14i7BXlLcq85v+gmpJW4WV2o6hPDrP
        FrAGNqvtU7fGJvCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C91F5139E0;
        Tue, 31 Jan 2023 12:40:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0km8MCUM2WNuEQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 31 Jan 2023 12:40:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 188A1A06D7; Tue, 31 Jan 2023 13:40:05 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <fstests@vger.kernel.org>
Cc:     Zorro Lang <zlang@redhat.com>, Jan Kara <jack@suse.cz>,
        David Disseldorp <ddiss@suse.de>
Subject: [PATCH v3 1/3] common: Provide blocksize and ecclength to udf fsck
Date:   Tue, 31 Jan 2023 13:39:57 +0100
Message-Id: <20230131124005.14207-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230131123809.28200-1-jack@suse.cz>
References: <20230131123809.28200-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

udf_test program used for verifying filesystem is not able to determine
filesystem blocksize. Provide it in the options together with disabling
ecclength as it is not used on harddrives.

Reviewed-by: David Disseldorp <ddiss@suse.de>
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

