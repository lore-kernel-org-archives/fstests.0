Received: from mx2.mpynet.fi ([82.197.21.85]:42665 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751360AbeA3Nzb (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 30 Jan 2018 08:55:31 -0500
From: Rostislav Skudnov <rostislav@tuxera.com>
Subject: [PATCH 2/2] generic/{274,315}: Require falloc -k support
Date: Tue, 30 Jan 2018 13:54:59 +0000
Message-ID: <1517320499-14714-3-git-send-email-rostislav@tuxera.com>
In-Reply-To: <1517320499-14714-1-git-send-email-rostislav@tuxera.com>
References: <1517320499-14714-1-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

These test cases require filesystem support for FALLOC_FL_KEEP_SIZE
flag in fallocate().

Signed-off-by: Rostislav Skudnov <rostislav@tuxera.com>
---
 tests/generic/274 | 2 +-
 tests/generic/315 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/274 b/tests/generic/274
index 7d09386..a3f8c75 100755
--- a/tests/generic/274
+++ b/tests/generic/274
@@ -48,7 +48,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
-_require_xfs_io_command "falloc"
+_require_xfs_io_command "falloc" "-k"
 
 echo "------------------------------"
 echo "preallocation test"
diff --git a/tests/generic/315 b/tests/generic/315
index 4433b6c..954f8a9 100755
--- a/tests/generic/315
+++ b/tests/generic/315
@@ -49,7 +49,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_test
-_require_xfs_io_command "falloc"
+_require_xfs_io_command "falloc" "-k"
 
 rm -f $seqres.full
 
-- 
2.1.4

