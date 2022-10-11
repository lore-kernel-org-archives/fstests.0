Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7882C433FE
	for <linux-fstests@archiver.kernel.org>; Tue, 11 Oct 2022 09:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJKJXh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 11 Oct 2022 05:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiJKJX0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 11 Oct 2022 05:23:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19C07171D
        for <fstests@vger.kernel.org>; Tue, 11 Oct 2022 02:23:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3276A1F953;
        Tue, 11 Oct 2022 09:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1665480201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XVeAUT8Ngoi+vdW5/Lz8iqRSKbphp+Xd9ONxli4pZ+Q=;
        b=wuF5D5/zCJcMADAb5mY7NXDhNx45ur4Jw0UmxslO6KSz69HgbnOo5NEXtZSMG/BQVNGpQ1
        uFgHIEIzLVps5U3Sa17wT4pjAuHQPrM8cDdSpksBf3AYlR/Py9IiATEh2YB2pNNRiXrvGc
        nKVX3sRv4bNbzSx1CNuTpHAW7QGfsxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1665480201;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XVeAUT8Ngoi+vdW5/Lz8iqRSKbphp+Xd9ONxli4pZ+Q=;
        b=mEz5xZu9BWGTuvadFfrLDI01Jr2NiG2Lcyoqp8VUZu+1L05w3h0eE1ohA173Rnt1YKMtWV
        HmyLKk81vddm79DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E744113ACA;
        Tue, 11 Oct 2022 09:23:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qLaNNgg2RWNodQAAMHmgww
        (envelope-from <ddiss@suse.de>); Tue, 11 Oct 2022 09:23:20 +0000
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org
Cc:     David Disseldorp <ddiss@suse.de>
Subject: [PATCH 2/2] seek_sanity_test: drop unused pagesz
Date:   Tue, 11 Oct 2022 11:23:40 +0200
Message-Id: <20221011092340.24857-3-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221011092340.24857-1-ddiss@suse.de>
References: <20221011092340.24857-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

b91889d7 ("seek_sanity_test: use XFS ioctls to determine file allocation
unit size") left this unused, resulting in:

seek_sanity_test.c: In function 'get_io_sizes':
seek_sanity_test.c:70:6: warning: unused variable 'pagesz'
  int pagesz = sysconf(_SC_PAGE_SIZE);
      ^~~~~~

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 src/seek_sanity_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
index 78f835e8..8a586f74 100644
--- a/src/seek_sanity_test.c
+++ b/src/seek_sanity_test.c
@@ -67,7 +67,6 @@ static int get_io_sizes(int fd)
 	off_t pos = 0, offset = 1;
 	struct stat buf;
 	int shift, ret;
-	int pagesz = sysconf(_SC_PAGE_SIZE);
 
 	ret = detect_xfs_alloc_unit(fd);
 	if (!ret)
-- 
2.35.3

