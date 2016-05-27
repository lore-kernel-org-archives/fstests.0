Received: from cn.fujitsu.com ([59.151.112.132]:29656 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754581AbcE0HSk (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 27 May 2016 03:18:40 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] xfs/122: add check number of structure
Date: Fri, 27 May 2016 14:33:12 +0800
Message-ID: <1464330792-24031-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20160526163249.GA4595@birch.djwong.org>
References: <20160526163249.GA4595@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: darrick.wong@oracle.com
Cc: fstests@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

I think the number of structure is always changing based on
different xfsporg-dev version. If some expected structure is
missing in current environment, we won't check structure size
and offset and set the result to notrun.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/xfs/122 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/xfs/122 b/tests/xfs/122
index 845cdd2..64f4a1b 100755
--- a/tests/xfs/122
+++ b/tests/xfs/122
@@ -239,6 +239,11 @@ if [ $XFSPROGS_VERSION -lt 30000 ]; then
 	echo 'sizeof( xfs_dsb_t ) = 208' >>$progout;
 fi
 
+actual_num=`cat $progout | wc -l`
+if [ $actual_num -lt 148 ]; then
+        _notrun "Some structure is missing in current envirment"
+fi
+
 LC_COLLATE=POSIX sort $progout
 
 status=0
-- 
1.8.3.1



