Received: from mx1.redhat.com ([209.132.183.28]:57127 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380AbcGMKq7 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 13 Jul 2016 06:46:59 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 78DCA3B730
	for <fstests@vger.kernel.org>; Wed, 13 Jul 2016 10:46:43 +0000 (UTC)
Date: Wed, 13 Jul 2016 18:46:41 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v3] xfstests: Add mkfs input validation tests
Message-ID: <20160713104641.GT2432@eguan.usersys.redhat.com>
References: <1465893068-1615-1-git-send-email-jtulak@redhat.com>
 <1467389557-4360-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467389557-4360-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jan Tulak <jtulak@redhat.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Jul 01, 2016 at 06:12:37PM +0200, Jan Tulak wrote:
> mkfs.xfs does not do a very good job of input validation. This test
> is designed to exercise the input validation and test good/bad
> combinations of options being set. It will not pass on an old
> mkfs.xfs binary - it is designed to be the test case for an input
> validation cleanup (merged in spring/summer 2016).
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Jan Tulak <jtulak@redhat.com>
> 
> ---
> CHANGES:
>   * Skip this test on older binaries, detected by a few feature checks
> 
> Cheers,
> Jan
> 
> Signed-off-by: Jan Tulak <jtulak@redhat.com>
> ---
>  tests/xfs/400-input-validation     | 350 +++++++++++++++++++++++++++++++++++++
>  tests/xfs/400-input-validation.out |   2 +
>  tests/xfs/group                    |   1 +
>  3 files changed, 353 insertions(+)
>  create mode 100755 tests/xfs/400-input-validation
>  create mode 100644 tests/xfs/400-input-validation.out
> 
> diff --git a/tests/xfs/400-input-validation b/tests/xfs/400-input-validation
> new file mode 100755
> index 0000000..d6f9110
> --- /dev/null
> +++ b/tests/xfs/400-input-validation
> @@ -0,0 +1,350 @@
> +#! /bin/bash
> +# FS QA Test No. xfs/400
> +#
> +# mkfs.xfs input validation test. Designed to break mkfs.xfs if it doesn't
> +# filter garbage input or invalid option combinations correctly.
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
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs xfs
> +_supported_os Linux
> +_require_scratch
> +
> +# Skip if we are running an older binary without the stricter input checks.
> +# Make multiple checks to be sure that there is no regression on the one
> +# selected feature check, which would skew the result.
> +$MKFS_XFS_PROG -f -N -s size=2s $SCRATCH_DEV >/dev/null 2>&1
> +sum=$?
> +$MKFS_XFS_PROG -f -N -l version=2,su=$((256 * 1024 + 4096)) $SCRATCH_DEV >/dev/null 2>&1
> +sum=`expr $sum + $?`
> +
> +if [ "$sum" -eq 0 ]; then
> +	_notrun "Requires newer mkfs with stricter input checks."
> +fi

I think this can be put into a new _require rule in common/rc, as Dave
suggested in his previous review:

"
... a "_require_xfs_mkfs_validation" rule should be
written to determine the version of mkfs being. e.g. by testing one
of the failure cases that the unfixed binary says is ok.
"

Thanks,
Eryu
