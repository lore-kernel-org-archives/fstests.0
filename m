Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2A2C43334
	for <linux-fstests@archiver.kernel.org>; Thu, 23 Jun 2022 19:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiFWTSE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiFWTRo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 23 Jun 2022 15:17:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34E890985
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 11:22:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CDFF61F92
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 18:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C3AC3411B;
        Thu, 23 Jun 2022 18:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656008541;
        bh=xVOtUmrJRRkyn36thHXn77I8tP9kxx31GHjx/DP2XY8=;
        h=From:To:Cc:Subject:Date:From;
        b=NkNtC5RS54+pTj3Zt2XgCT2GiDkdYv9PJ/iGFyX7ZhifvMvVVSfpD0obvBrNf/Zs2
         WiA74DhmG/PPOdFtgzwNE5sIZZ40pPB6h4hePsnsbXLni1dwaP14XGcavpDcRjfGS3
         XeKKwDGlMlaRv8s+rQ94sAoZP4OgIj3bWJxGNHR3g/9d6ul5sMIX3zTZff+2cPYTM0
         okIDLV5lh3bU59EKmCySwgGsdNErJFclrTorXLJXXPTwvGugVR6NycdGLrEG2lUUDJ
         QnVaRkCKsSTYv03uAaXVi6X1u7FI8pQaVn8W3pviQBQ4dDVmL4sfCwbncLAMBMQxxW
         JcLe49zdsyLPw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: [xfstests-bld PATCH] {kvm,gce}-xfstests: fix the --update-xfstests-tar option
Date:   Thu, 23 Jun 2022 11:21:31 -0700
Message-Id: <20220623182131.210809-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Make --update-xfstests-tar work with the new directory organization.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 run-fstests/gce-xfstests   | 2 +-
 run-fstests/kvm-xfstests   | 2 +-
 run-fstests/util/parse_cli | 6 ++----
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/run-fstests/gce-xfstests b/run-fstests/gce-xfstests
index 0127509..baf1fb9 100755
--- a/run-fstests/gce-xfstests
+++ b/run-fstests/gce-xfstests
@@ -806,7 +806,7 @@ fi
 
 if test -z "$NO_ACTION" -a "$UPDATE_XFSTESTS" = "yes"
 then
-    LOCAL_XFSTESTS="$DIR/../xfstests.tar.gz"
+    LOCAL_XFSTESTS="$DIR/../fstests-bld/xfstests.tar.gz"
     GS_XFSTESTS="gs://$GS_BUCKET/xfstests.tar.gz"
     get_local_hash "$LOCAL_XFSTESTS"
     get_remote_hash "$GS_XFSTESTS"
diff --git a/run-fstests/kvm-xfstests b/run-fstests/kvm-xfstests
index 10b90d8..db2fcdd 100755
--- a/run-fstests/kvm-xfstests
+++ b/run-fstests/kvm-xfstests
@@ -132,7 +132,7 @@ tar -c -f "$VDH" -T /dev/null
 
 if test -z "$NO_ACTION" -a "$UPDATE_XFSTESTS" = "yes"
 then
-    tar -r -f $VDH -C "$DIR/.." xfstests.tar.gz
+    tar -r -f $VDH -C "$DIR/../fstests-bld" xfstests.tar.gz
 fi
 
 if test -z "$NO_ACTION" -a "$UPDATE_EXTRA_TESTS" = "yes"
diff --git a/run-fstests/util/parse_cli b/run-fstests/util/parse_cli
index 441170e..5848bf4 100644
--- a/run-fstests/util/parse_cli
+++ b/run-fstests/util/parse_cli
@@ -402,17 +402,15 @@ while (( $# >= 1 )); do
 	    supported_flavors kvm gce
 	    UPDATE_XFSTESTS_TAR=yes
 	    UPDATE_XFSTESTS=yes
-	    UPDATE_XFSTESTS_DIR="$DIR/.."
 	    ;;
 	--update-xfstests)
 	    supported_flavors kvm gce
-	    if ! test -f "$DIR/../xfstests.tar.gz"
+	    if ! test -f "$DIR/../fstests-bld/xfstests.tar.gz"
 	    then
 		echo "The xfstests.tar.gz file has not been built!"
 		exit 1
 	    fi
 	    UPDATE_XFSTESTS=yes
-	    UPDATE_XFSTESTS_DIR="$DIR/.."
 	    ;;
 	--update-files)
 	    supported_flavors kvm gce
@@ -1032,7 +1030,7 @@ fi
 find_kernel_to_use
 
 if test -n "$UPDATE_XFSTESTS_TAR" ; then
-    (cd $DIR/.. ; ./gen-tarball --fast)
+    (cd "$DIR/../fstests-bld" ; ./gen-tarball --fast)
 fi
 
 if test -n "$PMEM_DEVICE" ; then

base-commit: 3b4b532e7c82bb17dbe50cf30ff933554ebf28cb
-- 
2.36.1

