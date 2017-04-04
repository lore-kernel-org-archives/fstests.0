Received: from mail.kernel.org ([198.145.29.136]:41718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933621AbdDEKw3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 5 Apr 2017 06:52:29 -0400
From: fdmanana@kernel.org
Subject: [PATCH 3/3] generic/071: check that the fs supports fallocate with the KEEP_SIZE flag
Date: Tue,  4 Apr 2017 07:34:31 +0100
Message-Id: <1491287671-23097-3-git-send-email-fdmanana@kernel.org>
In-Reply-To: <1491287671-23097-1-git-send-email-fdmanana@kernel.org>
References: <1491287671-23097-1-git-send-email-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

So that the test is skipped for filesystems that don't support it instead
of failing (like NFS 4.2 for example).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/071 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/071 b/tests/generic/071
index 65ed0c7..c1f90c6 100755
--- a/tests/generic/071
+++ b/tests/generic/071
@@ -46,7 +46,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _require_scratch
-_require_xfs_io_command "falloc"
+_require_xfs_io_command "falloc -k"
 
 rm -f $seqres.full
 
-- 
2.7.0.rc3

