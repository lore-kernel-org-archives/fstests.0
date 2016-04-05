Received: from e23smtp07.au.ibm.com ([202.81.31.140]:55628 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754135AbcDEFy3 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 5 Apr 2016 01:54:29 -0400
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <fstests@vger.kernel.org> from <chandan@linux.vnet.ibm.com>;
	Tue, 5 Apr 2016 15:54:25 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 018F73578057
	for <fstests@vger.kernel.org>; Tue,  5 Apr 2016 15:54:22 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u355sCBY9896396
	for <fstests@vger.kernel.org>; Tue, 5 Apr 2016 15:54:21 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u355rm9I020604
	for <fstests@vger.kernel.org>; Tue, 5 Apr 2016 15:53:48 +1000
Received: from localhost.in.ibm.com ([9.124.35.68])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u355rl3Z020052
	for <fstests@vger.kernel.org>; Tue, 5 Apr 2016 15:53:48 +1000
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH] generic/273: Remove hard coded block size
Date: Tue,  5 Apr 2016 11:23:29 +0530
Message-Id: <1459835609-17892-1-git-send-email-chandan@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

The space occupied by files in the 'origin' directory is calculated with
the assumption that 4k is the block size of the underlying filesystem.
This causes the test to fail with ENOSPC errors when running on
filesystems with larger block sizes. To fix the issue, this commit makes
use of the the block size obtained from the mounted filesystem.

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
 tests/generic/273 | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/generic/273 b/tests/generic/273
index 0a4a600..d90212e 100755
--- a/tests/generic/273
+++ b/tests/generic/273
@@ -57,6 +57,7 @@ _threads_set()
 
 _file_create()
 {
+	block_size=$1
 	_i=0
 
 	if ! mkdir $SCRATCH_MNT/origin
@@ -70,11 +71,11 @@ _file_create()
 
 	_disksize=`$DF_PROG -B 1 $SCRATCH_MNT | tail -1 | $AWK_PROG '{ print $5 }'`
 	_disksize=$(($_disksize / 3))
-	_num=$(($_disksize / $count / $threads / 4096))
+	_num=$(($_disksize / $count / $threads / $block_size))
 	_count=$count
 	while [ $_i -lt $_num ]
 	do
-		dd if=/dev/zero of=file_$_i bs=4096 count=$_count >/dev/null 2>&1
+		dd if=/dev/zero of=file_$_i bs=$block_size count=$_count >/dev/null 2>&1
 		_i=$(($_i + 1))
 	done
 
@@ -105,9 +106,10 @@ _do_workload()
 {
 	_pids=""
 	_pid=1
+	block_size=$(get_block_size $SCRATCH_MNT)
 	
 	_threads_set
-	_file_create
+	_file_create $block_size
 
 	_threads=$threads
 
-- 
2.1.0

