Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198D0C4743C
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Jun 2021 16:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0353D60FE3
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Jun 2021 16:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhFUQxP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Jun 2021 12:53:15 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53644 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231339AbhFUQvO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Jun 2021 12:51:14 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15LGmtgR015916
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 12:48:56 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 803C115C3CD5; Mon, 21 Jun 2021 12:48:55 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH] ext4/048: skip test of filename wipe if journal checkpoint is not supported
Date:   Mon, 21 Jun 2021 12:48:51 -0400
Message-Id: <20210621164851.1808923-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

ext4/048 will fail when running on older kernels that don't support
the filename wipe feature.  The journal checkpoint ioctl is a related
feature, and landed just a little bit after filename wipe feature, so
use support for the journal checkpoint ioctl as a proxy for support
for the filename wipe feature.

Without this change, this test will fail when tesing 5.10, 5.4, and
other LTS kernels.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: Leah Rumancik <leah.rumancik@gmail.com>
---
 tests/ext4/048 | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/ext4/048 b/tests/ext4/048
index 51189618..35e6aa7f 100755
--- a/tests/ext4/048
+++ b/tests/ext4/048
@@ -93,6 +93,14 @@ _scratch_mkfs_sized $((128 * 1024 * 1024)) >> $seqres.full 2>&1
 # create scratch dir for testing
 # create some files with no name a substr of another name so we can grep later
 _scratch_mount >> $seqres.full 2>&1
+
+# Use the presence of the journal checkpoint ioctl as a proxy of filename
+# wipe being supported
+if test -x $here/src/checkpoint_journal && \
+	! $here/src/checkpoint_journal $SCRATCH_MNT --dry-run ; then
+    _notrun "filename wipe not supported"
+fi
+
 blocksize="$(_get_block_size $SCRATCH_MNT)"
 mkdir $testdir
 file_num=1
-- 
2.31.0

