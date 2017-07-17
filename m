Received: from sandeen.net ([63.231.237.45]:35056 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751316AbdGQTlF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 17 Jul 2017 15:41:05 -0400
Subject: Re: [PATCH v3] xfs/424: test xfs_db to ensure type size taken into
 account with new type
References: <20170712183112.5255-1-billodo@redhat.com>
 <20170717185359.18958-1-billodo@redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <e5a07a86-0081-7c7a-9807-a24c199c3abb@sandeen.net>
Date: Mon, 17 Jul 2017 14:41:04 -0500
MIME-Version: 1.0
In-Reply-To: <20170717185359.18958-1-billodo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Bill O'Donnell <billodo@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 07/17/2017 01:53 PM, Bill O'Donnell wrote:
> xfs_db should take type size into account when setting type.
> If type size isn't updated whenever type is set, a false crc
> error can occur due to the stale size. This test checks for
> that false crc error.
> 
> Signed-off-by: Bill O'Donnell <billodo@redhat.com>
> ---
> v2: Clarify commit message and test comments. Add a few more test cases.
> v3: Add more test cases. Use _scratch_xfs_db instead of $XFS_DB_PROG to
>     accomodate fses with external logs. Remove superfluous daddr and type
>     commands.
> 
>  tests/xfs/424     | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/424.out |  1 +
>  tests/xfs/group   |  1 +
>  3 files changed, 95 insertions(+)
>  create mode 100755 tests/xfs/424
>  create mode 100644 tests/xfs/424.out
> 
> diff --git a/tests/xfs/424 b/tests/xfs/424
> new file mode 100755
> index 00000000..8415ecd1
> --- /dev/null
> +++ b/tests/xfs/424
> @@ -0,0 +1,93 @@
> +#! /bin/bash
> +# FS QA Test 424
> +#
> +# xfs_db should take type size into account when setting type.
> +# If type size isn't updated whenever type is set, a false crc
> +# error can occur due to the stale size. This test checks for
> +# that false crc error.
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
> +_filter_dbval()
> +{
> +    awk '{ print $4 }'
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# Modify as appropriate
> +_supported_os Linux
> +_supported_fs xfs
> +_require_scratch
> +
> +# real QA test starts here
> +_scratch_unmount >> $seqres.full 2>&1
> +
> +# for different sector sizes, ensure no CRC errors are falsely reported.
> +
> +# Supported types include: agf, agfl, agi, attr3, bmapbta,
> +# bmapbtd, bnobt, cntbt, data, dir3, dqblk, inobt, inodata,
> +# inode, log, rtbitmap, rtsummary, sb, symlink, text, finobt.
> +# For various sector sizes, test some types that involve type size.
> +for SECTOR_SIZE in 512 1024 2048 4096; do
> +    $MKFS_XFS_PROG -f -s size=$SECTOR_SIZE $SCRATCH_DEV > /dev/null
> +
> +    for TYPE in agf agi agfl sb; do
> +	DADDR=`_scratch_xfs_db -c "$TYPE" -c "daddr" | _filter_dbval`
> +	_scratch_xfs_db -c "daddr $DADDR" -c "type $TYPE"
> +    done
> +
> +    for TYPE in inodata data log text rtbitmap rtsummary; do
> +	DADDR=`_scratch_xfs_db -c "sb" -c "addr rootino" -c "daddr" | _filter_dbval`
> +	_scratch_xfs_db -c "daddr $DADDR" -c "type $TYPE"
> +    done

Ok, I don't understand this part.  For each of those types, you get the address of
the root inode, then set it to the type - including types which are... not inodes?

(sure, type text & type data can be anything, but the others are specific data
types...)

> +
> +    DADDR=`_scratch_xfs_db -c "agf" -c "addr bnoroot" -c "daddr" | _filter_dbval`
> +    _scratch_xfs_db -c "daddr $DADDR" -c "type bnobt"
> +    DADDR=`_scratch_xfs_db -c "agf" -c "addr cntroot" -c "daddr" | _filter_dbval`
> +    _scratch_xfs_db -c "daddr $DADDR" -c "type cntbt"
> +    DADDR=`_scratch_xfs_db -c "agi" -c "addr root" -c "daddr" | _filter_dbval`
> +    _scratch_xfs_db -c "daddr $DADDR" -c "type inobt"
> +    DADDR=`_scratch_xfs_db -c "agi" -c "addr free_root" -c "daddr" | _filter_dbval`
> +    _scratch_xfs_db -c "daddr $DADDR" -c "type finobt"

to test the generic data & text types, you could just do:

+    _scratch_xfs_db -c "daddr $DADDR" -c "type text"
+    _scratch_xfs_db -c "daddr $DADDR" -c "type data"

here.  They don't hae CRCs anyway so if the test is truly to "test for crc errors"
then maybe it's not needed, but it can't hurt to actually iterate through each type
that's possible. 

> +done
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/424.out b/tests/xfs/424.out
> new file mode 100644
> index 00000000..d879a949
> --- /dev/null
> +++ b/tests/xfs/424.out
> @@ -0,0 +1 @@
> +QA output created by 424
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
