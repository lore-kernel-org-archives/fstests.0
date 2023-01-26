Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0C0C05027
	for <linux-fstests@archiver.kernel.org>; Thu, 26 Jan 2023 15:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjAZPP2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 26 Jan 2023 10:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjAZPPZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 26 Jan 2023 10:15:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD95D61851
        for <fstests@vger.kernel.org>; Thu, 26 Jan 2023 07:15:22 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4026D1FED4;
        Thu, 26 Jan 2023 15:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674746121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TnibvEqLyCiCFmXipilwIyyO3IPj+ViwWnrzCNnBdTE=;
        b=RiiHHJMOx/ld3up5eiTn7420P/Lv1r4KxtNZBW/P44K+IGyFrmM8gC4Kc8tPQUj/3eJ8+2
        QtwzvGCTSpIyMvvW1hr2QwkgD23EZF02oMLMS1RQyx7ZI/gX9AWq8T6zaJmY6YWyREH7Bm
        eX13qNoc/Lw+dN2aRvqX6pIB0p07ORA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674746121;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TnibvEqLyCiCFmXipilwIyyO3IPj+ViwWnrzCNnBdTE=;
        b=x+5lgbncXMgD1Bgahgt7ir4y4xNVpsy1weZOXSBiE00sm4mKZIRvy3Bk8GhkRZcW69LSqi
        YL+J4Flnb98gNDBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3283D139B3;
        Thu, 26 Jan 2023 15:15:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id le5HDAmZ0mPJHgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 26 Jan 2023 15:15:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6C017A06B4; Thu, 26 Jan 2023 16:15:20 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <fstests@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH] generic/707: Test moving directory while being grown
Date:   Thu, 26 Jan 2023 16:15:12 +0100
Message-Id: <20230126151512.5438-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Test how the filesystem can handle moving a directory to a different
directory (so that parent pointer gets updated) while it is grown. Ext4
and UDF had a bug where if the directory got converted to a different
type due to growth while rename is running, the filesystem got
corrupted.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/generic/707     | 54 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/707.out |  2 ++
 2 files changed, 56 insertions(+)
 create mode 100755 tests/generic/707
 create mode 100644 tests/generic/707.out

diff --git a/tests/generic/707 b/tests/generic/707
new file mode 100755
index 000000000000..25cbb7e98a23
--- /dev/null
+++ b/tests/generic/707
@@ -0,0 +1,54 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Jan Kara, SUSE Linux.  All Rights Reserved.
+#
+# FS QA Test 707
+#
+# This is a test verifying whether the filesystem can gracefully handle
+# modifying of a directory while it is being moved, in particular the cases
+# where directory format changes
+# 
+. ./common/preamble
+_begin_fstest auto
+
+_supported_fs generic
+_require_scratch
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+cd $SCRATCH_MNT
+
+# Loop multiple times trying to hit the race
+loops=100
+files=500
+moves=500
+
+create_files()
+{
+	# We use slightly longer file name to make directory grow faster and
+	# hopefully convert between various types
+	for (( i = 0; i < $files; i++ )); do
+		touch somewhatlongerfilename$i
+	done
+}
+
+for (( i = 0; i <= $moves; i++ )); do
+	mkdir dir$i
+done
+
+for (( l = 0; l < $loops; l++ )); do
+	mkdir dir0/dir
+	pushd dir0/dir &>/dev/null
+	create_files &
+	popd &>/dev/null
+	for (( i = 0; i < $moves; i++ )); do
+		mv dir$i/dir dir$((i+1))/dir
+	done
+	wait
+	rm -r dir$moves/dir
+done
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/707.out b/tests/generic/707.out
new file mode 100644
index 000000000000..8e57a1d8c971
--- /dev/null
+++ b/tests/generic/707.out
@@ -0,0 +1,2 @@
+QA output created by 707
+Silence is golden
-- 
2.35.3

