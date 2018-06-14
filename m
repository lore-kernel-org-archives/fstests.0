Received: from mail-pg0-f65.google.com ([74.125.83.65]:42245 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbeFNFal (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 14 Jun 2018 01:30:41 -0400
Date: Thu, 14 Jun 2018 13:30:34 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs: Test if btrfs will corrupt nodatasum
 compressed extent when replacing device
Message-ID: <20180614053034.GD2780@desktop>
References: <20180608061723.5276-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608061723.5276-1-wqu@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jun 08, 2018 at 02:17:23PM +0800, Qu Wenruo wrote:
> This is a long existing bug (from 2012) but exposed by a reporter
> recently, that when compressed extent without data csum get written to
> device-replace target device, the written data is in fact uncompressed data
> other than the original compressed data.
> 
> And since btrfs still consider the data is compressed and will try to read it
> as compressed, it can cause read error.
> 
> The root cause is located, and one RFC patch already sent to fix it,
> titled "[PATCH] btrfs: scrub: Don't use inode pages for device replace".
> (The RFC is only for the extra possible way to fix the bug, the fix
> itself should work without problem)
> 
> Reported-by: James Harvey <jamespharvey20@gmail.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> changelog:
> v2:
>   Now the fix patch is no longer RFC.
>   Remove _require_test as we don't really touch it.
>   Add comment on the mount cycle.
>   Add the test to group 'volume'.

Thanks for the revision! But again, I'd like to get some explicit
reviews from btrfs folks.

> ---
>  tests/btrfs/161     | 91 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/161.out |  2 +
>  tests/btrfs/group   |  1 +
>  3 files changed, 94 insertions(+)
>  create mode 100755 tests/btrfs/161
>  create mode 100644 tests/btrfs/161.out
> 
> diff --git a/tests/btrfs/161 b/tests/btrfs/161
> new file mode 100755
> index 00000000..ce1b0e04
> --- /dev/null
> +++ b/tests/btrfs/161
> @@ -0,0 +1,91 @@
> +#! /bin/bash
> +# FS QA Test 161
> +#
> +# Test if btrfs will corrupt compressed data extent without data csum
> +# by replacing it with uncompressed data, when doing replacing device.
> +#
> +# This could be fixed by the following RFC patch:
                                          ^^^^ can be dropped?

Thanks,
Eryu

P.S.
*IF* you're going to send v3, could you please follow the new test
template (create new test with './new btrfs' would do the work) and
rebase against latest master? That'd be easier for me to apply the
patch, but I'm also fine with taking it as-is (after we get Reviewed-by
tag), I can convert the test and re-number it on commit as always.

> +# "[PATCH] btrfs: scrub: Don't use inode pages for device replace"
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (C) 2018 SUSE Linux Products GmbH. All Rights Reserved.
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
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch_dev_pool 2
> +_require_scratch_dev_pool_equal_size
> +
> +
> +_scratch_dev_pool_get 1
> +_spare_dev_get
> +_scratch_pool_mkfs >> $seqres.full 2>&1
> +
> +# Create nodatasum inode
> +_scratch_mount "-o nodatasum"
> +touch $SCRATCH_MNT/nodatasum_file
> +_scratch_remount "datasum,compress"
> +_pwrite_byte 0xcd 0 128K $SCRATCH_MNT/nodatasum_file > /dev/null
> +
> +# Write the compressed data back to disk
> +sync
> +
> +# Replace the device
> +_run_btrfs_util_prog replace start -Bf 1 $SPARE_DEV $SCRATCH_MNT
> +
> +# Unmount to drop all cache so next read will read from disk
> +_scratch_unmount
> +_mount $SPARE_DEV $SCRATCH_MNT
> +
> +# Now the EXTENT_DATA item still marks the extent as compressed,
> +# but the on-disk data is uncompressed, thus reading it as compressed
> +# will definitely cause EIO.
> +cat $SCRATCH_MNT/nodatasum_file > /dev/null
> +
> +_scratch_unmount
> +_spare_dev_put
> +_scratch_dev_pool_put
> +
> +echo "Silence is golden"
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/161.out b/tests/btrfs/161.out
> new file mode 100644
> index 00000000..1752a243
> --- /dev/null
> +++ b/tests/btrfs/161.out
> @@ -0,0 +1,2 @@
> +QA output created by 161
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index f04ee8d5..9195b368 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -163,3 +163,4 @@
>  158 auto quick raid scrub
>  159 auto quick
>  160 auto quick
> +161 auto quick replace volume
> -- 
> 2.17.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
