Received: from mx1.redhat.com ([209.132.183.28]:35898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1954437AbdDZMCP (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 26 Apr 2017 08:02:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1369D75724
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2017 12:02:10 +0000 (UTC)
Date: Wed, 26 Apr 2017 08:02:07 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH v2] generic: test eofblocks race with file extending aio
 dio writes
Message-ID: <20170426120207.GA42456@bfoster.bfoster>
References: <1493055891-8814-1-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493055891-8814-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Apr 25, 2017 at 01:44:51AM +0800, Zorro Lang wrote:
> It's possible for post-eof blocks to end up being used for direct I/O
> writes. dio write performs an upfront unwritten extent allocation, sends
> the dio and then updates the inode size (if necessary) on write
> completion. If a file release occurs while a file extending dio write is
> in flight, it is possible to mistake the post-eof blocks for speculative
> preallocation and incorrectly truncate them from the inode. This means
> that the resulting dio write completion can discover a hole and allocate
> new blocks rather than perform unwritten extent conversion.
> 
> A kernel warning can be reproduced by generic/299 on XFS:
>   XFS: Assertion failed: tp->t_blk_res_used <= tp->t_blk_res, \
>        file: fs/xfs//xfs_trans.c, line: 309
> 
> The root cause is that xfs_free_eofblocks() uses i_size to truncate
> post-eof blocks from the inode, but async, file extending direct writes
> do not update i_size until write completion, long after inode locks are
> dropped. Therefore, xfs_free_eofblocks() effectively truncates the inode
> to the incorrect size.
> 
> Besides reproduce above kernel warning, the verification of written
> data is an important distinction between this test and generic/299.
> For cover this filesystem corruption testing, write this new case to
> check data integrality manually, not only depend on a kernel warning.
> 
> To increase the test stress of aio-dio-eof-race, add two arguments to
> this source code to change the file size will be written.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
> 
> Hi,
> 
> V2 did below changes:
> 1) change aio-dio-eof-race.c, add two arguments to change the file size
> and buffer size.
> 2) change fs size from 1G to 256M
> 3) move open/close loop before $AIO_TEST
> 4) use new aio-dio-eof-race arguments, and use cpu number to decide the
>    file size.
> 5) change open/close operation from "cat" to "xfs_io -c open"
> 
> Thanks,
> Zorro
> 
>  src/aio-dio-regress/aio-dio-eof-race.c | 74 ++++++++++++++++++++-------
>  tests/generic/426                      | 91 ++++++++++++++++++++++++++++++++++
>  tests/generic/426.out                  |  2 +
>  tests/generic/group                    |  1 +
>  4 files changed, 151 insertions(+), 17 deletions(-)
>  create mode 100755 tests/generic/426
>  create mode 100644 tests/generic/426.out
> 
> diff --git a/src/aio-dio-regress/aio-dio-eof-race.c b/src/aio-dio-regress/aio-dio-eof-race.c
> index 79fd928..7b2c26f 100644
> --- a/src/aio-dio-regress/aio-dio-eof-race.c
> +++ b/src/aio-dio-regress/aio-dio-eof-race.c
...
> @@ -113,8 +153,8 @@ int main(int argc, char *argv[])
>  	eof = 0;
>  
>  	/* Keep extending until 8MB (fairly arbitrary) */

Nit: stale comment.

Otherwise this looks fine to me. Thanks for the test!

Reviewed-by: Brian Foster <bfoster@redhat.com>

