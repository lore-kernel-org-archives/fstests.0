Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CB3EB64DD
	for <linux-fstests@archiver.kernel.org>; Wed, 12 Jul 2023 16:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjGLQfG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 12 Jul 2023 12:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjGLQfF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 12 Jul 2023 12:35:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0C4106
        for <fstests@vger.kernel.org>; Wed, 12 Jul 2023 09:35:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 15E6A1FDCE;
        Wed, 12 Jul 2023 16:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689179703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mZ0Sg/wcF0tufce59an2jsLWUIu0ZxaGPH8f30QUbho=;
        b=0JDPJTJZlln2k8MrSEkdYewayi38+DCa5Q8JAbY1u1cdZGX2Sr8JnTuZSGxwuGcIFKG3tu
        pfoATe5JKQh17jdby3IGJ0PCY3tBUn9xB9h9ObpcOE6h+ezf5+/+wIkwO0iPincfrS5xd8
        h2iSXaf5cvc/NnRxK3/O1jHIBkipkGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689179703;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mZ0Sg/wcF0tufce59an2jsLWUIu0ZxaGPH8f30QUbho=;
        b=QReJJz8QrM9j50r8pnln4fUpNn7OFgZ9SXHD3YqsGhVP5NmA5HgnUhRkGJuDdos0eX+2G4
        yH3zzw70xjlMj4DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D324F13336;
        Wed, 12 Jul 2023 16:35:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OzBUMDbWrmTlcwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Wed, 12 Jul 2023 16:35:02 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 86ce90d6;
        Wed, 12 Jul 2023 16:35:01 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     fstests@vger.kernel.org
Cc:     =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH v2] common/rc: cleanup old .kmemleak files
Date:   Wed, 12 Jul 2023 17:35:00 +0100
Message-Id: <20230712163500.5871-1-lhenriques@suse.de>
In-Reply-To: <20230712145101.4286-1-lhenriques@suse.de>
References: <20230712145101.4286-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

I've spent a non-negligible amount of time looking into a kmemleak that
didn't exist in the code I was testing because there was an old .kmemleak
file in the results directory.  I don't think this is an intended behaviour,
so I'm proposing to remove these files everytime we capture the result of a
new scan.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 common/rc | 2 ++
 1 file changed, 2 insertions(+)

Changes since v1:
I realised that _capture_kmemleak() is called with /dev/null as argument, so
this version is probably better.

diff --git a/common/rc b/common/rc
index 741579af82d2..6850889e815e 100644
--- a/common/rc
+++ b/common/rc
@@ -4433,6 +4433,8 @@ _capture_kmemleak()
 	local kern_knob="$DEBUGFS_MNT/kmemleak"
 	local leak_file="$1"
 
+	[ -f "$leak_file" ] && rm -f "$leak_file"
+
 	# Tell the kernel to scan for memory leaks.  Apparently the write
 	# returns before the scan is complete, so do it twice in the hopes
 	# that twice is enough to capture all the leaks.
