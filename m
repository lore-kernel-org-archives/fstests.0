Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15137C38142
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Jan 2023 12:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjAaMjf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 31 Jan 2023 07:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjAaMje (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 Jan 2023 07:39:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F463AA9
        for <fstests@vger.kernel.org>; Tue, 31 Jan 2023 04:39:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8C90F22738;
        Tue, 31 Jan 2023 12:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675168772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5FExObrGk6MUZJ6QXY0EkoJOH39rFi6J+vXSZ6322U0=;
        b=YsgtuTXe6oxzYtVjkLzgIz4bMscitvSAuQkx1f0B65aQcmX0b2fQK5iKn5DSbEnv3eLrpQ
        l0OWAZJgUBlNtFgQ6TSATFIEH7eI/cVMHO5HGdgkB/1eASOs3uFXDktPms1/fLXHgLa5AK
        eLBr1cQJWjDfVlxCs4mcy7EQXosuoCY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A15613585;
        Tue, 31 Jan 2023 12:39:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qIkoFAQM2WPxEAAAMHmgww
        (envelope-from <gniebler@suse.com>); Tue, 31 Jan 2023 12:39:32 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     fstests@vger.kernel.org
Cc:     Gabriel Niebler <gniebler@suse.com>
Subject: [PATCH 2/2] README: Add tiny note concerning required scratch devs for btrfs testing
Date:   Tue, 31 Jan 2023 13:38:39 +0100
Message-Id: <20230131123839.16084-3-gniebler@suse.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230131123839.16084-1-gniebler@suse.com>
References: <20230131123839.16084-1-gniebler@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Gabriel Niebler <gniebler@suse.com>
---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README b/README
index 008d3875..574cdd34 100644
--- a/README
+++ b/README
@@ -127,7 +127,7 @@ Setup Environment
     - device contents will be destroyed.
 
 4. (optional) Create SCRATCH device pool.
-    - needed for BTRFS testing
+    - needed for BTRFS testing (some tests require up to 5 disks of 10GB each)
     - specifies 3 or more independent SCRATCH devices via the SCRATCH_DEV_POOL
       variable e.g SCRATCH_DEV_POOL="/dev/sda /dev/sdb /dev/sdc"
     - device contents will be destroyed.
-- 
2.39.1

