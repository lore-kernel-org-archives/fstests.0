Received: from imap.thunk.org ([74.207.234.97]:58163 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752209AbbJSDno (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 18 Oct 2015 23:43:44 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] xfstests: move ext4/30[1234] from the dangerous to the auto group
Date: Sun, 18 Oct 2015 23:43:39 -0400
Message-Id: <1445226219-8496-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

The ext4/301, ext4/302, ext4/303, and ext4/304 tests are not crashing
on 3.10.89, 3.14.53, 3.18.21, 4.1.8, and 4.3-rc2.  So promote these
tests from the dangerous to the auto group.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/ext4/group | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/ext4/group b/tests/ext4/group
index c947db6..1191441 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -23,10 +23,10 @@
 018 fuzzers
 019 fuzzers
 271 auto rw quick
-301 aio dangerous ioctl rw stress
-302 aio dangerous ioctl rw stress
-303 aio dangerous ioctl rw stress
-304 aio dangerous ioctl rw stress
+301 aio auto ioctl rw stress
+302 aio auto ioctl rw stress
+303 aio auto ioctl rw stress
+304 aio auto ioctl rw stress
 305 auto
 306 auto rw resize quick
 307 auto ioctl rw
-- 
2.5.0

