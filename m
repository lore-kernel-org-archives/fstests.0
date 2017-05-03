Received: from mx1.redhat.com ([209.132.183.28]:55396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752967AbdECKIj (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 3 May 2017 06:08:39 -0400
Date: Wed, 3 May 2017 18:08:36 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v3] fstests: regression test for btrfs dio read repair
Message-ID: <20170503100836.GF7250@eguan.usersys.redhat.com>
References: <1493400352-5845-1-git-send-email-bo.li.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493400352-5845-1-git-send-email-bo.li.liu@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: Liu Bo <bo.li.liu@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 28, 2017 at 11:25:52AM -0600, Liu Bo wrote:
> This case tests whether dio read can repair the bad copy if we have
> a good copy.
> 
> Commit 2dabb3248453 ("Btrfs: Direct I/O read: Work on sectorsized blocks")
> introduced the regression.
> 
> The upstream fix is
> 	Btrfs: fix invalid dereference in btrfs_retry_endio
> 
> Signed-off-by: Liu Bo <bo.li.liu@oracle.com>

Sorry for the late review, and many thanks to Filipe's reviews! I agreed
with Filipe that the common helpers can be placed in common/btrfs and/or
common/rc files.

Some thoughts inline.

> ---
> v2: - Add regression commit and the fix to the description
>     - Use btrfs inspect-internal dump-tree to get rid of the dependence btrfs-map-logical
>     - Add comments in several places
> 
> v3: - Add 'mkfs -b 1G' to limit filesystem size to 2G in raid1 profile so that
>       we get a consistent output.
> 
>  tests/btrfs/140     | 167 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/140.out |  39 ++++++++++++
>  tests/btrfs/group   |   1 +
>  3 files changed, 207 insertions(+)
>  create mode 100755 tests/btrfs/140
>  create mode 100644 tests/btrfs/140.out
> 
> diff --git a/tests/btrfs/140 b/tests/btrfs/140
> new file mode 100755
> index 0000000..dcd8807
> --- /dev/null
> +++ b/tests/btrfs/140
> @@ -0,0 +1,167 @@
> +#! /bin/bash
> +# FS QA Test 140
> +#
> +# Regression test for btrfs DIO read's repair during read.
> +#
> +# Commit 2dabb3248453 ("Btrfs: Direct I/O read: Work on sectorsized blocks")
> +# introduced the regression.
> +# The upstream fix is
> +# 	Btrfs: fix invalid dereference in btrfs_retry_endio
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2017 Liu Bo.  All Rights Reserved.
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
> +
> +_require_btrfs_command inspect-internal dump-tree
> +_require_command "$FILEFRAG_PROG" filefrag
> +_require_odirect
> +
> +# helpe to convert 'file offset' to btrfs logical offset
> +FILEFRAG_FILTER='
> +	if (/blocks? of (\d+) bytes/) {
> +		$blocksize = $1;
> +		next
> +	}
> +	($ext, $logical, $physical, $length) =
> +		(/^\s*(\d+):\s+(\d+)..\s+\d+:\s+(\d+)..\s+\d+:\s+(\d+):/)
> +	or next;
> +	($flags) = /.*:\s*(\S*)$/;
> +	print $physical * $blocksize, "#",
> +	      $length * $blocksize, "#",
> +	      $logical * $blocksize, "#",
> +	      $flags, " "'
                      ^^^ "\n" so one extent per line?

This can be embedded in the filter function, like what _filter_mkfs
does.

> +
> +# this makes filefrag output script readable by using a perl helper.
> +# output is one extent per line, with three numbers separated by '#'
> +# the numbers are: physical, length, logical (all in bytes)
> +# sample output: "1234#10#5678" -> physical 1234, length 10, logical 5678
> +_filter_extents()

Global functions start with underscore, local functions don't.

> +{
> +	tee -a $seqres.full | $PERL_PROG -ne "$FILEFRAG_FILTER"

I don't think this tee belongs here, see below.

> +}
> +
> +_check_file_extents()
> +{
> +	cmd="filefrag -v $1"

$FILEFRAG_PROG

> +	echo "# $cmd" >> $seqres.full

Just call filefrag -v again to dump the filefrag output to $seqres.full

> +	out=`$cmd | _filter_extents`
> +	if [ -z "$out" ]; then
> +		return 1
> +	fi
> +	echo "after filter: $out" >> $seqres.full
> +	echo $out
> +	return 0
> +}

Hmm, seems that all you want from all these filters is the logical byte
of the first extent in the file. How about converting
_check_file_extents to _filter_filefrag and put it in common/filter?
And _get_physical can also be converted to _btrfs_get_physical and
placed in common/btrfs
e.g.

common/filter:
# <comments>
_filter_filefrag()
{
	perl -ne '
	<all the perl filter code here>
	<like what _filter_mkfs does>
	'
}

then

logical_in_btrfs=`$FILEFRAG -v $SCRATCH_MNT/foobar | _filter_filefrag | cut -d '#' -f 1`
physical_on_scratch=`_btrfs_get_physical $logical_in_btrfs`

> +
> +_check_repair()
> +{
> +	filter=${1:-cat}

filter is not used in these test, can be removed.

> +	dmesg | tac | sed -ne "0,\#run fstests $seqnum at $date_time#p" | tac | $filter | grep -q -e "csum failed"

This code is taken from _check_dmesg, I think we can factor out a new
helper to dump dmesg of current test, e.g.

_get_current_dmesg()
{
	dmesg | tac | sed -ne .... | tac
}

and the detection for "csum failed" can be

for i in `seq 1 10`; do
	$XFS_IO_PROG ...
	_get_current_dmesg | grep -q -e "csum failed" && break
done

and _check_dmesg would be like

_check_dmesg()
{
	....
	_get_current_dmesg | $filter >$seqres.dmesg
	grep -q -e "Kernel BUG at" \
	...
}

> +	if [ $? -eq 0 ]; then
> +		echo 1
> +	else
> +		echo 0
> +	fi
> +}
> +
> +_get_physical()
> +{
> +	# $1 is logical address
> +	# print chunk tree and find devid 2 which is $SCRATCH_DEV
> +	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | grep $1 -A 6 | awk '($1 ~ /stripe/ && $3 ~ /devid/ && $4 ~ /1/) { print $6 }'
> +}
> +
> +_scratch_dev_pool_get 2
> +# step 1, create a raid1 btrfs which contains one 128k file.
> +echo "step 1......mkfs.btrfs" >>$seqres.full
> +
> +mkfs_opts="-d raid1 -b 1G"
> +_scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
> +
> +# -o nospace_cache makes sure data is written to the start position of the data
> +# chunk
> +_scratch_mount -o nospace_cache
> +
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" | _filter_xfs_io
> +
> +sync
> +
> +# step 2, corrupt the first 64k of one copy (on SCRATCH_DEV which is the first
> +# one in $SCRATCH_DEV_POOL
> +echo "step 2......corrupt file extent" >>$seqres.full
> +
> +extents=`_check_file_extents $SCRATCH_MNT/foobar`
> +logical_in_btrfs=`echo ${extents} | cut -d '#' -f 1`
> +physical_on_scratch=`_get_physical ${logical_in_btrfs}`
> +
> +_scratch_unmount
> +$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical_on_scratch 64K" $SCRATCH_DEV | _filter_xfs_io
> +
> +_scratch_mount
> +
> +# step 3, 128k dio read (this read can repair bad copy)
> +echo "step 3......repair the bad copy" >>$seqres.full
> +
> +# since raid1 consists of two copies, and the following read may read the good
> +# copy directly, so lets loop 10 times here and discard output that dio reads
> +# give
> +for i in `seq 1 10`; do
> +	$XFS_IO_PROG -d -c "pread -b 128K 0 128K" "$SCRATCH_MNT/foobar" > /dev/null
> +	repair=`_check_repair`
> +	if [ $repair -eq 1 ]; then
> +		break
> +	fi
> +done

But do we need really to stop at the first read csum failure, if 10
times is enough to read from the bad copy? If there's no need to break
out the loop, all the dmesg search work can be skipped too.

The same comments apply to all other three patches.

Thanks,
Eryu

> +
> +_scratch_unmount
> +
> +# check if the repair works
> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical_on_scratch 512" $SCRATCH_DEV | _filter_xfs_io
> +
> +_scratch_dev_pool_put
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/140.out b/tests/btrfs/140.out
> new file mode 100644
> index 0000000..c8565f5
> --- /dev/null
> +++ b/tests/btrfs/140.out
> @@ -0,0 +1,39 @@
> +QA output created by 140
> +wrote 131072/131072 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 65536/65536 bytes at offset 136708096
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +08260000:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +08260010:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +08260020:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +08260030:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +08260040:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +08260050:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +08260060:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +08260070:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +08260080:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +08260090:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +082600a0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +082600b0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +082600c0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +082600d0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +082600e0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +082600f0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +08260100:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +08260110:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +08260120:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +08260130:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +08260140:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +08260150:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +08260160:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +08260170:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +08260180:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +08260190:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +082601a0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +082601b0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +082601c0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +082601d0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +082601e0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +082601f0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +read 512/512 bytes at offset 136708096
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 9d4b80b..1cb9c98 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -141,3 +141,4 @@
>  137 auto quick send
>  138 auto compress
>  139 auto qgroup
> +140 auto quick
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
