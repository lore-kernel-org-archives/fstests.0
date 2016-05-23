Received: from mx1.redhat.com ([209.132.183.28]:49263 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932267AbcEWJHw (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 23 May 2016 05:07:52 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1141F6406A
	for <fstests@vger.kernel.org>; Mon, 23 May 2016 09:07:52 +0000 (UTC)
Date: Mon, 23 May 2016 17:07:50 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/2] generic/352: new case test mmaped data when
 blocksize less than pagesize
Message-ID: <20160523090750.GI5140@eguan.usersys.redhat.com>
References: <1463502981-15593-1-git-send-email-zlang@redhat.com>
 <1463502981-15593-2-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1463502981-15593-2-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, May 18, 2016 at 12:36:21AM +0800, Zorro Lang wrote:
> This case is a regression test for linux commit 90a80202:
> 
>   vfs: fix data corruption when blocksize < pagesize for mmaped data
> 
>   ->page_mkwrite() is used by filesystems to allocate blocks under a page
>   which is becoming writeably mmapped in some process' address space. This
>   allows a filesystem to return a page fault if there is not enough space
>   available, user exceeds quota or similar problem happens, rather than
>   silently discarding data later when writepage is called.
> 
>   However VFS fails to call ->page_mkwrite() in all the cases where
>   filesystems need it when blocksize < pagesize. For example when
>   blocksize = 1024, pagesize = 4096 the following is problematic:
>     ftruncate(fd, 0);
>     pwrite(fd, buf, 1024, 0);
>     map = mmap(NULL, 1024, PROT_WRITE, MAP_SHARED, fd, 0);
>     map[0] = 'a';       ----> page_mkwrite() for index 0 is called
>     ftruncate(fd, 10000); /* or even pwrite(fd, buf, 1, 10000) */
>     mremap(map, 1024, 10000, 0);
>     map[4095] = 'a';    ----> no page_mkwrite() called
> 
>   At the moment ->page_mkwrite() is called, filesystem can allocate only
>   one block for the page because i_size == 1024. Otherwise it would create
>   blocks beyond i_size which is generally undesirable. But later at
>   ->writepage() time, we also need to store data at offset 4095 but we
>   don't have block allocated for it.
> 
>   This patch introduces a helper function filesystems can use to have
>   ->page_mkwrite() called at all the necessary moments.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
> 
> Hi,
> 
> After xfsprogs merged commit:
>   e0a8808 xfs_io: allow mmap command to reserve some free space
> 
> We can reserve(not 100% sure, but pretty high rate) some memory for mremap
> extend the map space. Due to it, I can use xfs_io to implement this
> case.
> 
> There're 2 problems when I write this case:
> 1. The reserved memory space can't be kept 100%, especially when
> system run heavy memory load. But I think it hard to resolve.
> 
> 2. When xfs_io process be killed by SIGBUS, I can't catch the "Bus error"
> output(it not on stdout/stderr). But it will printed into .out file. So
> I use a pipe stop it(Generally, that _filter_xfs_io after the pipe is
> useless. I just need a pipe.). But I'm not sure if it's a good idea.
> Anyone have better idea?
> 
> (BTW, this case rely on my last patch about _require_xfs_io_command.)
> 
> Thanks,
> Zorro
> 
>  tests/generic/352     | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/352.out |   3 ++
>  tests/generic/group   |   1 +
>  3 files changed, 113 insertions(+)
>  create mode 100755 tests/generic/352
>  create mode 100644 tests/generic/352.out
> 
> diff --git a/tests/generic/352 b/tests/generic/352
> new file mode 100755
> index 0000000..5e69127
> --- /dev/null
> +++ b/tests/generic/352
> @@ -0,0 +1,109 @@
> +#! /bin/bash
> +# FS QA Test 352
> +#
> +# Regression test for linux commit 90a80202, data corruption when
> +# blocksize < pagesize for mmaped data.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2016 Red Hat Inc.  All Rights Reserved.
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
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# support fs which can make block size < page size
> +_supported_fs xfs ext2 ext3 ext4 ext4dev udf

No need to filter out other fs, at least we can get some extra test
coverage on other filesystems, even if they cannot reproduce this bug

And all tests in generic dir should have "_supported_fs generic",
otherwise you should put it to "shared" dir or fs-specific dir.

> +_supported_os Linux
> +_require_scratch
> +_require_xfs_io_command mmap "-s <size>"
> +_require_xfs_io_command mremap
> +_require_xfs_io_command truncate
> +_require_xfs_io_command pwrite
> +_require_xfs_io_command mwrite
> +
> +sector_size=`blockdev --getss $SCRATCH_DEV`
> +page_size=$(get_page_size)
> +block_size=$((page_size/2))
> +
> +if [ $sector_size -gt $block_size ];then
> +    _notrun "need sector size < page size"
> +fi
> +
> +unset MKFS_OPTIONS
> +# For save time, 512MiB is enough to reproduce bug
> +_scratch_mkfs_sized 536870912 $block_size >$seqres.full 2>&1
> +
> +# avoid the interference of XFS preallocation
> +if [ "$FSTYP" = xfs ];then
> +    MOUNT_OPTIONS="$MOUNT_OPTIONS -o allocsize=$page_size"
> +fi

All these blocksize vs pagesize checks, mkfs with specific pagesize,
adding allocsize mount option are not necessary. We want more test
coverage even if the original bug can not be reproduced in such
configurations, it's up to the test runner to specify the blocksize,
mount options etc.

> +_scratch_mount
> +
> +# take one block size space
> +dd if=/dev/zero of=$SCRATCH_MNT/testfile bs=$block_size count=1 >$seqres.full 2>&1
> +# fill all free space
> +dd if=/dev/zero of=$SCRATCH_MNT/full bs=$block_size >$seqres.full 2>&1

We prefer $XFS_IO_PROG over dd in fstests. And please append (>>) the log to
$seqres.full not overwrite (>) the log.

I'd recommend add an explicit "rm -f $seqres.full" and use ">>" to
append the logs, so you don't have to worry when to use ">" and when to
use ">>".

> +sync
> +
> +# truncate 0
> +# pwrite -S 0x61 0 $block_size
> +# mmap -rw -s $((page_size * 2)) 0 $block_size
> +# mwrite -S 0x61 0 1  --> page_mkwrite() for index 0 is called
> +# truncate $((page_size * 2))
> +# mremap $((page_size * 2))
> +# mwrite -S 0x61 $((page_size - 1)) 1  --> [bug] no page_mkwrite() called
> +#
> +# If there's a bug, the last step will be killed by SIGBUS, and it won't
> +# write a "0x61" on the disk.

Please write a different char for the test, e.g. 0x62, so we can easily
know that it's the test char.

> +#
> +# Note: mremap maybe failed when memory load is heavy. 
> +$XFS_IO_PROG -f \
> +	     -c "truncate 0" \
> +	     -c "pwrite -S 0x61 0 $block_size" \
> +	     -c "mmap -rw -s $((page_size * 2)) 0 $block_size" \
> +	     -c "mwrite -S 0x61 0 1" \
> +	     -c "truncate $((page_size * 2))" \
> +	     -c "mremap $((page_size * 2))" \
> +	     -c "mwrite -S 0x61 $((page_size - 1)) 1" \
> +	     $SCRATCH_MNT/testfile | _filter_xfs_io
> +
> +# we will see 0x61 written by "mwrite -S 0x61 0 1"
> +# we shouldn't see one more 0x61 by the last mwrite.
> +hexdump -e '1/1 "%02x "' $SCRATCH_MNT/testfile

I personally perfer od here :)

Thanks,
Eryu

> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/352.out b/tests/generic/352.out
> new file mode 100644
> index 0000000..8be005d
> --- /dev/null
> +++ b/tests/generic/352.out
> @@ -0,0 +1,3 @@
> +QA output created by 352
> +61 *
> +00 *
> diff --git a/tests/generic/group b/tests/generic/group
> index 36fb759..7a72f6b 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -354,3 +354,4 @@
>  349 blockdev quick rw
>  350 blockdev quick rw
>  351 blockdev quick rw
> +352 auto quick
> -- 
> 2.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
