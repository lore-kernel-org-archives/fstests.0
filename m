Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A7EC433E0
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Mar 2021 17:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C0D6515B
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Mar 2021 17:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbhCARFm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 1 Mar 2021 12:05:42 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53202 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237083AbhCARDe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 1 Mar 2021 12:03:34 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 121H2iZx032103
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 1 Mar 2021 12:02:45 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5083D15C3A88; Mon,  1 Mar 2021 12:02:44 -0500 (EST)
Date:   Mon, 1 Mar 2021 12:02:44 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic: test which tries to exercise AIO/DIO into
 unwritten space
Message-ID: <YD0eNC7tSWzMzK0d@mit.edu>
References: <20210210205818.1494305-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210205818.1494305-1-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Feb 10, 2021 at 03:58:18PM -0500, Theodore Ts'o wrote:
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

Ping?

> ---
>  tests/generic/623     | 109 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/623.out |   4 ++
>  tests/generic/group   |   1 +
>  3 files changed, 114 insertions(+)
>  create mode 100755 tests/generic/623
>  create mode 100644 tests/generic/623.out
> 
> diff --git a/tests/generic/623 b/tests/generic/623
> new file mode 100755
> index 00000000..74136fef
> --- /dev/null
> +++ b/tests/generic/623
> @@ -0,0 +1,109 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +#
> +# FSQA Test No. 623
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
> +status=1	# failure is the default!
> +trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
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
> +size=${SIZE}
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
> +blocksize_range=4100k-8200k
> +blockalign=4k
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
> +_workout()
> +{
> +	echo ""
> +	echo "Run fio with random aio-dio pattern"
> +	echo ""
> +	cat $fio_config >>  $seqres.full
> +	run_check $FIO_PROG $fio_config
> +}
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +if ! _workout; then
> +	_scratch_unmount 2>/dev/null
> +	exit
> +fi
> +
> +if ! _scratch_unmount; then
> +	echo "failed to umount"
> +	status=1
> +	exit
> +fi
> +status=0
> +exit
> diff --git a/tests/generic/623.out b/tests/generic/623.out
> new file mode 100644
> index 00000000..e10c7fd9
> --- /dev/null
> +++ b/tests/generic/623.out
> @@ -0,0 +1,4 @@
> +QA output created by 623
> +
> +Run fio with random aio-dio pattern
> +
> diff --git a/tests/generic/group b/tests/generic/group
> index b10fdea4..24f53ed7 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -625,3 +625,4 @@
>  620 auto mount quick
>  621 auto quick encrypt
>  622 auto shutdown metadata atime
> +623 aio rw stress
> -- 
> 2.30.0
> 
