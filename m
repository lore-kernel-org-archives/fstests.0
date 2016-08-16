Received: from mx1.redhat.com ([209.132.183.28]:35862 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753428AbcHPNf0 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 16 Aug 2016 09:35:26 -0400
Date: Tue, 16 Aug 2016 08:34:58 -0500
From: "Bill O'Donnell" <billodo@redhat.com>
Subject: Re: [PATCH V2] xfs/263: test xfs_quota "state" command
Message-ID: <20160816133458.GA9918@redhat.com>
References: <ae59c7a8-321c-42c4-70e4-8d9e8dca80b8@redhat.com>
 <478e5463-e049-bbc5-2230-ba3a837a19a0@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <478e5463-e049-bbc5-2230-ba3a837a19a0@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, Aug 15, 2016 at 10:23:11PM -0500, Eric Sandeen wrote:
> This exercises the xfs_quota "state" command for every
> combination of user, group, and project quota enablement
> on both crc (with project quota inode on disk) and non-crc
> (where project quota overlaps group quota on disk) filesystems.
> 
> It currently requires patches to the upstream kernel
> ("quota: fill in Q_XGETQSTAT inode information for inactive quotas")
> and to xfsprogs ("xfs_quota: wire up XFS_GETQSTATV") to pass.
> 
> Rather than trying to make it run on older kernels without
> crc capability, I restrict the test to crc-capable environments,
> but test with and without crcs enabled (and hence with and without
> project quota inode on disk).
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Reviewed-by: Bill O'Donnell <billodo@redhat.com>

> ---
> 
> V2: Fix up whitespace nitpicks ;)
> 
> diff --git a/tests/xfs/263 b/tests/xfs/263
> new file mode 100755
> index 0000000..1dc47ae
> --- /dev/null
> +++ b/tests/xfs/263
> @@ -0,0 +1,97 @@
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
> +function option_string()
> +{
> +	VAL=$1
> +	# Treat 3 options as a bit field, prjquota|grpquota|usrquota
> +	OPT="rw"
> +	if [ "$((VAL & 4))" -ne "0" ]; then OPT=prjquota,${OPT}; fi;
> +	if [ "$((VAL & 2))" -ne "0" ]; then OPT=grpquota,${OPT}; fi;
> +	if [ "$((VAL & 1))" -ne "0" ]; then OPT=usrquota,${OPT}; fi;
> +	echo $OPT
> +}
> +
> +function test_all_state()
> +{
> +	for I in `seq 0 7`; do
> +		OPTIONS=`option_string $I`
> +		echo "== Options: $OPTIONS =="
> +		# Some combinations won't mount on V4 supers (grp + prj)
> +		_qmount_option "$OPTIONS"
> +		_scratch_mount &>> $seqres.full || continue
> +		$XFS_QUOTA_PROG -x -c "state" $SCRATCH_MNT | _filter_scratch
> +		_scratch_unmount
> +	done
> +}
> +
> +echo "==== NO CRC ===="
> +# Control size to control inode numbers
> +$MKFS_XFS_PROG -f -m crc=0 -n ftype=0 -d size=512m $SCRATCH_DEV >>$seqres.full
> +test_all_state
> +
> +echo "==== CRC ===="
> +$MKFS_XFS_PROG -f -m crc=1 -d size=512m $SCRATCH_DEV >>$seqres.full
> +test_all_state
> +
> +status=0
> +exit
> diff --git a/tests/xfs/263.out b/tests/xfs/263.out
> new file mode 100644
> index 0000000..70454dd
> --- /dev/null
> +++ b/tests/xfs/263.out
> @@ -0,0 +1,199 @@
> +QA output created by 263
> +==== NO CRC ====
> +== Options: rw ==
> +== Options: usrquota,rw ==
> +User quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: ON
> +  Enforcement: ON
> +  Inode: #131 (1 blocks, 1 extents)
> +Group quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: OFF
> +  Enforcement: OFF
> +  Inode: N/A
> +Project quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: OFF
> +  Enforcement: OFF
> +  Inode: N/A
> +Blocks grace time: [7 days]
> +Inodes grace time: [7 days]
> +Realtime Blocks grace time: [7 days]
> +== Options: grpquota,rw ==
> +User quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: OFF
> +  Enforcement: OFF
> +  Inode: #131 (1 blocks, 1 extents)
> +Group quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: ON
> +  Enforcement: ON
> +  Inode: #132 (1 blocks, 1 extents)
> +Project quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: OFF
> +  Enforcement: OFF
> +  Inode: N/A
> +Blocks grace time: [7 days]
> +Inodes grace time: [7 days]
> +Realtime Blocks grace time: [7 days]
> +== Options: usrquota,grpquota,rw ==
> +User quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: ON
> +  Enforcement: ON
> +  Inode: #131 (1 blocks, 1 extents)
> +Group quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: ON
> +  Enforcement: ON
> +  Inode: #132 (1 blocks, 1 extents)
> +Project quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: OFF
> +  Enforcement: OFF
> +  Inode: N/A
> +Blocks grace time: [7 days]
> +Inodes grace time: [7 days]
> +Realtime Blocks grace time: [7 days]
> +== Options: prjquota,rw ==
> +User quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: OFF
> +  Enforcement: OFF
> +  Inode: #131 (1 blocks, 1 extents)
> +Group quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: OFF
> +  Enforcement: OFF
> +  Inode: N/A
> +Project quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: ON
> +  Enforcement: ON
> +  Inode: #132 (1 blocks, 1 extents)
> +Blocks grace time: [7 days]
> +Inodes grace time: [7 days]
> +Realtime Blocks grace time: [7 days]
> +== Options: usrquota,prjquota,rw ==
> +User quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: ON
> +  Enforcement: ON
> +  Inode: #131 (1 blocks, 1 extents)
> +Group quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: OFF
> +  Enforcement: OFF
> +  Inode: N/A
> +Project quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: ON
> +  Enforcement: ON
> +  Inode: #132 (1 blocks, 1 extents)
> +Blocks grace time: [7 days]
> +Inodes grace time: [7 days]
> +Realtime Blocks grace time: [7 days]
> +== Options: grpquota,prjquota,rw ==
> +== Options: usrquota,grpquota,prjquota,rw ==
> +==== CRC ====
> +== Options: rw ==
> +== Options: usrquota,rw ==
> +User quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: ON
> +  Enforcement: ON
> +  Inode: #99 (1 blocks, 1 extents)
> +Group quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: OFF
> +  Enforcement: OFF
> +  Inode: N/A
> +Project quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: OFF
> +  Enforcement: OFF
> +  Inode: N/A
> +Blocks grace time: [7 days]
> +Inodes grace time: [7 days]
> +Realtime Blocks grace time: [7 days]
> +== Options: grpquota,rw ==
> +User quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: OFF
> +  Enforcement: OFF
> +  Inode: #99 (1 blocks, 1 extents)
> +Group quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: ON
> +  Enforcement: ON
> +  Inode: #100 (1 blocks, 1 extents)
> +Project quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: OFF
> +  Enforcement: OFF
> +  Inode: N/A
> +Blocks grace time: [7 days]
> +Inodes grace time: [7 days]
> +Realtime Blocks grace time: [7 days]
> +== Options: usrquota,grpquota,rw ==
> +User quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: ON
> +  Enforcement: ON
> +  Inode: #99 (1 blocks, 1 extents)
> +Group quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: ON
> +  Enforcement: ON
> +  Inode: #100 (1 blocks, 1 extents)
> +Project quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: OFF
> +  Enforcement: OFF
> +  Inode: N/A
> +Blocks grace time: [7 days]
> +Inodes grace time: [7 days]
> +Realtime Blocks grace time: [7 days]
> +== Options: prjquota,rw ==
> +User quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: OFF
> +  Enforcement: OFF
> +  Inode: #99 (1 blocks, 1 extents)
> +Group quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: OFF
> +  Enforcement: OFF
> +  Inode: #100 (1 blocks, 1 extents)
> +Project quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: ON
> +  Enforcement: ON
> +  Inode: #101 (1 blocks, 1 extents)
> +Blocks grace time: [7 days]
> +Inodes grace time: [7 days]
> +Realtime Blocks grace time: [7 days]
> +== Options: usrquota,prjquota,rw ==
> +User quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: ON
> +  Enforcement: ON
> +  Inode: #99 (1 blocks, 1 extents)
> +Group quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: OFF
> +  Enforcement: OFF
> +  Inode: #100 (1 blocks, 1 extents)
> +Project quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: ON
> +  Enforcement: ON
> +  Inode: #101 (1 blocks, 1 extents)
> +Blocks grace time: [7 days]
> +Inodes grace time: [7 days]
> +Realtime Blocks grace time: [7 days]
> +== Options: grpquota,prjquota,rw ==
> +User quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: OFF
> +  Enforcement: OFF
> +  Inode: #99 (1 blocks, 1 extents)
> +Group quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: ON
> +  Enforcement: ON
> +  Inode: #100 (1 blocks, 1 extents)
> +Project quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: ON
> +  Enforcement: ON
> +  Inode: #101 (1 blocks, 1 extents)
> +Blocks grace time: [7 days]
> +Inodes grace time: [7 days]
> +Realtime Blocks grace time: [7 days]
> +== Options: usrquota,grpquota,prjquota,rw ==
> +User quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: ON
> +  Enforcement: ON
> +  Inode: #99 (1 blocks, 1 extents)
> +Group quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: ON
> +  Enforcement: ON
> +  Inode: #100 (1 blocks, 1 extents)
> +Project quota state on SCRATCH_MNT (SCRATCH_DEV)
> +  Accounting: ON
> +  Enforcement: ON
> +  Inode: #101 (1 blocks, 1 extents)
> +Blocks grace time: [7 days]
> +Inodes grace time: [7 days]
> +Realtime Blocks grace time: [7 days]
> diff --git a/tests/xfs/group b/tests/xfs/group
> index 6905a62..fbc4ebf 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -260,6 +260,7 @@
>  260 auto quick quota
>  261 auto quick quota
>  262 auto quick quota
> +263 auto quick quota
>  265 auto clone
>  266 dump ioctl auto quick
>  267 dump ioctl tape
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
