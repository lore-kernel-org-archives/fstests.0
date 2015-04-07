Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39599 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755525AbbDGNPt (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 7 Apr 2015 09:15:49 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t37DFmKi002523
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Tue, 7 Apr 2015 09:15:49 -0400
Date: Tue, 7 Apr 2015 09:15:46 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH v2 1/4] generic: test quota handling on remount ro failure
Message-ID: <20150407131546.GA23208@bfoster.bfoster>
References: <1428045351-10446-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1428045351-10446-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 03, 2015 at 03:15:51PM +0800, Eryu Guan wrote:
> Remount ro should not turn qouta off unconditionally, even remount ro
> failed, also kernel should not oops on the next succeeded remount ro.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---

Looks good to me:

Reviewed-by: Brian Foster <bfoster@redhat.com>

> v2:
> - rebase and re-numbered to generic/082
> - add comments to quotacheck and quotaon
> - add comments to the first remount,ro with unknown option
> - fail the test if the second remount,ro failed
> 
>  tests/generic/082     | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/082.out |  3 +++
>  tests/generic/group   |  1 +
>  3 files changed, 77 insertions(+)
>  create mode 100755 tests/generic/082
>  create mode 100644 tests/generic/082.out
> 
> diff --git a/tests/generic/082 b/tests/generic/082
> new file mode 100755
> index 0000000..ca77c25
> --- /dev/null
> +++ b/tests/generic/082
> @@ -0,0 +1,73 @@
> +#! /bin/bash
> +# FS QA Test No. 082
> +#
> +# Test quota handling on remount ro failure
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2015 Red Hat Inc.  All Rights Reserved.
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
> +. ./common/quota
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_test
> +_require_scratch
> +_require_quota
> +
> +rm -f $seqres.full
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount "-o usrquota,grpquota"
> +
> +# xfs doesn't need these setups and quotacheck even fails on xfs, so just
> +# redirect the output to $seqres.full for debug purpose and ignore the results,
> +# as we check the quota status later anyway.
> +quotacheck -ug $SCRATCH_MNT >>$seqres.full 2>&1
> +quotaon $SCRATCH_MNT >>$seqres.full 2>&1
> +
> +# first remount ro with a bad option, a failed remount ro should not disable
> +# quota, but currently xfs doesn't fail in this case, the unknown option is
> +# just ignored, but quota is still on. This may change in future, let's
> +# re-consider the case then.
> +_scratch_mount "-o remount,ro,nosuchopt" >>$seqres.full 2>&1
> +quotaon -p $SCRATCH_MNT | _filter_scratch
> +# second remount should succeed, no oops or hang expected
> +_scratch_mount "-o remount,ro" || _fail "second remount,ro failed"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/082.out b/tests/generic/082.out
> new file mode 100644
> index 0000000..1acc7e4
> --- /dev/null
> +++ b/tests/generic/082.out
> @@ -0,0 +1,3 @@
> +QA output created by 082
> +group quota on SCRATCH_MNT (SCRATCH_DEV) is on
> +user quota on SCRATCH_MNT (SCRATCH_DEV) is on
> diff --git a/tests/generic/group b/tests/generic/group
> index 63b883c..4fe2189 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -84,6 +84,7 @@
>  079 acl attr ioctl metadata auto quick
>  080 auto quick
>  081 auto quick
> +082 auto quick
>  083 rw auto enospc stress
>  088 perms auto quick
>  089 metadata auto
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
