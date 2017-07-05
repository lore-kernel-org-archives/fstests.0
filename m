Received: from mail-wm0-f68.google.com ([74.125.82.68]:36432 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752663AbdGEMBy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 5 Jul 2017 08:01:54 -0400
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v3 4/7] overlay/018: test lower hardlinks re-unite on copy up
Date: Wed,  5 Jul 2017 15:02:03 +0300
Message-Id: <1499256126-21866-5-git-send-email-amir73il@gmail.com>
In-Reply-To: <1499256126-21866-1-git-send-email-amir73il@gmail.com>
References: <1499256126-21866-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Test that when two lower hardlinks are copied up, they end up
as two upper hardlinks of the same upper inode.

Drop caches before copy up so there is no knowledge of the
copied up hardlink in inode/dcache.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tests/overlay/018     | 10 ++++++++++
 tests/overlay/018.out |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/tests/overlay/018 b/tests/overlay/018
index 46097a9..41855dc 100755
--- a/tests/overlay/018
+++ b/tests/overlay/018
@@ -111,5 +111,15 @@ echo "== After mount cycle =="
 cat $FILES
 check_ino_nlink $tmp.after_one $tmp.after_cycle
 
+# Drop caches to get the copied up hardlink out of cache
+echo 3 > /proc/sys/vm/drop_caches
+
+# Modify content of the other hardlink
+echo "two" >> $foo
+
+echo "== After write two =="
+cat $FILES
+check_ino_nlink $tmp.after_one $tmp.after_two
+
 status=0
 exit
diff --git a/tests/overlay/018.out b/tests/overlay/018.out
index 5b74ee1..adc7f72 100644
--- a/tests/overlay/018.out
+++ b/tests/overlay/018.out
@@ -12,3 +12,10 @@ zero
 one
 zero
 one
+== After write two ==
+zero
+one
+two
+zero
+one
+two
-- 
2.7.4

