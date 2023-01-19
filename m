Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D8FC00A5A
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Jan 2023 10:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjASKyX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 Jan 2023 05:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjASKyP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Jan 2023 05:54:15 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F2D6DB2B
        for <fstests@vger.kernel.org>; Thu, 19 Jan 2023 02:54:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0A200222C5;
        Thu, 19 Jan 2023 10:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674125652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iYfRtcUb1+DzFAIIQ4epuk09w7soAWIWiFpCd8LkXpw=;
        b=OZFOcB8BP37TZLd8qppYdvNS3BUpcmAdeQsqqwX+7hmmLIE2cdxSxrIOotXw5e6g8WoUDE
        2g4/+448S60gElsAwEWygimP84M3VlvMJ+8yZm5FNzK7KmrrlyfDB7JVZ4LE5jNZYjmV/f
        XiZdg0i6xBZff9+ZzScuDU7VvnogBbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674125652;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iYfRtcUb1+DzFAIIQ4epuk09w7soAWIWiFpCd8LkXpw=;
        b=9M/uIuPm00Ky8f+dLNxMa6KbEIDN+OOHB7e7RQG/U/qJD0OfYIzq5sVAxxtLW6XtxyM74k
        +8fGiN7eKub8XuAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ECACB139F0;
        Thu, 19 Jan 2023 10:54:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0mDHOVMhyWPlKwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 19 Jan 2023 10:54:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D5D72A06B5; Thu, 19 Jan 2023 11:54:10 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <fstests@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] common: Unmount udf filesystem prior checking
Date:   Thu, 19 Jan 2023 11:54:03 +0100
Message-Id: <20230119105410.9236-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230119104618.28701-1-jack@suse.cz>
References: <20230119104618.28701-1-jack@suse.cz>
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
index de94e5a4cde4..df6f237cabaa 100644
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
     local blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`
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

