Received: from mx1.redhat.com ([209.132.183.28]:44322 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750995AbcHOF3g (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 15 Aug 2016 01:29:36 -0400
Date: Mon, 15 Aug 2016 13:29:33 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] tests/xfs: test log recovery metadata LSN ordering
Message-ID: <20160815052933.GE27776@eguan.usersys.redhat.com>
References: <1471004010-52985-1-git-send-email-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1471004010-52985-1-git-send-email-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 12, 2016 at 08:13:30AM -0400, Brian Foster wrote:
> XFS had a bug that lead to a possible out-of-order log recovery
> situation (e.g., replay a stale modification from the log over more
> recent metadata in destination buffer). This resulted in false
> corruption reports during log recovery and thus mount failure.
> 
> This condition is caused by system crash or filesystem shutdown shortly
> after a successful log recovery. Add a test to run a combined workload,
> fs shutdown and log recovery loop known to reproduce the problem on
> affected kernels.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
> 
> This test reproduces the problem described and addressed in the
> following patchset:
> 
>   http://oss.sgi.com/pipermail/xfs/2016-August/050840.html
> 
> It runs anywhere from 50-100s in the couple of environments I've tested
> on so far and reproduces the problem for me with 100% reliability. Note
> that the bug only affects crc=1 kernels.

Looks good overall, and tested with the above patchset applied and test
passed without problems. Some minor issues inline

> 
> Brian
> 
>  tests/xfs/999     | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/999.out |  2 ++
>  tests/xfs/group   |  1 +
>  3 files changed, 90 insertions(+)
>  create mode 100755 tests/xfs/999
>  create mode 100644 tests/xfs/999.out
> 
> diff --git a/tests/xfs/999 b/tests/xfs/999
> new file mode 100755
> index 0000000..f9dd7f7
> --- /dev/null
> +++ b/tests/xfs/999
> @@ -0,0 +1,87 @@
> +#! /bin/bash
> +# FS QA Test No. 999
> +#
> +# Test XFS log recovery ordering on v5 superblock filesystems. XFS had a problem
> +# where it would incorrectly replay older modifications from the log over more
> +# recent versions of metadata due to failure to update metadata LSNs during log
> +# recovery. This could result in false positive reports of corruption during log
> +# recovery and permanent mount failure.
> +#
> +# To test this situation, run frequent shutdowns immediately after log recovery.
> +# Ensure that log recovery does not recover stale modifications and cause
> +# spurious corruption reports and/or mount failures.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
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
> +	killall -9 fsstress > /dev/null 2>&1

We need a '_require_command "$KILLALL_PROGA" killall' and use
$KILLALL_PROG in the test.

> +	_scratch_unmount > /dev/null 2>&1
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +
> +# Modify as appropriate.
> +_supported_fs xfs

I'm wondering if this test can be made generic by adding a
"_require_scratch_shutdown"? Like generic/042 to generic/051

Thanks,
Eryu
