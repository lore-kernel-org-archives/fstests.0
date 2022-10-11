Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278D6C4332F
	for <linux-fstests@archiver.kernel.org>; Tue, 11 Oct 2022 09:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiJKJXi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 11 Oct 2022 05:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJKJX0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 11 Oct 2022 05:23:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BD772EE6
        for <fstests@vger.kernel.org>; Tue, 11 Oct 2022 02:23:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E296E1F8D5;
        Tue, 11 Oct 2022 09:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1665480200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S+TiayvXFkz7buOpQxbSrqKE/FvYR4gPYjB5bEA3yuw=;
        b=ht+5pDxoj/mlITW+H/MlR/veRlgdpOhvUdMRLvBpU45d83Bqo4Ak0B8gMPoJtu5AKY2P+g
        z4CUKkVHYnpQf7Od4wiWKTENvexPQY6M3GcQjzkuD+1x/60i+cokAndrdB5BzNBohCjN7x
        6FMMaPtS2h9R79+FE1y58Ph9wtqF9Dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1665480200;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S+TiayvXFkz7buOpQxbSrqKE/FvYR4gPYjB5bEA3yuw=;
        b=JAbHstEcZhsiocnn/py1f5IekCfcc62LvZfKB3/r2zSWdIKUsVuN9LSdBmYcdhYPLChQ88
        FLPz4nGS6k0wk+Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB2BA13ACD;
        Tue, 11 Oct 2022 09:23:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IMFfKAg2RWNodQAAMHmgww
        (envelope-from <ddiss@suse.de>); Tue, 11 Oct 2022 09:23:20 +0000
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org
Cc:     David Disseldorp <ddiss@suse.de>
Subject: [PATCH 1/2] lsqa.pl: fix --header output
Date:   Tue, 11 Oct 2022 11:23:39 +0200
Message-Id: <20221011092340.24857-2-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221011092340.24857-1-ddiss@suse.de>
References: <20221011092340.24857-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

7e98d41a ("fstests: move test group info to test files") replaces the
post-header "seq" assignment with "./common/preamble\n_begin_fstest ..."
Update lsqa.pl to recognise the "./common/preamble" line as a header
divider.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 lsqa.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lsqa.pl b/lsqa.pl
index 8ca1167f..63bee582 100755
--- a/lsqa.pl
+++ b/lsqa.pl
@@ -99,7 +99,7 @@ sub get_qa_header($) {
 	m/^# SPDX/i		and next; # SPDX tags
 	m/^# Copyright/i	and next; # Copyright tags
 	m/^#\s*\-{10}/		and last; # dashed lines
-	m/^seq/i		and last; # test start
+	m/^\. \.\/common\/preamble/ and last; # test start
 
 	s/^# *//;
 
-- 
2.35.3

