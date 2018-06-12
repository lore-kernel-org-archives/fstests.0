Received: from mail-wm0-f65.google.com ([74.125.82.65]:39314 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932768AbeFLTjr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 12 Jun 2018 15:39:47 -0400
Received: by mail-wm0-f65.google.com with SMTP id p11-v6so996767wmc.4
        for <fstests@vger.kernel.org>; Tue, 12 Jun 2018 12:39:46 -0700 (PDT)
From: Jakob Unterwurzacher <jakobunt@gmail.com>
Subject: [PATCH] generic/391: add _require_odirect
Date: Tue, 12 Jun 2018 21:39:40 +0200
Message-Id: <20180612193940.26394-1-jakobunt@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jakob Unterwurzacher <jakobunt@gmail.com>
List-ID: <fstests@vger.kernel.org>

On filesystems that do not support O_DIRECT, the test should
skip itself with

> generic/391	 [not run] O_DIRECT is not supported

instead of failing with

> generic/391	 - output mismatch (see /home/jakob.donotbackup/code/fuse-xfstests/results//generic/391.out.bad)
>     --- tests/generic/391.out	2018-01-20 14:29:39.105452050 +0100
>     +++ /home/jakob.donotbackup/code/fuse-xfstests/results//generic/391.out.bad	2018-06-12 21:09:21.912486666 +0200
>     @@ -1,2 +1,3 @@
>      QA output created by 391
>     +open: Invalid argument
>      Silence is golden
>     ...
>     (Run 'diff -u tests/generic/391.out /home/jakob.donotbackup/code/fuse-xfstests/results//generic/391.out.bad'  to see the entire diff)

This patch make it do that by adding a call to _require_odirect.
Fixes https://github.com/rfjakob/gocryptfs/issues/244 .

Signed-off-by: Jakob Unterwurzacher <jakobunt@gmail.com>
---
 tests/generic/391 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/391 b/tests/generic/391
index 6da17814..61bcb802 100755
--- a/tests/generic/391
+++ b/tests/generic/391
@@ -53,6 +53,7 @@ _supported_os Linux
 _require_test
 _require_xfs_io_command "falloc"
 _require_test_program "dio-interleaved"
+_require_odirect
 
 extent_size="$(($(_get_block_size "$TEST_DIR") * 2))"
 num_extents=1024
-- 
2.17.1

