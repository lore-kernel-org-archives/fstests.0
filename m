Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FA2C07E9A
	for <linux-fstests@archiver.kernel.org>; Mon,  5 Jul 2021 04:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A825D61363
	for <linux-fstests@archiver.kernel.org>; Mon,  5 Jul 2021 04:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbhGEEFy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 5 Jul 2021 00:05:54 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53456 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229500AbhGEEFy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 5 Jul 2021 00:05:54 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16543Fou017799
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Jul 2021 00:03:15 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C631715C3C9E; Mon,  5 Jul 2021 00:03:14 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/2] generic/475: skip test when using an external log device
Date:   Mon,  5 Jul 2021 00:03:07 -0400
Message-Id: <20210705040307.3322709-3-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210705040307.3322709-1-tytso@mit.edu>
References: <20210705040307.3322709-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This test tests log recovery by kicking off fstress on the scratch fs,
then switch out the underlying the device with dm-error to see what
happens when the disk goes down.  But when there is an external log
device writes to the log device still succeed, while writes to the
rest of the file system fail, and this leads to file system
corruption.  So skip this test when there is an external log.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/475 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/generic/475 b/tests/generic/475
index 62894491..4f230430 100755
--- a/tests/generic/475
+++ b/tests/generic/475
@@ -34,6 +34,10 @@ _require_scratch
 _require_dm_target error
 _require_command "$KILLALL_PROG" "killall"
 
+if test "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ; then
+    _notrun "Cannot have external log device"
+fi
+
 echo "Silence is golden."
 
 _scratch_mkfs >> $seqres.full 2>&1
-- 
2.31.0

