Received: from mx2.suse.de ([195.135.220.15]:54572 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751415AbdFZQk6 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 26 Jun 2017 12:40:58 -0400
From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 2/2] common/rc: handle xfs_io copy_range when copy_file_range syscall isn't available
Date: Mon, 26 Jun 2017 17:40:53 +0100
Message-Id: <20170626164053.7634-2-lhenriques@suse.com>
In-Reply-To: <20170626164053.7634-1-lhenriques@suse.com>
References: <20170626164053.7634-1-lhenriques@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Anna Schumaker <Anna.Schumaker@Netapp.com>, Luis Henriques <lhenriques@suse.com>
List-ID: <fstests@vger.kernel.org>

_require_xfs_io_command() isn't handling the case where the copy_file_range
syscall isn't available.  Unfortunately, old versions of xfs_io don't
handle it correctly either and the test will succeed with an empty file.

To fix this function, we need to add two checks:

1) for old xfs_io versions, fail if the test seems to succeed (no output)
   but the file created is empty,
2) for newer versions, use the error returned.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 common/rc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/common/rc b/common/rc
index 2972f89e9527..aad065cb2ade 100644
--- a/common/rc
+++ b/common/rc
@@ -2146,6 +2146,10 @@ _require_xfs_io_command()
 		$XFS_IO_PROG -F -f -c "pwrite 0 4k" $testfile > /dev/null 2>&1
 		testio=`$XFS_IO_PROG -F -f -c "copy_range $testfile" $testcopy 2>&1`
 		rm -f $testcopy > /dev/null 2>&1
+		[ -z "$testio" -a ! -s "$testcopy" ] && \
+			_notrun "xfs_io $command support is missing"
+		echo $testio | egrep -q "Function not implemented" && \
+			_notrun "xfs_io $command support is missing"
 		;;
 	"falloc" )
 		testio=`$XFS_IO_PROG -F -f -c "falloc $param 0 1m" $testfile 2>&1`
