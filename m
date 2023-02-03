Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5D6C61DA4
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Feb 2023 17:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbjBCRzF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 3 Feb 2023 12:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbjBCRzB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 3 Feb 2023 12:55:01 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7686A4B18E
        for <fstests@vger.kernel.org>; Fri,  3 Feb 2023 09:54:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D95BE5C246;
        Fri,  3 Feb 2023 17:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675446880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c11DgajBu3SvzrTukp+7/f4btY09zZd2QwhKeqiqA0Q=;
        b=OKhDmXGqcY60Eoh5S3w+CHQSnLngvk8E3Le3mnQpt0mUlD50YESw9zVyyM57Qc6RLykBZq
        nhI8Xav2aj2YsruCI61xnDCmnDm4qoA7Z6xsUm1J9DZJ3bFj7/Yy8mJ/+7QIEdHfJDVecf
        uvxyhIq3/ZHDVjgkf/ijg5iw8MPgTCQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACF241346D;
        Fri,  3 Feb 2023 17:54:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FV08KGBK3WPOBgAAMHmgww
        (envelope-from <gniebler@suse.com>); Fri, 03 Feb 2023 17:54:40 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     fstests@vger.kernel.org
Cc:     Gabriel Niebler <gniebler@suse.com>
Subject: [PATCH] common: Chown mount even if already idmapped to account for remounts
Date:   Fri,  3 Feb 2023 18:54:37 +0100
Message-Id: <20230203175437.30687-1-gniebler@suse.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230203143545.23689-1-gniebler@suse.com>
References: <20230203143545.23689-1-gniebler@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This is a logical consequence of introducing the chown check in _idmapped_mount,
since now a read-only mount can be made idmapped successfully. But if the mount
is then remounted rw the chown never happens, as _idmapped_mount sees that it's
already idmapped and bows out early.

This patch fixes that by simply moving the chown ahead of the idmapped check,
so it will be performed in any case, even on already idmapped mounts.

Signed-off-by: Gabriel Niebler <gniebler@suse.com>
---
 common/rc | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index 19ab8062..88da356e 100644
--- a/common/rc
+++ b/common/rc
@@ -408,10 +408,6 @@ _idmapped_mount()
 	local tmp=`mktemp -d`
 
 	local mount_rec=`findmnt -rncv -S $dev -o OPTIONS`
-	if [[ "$mount_rec" == *"idmapped"* ]]; then
-		return 0
-	fi
-
 	# We create an idmapped mount where {g,u}id 0 writes to disk as
 	# {g,u}id 10000000 and $(id -u fsgqa) + 10000000. We change ownership
 	# of $mnt, provided it's not read-only, so {g,u} id 0 can actually
@@ -419,6 +415,11 @@ _idmapped_mount()
 	if [[ "$mount_rec" != *"ro,"* && "$mount_rec" != *",ro"* ]]; then
 		chown 10000000:10000000 $mnt || return 1
 	fi
+	# But if the mount is already idmapped, then there's nothing more to do.
+	if [[ "$mount_rec" == *"idmapped"* ]]; then
+		return 0
+	fi
+
 	$here/src/vfs/mount-idmapped \
 		--map-mount b:10000000:0:100000000000 \
 		$mnt $tmp
-- 
2.39.1

