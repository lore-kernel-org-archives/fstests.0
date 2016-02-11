Received: from imap.thunk.org ([74.207.234.97]:35992 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757AbcBKF41 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 11 Feb 2016 00:56:27 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 11/13] xfstests: add executable permission to tests
Date: Thu, 11 Feb 2016 00:56:20 -0500
Message-Id: <1455170182-32587-12-git-send-email-tytso@mit.edu>
In-Reply-To: <1455170182-32587-1-git-send-email-tytso@mit.edu>
References: <1455170182-32587-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: hughd@google.com, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/btrfs/026   | 0
 tests/btrfs/104   | 0
 tests/btrfs/114   | 0
 tests/generic/058 | 0
 tests/generic/060 | 0
 tests/generic/061 | 0
 tests/generic/063 | 0
 tests/generic/092 | 0
 tests/generic/094 | 0
 tests/generic/103 | 0
 tests/xfs/140     | 0
 11 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tests/btrfs/026
 mode change 100644 => 100755 tests/btrfs/104
 mode change 100644 => 100755 tests/btrfs/114
 mode change 100644 => 100755 tests/generic/058
 mode change 100644 => 100755 tests/generic/060
 mode change 100644 => 100755 tests/generic/061
 mode change 100644 => 100755 tests/generic/063
 mode change 100644 => 100755 tests/generic/092
 mode change 100644 => 100755 tests/generic/094
 mode change 100644 => 100755 tests/generic/103
 mode change 100644 => 100755 tests/xfs/140

diff --git a/tests/btrfs/026 b/tests/btrfs/026
old mode 100644
new mode 100755
diff --git a/tests/btrfs/104 b/tests/btrfs/104
old mode 100644
new mode 100755
diff --git a/tests/btrfs/114 b/tests/btrfs/114
old mode 100644
new mode 100755
diff --git a/tests/generic/058 b/tests/generic/058
old mode 100644
new mode 100755
diff --git a/tests/generic/060 b/tests/generic/060
old mode 100644
new mode 100755
diff --git a/tests/generic/061 b/tests/generic/061
old mode 100644
new mode 100755
diff --git a/tests/generic/063 b/tests/generic/063
old mode 100644
new mode 100755
diff --git a/tests/generic/092 b/tests/generic/092
old mode 100644
new mode 100755
diff --git a/tests/generic/094 b/tests/generic/094
old mode 100644
new mode 100755
diff --git a/tests/generic/103 b/tests/generic/103
old mode 100644
new mode 100755
diff --git a/tests/xfs/140 b/tests/xfs/140
old mode 100644
new mode 100755
-- 
2.5.0

