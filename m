Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AF5C433E0
	for <linux-fstests@archiver.kernel.org>; Mon, 15 Mar 2021 21:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A377564F0F
	for <linux-fstests@archiver.kernel.org>; Mon, 15 Mar 2021 21:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhCOVK4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 15 Mar 2021 17:10:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232883AbhCOVKX (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 15 Mar 2021 17:10:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6907164F0F;
        Mon, 15 Mar 2021 21:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615842622;
        bh=9IKDXHg2YUVpHNfFHRtc+UDaX2s+lKK+lTtElZJ/Anc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NPZKbUw4oLoAeBOwrAafM7agpB8nhqUDkeGFHRHqkw1KWMeolnbTcqhRh16itIYsJ
         3ksNCSd81bFHxdc3XdT6UxCUf8YOUOynOOPrYk5A1XT/sUcqWreLOo4myMiUpRxq25
         8VBBpPqA96+cBm0IUSkQOlbWnN5Ft8XCTtb09LyXsMzFk+qaUsyo/Jnp8esf04JnQ9
         LOeZzzxlnZb7ZxtXd0sfbnZktb2tkNtIfHEy14JP3RjzGd19oNEYDv9kmQhI69UeOV
         Q/aBqsZA2jKmVOMoCPnvq10sB1D6OMYpMDOzhky5/kjdab0HLG5geAf8YJ076zXtFT
         zYNxdAPVMFYDw==
Date:   Mon, 15 Mar 2021 14:10:19 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH -v2] generic: test which tries to exercise AIO/DIO into
 unwritten space
Message-ID: <20210315211019.GD22097@magnolia>
References: <YEVdqb9kcOV004ZO@mit.edu>
 <20210308012247.15250-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308012247.15250-1-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Mar 07, 2021 at 08:22:47PM -0500, Theodore Ts'o wrote:
> This test verifies that the an unwritten extent is properly marked as
> written after writing into it.
> 
> There was a hard-to-hit bug which would occasionally trigger with ext4
> for which this test was a reproducer.  This has been fixed after
> moving ext4 to use iomap for Direct I/O's, although as of this
> writing, there are still some occasional failures on ext4 when block
> size < page size.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
> 
> Differences between v1 and v2:
> * Addressed review comments from Eryu
> * Renumbered from generic/623 to generic/630 (since 623 has been assigned)
> 
>  tests/generic/630     | 105 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/630.out |   4 ++
>  tests/generic/group   |   1 +
>  3 files changed, 110 insertions(+)
>  create mode 100755 tests/generic/630
>  create mode 100644 tests/generic/630.out
> 
> diff --git a/tests/generic/630 b/tests/generic/630
> new file mode 100755
> index 00000000..7a04b899
> --- /dev/null
> +++ b/tests/generic/630
> @@ -0,0 +1,105 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +#
> +# FSQA Test No. 630
> +#
> +# AIO/DIO stress test
> +# Run random AIO/DIO activity on an file system with unwritten regions
> +#
> +# This test verifies that the an unwritten extent is properly marked
> +# as written after writing into it.
> +#
> +# There was a hard-to-hit bug which would occasionally trigger with
> +# ext4 for which this test was a reproducer.  This has been fixed
> +# after moving ext4 to use iomap for Direct I/O's, although as of this
> +# writing, there are still some occasional failures on ext4 when block
> +# size < page size.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +fio_config=$tmp.fio
> +fio_out=$tmp.fio.out
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +    rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_test
> +_require_scratch
> +_require_odirect
> +_require_aio
> +_require_block_device $SCRATCH_DEV
> +
> +NUM_JOBS=$((4*LOAD_FACTOR))
> +BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
> +FILE_SIZE=$(((BLK_DEV_SIZE * 512) * 3 / 4))
> +
> +max_file_size=$((5 * 1024 * 1024 * 1024))
> +if [ $max_file_size -lt $FILE_SIZE ]; then
> +	FILE_SIZE=$max_file_size
> +fi
> +SIZE=$((FILE_SIZE / 2))
> +
> +cat >$fio_config <<EOF
> +###########
> +# $seq test fio activity
> +# Filenames derived from jobsname and jobid like follows:
> +# ${JOB_NAME}.${JOB_ID}.${ITERATION_ID}
> +[global]
> +ioengine=libaio
> +bs=128k
> +directory=${SCRATCH_MNT}
> +filesize=${FILE_SIZE}
> +size=${FILE_SIZE}
> +io_size=${SIZE}
> +iodepth=$((128*$LOAD_FACTOR))
> +fallocate=native
> +
> +# Perform direct aio and verify data
> +# This test case should check use-after-free issues
> +[aio-dio-verifier]
> +numjobs=1
> +verify=crc32c-intel
> +verify_fatal=1
> +verify_dump=1
> +verify_backlog=1024
> +verify_async=4
> +direct=1
> +random_generator=lfsr
> +blocksize_range=4k-8200k

Something I hadn't noticed before this got committed -- setting the
maximum blocksize to 8200k and the iodepth to a multiple of 128 means
that fio will allocate an 8200k buffer per iodepth.  Given that the
iodepth is (128 * LOAD_FACTOR), this test therefore requires (1GB *
LOAD_FACTOR) memory.  On my testing VMs which have a generous 1200M of
memory, this causes the oom killer to zap fio, which in turn causes the
test to fail due to the SIGKILL being reported in the golden output.

Is it necessary to allocate 8MB of memory per io thread?  Given that
this is a regression test to probe a bug in ext4's unwritten extent
conversion I'm loath to touch it too much, but it seems to me that a
smaller blocksize would stress the extent mapping structures harder and
reduce the memory requirements at the same time.

--D

> +rw=randwrite
> +filename=test-file
> +
> +EOF
> +
> +rm -f $seqres.full
> +
> +_require_fio $fio_config
> +_require_xfs_io_command "falloc"
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +echo ""
> +echo "Run fio with random aio-dio pattern"
> +echo ""
> +cat $fio_config >> $seqres.full
> +$FIO_PROG $fio_config --output=$fio_out
> +cat $fio_out >> $seqres.full
> +
> +status=0
> +exit
> diff --git a/tests/generic/630.out b/tests/generic/630.out
> new file mode 100644
> index 00000000..7f3adb50
> --- /dev/null
> +++ b/tests/generic/630.out
> @@ -0,0 +1,4 @@
> +QA output created by 630
> +
> +Run fio with random aio-dio pattern
> +
> diff --git a/tests/generic/group b/tests/generic/group
> index 84db3789..1ff896a1 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -628,3 +628,4 @@
>  623 auto quick shutdown
>  624 auto quick verity
>  625 auto quick verity
> +630 aio rw stress
> -- 
> 2.30.0
> 
