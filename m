Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11314C4332F
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Dec 2022 23:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiLLXHe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 12 Dec 2022 18:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiLLXHd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 12 Dec 2022 18:07:33 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E401B1FE
        for <fstests@vger.kernel.org>; Mon, 12 Dec 2022 15:07:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1A83A337C0;
        Mon, 12 Dec 2022 23:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1670886451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fekh+/50vUYKMk/CkqbEdqr4sBl6kbzxpdZqFkdOjHE=;
        b=RrtnmIsxaAI8jaoy3gXsX4wovxbp7MwHajS9MPmYzHuiN8iBGQ5RklUxe33lbb9THtbEfX
        +MvsZLYkvmb00AlALROdpYoeH9t4+jlWgTMofvy5jD/lLHL6FSHnrFZpk+ZHaHAroWhRyP
        XnGQAdg/OgwrsqynPx1UnMe4ehu6zOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1670886451;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fekh+/50vUYKMk/CkqbEdqr4sBl6kbzxpdZqFkdOjHE=;
        b=O+zbvNNYnOhXdeRaqq+5sbmPaFLkjXBJQw5RytGzf6nT0JNoBFzkzjwF7KUVTxuCfs+IcL
        fASpD5GuRFmYdOCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2E8613456;
        Mon, 12 Dec 2022 23:07:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CqraOTK0l2NtNQAAMHmgww
        (envelope-from <ddiss@suse.de>); Mon, 12 Dec 2022 23:07:30 +0000
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org
Cc:     David Disseldorp <ddiss@suse.de>
Subject: [PATCH 1/3] common/attr: require xfs_spaceman for xfs acl_get_max
Date:   Tue, 13 Dec 2022 00:08:18 +0100
Message-Id: <20221212230820.3466-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

For xfs, _acl_get_max() calls xfs_info which in turn calls
"xfs_spaceman -c info ...".

Without this change, xfs_spaceman absence results in:
--- tests/generic/026.out
+++ /home/david/xfstests/results//generic/026.out.bad
@@ -1,9 +1,11 @@
 QA output created by 026
+/usr/sbin/xfs_info: line 44: xfs_spaceman: command not found

 === Test out large ACLs  ===
+/usr/sbin/xfs_info: line 44: xfs_spaceman: command not found
 1 below acl max
 acl max
...

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 common/attr | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/attr b/common/attr
index cce4d1b2..a94c5e4b 100644
--- a/common/attr
+++ b/common/attr
@@ -57,6 +57,9 @@ _acl_get_max()
 
 _require_acl_get_max()
 {
+	# _acl_get_max -> xfs_info -> xfs_spaceman
+	[ "$FSTYP" == "xfs" ] && _require_xfs_spaceman_command "info"
+
 	if [ $(_acl_get_max) -eq 0 ]; then
 		_notrun "$FSTYP does not define maximum ACL count"
 	fi
-- 
2.35.3

