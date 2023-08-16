Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F0EC001B0
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Aug 2023 10:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243702AbjHPKbD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Aug 2023 06:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243922AbjHPKax (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Aug 2023 06:30:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BC51BD4
        for <fstests@vger.kernel.org>; Wed, 16 Aug 2023 03:30:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BCF131F74D;
        Wed, 16 Aug 2023 10:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692181850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=HYKb7WCcF2xloubaY3x7ogE/Wc/qlIIHpOkj3MYUscU=;
        b=uEO8vWeBqzMeYqGQeBtzHiCb4pWLXrQd016Bu+DlvTbtQP+CO5eMj5Z+EkB3MsXh4a9y72
        N4bqW035UvlFj2JQrAKHcXMStGGnSKT8hoqInL5ybofzDErFf3VumoIeYxpeQOtXJ0lTJL
        7KqrQJakghf7qahH7e6aC1kE2yi+50k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692181850;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=HYKb7WCcF2xloubaY3x7ogE/Wc/qlIIHpOkj3MYUscU=;
        b=qB7jUtIHfx3c4bmCZzm4c67cyxg8nAxlbrtKute6vRWG27uuYDcJI0YHppvVol6i9R6rlL
        vzyUtqngLp/oO4BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 968881353E;
        Wed, 16 Aug 2023 10:30:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tQUYI1ql3GRFbwAAMHmgww
        (envelope-from <ddiss@suse.de>); Wed, 16 Aug 2023 10:30:50 +0000
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org
Cc:     David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2] common/rc: drop 'fsck -f' parameter from _repair_test_fs
Date:   Wed, 16 Aug 2023 12:33:30 +0200
Message-Id: <20230816103330.961-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The '-f' parameter is fsck.ext# specific, where it's documented to:
  Force checking even if filesystem is marked clean

_repair_test_fs() is only called on _check_test_fs() failure, so
dropping the parameter should be possible without changing ext#
behaviour.
Doing so fixes _repair_test_fs() on exfat, where fsck.exfat doesn't
support '-f'.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
v2: drop -f from default case instead of splitting out exfat case

 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 5c4429ed..66d270ac 100644
--- a/common/rc
+++ b/common/rc
@@ -1231,7 +1231,7 @@ _repair_test_fs()
 		;;
 	*)
 		# Let's hope fsck -y suffices...
-		fsck -t $FSTYP -fy $TEST_DEV >$tmp.repair 2>&1
+		fsck -t $FSTYP -y $TEST_DEV >$tmp.repair 2>&1
 		res=$?
 		if test "$res" -lt 4 ; then
 			res=0
-- 
2.35.3

