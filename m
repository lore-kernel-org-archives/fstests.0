Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C41C388F9
	for <linux-fstests@archiver.kernel.org>; Wed, 11 Nov 2020 21:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C31C208FE
	for <linux-fstests@archiver.kernel.org>; Wed, 11 Nov 2020 21:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ys+6chpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgKKVfy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 11 Nov 2020 16:35:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:50668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgKKVfx (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 11 Nov 2020 16:35:53 -0500
Received: from sol.attlocal.net (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04E7B20637;
        Wed, 11 Nov 2020 21:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605130553;
        bh=IJmLDGVhGfKMeGsX4FcHQB8zE8vJajqR0FxUJhCecEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ys+6chpCgg0ec2CYvLejqvJ2gpEmPPjvqkINPvkFINrYoVVA1gowi9PN6SEdoCYdJ
         sxwU7mIX0IXVPRPbu9kZ5Z3jaX/SQYyuTbwQE2KNDOJvx9yTd4CDE/Qw3AwCn9kd+u
         GDCTP73IuiKDqkyOiAU6uZwjtnQtpb6prFRBX7GI=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: [xfstests-bld PATCH v2] gen-tarball: add 'set -e'
Date:   Wed, 11 Nov 2020 13:35:15 -0800
Message-Id: <20201111213515.320012-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <X6xWtkUQeUGcE786@sol.localdomain>
References: <X6xWtkUQeUGcE786@sol.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

'make install' in xfstests was temporarily broken (it was broken by
commit 10f3f9707cca and fixed by commit 1de2b58b8e29).  gen-tarball
didn't notice this, resulting in test appliances being "successfully"
built but not actually containing all the xfstests files.

Fix gen-tarball to check for errors by adding 'set -e'.  To make this
work, adjust a few commands that are expected to fail.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---

v2: handle case where kvm-xfstests/test-appliance/debs doesn't exist

 gen-tarball | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/gen-tarball b/gen-tarball
index 7d38b95..b8e3307 100755
--- a/gen-tarball
+++ b/gen-tarball
@@ -1,5 +1,7 @@
 #!/bin/bash
 
+set -e
+
 if test -f config.custom ; then
 	. config.custom
 else
@@ -59,7 +61,11 @@ else
     cp xfstests-dev/README* xfstests
 fi
 echo "xfstests-bld	$(git describe --always --dirty) ($(git log -1 --pretty=%cD))" > xfstests-bld.ver
-debs_vers=$(find kvm-xfstests/test-appliance/debs -name "*.ver" -print 2>/dev/null)
+if test -e kvm-xfstests/test-appliance/debs ; then
+    debs_vers=$(find kvm-xfstests/test-appliance/debs -name "*.ver" -print)
+else
+    debs_vers=
+fi
 cat *.ver $debs_vers | sort > xfstests/git-versions
 if test -f build-distro ; then
     cp build-distro xfstests/build-distro
@@ -72,15 +78,19 @@ if test -d bld/usr/bin ; then
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
2.29.2

