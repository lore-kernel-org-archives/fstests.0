Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058F7C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 23 Sep 2021 10:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D995B6121F
	for <linux-fstests@archiver.kernel.org>; Thu, 23 Sep 2021 10:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240387AbhIWKnA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 23 Sep 2021 06:43:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50784 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240391AbhIWKnA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 23 Sep 2021 06:43:00 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E8E101FFA2;
        Thu, 23 Sep 2021 10:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632393687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GSwG+xCjw2FNPe9+OsgpMASeSKlgroe7thja4hNiepc=;
        b=PrAeixXZ23lxme5c/4qrrzNRGyE4SJ7jM+ZMeTdvCXubHPPeXoWVMjuI4oRfBk7Z9OHUx0
        avCe7d6bH6Vo1b5H2L9i+jwKc1Lz0qh/b4R8b7hKiDlZqqGZXJiJ8KwXxWK2s3NFc4CO4n
        vE1h+d1WfwVjM/LHkfNpI9A3EWvsymE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632393687;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GSwG+xCjw2FNPe9+OsgpMASeSKlgroe7thja4hNiepc=;
        b=Vg3uScLfVQzfzD2HqWeq8TeetDWigE4SrnrPFxZ3ZE+qSLhY8PHhhKlrXBrUJOCFHc0NfQ
        wKq05z/LLedFBfBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99A8C13DCD;
        Thu, 23 Sep 2021 10:41:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AAaqItdZTGFgZwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 23 Sep 2021 10:41:27 +0000
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 59bd3170;
        Thu, 23 Sep 2021 10:41:26 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     fstests@vger.kernel.org
Cc:     Eryu Guan <guan@eryu.me>, Luis Chamberlain <mcgrof@kernel.org>,
        Luis Henriques <lhenriques@suse.de>
Subject: [PATCH 2/2] generic/079: make sure users 'nobody' and 'daemon' exist
Date:   Thu, 23 Sep 2021 11:41:23 +0100
Message-Id: <20210923104123.29878-3-lhenriques@suse.de>
In-Reply-To: <20210923104123.29878-1-lhenriques@suse.de>
References: <20210923104123.29878-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Test 'src/t_immutable' assumes the existence of users 'nobody' and
'daemon' on the system.  If any of these users don't exist, the test will
fail with:

  add_acl(/media/scratch/079/immutable.f) did not set errno == EPERM
  ...

because it tries to set ACLs such as:

  u::rwx,g::rwx,o::rwx,u:daemon:rwx,m::rwx

Use the new _require_user_exists() function to ensure these users exist.

Signed-off-by: Luis Henriques <lhenriques@suse.de>
---
 tests/generic/079 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/generic/079 b/tests/generic/079
index 829275db8cdf..9e7ccd31c8e2 100755
--- a/tests/generic/079
+++ b/tests/generic/079
@@ -26,6 +26,8 @@ _cleanup()
 _supported_fs generic
 
 _require_chattr ia
+_require_user_exists "nobody"
+_require_user_exists "daemon"
 _require_test_program "t_immutable"
 _require_scratch
 
