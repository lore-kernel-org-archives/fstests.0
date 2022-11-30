Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5A9C4321E
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Nov 2022 16:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiK3QWu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 30 Nov 2022 11:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiK3QWs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Nov 2022 11:22:48 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A021C10DA
        for <fstests@vger.kernel.org>; Wed, 30 Nov 2022 08:22:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C203321B0E;
        Wed, 30 Nov 2022 16:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669825364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=doAKYJiD0p1sKtwM4WUi4hL7Hd2JT4T16uuA3RtClzw=;
        b=fBySCaELeet/ubIIsQkQXvS64ZPTG4/gG0SzqNxov+o1t8aBMpuLRe9WPFcjOGryO+E3uf
        +Tcg9KqKJBi5FEFeg5q4y0tJWxTcg/5ET4RAbi/WwqnP+4eHoA/az9se4mzO95gnGfFcH5
        pdN2Cv3klzqwHGepMngjxf/Z2a8E9yI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669825364;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=doAKYJiD0p1sKtwM4WUi4hL7Hd2JT4T16uuA3RtClzw=;
        b=5fK5MkSZg4IGy2MUkcl8e/l/q4Bidsza04Gx5DV/gUB9GtkBO95hEHbZE5LlzGRwIG8Kam
        5hwNZMW3tIcOqKDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5C9013A70;
        Wed, 30 Nov 2022 16:22:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +rBeLFSDh2MKPAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 30 Nov 2022 16:22:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 34F39A0710; Wed, 30 Nov 2022 17:22:44 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     fstests@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH] generic/273: Limit number of files by available inodes
Date:   Wed, 30 Nov 2022 17:22:39 +0100
Message-Id: <20221130162239.27153-1-jack@suse.cz>
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
 tests/generic/273 | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tests/generic/273 b/tests/generic/273
index f86dae9b8095..80c02d43c7ac 100755
--- a/tests/generic/273
+++ b/tests/generic/273
@@ -50,9 +50,16 @@ _file_create()
 
 	cd $SCRATCH_MNT/origin
 
-	_disksize=`$DF_PROG -B 1 $SCRATCH_MNT | tail -1 | $AWK_PROG '{ print $5 }'`
+	_disksize=$(_get_available_space $SCRATCH_MNT)
+	_free_inodes=$(_get_free_inode $SCRATCH_MNT)
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

