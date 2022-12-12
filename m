Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69585C00145
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Dec 2022 23:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiLLXHe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 12 Dec 2022 18:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiLLXHd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 12 Dec 2022 18:07:33 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0A21B786
        for <fstests@vger.kernel.org>; Mon, 12 Dec 2022 15:07:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5D6D0337EC;
        Mon, 12 Dec 2022 23:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1670886451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U9t0bjFqLRCCXSO9jyTGI4Ew9eD3z6E7ZslH0ro/uwU=;
        b=wVhei5TGtZkEaShbfPpYwrqDt6/UXcMx9y4+w9V2U9Wbwg0fYhdfXalhLaXc+xzEAn2IrH
        YuSglML432L/Ce3sxezeqaQXPLLeTjL84iViuyOsxb/gRKI2bLWHPEsl34q30SgoLh4N3K
        OpM7jhcQaRFYmlxNTlZOubDaP1Im72s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1670886451;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U9t0bjFqLRCCXSO9jyTGI4Ew9eD3z6E7ZslH0ro/uwU=;
        b=MWU0QLrEynqV6xPGyRGJz8054NV4x6voH/X58PDWqB8YlFIjL0BPMKgO3+fS3kemEvn992
        nzD++yrzkUxpWLDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 41EEA138F4;
        Mon, 12 Dec 2022 23:07:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UFe4DjO0l2NtNQAAMHmgww
        (envelope-from <ddiss@suse.de>); Mon, 12 Dec 2022 23:07:31 +0000
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org
Cc:     David Disseldorp <ddiss@suse.de>
Subject: [PATCH 3/3] check: ensure sect_stop is initialized if interrupted
Date:   Tue, 13 Dec 2022 00:08:20 +0100
Message-Id: <20221212230820.3466-3-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221212230820.3466-1-ddiss@suse.de>
References: <20221212230820.3466-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

sect_stop is normally set immediately prior to calling _wrapup() via
run_section(). However, when called via a trap signal handler,
sect_stop may be uninitialized, leading to a negative section time
(sect_stop - sect_start) in the xunit report. E.g.
  Interrupted!
  Passed all 1 tests
  Xunit report: /home/david/xfstests/results//result.xml
  rapido1:/# head /home/david/xfstests/results//result.xml
  <?xml version="1.0" encoding="UTF-8"?>
  <testsuite name="xfstests" failures="0" skipped="0" tests="1"
   time="-1670885797" ... >

This commit uses the existing $interrupt flag to determine when
sect_stop needs to be initialised.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 check | 1 +
 1 file changed, 1 insertion(+)

diff --git a/check b/check
index d2e51296..cb3ea155 100755
--- a/check
+++ b/check
@@ -433,6 +433,7 @@ _wrapup()
 {
 	seq="check"
 	check="$RESULT_BASE/check"
+	$interrupt && sect_stop=`_wallclock`
 
 	if $showme && $needwrap; then
 		if $do_report; then
-- 
2.35.3