> -	while (eof < 8 * 1024 * 1024) {
> -		memset(buf, IO_PATTERN, BUF_SIZE);
> +	while (eof < size_MB * 1024 * 1024) {
> +		memset(buf, IO_PATTERN, buf_size);
>  		fstat(fd, &statbuf);
>  		eof = statbuf.st_size;
>  
> @@ -125,10 +165,10 @@ int main(int argc, char *argv[])
>  		 * management and stale block zeroing for races and can lead to
>  		 * data corruption when not handled properly.
>  		 */
> -		io_prep_pwrite(&iocb1, fd, buf, BUF_SIZE/4, eof + 0*BUF_SIZE/4);
> -		io_prep_pwrite(&iocb2, fd, buf, BUF_SIZE/4, eof + 1*BUF_SIZE/4);
> -		io_prep_pwrite(&iocb3, fd, buf, BUF_SIZE/4, eof + 2*BUF_SIZE/4);
> -		io_prep_pwrite(&iocb4, fd, buf, BUF_SIZE/4, eof + 3*BUF_SIZE/4);
> +		io_prep_pwrite(&iocb1, fd, buf, buf_size/4, eof + 0*buf_size/4);
> +		io_prep_pwrite(&iocb2, fd, buf, buf_size/4, eof + 1*buf_size/4);
> +		io_prep_pwrite(&iocb3, fd, buf, buf_size/4, eof + 2*buf_size/4);
> +		io_prep_pwrite(&iocb4, fd, buf, buf_size/4, eof + 3*buf_size/4);
>  
>  		err = io_submit(ctx, 4, iocbs);
>  		if (err != 4) {
> @@ -150,20 +190,20 @@ int main(int argc, char *argv[])
>  		 * And then read it back.
>  		 *
>  		 * Using pread to keep it simple, but AIO has the same effect.
> -		 * eof is the prior eof; we just wrote BUF_SIZE more.
> +		 * eof is the prior eof; we just wrote buf_size more.
>  		 */
> -		if (pread(fd, buf, BUF_SIZE, eof) != BUF_SIZE) {
> +		if (pread(fd, buf, buf_size, eof) != buf_size) {
>  			perror("pread");
>  			return 1;
>  		}
>  
>  		/*
>  		 * We launched 4 AIOs which, stitched together, should write
> -		 * a seamless BUF_SIZE worth of IO_PATTERN to the last block.
> +		 * a seamless buf_size worth of IO_PATTERN to the last block.
>  		 */
> -		if (memcmp(buf, cmp_buf, BUF_SIZE)) {
> +		if (memcmp(buf, cmp_buf, buf_size)) {
>  			printf("corruption while extending from %ld\n", eof);
> -			dump_buffer(buf, 0, BUF_SIZE);
> +			dump_buffer(buf, 0, buf_size);
>  			return 1;
>  		}
>  	}
> diff --git a/tests/generic/426 b/tests/generic/426
> new file mode 100755
> index 0000000..8c4e204
> --- /dev/null
> +++ b/tests/generic/426
> @@ -0,0 +1,91 @@
> +#! /bin/bash
> +# FS QA Test 426
> +#
> +# Try to trigger a race of free eofblocks and file extending dio writes.
> +# A known bug of XFS has been fixed by "e4229d6 xfs: fix eofblocks race
> +# with file extending async dio writes"
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2017 Red Hat Inc.  All Rights Reserved.
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
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +_require_aiodio aio-dio-eof-race
> +
> +# limit the filesystem size, to save the time of filling filesystem
> +_scratch_mkfs_sized $((256 * 1024 * 1024)) >>$seqres.full 2>&1
> +_scratch_mount
> +
> +# try to write more bytes than filesystem size to fill the filesystem
> +$XFS_IO_PROG -f -c "pwrite -S 0x55 0 $((256 * 1024 * 1024 * 2))" \
> +	     $SCRATCH_MNT/fillfs-$seq 2>/dev/null
> +rm -f $SCRATCH_MNT/fillfs-$seq
> +
> +# open & close the file frequently, to trigger xfs_free_eofblocks
> +while true; do
> +	$XFS_IO_PROG -f -c open $SCRATCH_MNT/tst-aio-dio-eof-race.$seq \
> +		>/dev/null 2>&1
> +done &
> +open_close_pid=$!
> +
> +nr_cpu=`$here/src/feature -o`
> +fsize=$((nr_cpu * 10))
> +if [ $fsize -gt 200 ]; then
> +	fsize=200
> +fi
> +# start a background aio writer, which does several extending loops
> +# internally and check data integrality
> +$AIO_TEST -s $fsize -b 65536 $SCRATCH_MNT/tst-aio-dio-eof-race.$seq
> +status=$?
> +
> +kill $open_close_pid
> +wait $open_close_pid
> +if [ $status -ne 0 ]; then
> +	od -t x1 $SCRATCH_MNT/tst-aio-dio-eof-race.$seq >> $seqres.full
> +	exit
> +fi
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/426.out b/tests/generic/426.out
> new file mode 100644
> index 0000000..ad7a01a
> --- /dev/null
> +++ b/tests/generic/426.out
> @@ -0,0 +1,2 @@
> +QA output created by 426
> +Success, all done.
> diff --git a/tests/generic/group b/tests/generic/group
> index 6d6e4f6..70c36f9 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -428,3 +428,4 @@
>  423 auto quick
>  424 auto quick
>  425 auto quick attr
> +426 auto aio rw
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
