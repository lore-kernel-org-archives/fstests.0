Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5C0C54EBE
	for <linux-fstests@archiver.kernel.org>; Tue, 10 Jan 2023 22:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbjAJWXs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 10 Jan 2023 17:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbjAJWXY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 10 Jan 2023 17:23:24 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28941005C
        for <fstests@vger.kernel.org>; Tue, 10 Jan 2023 14:21:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 009B26B4F2;
        Tue, 10 Jan 2023 22:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673389310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=VeRdpipVweu3JQat6v7GDTmKD8iACo+WkmKO8+s70+k=;
        b=Z7g4FptEFCis/pkwFjO7pGDUU1O64vqACreggB1+ExhVwK4DTlHAkEp6BYJ1iFer1rBUJf
        h+vhbcJ6BeQCDJJwKL4ELoAqj9oMJ9khQ0lvb+XwNFmS7AFuyX+LxRwEmAkeS+CyFne29r
        z145ZX/tcan77gVDWEZOt4VE3BvEywY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673389310;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=VeRdpipVweu3JQat6v7GDTmKD8iACo+WkmKO8+s70+k=;
        b=pb9dHCNcnD8mBA1towY4fr3fCyZDF64reqNz/zRiCSjjakfst6d0/8LAynDikaJRzji9Qc
        Zt6ONUFbXeYv6WBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D208313338;
        Tue, 10 Jan 2023 22:21:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sgmQMf3kvWOtQgAAMHmgww
        (envelope-from <ddiss@suse.de>); Tue, 10 Jan 2023 22:21:49 +0000
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org
Cc:     David Disseldorp <ddiss@suse.de>
Subject: [PATCH] common/rc: drop SGI DMF specific _mount_ops_filter
Date:   Tue, 10 Jan 2023 23:22:43 +0100
Message-Id: <20230110222243.6522-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The _mount() helper function is the only caller of _mount_ops_filter(),
which appears to have been used in the past to replace the SGI DMF
specific mtpt= mount option setting.

_mount() invocations could now be replaced with $MOUNT_PROG calls
directly, but I've retained the helper function for readability.

Link: https://irix7.com/techpubs/007-3683-007.pdf
Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 common/rc | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/common/rc b/common/rc
index 23530413..81ce1026 100644
--- a/common/rc
+++ b/common/rc
@@ -120,7 +120,7 @@ _get_hugepagesize()
 
 _mount()
 {
-    $MOUNT_PROG `_mount_ops_filter $*`
+    $MOUNT_PROG $*
 }
 
 # Call _mount to do mount operation but also save mountpoint to
@@ -211,19 +211,6 @@ _test_options()
 	TEST_OPTIONS="$TEST_OPTIONS ${log_opt}logdev=$TEST_LOGDEV"
 }
 
-_mount_ops_filter()
-{
-    local params="$*"
-    local last_index=$(( $# - 1 ))
-
-    [ $last_index -gt 0 ] && shift $last_index
-    local fs_escaped=$1
-
-    echo $params | \
-        $PERL_PROG -ne "s#mtpt=[^,|^\n|^\s]*#mtpt=$fs_escaped\1\2#; print;"
-
-}
-
 # Used for mounting non-scratch devices (e.g. loop, dm constructs)
 # with the safe set of scratch mount options (e.g. loop image may be
 # hosted on $SCRATCH_DEV, so can't use external scratch devices).
-- 
2.35.3

