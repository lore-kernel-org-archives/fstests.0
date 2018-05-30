Received: from mail.cn.fujitsu.com ([183.91.158.132]:18525 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750821AbeE3CXM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 May 2018 22:23:12 -0400
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id B2E4B4B41E69
        for <fstests@vger.kernel.org>; Wed, 30 May 2018 10:23:04 +0800 (CST)
From: Huan Xu <xuhuan.fnst@cn.fujitsu.com>
Subject: [PATCH] fix generic 401 on fs without filesystem support
Date: Wed, 30 May 2018 10:11:07 +0800
Message-ID: <1527646267-2257-1-git-send-email-xuhuan.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xu Huan <xuhuan.fnst@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

From: Xu Huan <xuhuan.fnst@cn.fujitsu.com>

in generic 401 when test on fs without filesystem support
list DT_UNKNOWN file . and .. , then list all file without
. and ..

following  is test result on nfs

generic/401     QA output created by 401
. d
.. d
 - output mismatch (see /var/lib/xfstests/results//generic/401.out.bad)
    --- tests/generic/401.out   2018-05-22 04:22:11.641999979 -0400
    +++ /var/lib/xfstests/results//generic/401.out.bad  2018-05-28 23:22:42.312999931 -0400
    @@ -1,9 +1,3 @@
     QA output created by 401
     . d
     .. d
    -b b
    -c c
    -d d
    -f f
---
 tests/generic/401 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/401 b/tests/generic/401
index 74f2bea5..26938864 100755
--- a/tests/generic/401
+++ b/tests/generic/401
@@ -86,8 +86,8 @@ else
 	# print fake dir file type for . and .. if they are DT_UNKNOWN
 	src/t_dir_type $testdir u | grep -F '.' | \
 		awk '{ print $1, "d" }' | sort
-	# list unknown files and print filename as fake file type
-	src/t_dir_type $testdir u | grep -vF '.' | \
+	# list all files without . and .. and print filename as fake file type
+	src/t_dir_type $testdir | grep -vF '.' | \
 		awk '{ print $1, $1 }' | sort
 fi
 
-- 
2.17.0



