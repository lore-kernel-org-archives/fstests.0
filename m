Received: from mx2.suse.de ([195.135.220.15]:54569 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751386AbdFZQk6 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 26 Jun 2017 12:40:58 -0400
From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 1/2] generic/430: Fix filename in "copy beyond end" test
Date: Mon, 26 Jun 2017 17:40:52 +0100
Message-Id: <20170626164053.7634-1-lhenriques@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Anna Schumaker <Anna.Schumaker@Netapp.com>, Luis Henriques <lhenriques@suse.com>
List-ID: <fstests@vger.kernel.org>

The cmp command was using the wrong file to perform the comparison.  Use
$testdir/beyond instead of $testdir/end.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 tests/generic/430 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/430 b/tests/generic/430
index 2ec126db9847..5d6b8d6c2aa3 100755
--- a/tests/generic/430
+++ b/tests/generic/430
@@ -87,7 +87,7 @@ md5sum $testdir/{file,end} | _filter_test_dir
 
 echo "Copy beyond end of original file"
 $XFS_IO_PROG -f -c "copy_range -s 4000 -l 2000 $testdir/file" "$testdir/beyond"
-cmp -n 1000 $testdir/file $testdir/end 4000
+cmp -n 1000 $testdir/file $testdir/beyond 4000
 echo "md5sums after copying beyond:"
 md5sum $testdir/{file,beyond} | _filter_test_dir
 
