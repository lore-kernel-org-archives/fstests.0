Received: from imap.thunk.org ([74.207.234.97]:34549 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013AbcBMRlQ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 13 Feb 2016 12:41:16 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 14/16] xfstests: add executable permission to tests
Date: Sat, 13 Feb 2016 12:41:07 -0500
Message-Id: <1455385269-26319-15-git-send-email-tytso@mit.edu>
In-Reply-To: <1455385269-26319-1-git-send-email-tytso@mit.edu>
References: <1455385269-26319-1-git-send-email-tytso@mit.edu>
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

