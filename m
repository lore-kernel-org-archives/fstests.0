Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0DBC4167B
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Dec 2022 23:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiLLXHf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 12 Dec 2022 18:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbiLLXHe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 12 Dec 2022 18:07:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ED61B783
        for <fstests@vger.kernel.org>; Mon, 12 Dec 2022 15:07:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 46412337E6;
        Mon, 12 Dec 2022 23:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1670886451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JmwC85hKQFhfaYeWk3vERnOwRrvk138oCJrVtmkMvgE=;
        b=wZVHsrvC6Ssq6By/fRcbRrfrZ86Yw1sTY69EsyZr3Io1Z868plnsmDf9+XUF4GoGI2gw9Z
        IwncsRvWZR5ZFpGJyJePxLtoXpaFer/fyRmio0DUXeSSFbRQRtVunMzrOlnxKZek34XmU3
        39Iah3+DY1NdA9AOe5Jn5TBjCZct6gU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1670886451;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JmwC85hKQFhfaYeWk3vERnOwRrvk138oCJrVtmkMvgE=;
        b=yzylAkfzm583G7ukqoUsqbKmiXwNgdUrZ3OitKwCRihVbEUv50Ohbwt/kHwMflbRNTTFRI
        Vr0iHHIDNkPUZkAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2076313456;
        Mon, 12 Dec 2022 23:07:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kGesBjO0l2NtNQAAMHmgww
        (envelope-from <ddiss@suse.de>); Mon, 12 Dec 2022 23:07:31 +0000
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org
Cc:     David Disseldorp <ddiss@suse.de>
Subject: [PATCH 2/3] tests/generic/027: use c-style for loops
Date:   Tue, 13 Dec 2022 00:08:19 +0100
Message-Id: <20221212230820.3466-2-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221212230820.3466-1-ddiss@suse.de>
References: <20221212230820.3466-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 tests/generic/027 | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tests/generic/027 b/tests/generic/027
index 47f1981d..002be120 100755
--- a/tests/generic/027
+++ b/tests/generic/027
@@ -53,22 +53,18 @@ fi
 
 dir=$SCRATCH_MNT/testdir
 echo -n "iteration" >>$seqres.full
-i=1
-while [ $i -le $loop ]; do
+for ((i = 1; i < loop; i++)); do
 	echo -n " $i" >>$seqres.full
-	nr_worker=8
-	while [ $nr_worker -gt 0 ]; do
+	for ((nr_worker = 8; nr_worker > 0; nr_worker--)); do
 		# half buffered I/O half direct I/O
 		if [ `expr $nr_worker % 2` -eq 0 ]; then
 			create_file $dir/$nr_worker -d >>$seqres.full &
 		else
 			create_file $dir/$nr_worker >>$seqres.full &
 		fi
-		let nr_worker=$nr_worker-1
 	done
 	wait
 	rm -rf $dir
-	let i=$i+1
 done
 _scratch_unmount
 
-- 
2.35.3

