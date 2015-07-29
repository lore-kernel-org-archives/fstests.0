Received: from mx1.redhat.com ([209.132.183.28]:59508 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753149AbbG2RI6 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 29 Jul 2015 13:08:58 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id CD3EEB7A9A
	for <fstests@vger.kernel.org>; Wed, 29 Jul 2015 17:08:58 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] generic/046: stress not enough to write something out
Date: Thu, 30 Jul 2015 01:08:54 +0800
Message-Id: <1438189734-1954-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, xuw@redhat.com, dchinner@redhat.com, bfoster@redhat.com, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

According to lots of our testing results, this case always
can't write any files out until this case run over. This
is not expected test condition.

But when I run this case on a very poor performance machine,
or run with other I/O stress, some file can write out.
So I think the stress of this case is not enough, and create
 more files or sleep more time will be helpful.

I choose the former. Because if only increase sleep time,
maybe cause all files be write out, nothing be cached.

There're many other conditions maybe affect this problem,
include "RAM size", "disk size", "vm.dirty_expire_centisecs",
"vm.dirty_writeback_centisecs" and so on...

I have to say "yes, the machine performance will affect test,
but according to my experiment, their effect isn't so much."

My test machine is 16G RAM, 20G test partation. I changed 16G
ram to 2G, 20G disk to 2G, and create 3000 files in case, but
useless. I also try to change vm.dirty_expire_centisecs and
vm.dirty_writeback_centisecs, big change, but still useless.

So I think create more files to increase the stress is the most
useful method. From my test, I find 60s is an enough time. So
I try to make sure this case keep running 60s.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

As I said above, please check the below patch. I can't sure
this's the best way. So if someone learn about XFS very well,
please help to review.

I find this problem from a bug which eguan@redhat.com has sent
patch:
  common: fix _count_extents and _count_holes

We have ran xfstests thousands of times, but nearly can't trigger
this bug, until I ran xfstests with fsstress. So I think the
stress of generic/046 is not enough.

I think Lachlan McIlroy is the author of this case, but I feel
his email lmcilroy@redhat.com already invalid. So I can't cc
him.

Thanks,
Zorro Lang


 tests/generic/046 | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tests/generic/046 b/tests/generic/046
index 76993d4..dfc0967 100755
--- a/tests/generic/046
+++ b/tests/generic/046
@@ -47,16 +47,17 @@ _scratch_mount
 
 # create files
 i=1;
-while [ $i -lt 1000 ]
+t=`date +%s`
+while [ $i -lt 5000 ]
 do
 	file=$SCRATCH_MNT/$i
-	xfs_io -f -c "pwrite -b 32k -S 0xff 0 32k" $file > /dev/null
+	xfs_io -f -c "pwrite -b 8k -S 0xff 0 8k" $file > /dev/null
 	if [ $? -ne 0 ]
 	then
 		echo error creating/writing file $file
 		exit
 	fi
-	xfs_io -c "truncate 64k" $file > /dev/null
+	xfs_io -c "truncate 16k" $file > /dev/null
 	if [ $? -ne 0 ]
 	then
 		echo error truncating file $file
@@ -64,9 +65,13 @@ do
 	fi
 	let i=$i+1
 done
+t=$((`date +%s` - $t))
 
 # give the system a chance to write something out
-sleep 10
+if [ $t -lt 60 ]
+then
+	sleep $((60 - $t))
+fi
 
 src/godown $SCRATCH_MNT
 
@@ -82,7 +87,7 @@ _scratch_mount
 
 # check file size and contents
 i=1;
-while [ $i -lt 1000 ]
+while [ $i -lt 5000 ]
 do
 	file=$SCRATCH_MNT/$i
 	# if file does not exist, the create was not logged, skip it
-- 
1.9.3

