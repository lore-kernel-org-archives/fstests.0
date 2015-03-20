Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33551 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751762AbbCTKRp (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 20 Mar 2015 06:17:45 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 887A1AB118
	for <fstests@vger.kernel.org>; Fri, 20 Mar 2015 10:17:45 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 8/9] xfs/014: replace df with $DF_PROG
Date: Fri, 20 Mar 2015 18:16:57 +0800
Message-Id: <1426846618-23413-9-git-send-email-eguan@redhat.com>
In-Reply-To: <1426846618-23413-1-git-send-email-eguan@redhat.com>
References: <1426846618-23413-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

I've seen xfs/014 fails as

        [root@dhcp-66-86-3 xfstests]# diff -u tests/xfs/014.out /var/lib/xfstests/results//xfs/014.out.bad
        --- tests/xfs/014.out   2015-03-06 14:48:19.000000000 +0800
        +++ /var/lib/xfstests/results//xfs/014.out.bad  2015-03-09
        22:48:08.660001935 +0800
        @@ -1,2 +1,9 @@
         QA output created by 014
          Silence is golden.
          +falloc: invalid option -- '1'
          +falloc: invalid option -- '0'
          +falloc: invalid option -- 'M'
          +falloc [-k] off len -- allocates space associated with part of a file
          via fallocate
          +falloc [-k] off len -- allocates space associated with part of a file
          via fallocate
          +falloc [-k] off len -- allocates space associated with part of a file
          via fallocate
          +falloc [-k] off len -- allocates space associated with part of a file
          via fallocate

which is because output of "df -m" is split into two lines, and
freesp is 0, in _consume_free_space() function.

        Filesystem           1M-blocks  Used Available Use% Mounted on
        /mnt/testarea/scratch/014.fs
                                 10230  1061      9170  11% /mnt/testarea/scratch/014.mnt

Appending '-P' option to df fixes this issue. So use $DF_PROG which
already has -P option set.

$DF_PROG also sets -T option to print fs type in extra column, so change
the awk command accordingly to get the correct freespace.

Also replace awk with $AWK_PROG.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/xfs/014 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/014 b/tests/xfs/014
index 8866bfe..ab3d85b 100755
--- a/tests/xfs/014
+++ b/tests/xfs/014
@@ -88,7 +88,7 @@ _consume_free_space()
 	dir=$1
 
 	# allocate all but 10MB of available space
-	freesp=`df -m $dir | awk '/^\// { print $4 - 10 }'`
+	freesp=`$DF_PROG -m $dir | $AWK_PROG '/^\// { print $5 - 10 }'`
 	$XFS_IO_PROG -f -c "falloc 0 ${freesp}M" $dir/spc
 }
 
-- 
2.1.0

