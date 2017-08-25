Received: from mail-wr0-f193.google.com ([209.85.128.193]:33975 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754614AbdHYMFO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 25 Aug 2017 08:05:14 -0400
Received: by mail-wr0-f193.google.com with SMTP id y14so504150wrd.1
        for <fstests@vger.kernel.org>; Fri, 25 Aug 2017 05:05:14 -0700 (PDT)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id s86sm2025449wma.10.2017.08.25.05.05.12
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Aug 2017 05:05:12 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] generic/420: truncate testfile before executing the test
Date: Fri, 25 Aug 2017 14:04:41 +0200
Message-Id: <1503662681-5800-1-git-send-email-idryomov@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

If generic/437 is run before generic/420, the latter fails with:

  4c4
  < stat.size = 2048
  ---
  > stat.size = 2097152

because both use $TEST_DIR/testfile.  generic/437 leaves it at 2M,
while generic/420 assumes that it is empty (or at least smaller than
2048 bytes).

Use a private test file (testfile.$seq) and truncate it on open just in
case.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 tests/generic/420 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/420 b/tests/generic/420
index ccb6cb8e829b..aab2e08855d0 100755
--- a/tests/generic/420
+++ b/tests/generic/420
@@ -52,10 +52,10 @@ _supported_os Linux
 _require_test
 _require_xfs_io_command fpunch
 
-testfile="${TEST_DIR}/testfile"
+testfile="${TEST_DIR}/testfile.$seq"
 
 echo "Testing fallocate(mode=FALLOC_FL_KEEP_SIZE|FALLOC_FL_PUNCH_HOLE)"
-$XFS_IO_PROG -fc "pwrite -b 2048 0 2048" $testfile | head -n1
+$XFS_IO_PROG -f -t -c "pwrite -b 2048 0 2048" $testfile | head -n1
 # fpunch from xfs_io has KEEP_SIZE flag set
 $XFS_IO_PROG -c "fpunch 2048 2048" $testfile
 $XFS_IO_PROG -c "stat" $testfile | grep -F 'stat.size'
-- 
2.4.3

