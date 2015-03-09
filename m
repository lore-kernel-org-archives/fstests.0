Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55017 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753028AbbCIP3G (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 9 Mar 2015 11:29:06 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t29FT3mo007111
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Mon, 9 Mar 2015 11:29:06 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] xfs/014: use the POSIX output format of df
Date: Mon,  9 Mar 2015 23:28:43 +0800
Message-Id: <1425914923-19220-1-git-send-email-eguan@redhat.com>
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

Now use the POSIX output format of df to make it more portable.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/xfs/014 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/014 b/tests/xfs/014
index 8866bfe..a2069db 100755
--- a/tests/xfs/014
+++ b/tests/xfs/014
@@ -88,7 +88,7 @@ _consume_free_space()
 	dir=$1
 
 	# allocate all but 10MB of available space
-	freesp=`df -m $dir | awk '/^\// { print $4 - 10 }'`
+	freesp=`df -mP $dir | awk '/^\// { print $4 - 10 }'`
 	$XFS_IO_PROG -f -c "falloc 0 ${freesp}M" $dir/spc
 }
 
-- 
2.1.0

