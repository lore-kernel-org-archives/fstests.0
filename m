Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA40C07E99
	for <linux-fstests@archiver.kernel.org>; Mon,  5 Jul 2021 04:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84298613D1
	for <linux-fstests@archiver.kernel.org>; Mon,  5 Jul 2021 04:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbhGEEFy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 5 Jul 2021 00:05:54 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53454 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229495AbhGEEFy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 5 Jul 2021 00:05:54 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16543FsQ017797
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Jul 2021 00:03:15 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4919415C3C96; Mon,  5 Jul 2021 00:03:14 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/2] dmflakey: don't run dmflakey tests with an external log device
Date:   Mon,  5 Jul 2021 00:03:06 -0400
Message-Id: <20210705040307.3322709-2-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210705040307.3322709-1-tytso@mit.edu>
References: <20210705040307.3322709-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

dmflakey works by dropping all writes before unmounting to similate a
crash/power loss.  This doesn't work if there is an external log
device, since we only drop writes to the primary block device, and not
the external log device.  Fixing this for real would require somehow
arranging to atomically loading a new dmflakey table for two block
devices at the same time, so for now, just skip tests using dmflakey
if the external log device is enabled.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/dmflakey | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/common/dmflakey b/common/dmflakey
index b4e11ae9..3bbf6e2b 100644
--- a/common/dmflakey
+++ b/common/dmflakey
@@ -11,6 +11,10 @@ FLAKEY_ERROR_WRITES=2
 _init_flakey()
 {
 	local BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
+
+	if test "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ; then
+		_notrun "dmflakey tests don't work with an external log device"
+	fi
 	FLAKEY_DEV=/dev/mapper/flakey-test
 	FLAKEY_TABLE="0 $BLK_DEV_SIZE flakey $SCRATCH_DEV 0 180 0"
 	FLAKEY_TABLE_DROP="0 $BLK_DEV_SIZE flakey $SCRATCH_DEV 0 0 180 1 drop_writes"
-- 
2.31.0

