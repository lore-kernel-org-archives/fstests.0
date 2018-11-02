Received: from mail-io1-f67.google.com ([209.85.166.67]:44333 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbeKCGi6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 3 Nov 2018 02:38:58 -0400
Received: by mail-io1-f67.google.com with SMTP id c6-v6so2371234iob.11
        for <fstests@vger.kernel.org>; Fri, 02 Nov 2018 14:30:11 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH 1/7] generic/{472,496,497}: fix $seeqres typo
Date: Fri,  2 Nov 2018 14:29:36 -0700
Message-Id: <c9a9f45d901273f88c9ecb7bc4f64635d2ab9ba5.1541193856.git.osandov@fb.com>
In-Reply-To: <cover.1541193856.git.osandov@fb.com>
References: <cover.1541193856.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: kernel-team@fb.com, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 tests/generic/472 | 2 +-
 tests/generic/496 | 2 +-
 tests/generic/497 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/generic/472 b/tests/generic/472
index c74d6c70..04ed3e73 100755
--- a/tests/generic/472
+++ b/tests/generic/472
@@ -51,7 +51,7 @@ swapfile_cycle() {
 	$CHATTR_PROG +C $swapfile >> $seqres.full 2>&1
 	"$here/src/mkswap" $swapfile >> $seqres.full
 	"$here/src/swapon" $swapfile 2>&1 | _filter_scratch
-	swapoff $swapfile 2>> $seeqres.full
+	swapoff $swapfile 2>> $seqres.full
 	rm -f $swapfile
 }
 
diff --git a/tests/generic/496 b/tests/generic/496
index 1c9651ad..968b8012 100755
--- a/tests/generic/496
+++ b/tests/generic/496
@@ -53,7 +53,7 @@ swapfile_cycle() {
 	$CHATTR_PROG +C $swapfile >> $seqres.full 2>&1
 	"$here/src/mkswap" $swapfile >> $seqres.full
 	"$here/src/swapon" $swapfile 2>&1 | _filter_scratch
-	swapoff $swapfile 2>> $seeqres.full
+	swapoff $swapfile 2>> $seqres.full
 	rm -f $swapfile
 }
 
diff --git a/tests/generic/497 b/tests/generic/497
index 584af58a..3d5502ef 100755
--- a/tests/generic/497
+++ b/tests/generic/497
@@ -53,7 +53,7 @@ swapfile_cycle() {
 	$CHATTR_PROG +C $swapfile >> $seqres.full 2>&1
 	"$here/src/mkswap" $swapfile >> $seqres.full
 	"$here/src/swapon" $swapfile 2>&1 | _filter_scratch
-	swapoff $swapfile 2>> $seeqres.full
+	swapoff $swapfile 2>> $seqres.full
 	rm -f $swapfile
 }
 
-- 
2.19.1
