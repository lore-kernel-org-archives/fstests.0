From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] xfs/205: Fix that b2 variable is treated as octal vaule
Date: Mon, 12 Nov 2018 16:01:03 +0800
Message-ID: <1542009663-26173-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
To: fstests@vger.kernel.org
Cc: darrick.wong@oracle.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

Running xfs/205 triggers the following error:
----------------------------------------------
QA output created by 205
+./tests/xfs/205: line 61: 098: value too great for base (error token is "098")
...
----------------------------------------------

If b2 variable is a 2-digit number beginning with 0(e.g. 098),
it will be treated as octal vaule instaed of decimal value.  We
try to declare it as decimal value forcely.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/xfs/205 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/205 b/tests/xfs/205
index 9cc9b59..9035870 100755
--- a/tests/xfs/205
+++ b/tests/xfs/205
@@ -54,7 +54,7 @@ _scratch_resvblks 1024 >> $seqres.full 2>&1
 blks=$(( ($(_get_available_space $SCRATCH_MNT) / $fsblksz) - 15 ))
 test $blks -gt 1100 || _notrun "not enough space"
 b1=$(echo $blks | sed -e 's/[0-9][0-9][0-9]$/000/g')
-b2=$(echo $blks | sed -e 's/^[0-9][0-9]//g')
+b2=$((10#$(echo $blks | sed -e 's/^[0-9][0-9]//g')))
 echo "blks: $blks b1: $b1 b2: $b2" >> $seqres.full
 dd if=/dev/zero of=$SCRATCH_MNT/fred bs=$fsblksz count=$((b1 - 1000)) 2>&1 | _filter_dd
 dd if=/dev/zero of=$SCRATCH_MNT/fred2 bs=$fsblksz count=$b2 2>&1 | _filter_dd
-- 
1.8.3.1
