Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F78C27C7C
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Jan 2023 15:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjATPuq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 Jan 2023 10:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjATPun (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 Jan 2023 10:50:43 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C82C79CE
        for <fstests@vger.kernel.org>; Fri, 20 Jan 2023 07:50:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2ABEF3370E;
        Fri, 20 Jan 2023 15:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674229837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w9vGq20xHZBon1MOFoOxs/jlJXff6hhuIyyAxMc3T8E=;
        b=gtQptHVtt6mV2NBYhUuQf73uBRaVuls5w1CkAQebArRw9VwnwQZgASSrVezRo1N18LUGcX
        YecZUOJSWOE/Ow2YovLM+q18L/pefW6qmV6H0bOidgqGbgpoij91ZFpySAhyjmWPN8dB/l
        qzg0vxYhi4xpu+RKJekVZZEwzfcohA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674229837;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w9vGq20xHZBon1MOFoOxs/jlJXff6hhuIyyAxMc3T8E=;
        b=r/6gR+ZxVT+mOmM2wwoLBYhWU/fS5deFdloGlWA2/EPjmOKOE6fqrMe9yxZfYM6hdUd2zV
        +klJiexELGpb83DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D12813251;
        Fri, 20 Jan 2023 15:50:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CFsYB024ymNwEwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 20 Jan 2023 15:50:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9A09DA06B6; Fri, 20 Jan 2023 16:50:36 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <fstests@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>, David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 2/2] common: Unmount udf filesystem prior checking
Date:   Fri, 20 Jan 2023 16:50:30 +0100
Message-Id: <20230120155034.22349-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230120154944.25573-1-jack@suse.cz>
References: <20230120154944.25573-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

_check_udf_filesystem forgot to unmount the filesystem prior to checking
it. That was leading to check failures.

Reviewed-by: David Disseldorp <ddiss@suse.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 common/rc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/common/rc b/common/rc
index bf3effa4c1ed..7f80afe7aeec 100644
--- a/common/rc
+++ b/common/rc
@@ -3074,6 +3074,12 @@ _check_udf_filesystem()
 	return
     fi
 
+    # Is the filesystem mounted?
+    local type=`_fs_type $device`
+    if [ "$type" = "$FSTYP" ]; then
+	local mountpoint=`_umount_or_remount_ro $device`
+    fi
+
     local device=$1
     local blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*(-b|--blocksize)[ =]?+([0-9]+).*/\2/p'`
     if [ -z "$blksz" ]; then
@@ -3090,6 +3096,10 @@ _check_udf_filesystem()
 	_udf_test_known_error_filter | \
 	grep -E -iv "Error count:.*[0-9]+.*total occurrences:.*[0-9]+|Warning count:.*[0-9]+.*total occurrences:.*[0-9]+" && \
         echo "Warning UDF Verifier reported errors see $seqres.checkfs." && return 1
+    # Remount the filesystem
+    if [ "$type" = "$FSTYP" ]; then
+	_mount_or_remount_rw "$MOUNT_OPTIONS" $device $mountpoint
+    fi
     return 0
 }
 
-- 
2.35.3

