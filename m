Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8651DC05027
	for <linux-fstests@archiver.kernel.org>; Thu,  2 Feb 2023 21:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjBBVNl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 2 Feb 2023 16:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjBBVNk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 2 Feb 2023 16:13:40 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2835A373
        for <fstests@vger.kernel.org>; Thu,  2 Feb 2023 13:13:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0CE2A1FDBB
        for <fstests@vger.kernel.org>; Thu,  2 Feb 2023 21:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675372412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=HvVoz8aoDpemURp01OtGmisMo9Jv5+Bt60uQOQ/SD6A=;
        b=dJ6P2GOf+qRIaf8tJ9GOgn2hIOS7mXcSxSsm+wnu6JQj1YfqSi+reM84SGXxwhWgItXc8V
        /FlDTTOjPIL1++QL5uH0Mt3NF5k9WQKVKr3Le9Vn5DZcOOl3aFRGkkE+9DTZ9aQg5j0pyF
        Zoff5/IVIz8TitHniydsXAO9CHuBNu0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2322139D0
        for <fstests@vger.kernel.org>; Thu,  2 Feb 2023 21:13:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KDlLOnsn3GOvAQAAMHmgww
        (envelope-from <ailiop@suse.com>)
        for <fstests@vger.kernel.org>; Thu, 02 Feb 2023 21:13:31 +0000
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] xfs/191: fix xattr leaf block emptying on 64k blocksized fses
Date:   Thu,  2 Feb 2023 22:09:40 +0100
Message-Id: <20230202210940.95791-1-ailiop@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This test is failing on filesystems with 64k blocksize since the leaf
hdr.firstused field is 16 bit and as such trying to reset it to $dbsize
overflows and is rejected by xfs_db. The leaf is never properly resetted
and the discrepancy is picked up by xfs_repair, thus failing the test.

Fix it by setting it to XFS_ATTR3_LEAF_NULLOFF (0) as this is the proper
on-disk value to indicate an empty leaf on 64k blocksized fses.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 tests/xfs/191 | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tests/xfs/191 b/tests/xfs/191
index 4f0a9b9eeef5..8dd875fcd28b 100755
--- a/tests/xfs/191
+++ b/tests/xfs/191
@@ -78,10 +78,20 @@ make_empty_leaf() {
 
 	base=$(_scratch_xfs_get_metadata_field "hdr.freemap[0].base" "inode $inum" "ablock 0")
 
+	# 64k dbsize is a special case since it overflows the 16 bit firstused
+	# field and it needs to be set to the special XFS_ATTR3_LEAF_NULLOFF (0)
+	# value to indicate a null leaf. For more details see kernel commit:
+	# e87021a2bc10 ("xfs: use larger in-core attr firstused field and detect overflow").
+	if [ $dbsize -eq 65536 ]; then
+		firstused=0;
+	else
+		firstused=$dbsize;
+	fi
+
 	_scratch_xfs_db -x -c "inode $inum" -c "ablock 0" \
 		-c "write -d hdr.count 0" \
 		-c "write -d hdr.usedbytes 0" \
-		-c "write -d hdr.firstused $dbsize" \
+		-c "write -d hdr.firstused $firstused" \
 		-c "write -d hdr.freemap[0].size $((dbsize - base))" \
 		-c print >> $seqres.full
 }
-- 
2.35.3

