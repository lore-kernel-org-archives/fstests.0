Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2360C76196
	for <linux-fstests@archiver.kernel.org>; Tue, 28 Mar 2023 15:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjC1PBk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 28 Mar 2023 11:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbjC1PBj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Mar 2023 11:01:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9966E3B1
        for <fstests@vger.kernel.org>; Tue, 28 Mar 2023 08:01:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5C45D219FF
        for <fstests@vger.kernel.org>; Tue, 28 Mar 2023 15:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680015672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=WcHkDw4fkWzdYFWj0rHihg38UWH706znpLyLDXajH9M=;
        b=JgY+VrBglEQdHZYphHoivd5ZFbidGp/jm4AIKMMunm9zc2lkpASaosHhvwLwpHF0A4vhMl
        sC9MWzj3DaL1YShxybK0Tn3KTOx1A6psCm7liSlJfU5E5pUUfTpe/5wFSiePa4vtepyLoq
        cYf+iWClWOs4Ney1Uu+nwJhHqfPEANA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4EA1C1390D
        for <fstests@vger.kernel.org>; Tue, 28 Mar 2023 15:01:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9AJvEjgBI2RLDAAAMHmgww
        (envelope-from <ailiop@suse.com>)
        for <fstests@vger.kernel.org>; Tue, 28 Mar 2023 15:01:12 +0000
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] common: switch _get_available_space accounting to units of 512 bytes
Date:   Tue, 28 Mar 2023 17:01:04 +0200
Message-Id: <20230328150104.129486-1-ailiop@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

xfs/220 relies on detecting free space changes after truncation of
single filesystem blocks, and this fails when the fs block size is 512b.

By default df is counting 1024b block units and as such is not reporting
any change in the number of available blocks after freeing just a 512b
block.

Switch the df reporting block size from units of 1024b blocks to 512b
blocks to accommodate accounting for smaller granularity fs block sizes.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 common/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 90749343f3c4..a32bbe3c0b5f 100644
--- a/common/rc
+++ b/common/rc
@@ -4209,8 +4209,8 @@ _get_available_space()
 		exit 1
 	fi
 	local avail_kb;
-	avail_kb=`$DF_PROG $1 | tail -n1 | awk '{ print $5 }'`
-	echo $((avail_kb * 1024))
+	avail_kb=`$DF_PROG --block-size=512 $1 | tail -n1 | awk '{ print $5 }'`
+	echo $((avail_kb * 512))
 }
 
 # get the total space in bytes
-- 
2.35.3

