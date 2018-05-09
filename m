Received: from mail.cn.fujitsu.com ([183.91.158.132]:10718 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934638AbeEIM6a (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 May 2018 08:58:30 -0400
Subject: Re: [PATCH] btrfs: add test for seeing unseen fsync errors on newly
 open files
References: <20180508125657.10045-1-jlayton@kernel.org>
From: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Message-ID: <ee4f2765-0d4d-19a3-2cbe-6e7ad8892fdd@cn.fujitsu.com>
Date: Wed, 9 May 2018 20:58:20 +0800
MIME-Version: 1.0
In-Reply-To: <20180508125657.10045-1-jlayton@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>, guaneryu@gmail.com
Cc: fstests@vger.kernel.org, willy@infradead.org, andres@anarazel.de, david@fromorbit.com, amir73il@gmail.com
List-ID: <fstests@vger.kernel.org>

On 05/08/2018 08:56 PM, Jeff Layton wrote:
> From: Jeff Layton <jlayton@redhat.com>
> 
> This adds a regression test for the following kernel patch:
> 
>      errseq: Always report a writeback error once
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
> ---
>   tests/btrfs/999     | 110 ++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/999.out |   5 ++
>   tests/btrfs/group   |   1 +
>   3 files changed, 116 insertions(+)
>   create mode 100755 tests/btrfs/999
>   create mode 100644 tests/btrfs/999.out
> 
> diff --git a/tests/btrfs/999 b/tests/btrfs/999
> new file mode 100755
> index 000000000000..0f68942a91da
> --- /dev/null
> +++ b/tests/btrfs/999
> @@ -0,0 +1,110 @@
> +#! /bin/bash
> +# FS QA Test No. 999
> +#
> +# Open a file and write to it and fsync. Then flip the data device to throw
> +# errors, write to it again and call sync. Close the file, reopen it and
> +# then call fsync on it. Is the error reported?
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
> +	cd /
> +	rm -rf $tmp.* $testdir
> +	_dmerror_cleanup
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/dmerror
> +
> +# real QA test starts here
> +_supported_os Linux
> +_supported_fs btrfs
> +# This test uses "dm" without taking into account the data could be on
> +# realtime subvolume, thus the test will fail with rtinherit=1
> +_require_no_rtinherit
> +_require_scratch_dev_pool
> +
> +_require_dm_target error
> +
> +rm -f $seqres.full
> +
> +# bring up dmerror device
> +_scratch_unmount

# diff -u tests/btrfs/999.out results/btrfs/999.out.bad
--- tests/btrfs/999.out 2018-05-09 13:01:21.605173303 +0800
+++ results/btrfs/999.out.bad 2018-05-09 20:50:46.721383569 +0800
@@ -1,4 +1,5 @@
  QA output created by 999
+umount: /mnt/scratch: not mounted.
  Format and mount
  The following fsync should fail with EIO:
  fsync: Input/output error

The above _require_scratch_dev_pool has already umounted the scratch.

-- 
Thanks,
Lu

> +_dmerror_init
> +
> +# Replace first device with error-test device
> +old_SCRATCH_DEV=$SCRATCH_DEV
> +SCRATCH_DEV_POOL=`echo $SCRATCH_DEV_POOL | perl -pe "s#$SCRATCH_DEV#$DMERROR_DEV#"`
> +SCRATCH_DEV=$DMERROR_DEV
> +
> +echo "Format and mount"
> +_scratch_pool_mkfs "-d raid0 -m raid1" > $seqres.full 2>&1
> +_scratch_mount
> +
> +# How much do we need to write? We need to hit all of the stripes. btrfs uses a
> +# fixed 64k stripesize, so write enough to hit each one. In the case of
> +# compression, each 128K input data chunk will be compressed to 4K (because of
> +# the characters written are duplicate). Therefore we have to write
> +# (128K * 16) = 2048K to make sure every stripe can be hit.
> +number_of_devices=`echo $SCRATCH_DEV_POOL | wc -w`
> +write_kb=$(($number_of_devices * 2048))
> +_require_fs_space $SCRATCH_MNT $write_kb
> +datalen=$((($write_kb * 1024)-1))
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
> +status=0
> +exit
> diff --git a/tests/btrfs/999.out b/tests/btrfs/999.out
> new file mode 100644
> index 000000000000..38d2d7f6495f
> --- /dev/null
> +++ b/tests/btrfs/999.out
> @@ -0,0 +1,5 @@
> +QA output created by 999
> +Format and mount
> +The following fsync should fail with EIO:
> +fsync: Input/output error
> +done
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index ba766f6b84f8..8550f87a2305 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -162,3 +162,4 @@
>   157 auto quick raid
>   158 auto quick raid scrub
>   159 auto quick
> +999 auto quick
> 


