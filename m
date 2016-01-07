Received: from mail-ob0-f171.google.com ([209.85.214.171]:34461 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbcAGGhj (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 7 Jan 2016 01:37:39 -0500
Received: by mail-ob0-f171.google.com with SMTP id wp13so183992150obc.1
        for <fstests@vger.kernel.org>; Wed, 06 Jan 2016 22:37:38 -0800 (PST)
From: Jia He <hejianet@gmail.com>
Subject: [PATCH 1/2] fstests: comments to prevent from adding "/" to the end of 2 environment variables
Date: Thu,  7 Jan 2016 14:37:28 +0800
Message-Id: <1452148649-22451-2-git-send-email-hejianet@gmail.com>
In-Reply-To: <1452148649-22451-1-git-send-email-hejianet@gmail.com>
References: <1452148649-22451-1-git-send-email-hejianet@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jia He <hejianet@gmail.com>
List-ID: <fstests@vger.kernel.org>

This adds comments to prevent user from adding "/" to the end of TEST_DIR and 
SCRATCH_MNT

Signed-off-by: Jia He <hejianet@gmail.com>
---
 configs/example.config   | 1 +
 configs/localhost.config | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/example.config b/configs/example.config
index 7b6e142..cf8f08e 100644
--- a/configs/example.config
+++ b/configs/example.config
@@ -1,5 +1,6 @@
 # Example config file with all typical device options set for full
 # XFS kernel, progs and dump testing.
+# please do NOT add "/" to end of TEST_DIR and SCRATCH_MNT
 MODULAR=0
 SCRATCH_MNT=/mnt/scratch
 SCRATCH_DEV=/dev/sdb5
diff --git a/configs/localhost.config b/configs/localhost.config
index f47e694..a7b9fe3 100644
--- a/configs/localhost.config
+++ b/configs/localhost.config
@@ -1,5 +1,6 @@
 # default localhost file, set up for virtual machines using KVM and
 # virtio for it's block devices
+# Please do NOT add "/" to the end of TEST_DIR and SCRATCH_MNT
 #
 MODULAR=0
 TEST_DIR=/mnt/test
-- 
2.1.4

