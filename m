Received: from mail-yb0-f196.google.com ([209.85.213.196]:44102 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932361AbeD1PTG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 28 Apr 2018 11:19:06 -0400
Received: by mail-yb0-f196.google.com with SMTP id v63-v6so1717022ybi.11
        for <fstests@vger.kernel.org>; Sat, 28 Apr 2018 08:19:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180428145937.6804-1-jlayton@kernel.org>
References: <20180427163833.21882-1-jlayton@kernel.org> <20180428145937.6804-1-jlayton@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 28 Apr 2018 08:19:04 -0700
Message-ID: <CAOQ4uxjeNMJNg_toEj8bG_nbn-vW_ae7V1tP938td0_jh1U_Sw@mail.gmail.com>
Subject: Re: [PATCH v2] generic: test for seeing unseen fsync errors on newly
 open files
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests <fstests@vger.kernel.org>, Eryu Guan <eguan@redhat.com>, willy@infradead.org, andres@anarazel.de, Dave Chinner <david@fromorbit.com>
List-ID: <fstests@vger.kernel.org>

On Sat, Apr 28, 2018 at 7:59 AM, Jeff Layton <jlayton@kernel.org> wrote:
> From: Jeff Layton <jlayton@redhat.com>
>
> This adds a regression test for the following kernel patch:
>
>     errseq: Always report a writeback error once
>
> This is motivated by some rather odd behavior done by the PostgreSQL
> project. The main database writers will offload the fsync calls to a
> separate process, which can open files after a writeback error has
> already occurred.
>
> This used to work with older kernels that reported the error to only
> one fd, but with the errseq_t changes we lost the ability to see
> errors that occurred before the open. The above patch restores that
> behavior.
>
> Signed-off-by: Jeff Layton <jlayton@redhat.com>

Looks good. Minus a few nits, you can add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>


> ---
>  tests/generic/999     | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/999.out |  5 +++
>  tests/generic/group   |  1 +
>  3 files changed, 105 insertions(+)
>  create mode 100755 tests/generic/999
>  create mode 100644 tests/generic/999.out
>
> diff --git a/tests/generic/999 b/tests/generic/999
> new file mode 100755
> index 000000000000..081409f16100
> --- /dev/null
> +++ b/tests/generic/999
> @@ -0,0 +1,99 @@
> +#! /bin/bash
> +# FS QA Test No. XXX
> +#
> +# Open a file several times, write to it, fsync on all fds and make sure that
> +# they all return 0. Change the device to start throwing errors. Write again
> +# on all fds and fsync on all fds. Ensure that we get errors on all of them.
> +# Then fsync on all one last time and verify that all return 0.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2018, Jeff Layton <jlayton@redhat.com>
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
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1    # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +       cd /
> +       rm -rf $tmp.* $testdir
> +       _dmerror_cleanup
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/dmerror
> +
> +# real QA test starts here
> +_supported_os Linux
> +_require_scratch

Better _require_scratch_nocheck if you expect fs errors.

> +# This test uses "dm" without taking into account the data could be on
> +# realtime subvolume, thus the test will fail with rtinherit=1
> +_require_no_rtinherit
> +
> +_require_dm_target error
> +_require_test_program fsync-open-after-err
> +_require_test_program dmerror

Does it really require those programs?
I think you managed without them..

> +
> +rm -f $seqres.full
> +
> +echo "Format and mount"
> +_scratch_mkfs > $seqres.full 2>&1
> +_dmerror_init
> +_dmerror_mount
> +
> +datalen=65536
> +_require_fs_space $SCRATCH_MNT $datalen
> +
> +# use fd 5 to hold file open
> +testfile=$SCRATCH_MNT/fsync-open-after-err
> +exec 5>$testfile
> +
> +# write some data to file and fsync it out
> +$XFS_IO_PROG -c "pwrite -q 0 $datalen" -c fsync $testfile
> +
> +# flip device to non-working mode
> +_dmerror_load_error_table
> +
> +# rewrite the data, call sync to ensure it's written back w/o scraping error
> +$XFS_IO_PROG -c "pwrite -q 0 $datalen" -c sync $testfile
> +
> +# heal the device error
> +_dmerror_load_working_table
> +
> +# open again and call fsync
> +echo "The following fsync should fail with EIO:"
> +$XFS_IO_PROG -c fsync $testfile
> +echo "done"
> +
> +# close file
> +exec 5>&-
> +
> +# success, all done
> +_dmerror_unmount
> +_dmerror_cleanup
> +
> +# fs may be corrupt after this -- attempt to repair it
> +_repair_scratch_fs >> $seqres.full

Do we need that? Doesn't seem relevant to the test??

Thanks,
Amir.
