Received: from mx1.redhat.com ([209.132.183.28]:40540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751209AbdDJDSr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 9 Apr 2017 23:18:47 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] generic/422: check fallocate KEEP_SIZE flag correctly
Date: Mon, 10 Apr 2017 11:18:28 +0800
Message-Id: <20170410031828.2110-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: fdmanana@kernel.org, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

"-k" should be passed to _require_xfs_io_command() as a separate
parameter.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---

Hi Filipe,

This is a merge error, I did correct updates to _require_xfs_io_command() and
generic/071 but forgot generic/422. Sorry again for the whole mess :-(

(Not sure why my release testing didn't catch this merge error, I guess it had
something to do with post-release-testing modifications to the stage tree when
I dropped statx tests)

 tests/generic/422 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/422 b/tests/generic/422
index cae76a9..a42a30d 100755
--- a/tests/generic/422
+++ b/tests/generic/422
@@ -48,7 +48,7 @@ _supported_fs generic
 _supported_os Linux
 _require_test
 _require_scratch
-_require_xfs_io_command "falloc -k"
+_require_xfs_io_command "falloc" "-k"
 _require_odirect
 
 rm -f $seqres.full
-- 
2.9.3

