Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE51C433EF
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Nov 2021 17:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 505586128B
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Nov 2021 17:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241461AbhKIR6s (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 9 Nov 2021 12:58:48 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45070 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241455AbhKIR6q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 9 Nov 2021 12:58:46 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0FC7421940;
        Tue,  9 Nov 2021 17:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1636480558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SFKaA296PpTngwwYFam18NJoa6qaAmNM3higySL7Gfw=;
        b=iGjZg8rr10Qh+Cx8lqQAHnULploqiauqGJgVGbxUvu6fHE6Ls6Oh3XEOSfe44wyZ1LQXvt
        EgbmOxj/tXDFrwudtTMw55cQe+v4mm6n5vaNWdb4QL4CiUYx36R15eC/2hfmm5wRmnumUu
        sSS0GdORT6y7tDNtdKUkCLI7SE+y5Q4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1636480558;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SFKaA296PpTngwwYFam18NJoa6qaAmNM3higySL7Gfw=;
        b=olLWN6/xNBjvbw4YzyNbokf+AL7RjSbHboTx1q8RmDffU7S7XQJChOCEAyx0O7ykkpW3eF
        /0/tWbFTyHziR9CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CCE0413B1D;
        Tue,  9 Nov 2021 17:55:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3yjxLi22imENYAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Tue, 09 Nov 2021 17:55:57 +0000
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id ac01af06;
        Tue, 9 Nov 2021 17:55:57 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     fstests@vger.kernel.org
Cc:     =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH] common/renameat2: use mktemp(1) to create temporary directory
Date:   Tue,  9 Nov 2021 17:55:55 +0000
Message-Id: <20211109175555.16795-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Instead of using $TEST_DIR/$$, use the _correct_ way to create temporary
directories.  I've seen generic/626 failing with:

  QA output created by 626
  mkdir: cannot create directory '/media/test/471': File exists
  Silence is golden

which was likely due to another test that used the same directory name and
didn't do the clean-up.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 common/renameat2 | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/common/renameat2 b/common/renameat2
index 4d25d7cebf94..9737dff54a2b 100644
--- a/common/renameat2
+++ b/common/renameat2
@@ -105,14 +105,13 @@ _rename_tests()
 _require_renameat2()
 {
 	local flags=$1
-	local rename_dir=$TEST_DIR/$$
+	local rename_dir=`mktemp -d -p $TEST_DIR`
 	local cmd=""
 
 	if test ! -x $here/src/renameat2; then
 		_notrun "renameat2 binary not found"
 	fi
 
-	mkdir $rename_dir
 	touch $rename_dir/foo
 	case $flags in
 	"noreplace")
