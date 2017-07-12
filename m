Received: from sandeen.net ([63.231.237.45]:53166 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751842AbdGLTCJ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 12 Jul 2017 15:02:09 -0400
Subject: Re: [PATCH] xfs/424: test xfs_db to ensure sector size taken into
 account with new type
References: <20170712183112.5255-1-billodo@redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <a65215f5-6158-acbf-beaf-bd6b3ed1985f@sandeen.net>
Date: Wed, 12 Jul 2017 14:02:08 -0500
MIME-Version: 1.0
In-Reply-To: <20170712183112.5255-1-billodo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Bill O'Donnell <billodo@redhat.com>, fstests@vger.kernel.org
Cc: eguan@redhat.com
List-ID: <fstests@vger.kernel.org>



On 07/12/2017 01:31 PM, Bill O'Donnell wrote:
> xfs_db should take sector size into account when setting type.

type size.  Sector size just happens to influence some type sizes.

> If sector size ignored, a false crc error can occur due to
> the new size not being picked up when type gets set. This test
> checks for that false crc error.
> 
> Signed-off-by: Bill O'Donnell <billodo@redhat.com>
> ---
>  tests/xfs/424     | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/424.out |  5 ++++
>  tests/xfs/group   |  1 +
>  3 files changed, 78 insertions(+)
>  create mode 100755 tests/xfs/424
>  create mode 100644 tests/xfs/424.out
> 
> diff --git a/tests/xfs/424 b/tests/xfs/424
> new file mode 100755
> index 00000000..12945678
> --- /dev/null
> +++ b/tests/xfs/424
> @@ -0,0 +1,72 @@
> +#! /bin/bash
> +# FS QA Test 424
> +#
> +# xfs_db should take sector size into account when setting type.
> +# If sector size ignored, a false crc error can occur due to
> +# the new size not being picked up when type is set. This test
> +# checks for that false crc error.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2017 Red Hat, Inc.  All Rights Reserved.
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
> +_scratch_unmount >> $seqres.full 2>&1

Scratch should be unmounted already, maybe it's ok to be defensive.

> +
> +# for different sector sizes, ensure no CRC errors are falsely reported
> +$MKFS_PROG -t xfs -f -s size=512 $SCRATCH_DEV > /dev/null

Could also just use $MKFS_XFS_PROG, but *shrug*

> +$XFS_DB_PROG -c "agi 0" -c "daddr" -c "daddr 42" -c "daddr 2" -c "type agi" $SCRATCH_DEV

While it's probably safe in this instance, because:

#define XFS_AGI_DADDR(mp)       ((xfs_daddr_t)(2 << (mp)->m_sectbb_log))

hardcoding the agi 0 location feels a little fragile.  If this were testing various types,
it would be safest to do i.e. "agf 0; daddr" and collect the computed disk address, then
set it back to the daddr reported by db...

> +ack"daddr" -c "daddr 42" -c "daddr 4" -c "type agi" $SCRATCH_DEV
> +
> +$MKFS_PROG -t xfs -f -s size=2048 $SCRATCH_DEV > /dev/null
> +$XFS_DB_PROG -c "agi 0" -c "daddr" -c "daddr 42" -c "daddr 8" -c "type agi" $SCRATCH_DEV
> +
> +$MKFS_PROG -t xfs -f -s size=4096 $SCRATCH_DEV > /dev/null
> +$XFS_DB_PROG -c "agi 0" -c "daddr" -c "daddr 42" -c "daddr 16" -c "type agi" $SCRATCH_DEV

Is it sufficient to only test agi types?

> +
> +# Modify as appropriate.

Surely all the requirements should  go prior to the actual testing above?
> +_supported_fs generic

I doubt that this works on generic filesystems.  xfs, right?

> +_supported_os Linux
> +_require_test

why do you need a test dev?  On the other hand, you /do/ need a scratch dev ...

thanks,
-eric


> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/424.out b/tests/xfs/424.out
> new file mode 100644
> index 00000000..ff12d9d0
> --- /dev/null
> +++ b/tests/xfs/424.out
> @@ -0,0 +1,5 @@
> +QA output created by 424
> +current daddr is 2
> +current daddr is 4
> +current daddr is 8
> +current daddr is 16
> diff --git a/tests/xfs/group b/tests/xfs/group
> index ffdb0615..75c8280c 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -421,3 +421,4 @@
>  421 auto quick clone dedupe
>  422 dangerous_scrub dangerous_online_repair
>  423 dangerous_scrub
> +424 auto quick db
> 
