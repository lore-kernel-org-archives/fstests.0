Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF15C433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 21 Jan 2022 13:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350778AbiAUN6I (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 21 Jan 2022 08:58:08 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42706 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350745AbiAUN6I (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 21 Jan 2022 08:58:08 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DD96B1F3AF
        for <fstests@vger.kernel.org>; Fri, 21 Jan 2022 13:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642773486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Sw+w24umqz5ZYMN5zW9yw+aXR7aBiD1SsgNlOM+1IKY=;
        b=tgWMr+MJLOMSFOrpUvLz55Ce1s24sXDQrgc6hy24S+6I3tRUnDFPoZM29+uDPI4Jh787BG
        vJy66L9ZWnQO2zTyIm+qxhqpS8HSHuHdSgVy/wQLPTDsrqYQYSFiagikAQI8gI3MnvVF74
        SXW949m1AZtFM6dD1sqE1m7Fnt1ILno=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D472413941
        for <fstests@vger.kernel.org>; Fri, 21 Jan 2022 13:58:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3ANPM+676mFRWAAAMHmgww
        (envelope-from <ailiop@suse.com>)
        for <fstests@vger.kernel.org>; Fri, 21 Jan 2022 13:58:06 +0000
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] common/rc: fix group detection regex to strictly match required name
Date:   Fri, 21 Jan 2022 14:58:01 +0100
Message-Id: <20220121135802.9251-1-ailiop@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

_require_group greps for the required group string in /etc/group but
this can partially match other groups or group member names and falsely
return success where it should fail.

Make the regex more specific so that it can unambigiously match only the
exact group name rather than any other group that happens to match as a
substring or any matching username from the group member list field.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index b3289de985d8..73f484bd8be2 100644
--- a/common/rc
+++ b/common/rc
@@ -2428,7 +2428,7 @@ _require_group()
     if [ -n "$1" ];then
         qa_group=$1
     fi
-    _cat_group | grep -q $qa_group
+    _cat_group | grep -q "^$qa_group:"
     [ "$?" == "0" ] || _notrun "$qa_group group not defined."
 }
 
-- 
2.34.1

