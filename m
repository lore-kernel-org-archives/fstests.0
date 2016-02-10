Received: from imap.thunk.org ([74.207.234.97]:51040 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756064AbcBJBuM (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 9 Feb 2016 20:50:12 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 09/12] xfstests: generic/079 requires chattr, not xattrs
Date: Tue,  9 Feb 2016 20:49:58 -0500
Message-Id: <1455069001-17846-10-git-send-email-tytso@mit.edu>
In-Reply-To: <1455069001-17846-1-git-send-email-tytso@mit.edu>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: hughd@google.com, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/079 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/079 b/tests/generic/079
index 041d9c0..a2c3286 100755
--- a/tests/generic/079
+++ b/tests/generic/079
@@ -48,7 +48,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 
-_require_attrs
+_require_chattr
 _require_scratch
 
 [ -x $timmutable ] || _notrun "t_immutable was not built for this platform"
-- 
2.5.0

