Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92400C38142
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Jan 2023 12:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjAaMyY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 31 Jan 2023 07:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAaMyX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 Jan 2023 07:54:23 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C36F47439
        for <fstests@vger.kernel.org>; Tue, 31 Jan 2023 04:54:22 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3BDCA228B1;
        Tue, 31 Jan 2023 12:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675169661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/zdj8xm8zYqA056400fT40rR1rO4fpAYtUAl1BwwLiE=;
        b=k+3vyS8zDsoH8MMON2VxEqxw1wNMtZa/oLg1eTMXzRT97kKHKZ7n3iBoSAmVB7VItApV0p
        YrMvfGAdw/SXND3ZY3MqBZSxFbpHk38hayxE9Cca4HnFVlQGL6G+cSCnqdmmPsS6CUpktT
        n6/k9PoGZQmMWYpbkklFahzbxOfmrwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675169661;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/zdj8xm8zYqA056400fT40rR1rO4fpAYtUAl1BwwLiE=;
        b=wrDqChDQ+t1EKKQJblOck5fEWib+quLyYqLz10nZHIJbB8uUxEk5WN/d64Rn81rx0/yozN
        XWqXYNVyDdk6aiAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2AB7413585;
        Tue, 31 Jan 2023 12:54:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l/hqCn0P2WOkFwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 31 Jan 2023 12:54:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3034BA06D5; Tue, 31 Jan 2023 13:54:20 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <fstests@vger.kernel.org>
Cc:     bodonnel@redhat.com, Zorro Lang <zlang@redhat.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v3] generic/707: Test moving directory while being grown
Date:   Tue, 31 Jan 2023 13:54:16 +0100
Message-Id: <20230131125416.16120-1-jack@suse.cz>
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
 tests/generic/707     | 70 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/707.out |  2 ++
 2 files changed, 72 insertions(+)
 create mode 100755 tests/generic/707
 create mode 100644 tests/generic/707.out

diff --git a/tests/generic/707 b/tests/generic/707
new file mode 100755
index 000000000000..ad1592a1b957
--- /dev/null
+++ b/tests/generic/707
@@ -0,0 +1,70 @@
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
+_fixed_by_kernel_commit f950fd052913 \
+	"udf: Protect rename against modification of moved directory"
+_fixed_by_kernel_commit XXXXXXXXXXXX \
+	"ext4: fix possible corruption when moving a directory"
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
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
+	unset BGPID
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

