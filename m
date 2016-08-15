Received: from mx1.redhat.com ([209.132.183.28]:53602 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438AbcHOFg2 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 15 Aug 2016 01:36:28 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1873537E62
	for <fstests@vger.kernel.org>; Mon, 15 Aug 2016 05:36:28 +0000 (UTC)
Date: Mon, 15 Aug 2016 13:36:26 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs/263: test xfs_quota "state" command
Message-ID: <20160815053626.GF27776@eguan.usersys.redhat.com>
References: <ae59c7a8-321c-42c4-70e4-8d9e8dca80b8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae59c7a8-321c-42c4-70e4-8d9e8dca80b8@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 12, 2016 at 05:53:04PM -0500, Eric Sandeen wrote:
> This exercises the xfs_quota "state" command for every
> combination of user, group, and project quota enablement
> on both crc (with project quota inode on disk) and non-crc
> (where project quota overlaps group quota on disk) filesystems.
> 
> It currently requires patches to the upstream kernel
> ("quota: fill in Q_XGETQSTAT inode information for inactive quotas")
> and to xfsprogs ("xfs_quota: wire up XFS_GETQSTATV") to pass.

I've applied these patches to kernel (4.8-rc1 based) and xfsprogs
(4.7-rc1 based), and the quota filter fix to xfstests, but I still saw
failures on this, did I miss anything?

[root@dhcp-66-86-11 xfstests]# diff -u tests/xfs/263.out /root/workspace/xfstests/results//xfs_4k_crc/xfs/263.out.bad
--- tests/xfs/263.out   2016-08-15 10:56:23.973000000 +0800
+++ /root/workspace/xfstests/results//xfs_4k_crc/xfs/263.out.bad        2016-08-15 13:29:48.934000000 +0800
@@ -9,11 +9,11 @@
 Group quota state on SCRATCH_MNT (SCRATCH_DEV)
   Accounting: OFF
   Enforcement: OFF
-  Inode: N/A
+  Inode: #0 (0 blocks, 0 extents)
 Project quota state on SCRATCH_MNT (SCRATCH_DEV)
   Accounting: OFF
   Enforcement: OFF
-  Inode: N/A
+  Inode: #0 (0 blocks, 0 extents)
 Blocks grace time: [7 days]   
 Inodes grace time: [7 days]   
 Realtime Blocks grace time: [7 days]
@@ -29,7 +29,7 @@
 Project quota state on SCRATCH_MNT (SCRATCH_DEV)
   Accounting: OFF
   Enforcement: OFF
-  Inode: N/A
+  Inode: #0 (0 blocks, 0 extents)
 Blocks grace time: [7 days]   
 Inodes grace time: [7 days]   
 Realtime Blocks grace time: [7 days]
@@ -45,7 +45,7 @@
 Project quota state on SCRATCH_MNT (SCRATCH_DEV)
   Accounting: OFF
   Enforcement: OFF
-  Inode: N/A
+  Inode: #0 (0 blocks, 0 extents)
 Blocks grace time: [7 days]   
 Inodes grace time: [7 days]   
 Realtime Blocks grace time: [7 days]
@@ -57,7 +57,7 @@
 Group quota state on SCRATCH_MNT (SCRATCH_DEV)
   Accounting: OFF
   Enforcement: OFF
-  Inode: N/A
+  Inode: #0 (0 blocks, 0 extents)
 Project quota state on SCRATCH_MNT (SCRATCH_DEV)
   Accounting: ON
   Enforcement: ON
@@ -73,7 +73,7 @@
 Group quota state on SCRATCH_MNT (SCRATCH_DEV)
   Accounting: OFF
   Enforcement: OFF
-  Inode: N/A
+  Inode: #0 (0 blocks, 0 extents)
 Project quota state on SCRATCH_MNT (SCRATCH_DEV)
   Accounting: ON
   Enforcement: ON
@@ -93,11 +93,11 @@
 Group quota state on SCRATCH_MNT (SCRATCH_DEV)
   Accounting: OFF
   Enforcement: OFF
-  Inode: N/A
+  Inode: #0 (0 blocks, 0 extents)
 Project quota state on SCRATCH_MNT (SCRATCH_DEV)
   Accounting: OFF
   Enforcement: OFF
-  Inode: N/A
+  Inode: #0 (0 blocks, 0 extents)
 Blocks grace time: [7 days]
 Inodes grace time: [7 days]
 Realtime Blocks grace time: [7 days]
@@ -113,7 +113,7 @@
 Project quota state on SCRATCH_MNT (SCRATCH_DEV)
   Accounting: OFF
   Enforcement: OFF
-  Inode: N/A
+  Inode: #0 (0 blocks, 0 extents)
 Blocks grace time: [7 days]
 Inodes grace time: [7 days]
 Realtime Blocks grace time: [7 days]
@@ -129,7 +129,7 @@
 Project quota state on SCRATCH_MNT (SCRATCH_DEV)
   Accounting: OFF
   Enforcement: OFF
-  Inode: N/A
+  Inode: #0 (0 blocks, 0 extents)
 Blocks grace time: [7 days]
 Inodes grace time: [7 days]
 Realtime Blocks grace time: [7 days]
@@ -141,7 +141,7 @@
 Group quota state on SCRATCH_MNT (SCRATCH_DEV)
   Accounting: OFF
   Enforcement: OFF
-  Inode: #100 (1 blocks, 1 extents)
+  Inode: #0 (0 blocks, 0 extents)
 Project quota state on SCRATCH_MNT (SCRATCH_DEV)
   Accounting: ON
   Enforcement: ON
@@ -157,7 +157,7 @@
 Group quota state on SCRATCH_MNT (SCRATCH_DEV)
   Accounting: OFF
   Enforcement: OFF
-  Inode: #100 (1 blocks, 1 extents)
+  Inode: #0 (0 blocks, 0 extents)
 Project quota state on SCRATCH_MNT (SCRATCH_DEV)
   Accounting: ON
   Enforcement: ON
@@ -177,7 +177,7 @@
 Project quota state on SCRATCH_MNT (SCRATCH_DEV)
   Accounting: ON
   Enforcement: ON
-  Inode: #101 (1 blocks, 1 extents)
+  Inode: #0 (0 blocks, 0 extents)
 Blocks grace time: [7 days]
 Inodes grace time: [7 days]
 Realtime Blocks grace time: [7 days]
@@ -193,7 +193,7 @@
 Project quota state on SCRATCH_MNT (SCRATCH_DEV)
   Accounting: ON
   Enforcement: ON
-  Inode: #101 (1 blocks, 1 extents)
+  Inode: #0 (0 blocks, 0 extents)
 Blocks grace time: [7 days]
 Inodes grace time: [7 days]
 Realtime Blocks grace time: [7 days]

> 
> Rather than trying to make it run on older kernels without
> crc capability, I restrict the test to crc-capable environments,
> but test with and without crcs enabled (and hence with and without
> project quota inode on disk).
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> diff --git a/tests/xfs/263 b/tests/xfs/263
> new file mode 100755
> index 0000000..78d8a72
> --- /dev/null
> +++ b/tests/xfs/263
> @@ -0,0 +1,95 @@
> +#! /bin/bash
> +# FS QA Test 263
> +#
> +# test xfs_quota state command
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#-----------------------------------------------------------------------
> +#
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/quota
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs xfs
> +_supported_os Linux
> +
> +_require_scratch
> +_require_xfs_quota
> +
> +# We could test older, non-project capable kernels but keep it simpler;
> +# Only test crc and beyond (but we will test with and without the feature)
> +_require_xfs_mkfs_crc
> +_require_xfs_crc
> +
> +rm -f $seqres.full
> +
> +function option_string() {

Move "{" to a new line to make it consistent with other tests.

> +	VAL=$1
> +	# Treat 3 options as a bit field, prjquota|grpquota|usrquota
> +	OPT="rw"
> +	if [ "$((VAL & 4))" -ne "0" ]; then OPT=prjquota,${OPT}; fi; 
> +	if [ "$((VAL & 2))" -ne "0" ]; then OPT=grpquota,${OPT}; fi; 
> +	if [ "$((VAL & 1))" -ne "0" ]; then OPT=usrquota,${OPT}; fi; 

Trailing whitespaces in above "if" lines.

> +	echo $OPT
> +}
> +
> +function test_all_state() {
> +    for I in `seq 0 7`; do
> +	OPTIONS=`option_string $I`
> +	echo "== Options: $OPTIONS =="
> +	# Some combinations won't mount on V4 supers (grp + prj)
> +	_qmount_option "$OPTIONS"
> +	_scratch_mount &>> $seqres.full || continue
> +	$XFS_QUOTA_PROG -x -c "state" $SCRATCH_MNT | _filter_scratch
> +	_scratch_unmount
> +    done

This function is mixing tab and space for indention.

Thanks,
Eryu
