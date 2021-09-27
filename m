Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD10C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Sep 2021 10:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA03060F4A
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Sep 2021 10:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbhI0LA2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 27 Sep 2021 07:00:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38994 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbhI0LA0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 27 Sep 2021 07:00:26 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 592661FD7A;
        Mon, 27 Sep 2021 10:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632740327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IcWV/0gJLQnS5dIoKu7kRRehkABs0zTMvv6KhFxMbVo=;
        b=jYWsvrROtYkn/0NzicElObiyZOpFl13Jzsy/bmhp29KSp5nLu2TPX3A1GKWPhq8RQWNOze
        XKseT6BIcEZpGOVnqEq/wUYKUkT2L+T/DHYqzoDxjzm3GNVFUwL7a1xZYtLveYZhs/FBNt
        itsHB5qjJFs20e8opU7K1xm3XySYg98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632740327;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IcWV/0gJLQnS5dIoKu7kRRehkABs0zTMvv6KhFxMbVo=;
        b=RK2UwaRe11sGwcxj+XvQXmuR8OGWYo6YkZIMDBGWvrkEhgXOL10Lc//Eu6RkatrJWKNBx9
        9ynP5LzJgidLw2CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D2E2013A7F;
        Mon, 27 Sep 2021 10:58:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WMdkMOajUWFmMQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 27 Sep 2021 10:58:46 +0000
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id a01ed467;
        Mon, 27 Sep 2021 10:58:45 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     fstests@vger.kernel.org
Cc:     Zorro Lang <zlang@redhat.com>, Eric Biggers <ebiggers@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>, Eryu Guan <guan@eryu.me>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Luis Henriques <lhenriques@suse.de>
Subject: [PATCH v3 1/2] common/rc: add _require_user_exists() to check if a user exists
Date:   Mon, 27 Sep 2021 11:58:42 +0100
Message-Id: <20210927105843.8661-2-lhenriques@suse.de>
In-Reply-To: <20210927105843.8661-1-lhenriques@suse.de>
References: <20210927105843.8661-1-lhenriques@suse.de>
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
index 154bc2dd7e94..7154d246b1fc 100644
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
+	_cat_passwd | grep -q "^$user:"
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
