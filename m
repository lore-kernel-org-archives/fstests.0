Received: from mx2.suse.de ([195.135.220.15]:44959 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751498AbdF1LU4 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 28 Jun 2017 07:20:56 -0400
From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 2/2 v2] common/rc: handle xfs_io copy_range when copy_file_range syscall isn't available
Date: Wed, 28 Jun 2017 12:20:51 +0100
Message-Id: <20170628112051.9164-1-lhenriques@suse.com>
In-Reply-To: <20170628075008.GE23360@eguan.usersys.redhat.com>
References: <20170628075008.GE23360@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, Anna Schumaker <Anna.Schumaker@Netapp.com>, Luis Henriques <lhenriques@suse.com>
List-ID: <fstests@vger.kernel.org>

_require_xfs_io_command() isn't handling the case where the copy_file_range
syscall isn't available.  To fix this simply check the error returned by
xfs_io.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
Changes since v1:
- dropped check that worked around an xfs_io bug.

common/rc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/rc b/common/rc
index 2972f89e9527..57d596cd4f2e 100644
--- a/common/rc
+++ b/common/rc
@@ -2195,6 +2195,8 @@ _require_xfs_io_command()
 		_notrun "xfs_io $command failed (old kernel/wrong fs/bad args?)"
 	echo $testio | grep -q "foreign file active" && \
 		_notrun "xfs_io $command not supported on $FSTYP"
+	echo $testio | egrep -q "Function not implemented" && \
+		_notrun "xfs_io $command support is missing (missing syscall?)"
 
 	if [ -n "$param" -a $param_checked -eq 0 ]; then
 		$XFS_IO_PROG -c "help $command" | grep -q "^ $param --" || \
