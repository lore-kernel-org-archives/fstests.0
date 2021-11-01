Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9D2C433EF
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Nov 2021 13:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4003661051
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Nov 2021 13:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhKAN7e (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 1 Nov 2021 09:59:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54572 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhKAN7d (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 1 Nov 2021 09:59:33 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B194C2195B;
        Mon,  1 Nov 2021 13:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635775019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MsofieGP9NgnGlQEK9RJWH2ZdMt+AEWKbOcdB0Y9Yoc=;
        b=c7Ei/pi/9MrO/5WjQDBw/FV772m6S9/ufIWIwmU4aSNlxA1B0LX1qWu+DKOLp/ldN6+zLz
        3xsY68IzZPvlX5hiF9liCeNnnb1HFzMnuT5UIciTLbVLgz4DTiWuovWVTvdRc4H8FY+0p1
        GF1zhG2of7PlJpsKwpdreNWUgkbkBRo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 716221342A;
        Mon,  1 Nov 2021 13:56:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q1ngFyvyf2HDGAAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 01 Nov 2021 13:56:59 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     fstests@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] common/rc: Fix check for SCRATCH_DEV_POOL presence in _scratch_dev_pool_get
Date:   Mon,  1 Nov 2021 15:56:58 +0200
Message-Id: <20211101135658.385131-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211101133511.383232-1-nborisov@suse.com>
References: <20211101133511.383232-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Current check is buggy because it can never trigger as even if
SCRATCH_DEV_POOL is not defined config_ndevs will get a value of 0 from
'wc -w', this in turn makes 'typeset -p config_ndevs' always return 0,
triggering the existing check a noop.

Fix this by explicitly checking for the presence of SCHRATC_DEV_POOL

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

Eryu,

Please use this patch as it's a more proper fix

 common/rc | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/common/rc b/common/rc
index 7f693d3922e8..07b69880eea6 100644
--- a/common/rc
+++ b/common/rc
@@ -917,15 +917,15 @@ _scratch_dev_pool_get()
 		_fail "Usage: _scratch_dev_pool_get ndevs"
 	fi

-	local test_ndevs=$1
-	local config_ndevs=`echo $SCRATCH_DEV_POOL| wc -w`
-	local -a devs="( $SCRATCH_DEV_POOL )"
-
-	typeset -p config_ndevs >/dev/null 2>&1
+	typeset -p SCRATCH_DEV_POOL >/dev/null 2>&1
 	if [ $? -ne 0 ]; then
 		_fail "Bug: cant find SCRATCH_DEV_POOL ndevs"
 	fi

+	local test_ndevs=$1
+	local config_ndevs=`echo $SCRATCH_DEV_POOL| wc -w`
+	local -a devs="( $SCRATCH_DEV_POOL )"
+
 	if [ $config_ndevs -lt $test_ndevs ]; then
 		_notrun "Need at least test requested number of ndevs $test_ndevs"
 	fi
--
2.17.1

