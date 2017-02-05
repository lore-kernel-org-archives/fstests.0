Received: from mail-wm0-f49.google.com ([74.125.82.49]:37887 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751734AbdBEG6Z (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 5 Feb 2017 01:58:25 -0500
Received: by mail-wm0-f49.google.com with SMTP id v77so82553378wmv.0
        for <fstests@vger.kernel.org>; Sat, 04 Feb 2017 22:58:24 -0800 (PST)
Received: from [192.168.43.93] ([2.55.156.149])
        by smtp.gmail.com with ESMTPSA id 40sm53898046wry.22.2017.02.04.22.58.22
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Feb 2017 22:58:23 -0800 (PST)
From: Omer Zilberberg <omzg@plexistor.com>
Subject: [PATCH v2] generic/074: _cleanup potentially removes local FS files
Message-ID: <60d70b3b-98ff-ac48-3d34-0a8cd0002f16@plexistor.com>
Date: Sun, 5 Feb 2017 08:58:20 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

fstest_dir is set after _cleanup() is defined and _require_test is
called. If _require_test fails (due to some unrelated bug in tested FS),
_cleanup will attempt to remove $fstest_dir.*, which expands to .*
This has the unfortunate effect of removing xfstests' .git and
.gitignore.

Here is the 074.out.bad file for this case:
QA output created by 074
mount: permission denied
common/rc: retrying test device mount with external set
mount: permission denied
common/rc: could not mount /dev/pmem0 on /mnt
rm: refusing to remove '.' or '..' directory: skipping '.'
rm: refusing to remove '.' or '..' directory: skipping '..'
----

The only other test which could face the same problem is generic/285.
However, that test defines _cleanup after the _require* calls, and so on
_require_test failure, 285.out.bad contains the harmless:
./common/rc: line 1: _cleanup: command not found

Signed-off-by: Omer Zilberberg <omzg@plexistor.com>
---
 tests/generic/074 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/074 b/tests/generic/074
index 55264bd..737b49b 100755
--- a/tests/generic/074
+++ b/tests/generic/074
@@ -28,6 +28,7 @@ echo "QA output created by $seq"
 
 here=`pwd`
 tmp=/tmp/$$
+fstest_dir=$TEST_DIR/fstest
 status=0	# success is the default!
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -45,7 +46,6 @@ _supported_os IRIX Linux
 _require_test
 
 rm -f $seqres.full
-fstest_dir=$TEST_DIR/fstest
 
 _do_test()
 {
-- 
2.9.3

