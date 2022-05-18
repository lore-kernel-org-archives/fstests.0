Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E2CC433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 18 May 2022 20:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242541AbiERUWp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 18 May 2022 16:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242539AbiERUWm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 May 2022 16:22:42 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5EDFD346
        for <fstests@vger.kernel.org>; Wed, 18 May 2022 13:22:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 4F0001F454A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652905359;
        bh=cx0M04ddz0d8F1E7ViwHvfJw9iHWShzU/tweNAk4oNk=;
        h=From:To:Cc:Subject:Date:From;
        b=LHhVdfYTxF/Ymt++JLE6pL0nRS7r9iyhm6YwhV/KLtmRGB1sQEX9M8AWYoF6Aw3b/
         P86eQx+T8zypI+4D2W8mnnACmT3c+xss2Z3l2CZ947qFbyslmv4KY/OVdp0VqGgrrL
         KzDAVZL7Xl8J0sWvOif+XmRinq1OjdjNA5S2XLspz8fRhOVJAf4hYyyl3842MB4C3z
         ccg+e5tSutYUuB+892wuj0U/TdiJsNe236VXL7kblYrHFQO7FT4NMQmhR13lm0u+Y+
         YEzu3+pyzQ/qqF2hh6MG75q7xNFr5SCTn50dDfaQgYiAZXis1W6PcvPKepCt48can5
         s0zuASOBATITg==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     zlang@redhat.com
Cc:     fstests@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH] generic/556: Adequate expected output to touch behavior change
Date:   Wed, 18 May 2022 16:22:14 -0400
Message-Id: <20220518202214.481121-1-krisman@collabora.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Coreutils commit d435cfc0bc55 ("touch: fix wrong
diagnostic (Bug#48106)"), released in coreutils v9.0, changed the error
reported by the tool when openat() fails with EINVAL.  Instead of
reporting a generic message for the failure of either openat() or the
following utimensat(), it now differentiates both failures with
different messages.

This change breaks generic/556, which relied on the parsing of that
message.  This test was originally developed by me on a Debian
Buster (coreutils v8.x), so I used the generic error message.  Now that
I tried to run it on a more modern distro, it reports a different error
message, which fails the test.

We could do it in a more flexible way to catch future changes.  These
are unlikely, and many other parts of fstests just use this generic
touch message, so don't bother with it here.

There is no change in behavior on the kernel side, just a broken test.
On both older and new distros, the kernel correctly rejects this invalid
sequence with -EINVAL, as shown in the strace hunk below:

...
openat(AT_FDCWD, "/scratch_mnt/strict/corac\314\247\303", ...) = -1 EINVAL
utimensat(AT_FDCWD, "/scratch_mnt/strict/corac\314\247\303", ...) = -1 EINVAL
...

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 tests/generic/556.out | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/556.out b/tests/generic/556.out
index f9dd9542fb12..12c77a5b0176 100644
--- a/tests/generic/556.out
+++ b/tests/generic/556.out
@@ -12,5 +12,5 @@ user.foo="bar"
 # file: SCRATCH_MNT/xattrs/x/f1
 user.foo="bar"
 
-touch: setting times of 'SCRATCH_MNT/strict/corac'$'\314\247\303': Invalid argument
-touch: setting times of 'SCRATCH_MNT/strict/cora'$'\303\247\303': Invalid argument
+touch: cannot touch 'SCRATCH_MNT/strict/corac'$'\314\247\303': Invalid argument
+touch: cannot touch 'SCRATCH_MNT/strict/cora'$'\303\247\303': Invalid argument
-- 
2.36.1

