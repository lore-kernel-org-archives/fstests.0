Received: from mail-wm0-f65.google.com ([74.125.82.65]:37415 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932100AbdHWPsw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 23 Aug 2017 11:48:52 -0400
From: Amir Goldstein <amir73il@gmail.com>
Subject: [RFC][PATCH 2/8] common/rc: fix _require_xfs_io_command params check
Date: Wed, 23 Aug 2017 18:49:11 +0300
Message-Id: <1503503357-26234-3-git-send-email-amir73il@gmail.com>
In-Reply-To: <1503503357-26234-1-git-send-email-amir73il@gmail.com>
References: <1503503357-26234-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Josef Bacik <jbacik@fb.com>, Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

When _require_xfs_io_command is passed command parameters,
the resulting error from invalid parameters may be ignored.

For example, the following bogus params would not abort the test:
_require_xfs_io_command "falloc" "-X"
_require_xfs_io_command "fiemap" "-X"

Fix this by looking for the relevant error message.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 common/rc | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 9d7b783..44b98f6 100644
--- a/common/rc
+++ b/common/rc
@@ -2212,9 +2212,14 @@ _require_xfs_io_command()
 	echo $testio | grep -q "Function not implemented" && \
 		_notrun "xfs_io $command support is missing (missing syscall?)"
 
-	if [ -n "$param" -a $param_checked -eq 0 ]; then
+	[ -n "$param" ] || return
+
+	if [ $param_checked -eq 0 ]; then
 		$XFS_IO_PROG -c "help $command" | grep -q "^ $param --" || \
 			_notrun "xfs_io $command doesn't support $param"
+	else
+		echo $testio | grep -q "invalid option" && \
+			_notrun "xfs_io $command doesn't support $param"
 	fi
 }
 
-- 
2.7.4

