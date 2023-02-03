Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5443BC05027
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Feb 2023 14:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjBCOg0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 3 Feb 2023 09:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbjBCOg0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 3 Feb 2023 09:36:26 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5266A83FA
        for <fstests@vger.kernel.org>; Fri,  3 Feb 2023 06:36:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 122F35BE2E;
        Fri,  3 Feb 2023 14:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675434984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=gTfjx5v29PdOZ/brVs6lZYrZYFsZscbQn7UiGdIY5lY=;
        b=rJ9y4kQuxIBZcTnUO0jaV1FUdwBVyNm46dyGQP+DmOF/q3fVy+5V0s6eq1yq4radJf47tn
        Bm2nI2o/OtHY5aXGLQ2PCZ+wFq+qJrdAGnp/v0IHNZN+2KVSDgdam8zJ7lmLM9LJpXf5cY
        9V59RLSM9c2VZjQqcyKVxZnXUZHd134=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E234C1358A;
        Fri,  3 Feb 2023 14:36:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kNabNecb3WOhIwAAMHmgww
        (envelope-from <gniebler@suse.com>); Fri, 03 Feb 2023 14:36:23 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     fstests@vger.kernel.org
Cc:     Gabriel Niebler <gniebler@suse.com>
Subject: [PATCH] common: Do not chown ro mountpoint when creating idmapped mount
Date:   Fri,  3 Feb 2023 15:35:45 +0100
Message-Id: <20230203143545.23689-1-gniebler@suse.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The function _idmapped_mount tries to change the ownership of the mountpoint
for which it aims to create an idmapped mount, to ensure that the mapped UID
and GID can actually create objects within it. Some tests set up a read-only
mount, however, which lets the chown call fail. This patch fixes the
function to check whether the mount is read-only and skip the chown, if so.

Signed-off-by: Gabriel Niebler <gniebler@suse.com>
---
 common/rc | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 81ce1026..19ab8062 100644
--- a/common/rc
+++ b/common/rc
@@ -414,8 +414,11 @@ _idmapped_mount()
 
 	# We create an idmapped mount where {g,u}id 0 writes to disk as
 	# {g,u}id 10000000 and $(id -u fsgqa) + 10000000. We change ownership
-        # of $mnt so {g,u} id 0 can actually create objects in there.
-	chown 10000000:10000000 $mnt || return 1
+	# of $mnt, provided it's not read-only, so {g,u} id 0 can actually
+	# create objects in there.
+	if [[ "$mount_rec" != *"ro,"* && "$mount_rec" != *",ro"* ]]; then
+		chown 10000000:10000000 $mnt || return 1
+	fi
 	$here/src/vfs/mount-idmapped \
 		--map-mount b:10000000:0:100000000000 \
 		$mnt $tmp
-- 
2.39.1

