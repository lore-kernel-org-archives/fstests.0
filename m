Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4928DC4332F
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Sep 2021 10:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ABBA60F46
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Sep 2021 10:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbhI0LA3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 27 Sep 2021 07:00:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39010 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbhI0LA0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 27 Sep 2021 07:00:26 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 02C2B1FDC3;
        Mon, 27 Sep 2021 10:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632740328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M9/H5AFtlnnUB7yVH2boA1sKq/7FGMElsi1uSs9Ffsg=;
        b=yUkW7SC/tMx36HsAwprcn25Gvxx+oYDyYmnRC5j8xvcAdH5KbONAsbcaCkTUeTQK+RW4lg
        CADwpfotA9usdUSEO0vUrjpjmRJJfFHuR5SunNMJNcyiJzvN0PO3wpZGA1lImd7xEiOK+C
        VJshR33Jmc5B5w2cEvmuxZf6wMuKLzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632740328;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M9/H5AFtlnnUB7yVH2boA1sKq/7FGMElsi1uSs9Ffsg=;
        b=faPGoqZcZDO3hUWEGt/zpv1C7m1CiYet4vVTK5zNrP2yXTWlyz7v46u7R4Y2d3oFWTituk
        aia9ZbKS5SX/3hBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6EFAA13A7F;
        Mon, 27 Sep 2021 10:58:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iJfXF+ejUWFmMQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 27 Sep 2021 10:58:47 +0000
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 1a8c2d6d;
        Mon, 27 Sep 2021 10:58:46 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     fstests@vger.kernel.org
Cc:     Zorro Lang <zlang@redhat.com>, Eric Biggers <ebiggers@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>, Eryu Guan <guan@eryu.me>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Luis Henriques <lhenriques@suse.de>
Subject: [PATCH v3 2/2] generic/079: make sure users 'nobody' and 'daemon' exist
Date:   Mon, 27 Sep 2021 11:58:43 +0100
Message-Id: <20210927105843.8661-3-lhenriques@suse.de>
In-Reply-To: <20210927105843.8661-1-lhenriques@suse.de>
References: <20210927105843.8661-1-lhenriques@suse.de>
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
 
