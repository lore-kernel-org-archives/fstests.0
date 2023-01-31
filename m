Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62F4C636D3
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Jan 2023 12:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjAaMkJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 31 Jan 2023 07:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjAaMkI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 Jan 2023 07:40:08 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221DA4696
        for <fstests@vger.kernel.org>; Tue, 31 Jan 2023 04:40:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D6F2922877;
        Tue, 31 Jan 2023 12:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675168805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pfp5o58ccdf2xgm1YypZhtoaQWMC//ij1ULXNxnj0Yw=;
        b=mgUUf1bshzzLo+5vugk/zLmBvJnU9DjcX0RMBA7wcGOswkTBS6ZUz3SNvJ6EIHYrEZSeIy
        wDfm3sIuU1Mj0IbsAPzCU8shJE4rj/gWKRHTqlJtRJFi4V4I9o8OI0I/MDhEkdIC5fn2Tj
        MGws7BbOldvEg/RRLKPvDzFxO4OA5Cg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675168805;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pfp5o58ccdf2xgm1YypZhtoaQWMC//ij1ULXNxnj0Yw=;
        b=t+DS9BVLcjM/K7ff6QNNNAid004Tkr/S4tCyY4ec5UuV/tAJgcHTm7vKFDg5NeR74vFJV2
        80ZjPZ5ejsL7QfCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA30F13A06;
        Tue, 31 Jan 2023 12:40:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZhjFMCUM2WNvEQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 31 Jan 2023 12:40:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 25CEEA06E1; Tue, 31 Jan 2023 13:40:05 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <fstests@vger.kernel.org>
Cc:     Zorro Lang <zlang@redhat.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v3 3/3] common: Improve blocksize support for udf
Date:   Tue, 31 Jan 2023 13:39:59 +0100
Message-Id: <20230131124005.14207-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230131123809.28200-1-jack@suse.cz>
References: <20230131123809.28200-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add better support for blocksize selection in _scratch_mkfs_sized
(accept another variant of mkfs options, select correct default block
size if not specified). Also add blocksize selection support to
_scratch_mkfs_blocksized.

For _check_udf_filesystem to keep working when blocksize is not
specified in MKFS_OPTIONS, add detection of blocksize from a mounted
filesystem.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 common/rc | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/common/rc b/common/rc
index 7f80afe7aeec..e49918c9deab 100644
--- a/common/rc
+++ b/common/rc
@@ -922,9 +922,15 @@ _scratch_mkfs_sized()
 	btrfs)
 		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-s ?+([0-9]+).*/\1/p'`
 		;;
-	ext2|ext3|ext4|ext4dev|udf|reiser4|ocfs2|reiserfs)
+	ext2|ext3|ext4|ext4dev|reiser4|ocfs2|reiserfs)
 		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`
 		;;
+	udf)
+		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*(-b|--blocksize)[ =]?+([0-9]+).*/\2/p'`
+		if [ -z "$def_blksz" ]; then
+			def_blksz=512
+		fi
+		;;
 	jfs)
 		def_blksz=4096
 		;;
@@ -1116,6 +1122,9 @@ _scratch_mkfs_blocksized()
 		${MKFS_PROG} -t $FSTYP $MKFS_OPTIONS --block_size=$blocksize \
 								$SCRATCH_DEV
 		;;
+	udf)
+		_scratch_mkfs -b $blocksize
+		;;
 	*)
 		_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_blocksized"
 		;;
@@ -3074,17 +3083,18 @@ _check_udf_filesystem()
 	return
     fi
 
+    local device=$1
+    local blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*(-b|--blocksize)[ =]?+([0-9]+).*/\2/p'`
+    if [ -z "$blksz" ]; then
+	blksz=512
+    fi
     # Is the filesystem mounted?
     local type=`_fs_type $device`
     if [ "$type" = "$FSTYP" ]; then
+	blksz=`blockdev --getbsz $device`
 	local mountpoint=`_umount_or_remount_ro $device`
     fi
 
-    local device=$1
-    local blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*(-b|--blocksize)[ =]?+([0-9]+).*/\2/p'`
-    if [ -z "$blksz" ]; then
-	blksz=512
-    fi
     local opt_arg="-ecclength 1 -blocksize $blksz"
     if [ $# -eq 2 ]; then
 	opt_arg+=" -lastvalidblock $(( $2 - 1 ))"
-- 
2.35.3

