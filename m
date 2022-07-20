Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757BECCA480
	for <linux-fstests@archiver.kernel.org>; Wed, 20 Jul 2022 16:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbiGTQpH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 20 Jul 2022 12:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbiGTQoH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 Jul 2022 12:44:07 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AC365D56
        for <fstests@vger.kernel.org>; Wed, 20 Jul 2022 09:44:04 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26KGi14S023371
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 12:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658335442; bh=iCnwOw0mW1GMjl/nYcdjKKDpZAilqI7XsqfHaDyvrZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=P0G5mygfQ7iUmqB4QciybLZ1iWyznZm8W4FuiSyVT9Vhij1BRKoOQi0ImpGmJsu+Q
         gV4dasCuKAjKYIml7m/jS+IF9fRtvrB90JvN4O7MWWMWRem0M4rodtet8XhhVBlsna
         kbOUNxSu5fe+oEwEg9aRUpE2LrWfgvykZzlyv3HSGwRYjRK43zGDK7LYWyMxTthCtG
         yWYF33SrsfGM/xSPzKG7pNrrLsETbaQETfz6Hp3kpUcqCJ6cZAXS7bazFSoBQlg39P
         65irZ5r+qoNfEa7XRCGdE0M52cEOf86uvrKitvRlspXOE/HhwsFLL+T+uRciXxm7uS
         FqkeN0O+NLOrw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0D9D815C3ECF; Wed, 20 Jul 2022 12:44:01 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 4/4] generic/475: skip test when using an external log device
Date:   Wed, 20 Jul 2022 12:43:56 -0400
Message-Id: <20220720164356.4078789-5-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220720164356.4078789-1-tytso@mit.edu>
References: <20220720164356.4078789-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This test tests log recovery by kicking off fstress on the scratch fs,
then switching out the underlying the device with dm-error to see what
happens when the disk goes down.  But when there is an external log
device writes to the log device still succeed, while writes to the
rest of the file system fail, and this leads to file system
corruption.  So skip this test when there is an external log.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/475 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/generic/475 b/tests/generic/475
index c426402e..43c26303 100755
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

