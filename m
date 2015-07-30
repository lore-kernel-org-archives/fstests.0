Received: from cn.fujitsu.com ([59.151.112.132]:57199 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751212AbbG3GNt (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 30 Jul 2015 02:13:49 -0400
From: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
Subject: [PATCH] xfstests: mount scratch before checking it
Date: Thu, 30 Jul 2015 14:08:09 +0800
Message-ID: <1438236489-24747-1-git-send-email-yangds.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, fdmanana@suse.com
Cc: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

We want to check the size of scratch with _require_fs_space,
but we have to mount it firstly.

Reported-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Signed-off-by: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
---
 tests/generic/038 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/038 b/tests/generic/038
index 7bfebfc..4d108cf 100755
--- a/tests/generic/038
+++ b/tests/generic/038
@@ -121,8 +121,8 @@ create_files()
 }
 
 _scratch_mkfs >>$seqres.full 2>&1
-_require_fs_space $SCRATCH_MNT $((10 * 1024 * 1024))
 _scratch_mount
+_require_fs_space $SCRATCH_MNT $((10 * 1024 * 1024))
 _require_batched_discard $SCRATCH_MNT
 
 for ((i = 0; i < $((4 * $LOAD_FACTOR)); i++)); do
-- 
1.8.4.2

