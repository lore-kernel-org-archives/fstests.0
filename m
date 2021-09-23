Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E960C4332F
	for <linux-fstests@archiver.kernel.org>; Thu, 23 Sep 2021 10:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42C176124A
	for <linux-fstests@archiver.kernel.org>; Thu, 23 Sep 2021 10:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240391AbhIWKnA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 23 Sep 2021 06:43:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45500 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240314AbhIWKm7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 23 Sep 2021 06:42:59 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8786B222DC;
        Thu, 23 Sep 2021 10:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632393687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JDKPbThXtHcfd3soebI8lHnNAsZy1BkoRLeumQBmu64=;
        b=YXSNenf2U4+QRUNnwQ+/Z7utpiltTbw2HMyZkdxpXpYGpqJkO62yJ3kj1tuC5q4RbeJ21G
        gRrN+2m1lu6/c1i46mmQVfaPlcQOcYXv+3wzH+4p+ZcfefbiHFYnAq0okE1OWOv7YM/2lx
        M8uL9u8YT09GomOY32ZLXOEghF4GwyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632393687;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JDKPbThXtHcfd3soebI8lHnNAsZy1BkoRLeumQBmu64=;
        b=6VNZrshRhw241rakRGoTTwT4jibbYd9EQ/4fNfJMyDkhFopNJ51JWV3+x12jL7N6l+atVn
        /E1nXpxS2jvl1QCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B2C013DCD;
        Thu, 23 Sep 2021 10:41:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MFOUC9dZTGFgZwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 23 Sep 2021 10:41:27 +0000
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 14ac5c8d;
        Thu, 23 Sep 2021 10:41:26 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     fstests@vger.kernel.org
Cc:     Eryu Guan <guan@eryu.me>, Luis Chamberlain <mcgrof@kernel.org>,
        Luis Henriques <lhenriques@suse.de>
Subject: [PATCH 1/2] common/rc: add _require_user_exists() to check if a user exists
Date:   Thu, 23 Sep 2021 11:41:22 +0100
Message-Id: <20210923104123.29878-2-lhenriques@suse.de>
In-Reply-To: <20210923104123.29878-1-lhenriques@suse.de>
References: <20210923104123.29878-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Function _require_user() does check if a user exists *and* if it is able
to execute commands.  Add a new function to simply check if a user exists.

Signed-off-by: Luis Henriques <lhenriques@suse.de>
---
 common/rc | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/common/rc b/common/rc
index 154bc2dd7e94..c7e77c0e26dc 100644
--- a/common/rc
+++ b/common/rc
@@ -2289,18 +2289,27 @@ _cat_group()
 	cat /etc/group
 }
 
-# check for a user on the machine, fsgqa as default
+# check if a user exists in the system
+#
+_require_user_exists()
+{
+	user=$1
+	_cat_passwd | grep -q $user
+	[ "$?" == "0" ] || _notrun "$user user not defined."
+}
+
+# check if a user exists and is able to execute commands.
+# Uses 'fsgqa' user as default.
 #
 _require_user()
 {
-    qa_user=fsgqa
-    if [ -n "$1" ];then
-        qa_user=$1
-    fi
-    _cat_passwd | grep -q $qa_user
-    [ "$?" == "0" ] || _notrun "$qa_user user not defined."
-    echo /bin/true | su $qa_user
-    [ "$?" == "0" ] || _notrun "$qa_user cannot execute commands."
+	qa_user=fsgqa
+	if [ -n "$1" ];then
+		qa_user=$1
+	fi
+	_require_user_exists $qa_user
+	echo /bin/true | su $qa_user
+	[ "$?" == "0" ] || _notrun "$qa_user cannot execute commands."
 }
 
 # check for a chown support
