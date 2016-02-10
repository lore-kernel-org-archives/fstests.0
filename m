Received: from imap.thunk.org ([74.207.234.97]:51030 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755406AbcBJBuM (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 9 Feb 2016 20:50:12 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 11/12] xfstests: add executable permission to tests
Date: Tue,  9 Feb 2016 20:50:00 -0500
Message-Id: <1455069001-17846-12-git-send-email-tytso@mit.edu>
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
 tests/generic/058 | 0
 tests/generic/060 | 0
 tests/generic/061 | 0
 tests/generic/063 | 0
 4 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tests/generic/058
 mode change 100644 => 100755 tests/generic/060
 mode change 100644 => 100755 tests/generic/061
 mode change 100644 => 100755 tests/generic/063

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
-- 
2.5.0

