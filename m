Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:52018 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751440AbaHIFkM (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 9 Aug 2014 01:40:12 -0400
From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] generic/077: fall back to /usr if /lib/modules doesn't exist
Date: Sat,  9 Aug 2014 01:39:13 -0400
Message-Id: <1407562753-11033-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

We need a source of "filler" that can fill up a 50M file system.
Unfortunately, on some systems /lib/modules might not exist at all.
In that case, use /usr instead.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/077 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/generic/077 b/tests/generic/077
index 172ce6e..0d6aec7 100755
--- a/tests/generic/077
+++ b/tests/generic/077
@@ -32,6 +32,9 @@ status=1
 # Something w/ enough data to fill 50M of fs...
 filler=/lib/modules/
 
+# fall back in case /lib/modules doesn't exist
+[ -d $filler ] || filler=/usr
+
 _cleanup()
 {
 	cd /
-- 
2.0.0

