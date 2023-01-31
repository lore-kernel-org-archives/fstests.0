Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55999C636CC
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Jan 2023 12:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjAaMkJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 31 Jan 2023 07:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjAaMkI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 Jan 2023 07:40:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FD55BAD
        for <fstests@vger.kernel.org>; Tue, 31 Jan 2023 04:40:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D9C7F2064C;
        Tue, 31 Jan 2023 12:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675168805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KVWZZJrX1OB52h4yA8g84IfBCLmOm8y4yAqmjPArMvk=;
        b=PSy9KID0EOtjb+QarWb6+PEmddmuCvLkuKb7pD6bcpv0uo4RCLTzTXHGQBEzglC4nLHSsC
        dyc7fy0fsi97zK0WqWmeMZmM52Cc3dY2aMg2cnUrREYV6p5U/IscJDfWBphZ8ve5TsFU3K
        x5nlNR8tjLCjUFK1a/wFNhE15OQUuvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675168805;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KVWZZJrX1OB52h4yA8g84IfBCLmOm8y4yAqmjPArMvk=;
        b=Gs8HLjKF4CoWg2wBmQ8ehyhv3UEeLrrWiHOJ+Gb134oeDnaVRP4Oo0PXBaS/5Gza50maQE
        0h4MGy7ij0Ah97Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD0DD13A14;
        Tue, 31 Jan 2023 12:40:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kjy5MCUM2WNyEQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 31 Jan 2023 12:40:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1F337A06D8; Tue, 31 Jan 2023 13:40:05 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <fstests@vger.kernel.org>
Cc:     Zorro Lang <zlang@redhat.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v3 2/3] common: Unmount udf filesystem prior checking
Date:   Tue, 31 Jan 2023 13:39:58 +0100
Message-Id: <20230131124005.14207-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230131123809.28200-1-jack@suse.cz>
References: <20230131123809.28200-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

_check_udf_filesystem forgot to unmount the filesystem prior to checking
it. That was leading to check failures.

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

