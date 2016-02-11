Received: from imap.thunk.org ([74.207.234.97]:36007 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479AbcBKF42 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 11 Feb 2016 00:56:28 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 08/13] generic: require fiemap for generic/009
Date: Thu, 11 Feb 2016 00:56:17 -0500
Message-Id: <1455170182-32587-9-git-send-email-tytso@mit.edu>
In-Reply-To: <1455170182-32587-1-git-send-email-tytso@mit.edu>
References: <1455170182-32587-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: hughd@google.com, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

Require xfs_io commands fiemap and falloc as well as fzero: fzero
without falloc is unlikely, but tmpfs may later support fzero, though
probably never fiemap (and in v3.15 wrongly claimed to support fzero).

Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/009 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/generic/009 b/tests/generic/009
index 7fbec34..5902afd 100755
--- a/tests/generic/009
+++ b/tests/generic/009
@@ -45,6 +45,8 @@ trap "_cleanup ; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _supported_os Linux
 _require_xfs_io_command "fzero"
+_require_xfs_io_command "fiemap"
+_require_xfs_io_command "falloc"
 _require_test
 
 testfile=$TEST_DIR/009.$$
-- 
2.5.0

