Received: from mx1.redhat.com ([209.132.183.28]:59074 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751553AbdJZKFJ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 26 Oct 2017 06:05:09 -0400
Date: Thu, 26 Oct 2017 18:05:06 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/2][v3] perf/001: a random write buffered fio perf test
Message-ID: <20171026100506.GO3235@eguan.usersys.redhat.com>
References: <1508360332-12033-1-git-send-email-josef@toxicpanda.com>
 <1508360332-12033-2-git-send-email-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508360332-12033-2-git-send-email-josef@toxicpanda.com>
Sender: fstests-owner@vger.kernel.org
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, david@fromorbit.com, fstests@vger.kernel.org, tytso@mit.edu, darrick.wong@oracle.com, Josef Bacik <jbacik@fb.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Oct 18, 2017 at 04:58:52PM -0400, Josef Bacik wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> This uses the new fio results perf helpers to run a rand write buffered
> workload on the scratch device.
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>
> ---
> v2->v3:
> - use _scratch_mkfs_sized so we skip if our scratch device is too small.
> - dump the fio results into teh seqres.full file for debugging.
> - fixed the _size math, it was all wrong.
> 
> v1->v2:
> - no change
> 
>  tests/perf/001     | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/perf/001.out |  2 ++
>  tests/perf/group   |  1 +
>  3 files changed, 82 insertions(+)
>  create mode 100644 tests/perf/001
>  create mode 100644 tests/perf/001.out
>  create mode 100644 tests/perf/group
> 
> diff --git a/tests/perf/001 b/tests/perf/001
> new file mode 100644
> index 000000000000..73faef39e9af
> --- /dev/null
> +++ b/tests/perf/001
> @@ -0,0 +1,79 @@
> +#! /bin/bash
> +# perf/001 Test
> +#
> +# Buffered random write performance test.
> +#
> +#-----------------------------------------------------------------------
> +# (c) 2017 Josef Bacik
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
> +#
> +#-----------------------------------------------------------------------
> +#
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +fio_config=$tmp.fio
> +fio_results=$tmp.json
> +status=1	# failure is the default!
> +trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/perf
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +_require_block_device $SCRATCH_DEV
> +_require_fio_results
> +
> +rm -f $seqres.full
> +
> +_size=$((16 * $LOAD_FACTOR))
> +cat >$fio_config <<EOF
> +[t1]
> +directory=${SCRATCH_MNT}
> +allrandrepeat=1
> +readwrite=randwrite
> +size=${_size}G
> +ioengine=psync
> +end_fsync=1
> +fallocate=none
> +EOF
> +
> +_require_fio $fio_config
> +
> +_fio_results_init
> +
> +# We are going to write at least 16gib, make sure our scratch fs is large enough
> +# to fit and not deal with any enospc overhead.
> +_size=$(($_size * 4))
> +_scratch_mkfs_sized $(($_size * 1024 * 1024 * 1024)) >> $seqres.full 2>&1

I tend to mkfs & mount first and use _require_fs_space to check the
available space, as _scratch_mkfs_sized creates exact 16G filesystem,
and we're going to write 16G file to it and 100% fulfill the device.

> +_scratch_mount
> +
> +cat $fio_config >> $seqres.full
> +run_check $FIO_PROG --output-format=json --output=$fio_results $fio_config

Same here, avoid run_check if possible.

> +
> +_scratch_unmount
> +cat $fio_results >> $seqres.full
> +_fio_results_compare $seq $fio_results
> +echo "Silence is golden"
> +status=0; exit
> diff --git a/tests/perf/001.out b/tests/perf/001.out
> new file mode 100644
> index 000000000000..88678b8ed5ad
> --- /dev/null
> +++ b/tests/perf/001.out
> @@ -0,0 +1,2 @@
> +QA output created by 001
> +Silence is golden
> diff --git a/tests/perf/group b/tests/perf/group
> new file mode 100644
> index 000000000000..d3ed434926e7
> --- /dev/null
> +++ b/tests/perf/group
> @@ -0,0 +1 @@
> +001 auto

I think auto group is fine here, perf tests are not run by default in a
'-g auto' run, even if perf/001 is in auto group. It only means it's a
reliable & meaningful perf test, and we can run all 'auto' tests in perf
dir with "./check -g perf/auto" anyway.

Thanks,
Eryu
