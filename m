Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C482C46467
	for <linux-fstests@archiver.kernel.org>; Wed, 11 Jan 2023 10:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbjAKK5f (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 11 Jan 2023 05:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238467AbjAKK51 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 Jan 2023 05:57:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09031081
        for <fstests@vger.kernel.org>; Wed, 11 Jan 2023 02:57:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6D9CA1750D;
        Wed, 11 Jan 2023 10:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673434645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YShmFyTpAHmFyAl2Wwx5Tgt+HJDLBNJ6cEV+joY+qcg=;
        b=qKeG8DO7U2LicHp51NJBB/YBsQnmXel5oe/IRa4YE+bFRkl/03BV3fsiCXTUYyEG5B4Ut0
        G3wS9n3biF9ciBv50ZrxGZOhWVaEEuBGRKWrTel3ihd4IiKtQgildi0w48Na3AYT14j4A2
        45fMBrMHMtrXv81fAf2Vq4nBj0/DwxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673434645;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YShmFyTpAHmFyAl2Wwx5Tgt+HJDLBNJ6cEV+joY+qcg=;
        b=9L1+4nw+bwvc6HiQYt8s6/YnzEEGmQGHqO5tNrJ2XVwodcJ8hs8wX8XG44CVt7N9ZyvkpH
        p8DwfycMztHcyQDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 52A1F13591;
        Wed, 11 Jan 2023 10:57:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J+jXEhWWvmNvFgAAMHmgww
        (envelope-from <ddiss@suse.de>); Wed, 11 Jan 2023 10:57:25 +0000
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org
Cc:     David Disseldorp <ddiss@suse.de>
Subject: [PATCH] common/btrfs: avoid reinitialization of unsupported profile array
Date:   Wed, 11 Jan 2023 11:58:27 +0100
Message-Id: <20230111105827.16852-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The _btrfs_get_profile_configs() unsupported array doesn't change
between configs, so avoid reinitializing it on each loop iteration.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 common/btrfs | 66 ++++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index ee673a93..9531c914 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -201,6 +201,39 @@ _btrfs_get_profile_configs()
 		return
 	fi
 
+	local unsupported=()
+	if [ "$1" == "replace" ]; then
+		# We can't do replace with these profiles because they
+		# imply only one device ($SCRATCH_DEV), and we need to
+		# keep $SCRATCH_DEV around for _scratch_mount
+		# and _check_scratch_fs.
+		unsupported+=(
+			"dup"
+		)
+	elif [ "$1" == "replace-missing" ]; then
+		# We can't replace missing devices with these profiles
+		# because there isn't enough redundancy.
+		unsupported+=(
+			"single"
+			"dup"
+			"raid0"
+		)
+	fi
+
+	if _scratch_btrfs_is_zoned; then
+		# Zoned btrfs only supports SINGLE profile
+		unsupported+=(
+			"dup"
+			"raid0"
+			"raid1"
+			"raid1c3"
+			"raid1c4"
+			"raid10"
+			"raid5"
+			"raid6"
+		)
+	fi
+
 	if [ -z "$BTRFS_PROFILE_CONFIGS" ]; then
 		# Default configurations to test.
 		local configs=(
@@ -222,39 +255,6 @@ _btrfs_get_profile_configs()
 	for cfg in "${configs[@]}"; do
 		local supported=true
 		local profiles=(${cfg/:/ })
-		if [ "$1" == "replace" ]; then
-			# We can't do replace with these profiles because they
-			# imply only one device ($SCRATCH_DEV), and we need to
-			# keep $SCRATCH_DEV around for _scratch_mount
-			# and _check_scratch_fs.
-			local unsupported=(
-				"dup"
-			)
-		elif [ "$1" == "replace-missing" ]; then
-			# We can't replace missing devices with these profiles
-			# because there isn't enough redundancy.
-			local unsupported=(
-				"single"
-				"dup"
-				"raid0"
-			)
-		else
-			local unsupported=()
-		fi
-
-		if _scratch_btrfs_is_zoned; then
-			# Zoned btrfs only supports SINGLE profile
-			unsupported+=(
-				"dup"
-				"raid0"
-				"raid1"
-				"raid1c3"
-				"raid1c4"
-				"raid10"
-				"raid5"
-				"raid6"
-			)
-		fi
 
 		for unsupp in "${unsupported[@]}"; do
 			if [ "${profiles[0]}" == "$unsupp" -o "${profiles[1]}" == "$unsupp" ]; then
-- 
2.35.3

