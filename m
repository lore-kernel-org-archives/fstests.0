Received: from mail-wr0-f195.google.com ([209.85.128.195]:35780 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933210AbdGKTv4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 11 Jul 2017 15:51:56 -0400
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 1/5] overlay/014: remove unneeded require and include
Date: Tue, 11 Jul 2017 22:52:02 +0300
Message-Id: <1499802726-11045-2-git-send-email-amir73il@gmail.com>
In-Reply-To: <1499802726-11045-1-git-send-email-amir73il@gmail.com>
References: <1499802726-11045-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tests/overlay/014 | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/overlay/014 b/tests/overlay/014
index 653b7d6..40d10f5 100755
--- a/tests/overlay/014
+++ b/tests/overlay/014
@@ -46,7 +46,6 @@ _cleanup()
 # get standard environment, filters and checks
 . ./common/rc
 . ./common/filter
-. ./common/attr
 
 # remove previous $seqres.full before test
 rm -f $seqres.full
@@ -54,7 +53,6 @@ rm -f $seqres.full
 # real QA test starts here
 _supported_fs overlay
 _supported_os Linux
-_require_test
 _require_scratch
 
 # Remove all files from previous tests
-- 
2.7.4

