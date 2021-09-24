Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C33C433FE
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Sep 2021 09:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45B57603E9
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Sep 2021 09:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbhIXJUt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Sep 2021 05:20:49 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47860 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244407AbhIXJUs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Sep 2021 05:20:48 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2566522414;
        Fri, 24 Sep 2021 09:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632475155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xN8VuxlYOKY8LlBOSlX5mLgapXMTARszfFRC6LoZI14=;
        b=Q0o8OqW21As7IlhilMqwTtwgD/xjM0BjydvuL/AcZxD0Z1HJWbgyAkjlSim8bt8GbjkuJk
        TLc9fvDXPABMeQxh4U9Hzfgc8RffTVkwpI45UfzoXC4F00d43ZQNPfNYXUJc0Afxa4KpsU
        ga1hyhlFBwVbuoZVhloPZGU2kituWSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632475155;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xN8VuxlYOKY8LlBOSlX5mLgapXMTARszfFRC6LoZI14=;
        b=d1X8IzQE3jkMul9OrSWjMDX1RFAdyVLgfdzSPLX/tlR+SO6wlKCEynJUKs0EQsq8EkHEHm
        FHDj1d+pG915P+DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA40313AB3;
        Fri, 24 Sep 2021 09:19:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eKdfJhKYTWFoLAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 24 Sep 2021 09:19:14 +0000
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 1743cf49;
        Fri, 24 Sep 2021 09:19:13 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     fstests@vger.kernel.org
Cc:     Eric Biggers <ebiggers@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>, Eryu Guan <guan@eryu.me>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Luis Henriques <lhenriques@suse.de>
Subject: [PATCH v2 1/2] common/rc: add _require_user_exists() to check if a user exists
Date:   Fri, 24 Sep 2021 10:19:10 +0100
Message-Id: <20210924091911.19413-2-lhenriques@suse.de>
In-Reply-To: <20210924091911.19413-1-lhenriques@suse.de>
References: <20210924091911.19413-1-lhenriques@suse.de>
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
index 154bc2dd7e94..de9ba56eefcf 100644
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
+	local user=$1
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
