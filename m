Received: from aserp1040.oracle.com ([141.146.126.69]:34669 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753766AbcLORgs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 15 Dec 2016 12:36:48 -0500
Date: Thu, 15 Dec 2016 09:36:35 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] generic: make sure file size resource limit is honored
 by fs
Message-ID: <20161215173635.GB5355@birch.djwong.org>
References: <20161203062600.25471-1-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161203062600.25471-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Dec 03, 2016 at 02:26:00PM +0800, Eryu Guan wrote:
> If a file size limitation is set, underlying filesystem should not
> break the limit and exceed the max file size.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
>  tests/generic/394     | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/394.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 73 insertions(+)
>  create mode 100755 tests/generic/394
>  create mode 100644 tests/generic/394.out
> 
> diff --git a/tests/generic/394 b/tests/generic/394
> new file mode 100755
> index 0000000..c1e5eab
> --- /dev/null
> +++ b/tests/generic/394
> @@ -0,0 +1,70 @@
> +#! /bin/bash
> +# FS QA Test 394
> +#
> +# Make sure fs honors file size resource limit.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2016 Red Hat Inc.  All Rights Reserved.
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
> +	ulimit -f unlimited
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
> +# need a wrapper function so "File size limit exceeded" message can be filtered
> +do_truncate()
> +{
> +	$XFS_IO_PROG -fc "truncate $1" $2
> +}
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_test
> +
> +# set max file size to 1G (in block number of 1k blocks), so it should be big
> +# enough to let test run without bringing any trouble to test harness
> +ulimit -f $((1024 * 1024))
> +
> +# exercise file size limit boundaries
> +do_truncate $((1024 * 1024 * 1024 - 1))	$TEST_DIR/$seq.$$-1
> +do_truncate $((1024 * 1024 * 1024))	$TEST_DIR/$seq.$$
> +do_truncate $((1024 * 1024 * 1024 + 1))	$TEST_DIR/$seq.$$+1 2>&1 | \
> +	grep -o "File size limit exceeded"

So I tried this out in a shell and was very surprised to get a core dump
in addition to the 'File size limit exceeded' message.  Other than that
little surprise it looks ok to me....

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/394.out b/tests/generic/394.out
> new file mode 100644
> index 0000000..c79347b
> --- /dev/null
> +++ b/tests/generic/394.out
> @@ -0,0 +1,2 @@
> +QA output created by 394
> +File size limit exceeded
> diff --git a/tests/generic/group b/tests/generic/group
> index f4af986..20b31ef 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -396,3 +396,4 @@
>  391 auto quick rw
>  392 auto quick metadata
>  393 auto quick rw
> +394 auto quick
> -- 
> 2.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
