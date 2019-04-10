Received: from mx1.redhat.com ([209.132.183.28]:48396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731029AbfDJLOB (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 10 Apr 2019 07:14:01 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 981777DCEB
        for <fstests@vger.kernel.org>; Wed, 10 Apr 2019 11:14:00 +0000 (UTC)
Received: from bfoster.bos.redhat.com (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 509441A7D2
        for <fstests@vger.kernel.org>; Wed, 10 Apr 2019 11:14:00 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
Subject: [PATCH] fsx: test copy_file_range() using non-zero length copy
Date: Wed, 10 Apr 2019 07:13:59 -0400
Message-Id: <20190410111359.5243-1-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

The copy_file_range() test detection code performs a zero-length
copy to determine whether to perform such calls during the test run.
While this detects the common case of syscall availability,
copy_file_range() has a somewhat variable implementation on the
kernel side that can depend on certain per-filesystem features, etc.
In some implementations, a zero length copy can shortcut and return
success before ever invoking per-filesystem functionality and thus
not thoroughly testing the copy mechanism on the current system.
This can cause the test detection code to pass only to run into an
immediate failure on the first copy_file_range() call during the
test.

Tweak test_copy_range() to perform a small single byte copy to avoid
this problem. Also fix a typo bug in the errno check of the clone
range detection logic.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 ltp/fsx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 391824bf..06d08e4e 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -1364,7 +1364,7 @@ test_clone_range(void)
 	};
 
 	if (ioctl(fd, FICLONERANGE, &fcr) &&
-	    (errno = EOPNOTSUPP || errno == ENOTTY)) {
+	    (errno == EOPNOTSUPP || errno == ENOTTY)) {
 		if (!quiet)
 			fprintf(stderr,
 				"main: filesystem does not support "
@@ -1581,9 +1581,9 @@ do_dedupe_range(unsigned offset, unsigned length, unsigned dest)
 int
 test_copy_range(void)
 {
-	loff_t o1 = 0, o2 = 0;
+	loff_t o1 = 0, o2 = 1;
 
-	if (syscall(__NR_copy_file_range, fd, &o1, fd, &o2, 0, 0) == -1 &&
+	if (syscall(__NR_copy_file_range, fd, &o1, fd, &o2, 1, 0) == -1 &&
 	    (errno == ENOSYS || errno == EOPNOTSUPP || errno == ENOTTY)) {
 		if (!quiet)
 			fprintf(stderr,
-- 
2.17.2
