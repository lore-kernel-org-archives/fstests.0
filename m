Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50DDC04FE0
	for <linux-fstests@archiver.kernel.org>; Mon,  7 Aug 2023 11:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjHGLaY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 7 Aug 2023 07:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjHGLaL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 Aug 2023 07:30:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D801F3A98
        for <fstests@vger.kernel.org>; Mon,  7 Aug 2023 04:27:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1F00E1F8AF;
        Mon,  7 Aug 2023 11:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691407587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4Q/3JQdbuVOqFp5KRsqrCeWwlZPS2HAYMTNkw+dE6wU=;
        b=TtgOSTfNhg8MvGPK6pGywSNsNOtefES5r1WKvzFN/p/PW4WgnMeFn0oxcboQz0Fjd7ucWj
        1nepqDhbUCzOLqbGCKfTvZysMZAz9TOjbE6kKA9lNYtaFoLkJQOIrS8IOX9D2iq/mF5jyq
        jOSvbu/frQzwtQy4UgY7FsUC0Q+quZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691407587;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4Q/3JQdbuVOqFp5KRsqrCeWwlZPS2HAYMTNkw+dE6wU=;
        b=Mq6C/YbxDq/o9cnm4xjQbn1NsiEWKzcvvealWd4ORl5ITY4IAJDTE0dxc8cEisQ4q51gFt
        wiErbC393H/G2NCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D263413910;
        Mon,  7 Aug 2023 11:26:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HqTPMeLU0GTNXQAAMHmgww
        (envelope-from <ddiss@suse.de>); Mon, 07 Aug 2023 11:26:26 +0000
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org
Cc:     linkinjeon@kernel.org, sj1557.seo@samsung.com,
        David Disseldorp <ddiss@suse.de>
Subject: [PATCH] common/rc: drop '-f' parameter from fsck.exfat
Date:   Mon,  7 Aug 2023 13:28:50 +0200
Message-Id: <20230807112850.9198-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

fsck.exfat doesn't support the '-f' flag, so add a special case to
_repair_test_fs().

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 common/rc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/rc b/common/rc
index 5c4429ed..ac7e50f1 100644
--- a/common/rc
+++ b/common/rc
@@ -1229,6 +1229,14 @@ _repair_test_fs()
 			res=$?
 		fi
 		;;
+	exfat)
+		# exfat doesn't support -f
+		fsck -t $FSTYP -y $TEST_DEV >$tmp.repair 2>&1
+		res=$?
+		if ((res < 4)); then
+			res=0
+		fi
+		;;
 	*)
 		# Let's hope fsck -y suffices...
 		fsck -t $FSTYP -fy $TEST_DEV >$tmp.repair 2>&1
-- 
2.35.3

