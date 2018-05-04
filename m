Received: from mail-wr0-f194.google.com ([209.85.128.194]:38011 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbeEDJkM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 4 May 2018 05:40:12 -0400
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 1/2] overlay/049: update fix commit id
Date: Fri,  4 May 2018 12:41:30 +0300
Message-Id: <1525426891-6121-2-git-send-email-amir73il@gmail.com>
In-Reply-To: <1525426891-6121-1-git-send-email-amir73il@gmail.com>
References: <1525426891-6121-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tests/overlay/049 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/overlay/049 b/tests/overlay/049
index 1dafc46..376acf5 100755
--- a/tests/overlay/049
+++ b/tests/overlay/049
@@ -10,8 +10,8 @@
 # This test checks that overlayfs detects and fails lookup of a multiply
 # redirected dir.
 #
-# The check for multiply redirected dir was implemented by kernel titled
-# "ovl: hash directory inodes for fsnotify"
+# The check for multiply redirected dir was a by-product of kernel
+# commit 31747eda41ef ("ovl: hash directory inodes for fsnotify")
 #
 #-----------------------------------------------------------------------
 # Copyright (C) 2018 CTERA Networks. All Rights Reserved.
-- 
2.7.4

