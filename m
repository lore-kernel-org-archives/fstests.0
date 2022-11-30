Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB16C433FE
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Nov 2022 17:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiK3RHy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 30 Nov 2022 12:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiK3RHX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Nov 2022 12:07:23 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6188389AD9
        for <fstests@vger.kernel.org>; Wed, 30 Nov 2022 09:01:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1DAF51F37C;
        Wed, 30 Nov 2022 17:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669827718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=m50Im+G6qXk3eWhTiD0lmfgEsIZo6fBAWGIjNXMvPQg=;
        b=VWkGRrHP8FygYPg4JXdYzMtulyUkIS9h4FmB4Qw2kKvIp3IlpZoyToxeoPq/7GFkjg0l74
        bd6URnMnnmSsGXhqo2/DIJLDsQCS72Mu9Nr0kIohWACicYcHYwwJ3hKSaRf0ZF+h9v5szc
        +N8HjNt8rwiZ0Mx1R+mPXQa8KfRRiqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669827718;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=m50Im+G6qXk3eWhTiD0lmfgEsIZo6fBAWGIjNXMvPQg=;
        b=JhzZvIMtYyCp3F12lhdf86/U6KNJGKV3gTy++o86j6RwN0dEco7JUcj402sNH5A1MRHyWP
        JakZbvAhAlhcvbBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0ECF91331F;
        Wed, 30 Nov 2022 17:01:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wFiYA4aMh2MuTwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 30 Nov 2022 17:01:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9296EA0710; Wed, 30 Nov 2022 18:01:57 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     fstests@vger.kernel.org
Cc:     Filipe Manana <fdmanana@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2] generic/273: Limit number of files by available inodes
Date:   Wed, 30 Nov 2022 18:01:53 +0100
Message-Id: <20221130170153.31924-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Test generic/273 is failing for ext4 with 1k blocksize because it is
creating more files than we have available inodes. Just limit the number
of files created to the number of inodes.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/generic/273 | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

Changes since v1:
* Handle btrfs which reports 0 free inodes

diff --git a/tests/generic/273 b/tests/generic/273
index f86dae9b8095..54c199962421 100755
--- a/tests/generic/273
+++ b/tests/generic/273
@@ -50,9 +50,21 @@ _file_create()
 
 	cd $SCRATCH_MNT/origin
 
-	_disksize=`$DF_PROG -B 1 $SCRATCH_MNT | tail -1 | $AWK_PROG '{ print $5 }'`
+	_disksize=$(_get_available_space $SCRATCH_MNT)
+	_free_inodes=$(_get_free_inode $SCRATCH_MNT)
+	# Some filesystems do not limit number of inodes and return 0
+	if [ $_free_inodes -eq 0 ]; then
+		# Guess one block per inode
+		_free_inodes=$(($_disksize / $block_size))
+	fi
+	# Leave some slack for directories etc.
+	_free_inodes=$(($_free_inodes - $_free_inodes/8))
 	_disksize=$(($_disksize / 3))
-	_num=$(($_disksize / $count / $threads / $block_size))
+	_num=$(($_disksize / $count / $block_size))
+	if [ $_num -gt $_free_inodes ]; then
+		_num=$_free_inodes
+	fi
+	_num=$(($_num/$threads))
 	_count=$count
 	while [ $_i -lt $_num ]
 	do
-- 
2.35.3

