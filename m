Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:54353 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757733AbaISTi1 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 19 Sep 2014 15:38:27 -0400
Message-ID: <541C8632.5070700@sandeen.net>
Date: Fri, 19 Sep 2014 14:38:26 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH 3/5] generic: add mmap write vs truncate test
References: <1410918113-23516-1-git-send-email-david@fromorbit.com> <1410918113-23516-4-git-send-email-david@fromorbit.com>
In-Reply-To: <1410918113-23516-4-git-send-email-david@fromorbit.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 9/16/14 8:41 PM, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> This test exposed a problem with mapped writes to the tail page of a
> file in XFS. Hence make it a generic test so taht we can ensure that
> all fielsystems handle the case correctly.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

although I'd like to see "Pre-remount [123]" in the output to make
it a little easier to see which test failed (if only 2 test failed...)
- maybe that can be tidied up on commit.

Thanks,
-=Eric

> ---
>  tests/generic/029     | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/029.out |  65 ++++++++++++++++++++++++++
>  tests/generic/group   |   1 +
>  3 files changed, 189 insertions(+)
>  create mode 100644 tests/generic/029
>  create mode 100644 tests/generic/029.out
> 
> diff --git a/tests/generic/029 b/tests/generic/029
> new file mode 100644
> index 0000000..854794e
> --- /dev/null
> +++ b/tests/generic/029
> @@ -0,0 +1,123 @@
> +#! /bin/bash
> +# FS QA Test No. generic/029
> +#
> +# Test mapped writes against truncate down/up to ensure we get the data
> +# correctly written. This can expose data corruption bugs on filesystems where
> +# the block size is smaller than the page size.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2014 Red Hat, Inc.  All Rights Reserved.
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
> +    cd /
> +    rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os IRIX Linux
> +_require_scratch
> +
> +testfile=$SCRATCH_MNT/testfile
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +
> +# first case is just truncate down/truncate up to check that the mapped
> +# write after the truncate up is correctly handled.
> +$XFS_IO_PROG -t -f \
> +-c "truncate 5120"              `# truncate     |                        |` \
> +-c "pwrite -S 0x58 0 5120"      `# write        |XXXXXXXXXXXXXXXXXXXXXXXX|` \
> +-c "mmap -rw 0 5120"            `# mmap         |                        |` \
> +-c "mwrite -S 0x5a 2048 3072"   `# mwrite       |          ZZZZZZZZZZZZZZ|` \
> +-c "truncate 2048"              `# truncate dn  |         |` \
> +-c "truncate 5120"              `# truncate up  |                        |` \
> +-c "mwrite -S 0x59 2048 3072"   `# mwrite       |          YYYYYYYYYYYYYY|` \
> +-c "close"      \
> +$testfile | _filter_xfs_io
> +
> +echo "==== Pre-Remount ==="
> +hexdump -C $testfile
> +_scratch_remount
> +echo "==== Post-Remount =="
> +hexdump -C $testfile
> +
> +rm -f $testfile
> +sync
> +
> +# second case is to do a mwrite between the truncate to a block on the
> +# same page we are truncating within the EOF. This checks that a mapped
> +# write between truncate down and truncate up a further mapped
> +# write to the same page into the new space doesn't result in data being lost.
> +$XFS_IO_PROG -t -f \
> +-c "truncate 5120"              `# truncate     |                        |` \
> +-c "pwrite -S 0x58 0 5120"      `# write        |XXXXXXXXXXXXXXXXXXXXXXXX|` \
> +-c "mmap -rw 0 5120"            `# mmap         |                        |` \
> +-c "mwrite -S 0x5a 2048 3072"   `# mwrite       |          ZZZZZZZZZZZZZZ|` \
> +-c "truncate 2048"              `# truncate dn  |         |` \
> +-c "mwrite -S 0x57 1024 1024"   `# mwrite       |     WWWWW              |` \
> +-c "truncate 5120"              `# truncate up  |                        |` \
> +-c "mwrite -S 0x59 2048 3072"   `# mwrite       |          YYYYYYYYYYYYYY|` \
> +-c "close"      \
> +$testfile | _filter_xfs_io
> + 
> +echo "==== Pre-Remount ==="
> +hexdump -C $testfile
> +_scratch_remount
> +echo "==== Post-Remount =="
> +hexdump -C $testfile
> +
> +# third case is the same as second case, just with non-1k aligned offsets and
> +# sizes.
> +$XFS_IO_PROG -t -f \
> +-c "truncate 5121"              `# truncate     |                        |` \
> +-c "pwrite -S 0x58 0 5121"      `# write        |XXXXXXXXXXXXXXXXXXXXXXXX|` \
> +-c "mmap -rw 0 5121"            `# mmap         |                        |` \
> +-c "mwrite -S 0x5a 2047 3071"   `# mwrite       |          ZZZZZZZZZZZZZZ|` \
> +-c "truncate 2047"              `# truncate dn  |         |` \
> +-c "mwrite -S 0x57 513 1025"    `# mwrite       |  WWWWW                 |` \
> +-c "truncate 5121"              `# truncate up  |                        |` \
> +-c "mwrite -S 0x59 2047 3071"   `# mwrite       |          YYYYYYYYYYYYYY|` \
> +-c "close"      \
> +$testfile | _filter_xfs_io
> + 
> +echo "==== Pre-Remount ==="
> +hexdump -C $testfile
> +_scratch_remount
> +echo "==== Post-Remount =="
> +hexdump -C $testfile
> +
> +status=0
> +exit
> +
> diff --git a/tests/generic/029.out b/tests/generic/029.out
> new file mode 100644
> index 0000000..457982c
> --- /dev/null
> +++ b/tests/generic/029.out
> @@ -0,0 +1,65 @@
> +QA output created by 029
> +wrote 5120/5120 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +==== Pre-Remount ===
> +00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
> +*
> +00000800  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
> +*
> +00001400
> +==== Post-Remount ==
> +00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
> +*
> +00000800  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
> +*
> +00001400
> +wrote 5120/5120 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +==== Pre-Remount ===
> +00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
> +*
> +00000400  57 57 57 57 57 57 57 57  57 57 57 57 57 57 57 57  |WWWWWWWWWWWWWWWW|
> +*
> +00000800  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
> +*
> +00001400
> +==== Post-Remount ==
> +00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
> +*
> +00000400  57 57 57 57 57 57 57 57  57 57 57 57 57 57 57 57  |WWWWWWWWWWWWWWWW|
> +*
> +00000800  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
> +*
> +00001400
> +wrote 5121/5121 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +==== Pre-Remount ===
> +00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
> +*
> +00000200  58 57 57 57 57 57 57 57  57 57 57 57 57 57 57 57  |XWWWWWWWWWWWWWWW|
> +00000210  57 57 57 57 57 57 57 57  57 57 57 57 57 57 57 57  |WWWWWWWWWWWWWWWW|
> +*
> +00000600  57 57 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |WWXXXXXXXXXXXXXX|
> +00000610  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
> +*
> +000007f0  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 59  |XXXXXXXXXXXXXXXY|
> +00000800  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
> +*
> +000013f0  59 59 59 59 59 59 59 59  59 59 59 59 59 59 00 00  |YYYYYYYYYYYYYY..|
> +00001400  00                                                |.|
> +00001401
> +==== Post-Remount ==
> +00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
> +*
> +00000200  58 57 57 57 57 57 57 57  57 57 57 57 57 57 57 57  |XWWWWWWWWWWWWWWW|
> +00000210  57 57 57 57 57 57 57 57  57 57 57 57 57 57 57 57  |WWWWWWWWWWWWWWWW|
> +*
> +00000600  57 57 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |WWXXXXXXXXXXXXXX|
> +00000610  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
> +*
> +000007f0  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 59  |XXXXXXXXXXXXXXXY|
> +00000800  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
> +*
> +000013f0  59 59 59 59 59 59 59 59  59 59 59 59 59 59 00 00  |YYYYYYYYYYYYYY..|
> +00001400  00                                                |.|
> +00001401
> diff --git a/tests/generic/group b/tests/generic/group
> index bdcfd9d..18c94de 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -31,6 +31,7 @@
>  026 acl quick auto
>  027 auto enospc
>  028 auto quick
> +029 auto quick rw
>  053 acl repair auto quick
>  062 attr udf auto quick
>  068 other auto freeze dangerous stress
> 

