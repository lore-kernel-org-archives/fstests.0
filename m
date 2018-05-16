Received: from mail-pl0-f66.google.com ([209.85.160.66]:41363 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbeEPBtF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 May 2018 21:49:05 -0400
Date: Wed, 16 May 2018 09:48:58 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] btrfs: test ENOSPC caused by many orphan items
Message-ID: <20180516014858.GA29080@desktop.hz.ali.com>
References: <f6e37bbc4505f578176232a48cde99a9a3b7bb70.1525932731.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6e37bbc4505f578176232a48cde99a9a3b7bb70.1525932731.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

On Wed, May 09, 2018 at 11:21:55PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Btrfs has a bug where we can prematurely ENOSPC if we have lots of
> orphaned files, i.e., deleted files which are still open. Add a test
> which repeatedly creates and deletes a file while keeping all of the
> file descriptors open. This should succeed but doesn't on Btrfs without
> the fix.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  tests/generic/479     |  0
>  tests/generic/487     | 65 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/487.out |  2 ++
>  tests/generic/group   |  1 +
>  4 files changed, 68 insertions(+)
>  mode change 100644 => 100755 tests/generic/479
>  create mode 100755 tests/generic/487
>  create mode 100644 tests/generic/487.out
> 
> diff --git a/tests/generic/479 b/tests/generic/479
> old mode 100644
> new mode 100755
> diff --git a/tests/generic/487 b/tests/generic/487
> new file mode 100755
> index 00000000..66379cf0
> --- /dev/null
> +++ b/tests/generic/487
> @@ -0,0 +1,65 @@
> +#! /bin/bash
> +# FS QA Test 487
> +#
> +# Test having many file descriptors referring to deleted files open. Regression
> +# test for patch "Btrfs: fix ENOSPC caused by orphan items reservations".
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2018 Omar Sandoval.  All Rights Reserved.
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
> +. ./common/rc
> +. ./common/filter
> +
> +rm -f $seqres.full
> +
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +
> +_scratch_mkfs_sized $((1024 * 1024 * 1024)) >> $seqres.full 2>&1
> +_scratch_mount
> +
> +test_file="$SCRATCH_MNT/$seq"
> +
> +(
> +ulimit -n $((16 * 1024))
> +# ~10000 files on a 1 GB filesystem should be no problem.
> +for ((i = 1000; i < 10000; i++)); do
> +	eval "exec $i<> \"$test_file\"" && rm "$test_file" || break
> +done

There's a helper command in src that does exactly this job, e.g.

$here/src/multi_open_unlink -f $SCRATCH_MNT/$seq -n 10000 -s 0

which creates & unlinks 10000 files and keeps them open for 0 second in
$SCRATCH_MNT using "$seq" as name prefix. This reduces the test run time
from 13s to 1s for me.

It's a straightforward change, I'll just update on commit, please let me
know if you have different thoughts.

Thanks,
Eryu

> +)
> +
> +echo "Silence is golden"
> +
> +status=0
> +exit
> diff --git a/tests/generic/487.out b/tests/generic/487.out
> new file mode 100644
> index 00000000..5f31fd97
> --- /dev/null
> +++ b/tests/generic/487.out
> @@ -0,0 +1,2 @@
> +QA output created by 487
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 505383f7..93581257 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -489,3 +489,4 @@
>  484 auto quick
>  485 auto quick insert
>  486 auto quick attr
> +487 auto quick
> -- 
> 2.17.0
> 
