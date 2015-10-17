Received: from imap.thunk.org ([74.207.234.97]:56245 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851AbbJQSpY (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 17 Oct 2015 14:45:24 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] common: introduce XFS_IO_AVOID env var
Date: Sat, 17 Oct 2015 14:45:18 -0400
Message-Id: <1445107518-32022-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Like FSSTRESS_AVOID and FSX_AVOID, XFS_IO_AVOID can be used to avoid
using various advanced file system features such as "fpunch"
"fcollapse", "finsert", or "zero".  Tests that require an xfs_io
command which is included in the space-separated list found in the
XFS_IO_AVOID environment variable will be skipped using _notrun.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 README    | 4 ++++
 common/rc | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/README b/README
index f8a878c..bb0075b 100644
--- a/README
+++ b/README
@@ -78,6 +78,10 @@ Preparing system for tests (IRIX and Linux):
                added to the end of fsstresss and fsx invocations, respectively,
                in case you wish to exclude certain operational modes from these
                tests.
+	     - setenv XFS_IO_AVOID which may contain a list of space separated
+	       xfs_io commands which will be avoided in case you want to
+	       exclude tests that require the use of certain file system
+	       operations such as "fpunch", "fcollapse", "finsert", or "zero".
 
         - or add a case to the switch in common/config assigning
           these variables based on the hostname of your test
diff --git a/common/rc b/common/rc
index adf1edf..61de97e 100644
--- a/common/rc
+++ b/common/rc
@@ -1603,6 +1603,11 @@ _require_xfs_io_command()
 	fi
 	command=$1
 
+	if echo "$XFS_IO_AVOID" | grep -wq "$command"
+	then
+		_notrun "Avoiding xfs_io $command"
+	fi
+
 	testfile=$TEST_DIR/$$.xfs_io
 	case $command in
 	"falloc" )
-- 
2.5.0

