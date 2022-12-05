Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062B4C4321E
	for <linux-fstests@archiver.kernel.org>; Mon,  5 Dec 2022 12:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiLEMl7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 5 Dec 2022 07:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiLEMl6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 5 Dec 2022 07:41:58 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA5F1A3B5
        for <fstests@vger.kernel.org>; Mon,  5 Dec 2022 04:41:57 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 77FF720110;
        Mon,  5 Dec 2022 12:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670244116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=lv0S6+83XVKZSCZXB4fKTD1LGH+CHvESMh0cFHxUEL8=;
        b=CZey94KK4nEWHYZGqhYGuG8UkeLzxQ7IOd+hOhe8JicE5DpE+fyjJ2VU19drQcPw7sa/KI
        uBPifIwR6TIVvPhlsapzvW0QDVyo+ttjK+Cr5pLuwdsAaHgqnNbsIeNSwVCNlLAYIb6sFz
        OGtNOb3s+YHi73ocIoNE0s8Fpr7SxTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670244116;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=lv0S6+83XVKZSCZXB4fKTD1LGH+CHvESMh0cFHxUEL8=;
        b=frh3bAGhqxyopn4rqVfnvNoakLCWJoFAQOh21XLiPZAKaytsGa0TGKGIbKQzH+WZm5aXtE
        IrS7oVLRzpndhWDQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5CC031348F;
        Mon,  5 Dec 2022 12:41:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id ZYSiFhTnjWMGVQAAGKfGzw
        (envelope-from <jack@suse.cz>); Mon, 05 Dec 2022 12:41:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D210BA0727; Mon,  5 Dec 2022 13:41:55 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     fstests@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4/044: Fix failure when mount options are incompatible with ext3
Date:   Mon,  5 Dec 2022 13:41:44 +0100
Message-Id: <20221205124144.23770-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

There are some mount options that are incompatible with ext3 filesystem
type. If they are used, this test fails because it tries to remount the
filesystem as ext3. The test makes sense even without remounting as ext3
so just make the test silently skip the remount.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/ext4/044 | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/ext4/044 b/tests/ext4/044
index 50de5a40bdc7..96fa70cc0d1e 100755
--- a/tests/ext4/044
+++ b/tests/ext4/044
@@ -53,9 +53,10 @@ _within_tolerance "sec_ctime" $sec_ctime $sec 1 -v
 
 _scratch_unmount >> $seqres.full 2>&1
 
-# Test mount to ext3 then mount back to ext4 and check timestamp again
-_mount -t ext3 `_scratch_mount_options $*` || _fail "ext3 mount failed"
-_scratch_unmount >> $seqres.full 2>&1
+# Test mount to ext3 then mount back to ext4 and check timestamp again.  We
+# ignore if ext3 failed to mount. It can happen because some mount options are
+# incompatible with ext3. Still the test makes sense.
+_mount -t ext3 `_scratch_mount_options $*` >> $seqres.full 2>&1 && _scratch_unmount >> $seqres.full 2>&1
 _scratch_mount
 
 nsec_atime2=`$here/src/t_get_file_time $SCRATCH_MNT/tmp_file atime nsec`
-- 
2.35.3

