Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381CAC77B61
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Mar 2023 15:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjC2PxN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Mar 2023 11:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjC2Pwv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Mar 2023 11:52:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411554EEA
        for <fstests@vger.kernel.org>; Wed, 29 Mar 2023 08:52:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 013AE219C6
        for <fstests@vger.kernel.org>; Wed, 29 Mar 2023 15:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680105163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3XkPcB784nUYypP26+hL6wAl/2zTII0IhIWr5aV/NUY=;
        b=ueBH+SIn95jk8/3Y2QX0Z/1l74sY+cfrzopmWocBrpZcXPCAFOTu/Wabpw9Tk9SpFWZ4UF
        jUR0krhNHZBbNNvuv7M+rMCW7R9jA5VT+SE8/MeSUVE80mBNPTHYvfB/sTNUq1TKUFA/1p
        P97uPrR8fgMm4zShikgAmZCnDQsgW98=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E62BE138FF
        for <fstests@vger.kernel.org>; Wed, 29 Mar 2023 15:52:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jUNWN8peJGQbZQAAMHmgww
        (envelope-from <ailiop@suse.com>)
        for <fstests@vger.kernel.org>; Wed, 29 Mar 2023 15:52:42 +0000
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v2] common: switch _get_{available,total}_space accounting to units of single bytes
Date:   Wed, 29 Mar 2023 17:52:36 +0200
Message-Id: <20230329155236.81521-1-ailiop@suse.com>
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

Switch the _get_available_space df reporting block size from units of
1024b blocks directly to single bytes in order to make free space
accounting fine-grained and independent of any fs block size
assumptions.

Do the same for _get_available_space, since there is no reason for
having an additional conversion step.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 common/rc | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

v2: incorporate changes from reviews by djwong and zlang
* change reporting directly to bytes and avoid conversion step
  altogether
* do the same for _get_available_space

diff --git a/common/rc b/common/rc
index 90749343f3c4..9e4475c0f429 100644
--- a/common/rc
+++ b/common/rc
@@ -4208,9 +4208,7 @@ _get_available_space()
 		echo "Usage: _get_available_space <mnt>"
 		exit 1
 	fi
-	local avail_kb;
-	avail_kb=`$DF_PROG $1 | tail -n1 | awk '{ print $5 }'`
-	echo $((avail_kb * 1024))
+	$DF_PROG -B 1 $1 | tail -n1 | awk '{ print $5 }'
 }
 
 # get the total space in bytes
@@ -4221,9 +4219,7 @@ _get_total_space()
 		echo "Usage: _get_total_space <mnt>"
 		exit 1
 	fi
-	local total_kb;
-	total_kb=`$DF_PROG $1 | tail -n1 | awk '{ print $3 }'`
-	echo $(($total_kb * 1024))
+	$DF_PROG -B 1 $1 | tail -n1 | awk '{ print $3 }'
 }
 
 # return device size in kb
-- 
2.35.3

