Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22064C433F5
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Nov 2021 13:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA40E610E8
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Nov 2021 13:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhKANhv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 1 Nov 2021 09:37:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53990 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhKANhu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 1 Nov 2021 09:37:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C6655218B5;
        Mon,  1 Nov 2021 13:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635773713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UEmy219kQQmXXlBgIZq770XsjdKUkqhP6ldYtCUiljk=;
        b=lRauyZFReQrIcl5xC/6fbHQviFl5gqxtyMTE+OAvPdiS2C8EtdBjHbu5cFLB9STjLdIZcF
        iPBkTWVdAQIw0Y8Rhaeu/fpFYYtP0ag8U5bPs5bA54wQJHJLyipZnGU7/CE7doogZKUtFu
        swJtlOI4EiFD1Z9k5CQZe7H5SV17KUQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A55D133FE;
        Mon,  1 Nov 2021 13:35:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id y8+fHhHtf2GHEQAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 01 Nov 2021 13:35:13 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     fstests@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] common/rc: Remove impossible check
Date:   Mon,  1 Nov 2021 15:35:11 +0200
Message-Id: <20211101133511.383232-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

config_ndevs is guaranteed to be defined in _scratch_dev_pool_get
irrespective of whether SCRATCH_DEV_POOL is defined or not. If it's not
then wc -w will simply return 0 which simply sets config_ndevs to 0.
This causes 'typeset -p config_ndevs' to always succeeds and return 0 so
the check for the return value of typeset is effectively a noop. Just
remove it.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 common/rc | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/common/rc b/common/rc
index 7f693d3922e8..6f7467b574c2 100644
--- a/common/rc
+++ b/common/rc
@@ -921,11 +921,6 @@ _scratch_dev_pool_get()
 	local config_ndevs=`echo $SCRATCH_DEV_POOL| wc -w`
 	local -a devs="( $SCRATCH_DEV_POOL )"
 
-	typeset -p config_ndevs >/dev/null 2>&1
-	if [ $? -ne 0 ]; then
-		_fail "Bug: cant find SCRATCH_DEV_POOL ndevs"
-	fi
-
 	if [ $config_ndevs -lt $test_ndevs ]; then
 		_notrun "Need at least test requested number of ndevs $test_ndevs"
 	fi
-- 
2.17.1

