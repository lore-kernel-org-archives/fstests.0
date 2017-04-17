Received: from mail-pf0-f195.google.com ([209.85.192.195]:35710 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753657AbdDQT7S (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Apr 2017 15:59:18 -0400
Received: by mail-pf0-f195.google.com with SMTP id a188so26792441pfa.2
        for <fstests@vger.kernel.org>; Mon, 17 Apr 2017 12:59:18 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] test-appliance: remove gce-run
Date: Mon, 17 Apr 2017 12:59:11 -0700
Message-Id: <20170417195911.75159-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

The 'gce-run' command is obsolete now that we have 'gce-xfstests shell'.
It also didn't respect the settings in ~/.config/gce-xfstests.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/test-appliance/gce-run | 26 --------------------------
 1 file changed, 26 deletions(-)
 delete mode 100755 kvm-xfstests/test-appliance/gce-run

diff --git a/kvm-xfstests/test-appliance/gce-run b/kvm-xfstests/test-appliance/gce-run
deleted file mode 100755
index d8c895d..0000000
--- a/kvm-xfstests/test-appliance/gce-run
+++ /dev/null
@@ -1,26 +0,0 @@
-#!/bin/bash
-
-if test -r config.custom ; then
-   . $(pwd)/config.custom
-fi
-
-if test -z "$GCE_PROJECT" -o -z "$GCE_ZONE"
-then
-	echo "You must configure GCE_PROJECT and GCE_ZONE in"
-	echo "the config.custom file"
-	exit 1
-fi
-
-GS_RW=https://www.googleapis.com/auth/devstorage.read_write
-GS_RO=https://www.googleapis.com/auth/devstorage.read_only
-LOG_WR=https://www.googleapis.com/auth/logging.write
-COMPUTE_RW=https://www.googleapis.com/auth/compute
-
-SCOPES="$GS_RW,$COMPUTE_RW,$LOG_WR"
-
-gcloud compute --project "$GCE_PROJECT" \
-       instances create "xfstests" --zone "$GCE_ZONE" \
-       --machine-type "n1-highcpu-4" --network "default" \
-       --maintenance-policy "MIGRATE" \
-       --scopes "$SCOPES" \
-       --image "xfstests"
-- 
2.12.2.762.g0e3151a226-goog

