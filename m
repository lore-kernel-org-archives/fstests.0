Received: from mx1.redhat.com ([209.132.183.28]:42016 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751081AbeAYHjW (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 25 Jan 2018 02:39:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 672F972FE9
        for <fstests@vger.kernel.org>; Thu, 25 Jan 2018 07:39:22 +0000 (UTC)
Received: from dhcp-12-127.nay.redhat.com (unknown [10.66.12.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A497B5D728
        for <fstests@vger.kernel.org>; Thu, 25 Jan 2018 07:39:21 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] xfs/439: mkfs again to avoid corruption failure
Date: Thu, 25 Jan 2018 15:39:18 +0800
Message-Id: <20180125073918.22371-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

xfs/439 always fails on ppc64 as below:
  # ./check xfs/439
  ...
  ...
  xfs/439 2s ... 1s
  _check_xfs_filesystem: filesystem on /dev/sda5 is inconsistent (r)
  (see /var/lib/xfstests/results//xfs/439.full for details)
  Ran: xfs/439
  Failures: xfs/439
  Failed 1 of 1 tests

  # xfs_repair -n $SCRATCH_DEV
  ...
  ...
  Phase 6 - check inode connectivity...
          - traversing filesystem ...
          - traversal finished ...
          - moving disconnected inodes to lost+found ...
  Phase 7 - verify link counts...
  Maximum metadata LSN (1:2) is ahead of log (1:2).
  Would format log to cycle 4.
  No modify flag set, skipping filesystem flush and exiting.

It can't be fixed by log replay (scratch_mount), so mkfs again to
make sure the case won't be failed at the end.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/xfs/439 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/xfs/439 b/tests/xfs/439
index 7be700cd..cb13a212 100755
--- a/tests/xfs/439
+++ b/tests/xfs/439
@@ -78,6 +78,9 @@ fi
 # or CONFIG_XFS_DEBUG (when bug_on_assert is disabled) build, so filter them.
 _check_dmesg _filter_assert_dmesg
 
+# mkfs again to avoid xfs corruption at the end of test
+_scratch_mkfs > /dev/null 2>&1
+
 echo "Silence is golden"
 
 # success, all done
-- 
2.13.6

