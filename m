Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1483C54EAA
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Jan 2023 14:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbjA3O4r (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 30 Jan 2023 09:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjA3O4q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 Jan 2023 09:56:46 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C132942E
        for <fstests@vger.kernel.org>; Mon, 30 Jan 2023 06:56:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BE8B01F88F;
        Mon, 30 Jan 2023 14:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675090603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=hiR2Oqz7LFX0u1+Tp2pB5kiEXvzVHUq1ZQ619tdzMMg=;
        b=sKauGKTCTfjweyF+Au5xrGOU61i/WygAORZmNnA7MttvVxw0Iro8EPMolWk0hofgHq7bJv
        Mmnbd8EqigoSns3ZEDVcTcJJgVLI8Bo2YauF6TGufvbhadjWe3BBSbL6a/XSy3nnNVsAHS
        WzRUU2fLAk9mXnC+awjTntEm+NXAGNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675090603;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=hiR2Oqz7LFX0u1+Tp2pB5kiEXvzVHUq1ZQ619tdzMMg=;
        b=bpLvkRSbmZnjieEc3pvIYtVqO9wmxWH49WSZq7M8Em0g666fMzwP84+VhkY3XH4060lttk
        TtBkGYT5aU7vlqBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B2ED713444;
        Mon, 30 Jan 2023 14:56:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Yp6jK6va12MQCwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 30 Jan 2023 14:56:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0E126A06B6; Mon, 30 Jan 2023 15:56:43 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <fstests@vger.kernel.org>
Cc:     Bill O'Donnell <bodonnel@redhat.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2] generic/707: Test moving directory while being grown
Date:   Mon, 30 Jan 2023 15:56:39 +0100
Message-Id: <20230130145639.30027-1-jack@suse.cz>
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

Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/generic/707     | 63 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/707.out |  2 ++
 2 files changed, 65 insertions(+)
 create mode 100755 tests/generic/707
 create mode 100644 tests/generic/707.out

Changes since v1:
* Added TIME_FACTOR multiplier
* Handle background process in _cleanup
* Use absolute paths where possible

diff --git a/tests/generic/707 b/tests/generic/707
new file mode 100755
index 000000000000..d1d299563813
--- /dev/null
+++ b/tests/generic/707
@@ -0,0 +1,63 @@
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
+_cleanup()
+{
+	if [ -n "$BGPID" ]; then
+		# Stop background process
+		kill -9 $BGPID &>/dev/null
+		wait
+	fi
+}
+
+# Loop multiple times trying to hit the race
+loops=$((100*TIME_FACTOR))
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
+	mkdir $SCRATCH_MNT/dir$i
+done
+
+for (( l = 0; l < $loops; l++ )); do
+	mkdir $SCRATCH_MNT/dir0/dir
+	pushd $SCRATCH_MNT/dir0/dir &>/dev/null
+	create_files &
+	BGPID=$!
+	popd &>/dev/null
+	for (( i = 0; i < $moves; i++ )); do
+		mv $SCRATCH_MNT/dir$i/dir $SCRATCH_MNT/dir$((i+1))/dir
+	done
+	wait
+	BGPID=""
+	rm -r $SCRATCH_MNT/dir$moves/dir
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

