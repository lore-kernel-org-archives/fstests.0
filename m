Return-Path: <SRS0=/bTx=EH=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9B6C2D0A3
	for <linux-fstests@archiver.kernel.org>; Sun,  1 Nov 2020 17:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F10822268
	for <linux-fstests@archiver.kernel.org>; Sun,  1 Nov 2020 17:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604251570;
	bh=j7INIfYOeDtDUwjQLFvbYybhP/nFI4E/5QmHxpgQDqU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=eBq0Pjy4uTdJYkcg6YqDYAyiiEAE2WW9S4MnE6+uDIHwtqemRnbtO5/THEbjOs5it
	 5iuyn1cS+6QuIgKTxM2t6zbGhijrUFduhL0euL2C69YwlhVHrQwRt8oPXfvthD05iu
	 j5Sdu7iXdM2eFyAIFcwrL9B0e6D4504B6NSKKmOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgKAR0K (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 1 Nov 2020 12:26:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:48752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbgKAR0J (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 1 Nov 2020 12:26:09 -0500
Received: from sol.attlocal.net (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A8582225C;
        Sun,  1 Nov 2020 17:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604251569;
        bh=j7INIfYOeDtDUwjQLFvbYybhP/nFI4E/5QmHxpgQDqU=;
        h=From:To:Cc:Subject:Date:From;
        b=GBy4RNx0D+3KnKk8NmlPJfCqrFRevjharAB8I1qptNvaz2tn5xwNA+MwmPCtiTI6d
         UTnj30lDDTTyzqZSMC6F3IokxI0qpNQR7GuXCFhZCBPk8pfqHN7lToqSCazhg0ky2S
         3ybjMuGyMHNox0PLVpU58s9bVkprXTVOXBzsyIOg=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: [xfstests-bld PATCH] gen-tarball: add 'set -e'
Date:   Sun,  1 Nov 2020 09:24:50 -0800
Message-Id: <20201101172450.479000-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The latest master branch of xfstests is missing a Makefile in
tests/ceph/, which broke xfstests's 'make install'.  But gen-tarball
didn't notice this.  Fix this by adding 'set -e', and to make this work
adjust a couple other commands that are expected to fail.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 gen-tarball | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/gen-tarball b/gen-tarball
index 7d38b95..f925b39 100755
--- a/gen-tarball
+++ b/gen-tarball
@@ -1,5 +1,7 @@
 #!/bin/bash
 
+set -e
+
 if test -f config.custom ; then
 	. config.custom
 else
@@ -72,15 +74,19 @@ if test -d bld/usr/bin ; then
     cp bld/usr/bin/* xfstests/bin
 fi
 cp bld/lib/client.txt xfstests/lib
-cp bld/lib/libimaevm.so.0.0.0 xfstests/lib
-ln -s libimaevm.so.0.0.0 xfstests/lib/libimaevm.so.0
+# ima-evm-utils is optional.
+if test -e bld/lib/libimaevm.so.0.0.0; then
+    cp bld/lib/libimaevm.so.0.0.0 xfstests/lib
+    ln -s libimaevm.so.0.0.0 xfstests/lib/libimaevm.so.0
+fi
 rm -f xfstests/bin/compile_et xfstests/bin/mk_cmds
 for i in ltp/fsstress ltp/fsx ltp/aio-stress src/godown
 do
     ln -s ../$i xfstests/bin
 done
 echo "STRIP xfstests/*"
-find xfstests -mindepth 2 -type f -perm /0111 | xargs $STRIP 2> /dev/null
+find xfstests -mindepth 2 -type f -perm /0111 | xargs $STRIP 2> /dev/null \
+    || true
 echo "TAR xfstests"
 find xfstests blktests -path blktests/.git -prune -o -print0 | \
     LC_ALL=C sort -z | \
-- 
2.29.1

