Received: from mx1.redhat.com ([209.132.183.28]:37488 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752083AbcFNLn2 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 14 Jun 2016 07:43:28 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A66B3F722
	for <fstests@vger.kernel.org>; Tue, 14 Jun 2016 11:43:28 +0000 (UTC)
Date: Tue, 14 Jun 2016 07:43:26 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH 2/3] generic: test error handling on filesystem shutdown
Message-ID: <20160614114326.GB32443@bfoster.bfoster>
References: <1465890821-4388-1-git-send-email-eguan@redhat.com>
 <1465890821-4388-2-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1465890821-4388-2-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 14, 2016 at 03:53:40PM +0800, Eryu Guan wrote:
> Test XFS EFI/EFD error handling. Though it's an XFS bug, it can ran on
> any filesystem supports shutdown.
> 
> This kernel commit fixed a hang on umount in XFS
> 8d99fe9 xfs: fix efi/efd error handling to avoid fs shutdown hangs
> 
> Though this bug is hard to hit, it's still good to have some coverage.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---

The test looks fine, though I wonder if we already have other tests that
might reproduce this problem. On a quick look, generic/051, xfs/079 and
perhaps one or two others look similar to this test.

Have you verified that 1.) this test reproduces the original problem and
2.) that some of these other fsstress+godown tests do not (or are not as
effective)?

>  tests/generic/353     | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/353.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 76 insertions(+)
>  create mode 100755 tests/generic/353
>  create mode 100644 tests/generic/353.out
> 
> diff --git a/tests/generic/353 b/tests/generic/353
> new file mode 100755
> index 0000000..0516d8a
> --- /dev/null
> +++ b/tests/generic/353
> @@ -0,0 +1,73 @@
> +#! /bin/bash
> +# FS QA Test 353
> +#
> +# Test XFS EFI/EFD error handling.
> +#
> +# This kernel commit fixed a hang on umount in XFS
> +# 8d99fe9 xfs: fix efi/efd error handling to avoid fs shutdown hangs
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
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +_require_scratch_shutdown
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +# fsstress load to generate EFI(extent free intention/EFD(extent free done)
> +$FSSTRESS_PROG  -d $SCRATCH_MNT/testdir -n 99999 -p 16 -z -f fallocate=1 \
> +		-f punch=1 -f creat=1 -f unlink=1 >>$seqres.full 2>&1 &
> +sleep 5
> +kill $!
> +wait
> +
> +# shutdown filesystem, handle EFI/EFD in error path
> +src/godown -f $SCRATCH_MNT
> +
> +# don't expect umount to hang. mount it again to do log replay and pass fs check
> +_scratch_cycle_mount
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/353.out b/tests/generic/353.out
> new file mode 100644
> index 0000000..16ba4f1
> --- /dev/null
> +++ b/tests/generic/353.out
> @@ -0,0 +1,2 @@
> +QA output created by 353
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 4b65dcb..0203afa 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -355,3 +355,4 @@
>  350 blockdev quick rw
>  351 blockdev quick rw
>  352 auto quick metadata
> +353 auto quick metadata

We might want the (v2)log group as well.

Brian

> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
