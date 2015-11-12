Received: from mail-pa0-f47.google.com ([209.85.220.47]:36121 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511AbbKLAh3 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 11 Nov 2015 19:37:29 -0500
Received: by pacdm15 with SMTP id dm15so46007501pac.3
        for <fstests@vger.kernel.org>; Wed, 11 Nov 2015 16:37:29 -0800 (PST)
From: Tahsin Erdogan <tahsin@google.com>
Subject: [PATCH] generic/310: make ext[2-4] error patterns more specific
Date: Wed, 11 Nov 2015 16:36:30 -0800
Message-Id: <1447288590-31937-1-git-send-email-tahsin@google.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Zhao Hongjiang <zhaohongjiang@huawei.com>, Theodore Ts'o <tytso@mit.edu>, Tahsin Erdogan <tahsin@google.com>
List-ID: <fstests@vger.kernel.org>

This test watches for ext[2-4] filesystem errors in kernel messages but it
incorrectly identifies unrelated messages that contain string "error" as
a failure condition.

Make grep pattern more specific to catch only relevant messages.

Signed-off-by: Tahsin Erdogan <tahsin@google.com>
---
 tests/generic/310 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/310 b/tests/generic/310
index c0a8645..9173fb9 100755
--- a/tests/generic/310
+++ b/tests/generic/310
@@ -62,7 +62,7 @@ _require_test
 dmesg -c > /dev/null
 
 nr_bug=`dmesg | grep -c "kernel BUG"`
-nr_error=`dmesg | grep -c "error"`
+nr_error=`dmesg | grep -c "EXT[234]-fs .*error"`
 nr_null=`dmesg | grep -c "kernel NULL pointer dereference"`
 nr_warning=`dmesg | grep -c "^WARNING"`
 nr_lockdep=`dmesg | grep -c "possible recursive locking detected"`
@@ -71,7 +71,7 @@ nr_lockdep=`dmesg | grep -c "possible recursive locking detected"`
 check_kernel_bug()
 {
 	new_bug=`dmesg | grep -c "kernel BUG"`
-	new_error=`dmesg | grep -c "error"`
+	new_error=`dmesg | grep -c "EXT[234]-fs .*error"`
 	new_null=`dmesg | grep -c "kernel NULL pointer dereference"`
 	new_warning=`dmesg | grep -c "^WARNING"`
 	new_lockdep=`dmesg | grep -c "possible recursive locking detected"`
-- 
2.6.0.rc2.230.g3dd15c0

