Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93377C433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Sep 2021 09:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D5A06124C
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Sep 2021 09:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244407AbhIXJUt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Sep 2021 05:20:49 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47876 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244462AbhIXJUt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Sep 2021 05:20:49 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A4E092241B;
        Fri, 24 Sep 2021 09:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632475155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M9/H5AFtlnnUB7yVH2boA1sKq/7FGMElsi1uSs9Ffsg=;
        b=jKGRKnCVY+nzam5gkrs6rCeSjWtLof1PUjvEYph58tgV5BTnkoEP0N+sj2CX1L9MYCNXhj
        Okjw/FX/8tAqVffNYuEFxJhwIUs3RXmErTtYyAqaGP3iaN0E/cvSxMwxDXZ7uPrPnS9Yaf
        JRl+GyZG35ZixZStDEVGwkw2Z93vkRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632475155;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M9/H5AFtlnnUB7yVH2boA1sKq/7FGMElsi1uSs9Ffsg=;
        b=XgqK+RMvxpQ6HCDtJSAwt4FcSLGjBNdNEEISLAg7wHNMwBkXm1HLyT9lAO67tipipIuPRi
        fT6wZ7GjJ/01jSAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 393AD13AB3;
        Fri, 24 Sep 2021 09:19:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8B3xChOYTWFoLAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 24 Sep 2021 09:19:15 +0000
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 968b6c65;
        Fri, 24 Sep 2021 09:19:13 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     fstests@vger.kernel.org
Cc:     Eric Biggers <ebiggers@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>, Eryu Guan <guan@eryu.me>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Luis Henriques <lhenriques@suse.de>
Subject: [PATCH v2 2/2] generic/079: make sure users 'nobody' and 'daemon' exist
Date:   Fri, 24 Sep 2021 10:19:11 +0100
Message-Id: <20210924091911.19413-3-lhenriques@suse.de>
In-Reply-To: <20210924091911.19413-1-lhenriques@suse.de>
References: <20210924091911.19413-1-lhenriques@suse.de>
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
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
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
 
