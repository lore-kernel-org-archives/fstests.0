Received: from mx1.redhat.com ([209.132.183.28]:39155 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751654AbcFWLET (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 23 Jun 2016 07:04:19 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1433480F6B
	for <fstests@vger.kernel.org>; Thu, 23 Jun 2016 11:04:19 +0000 (UTC)
Date: Thu, 23 Jun 2016 19:04:17 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfstests: Add mkfs input validation tests
Message-ID: <20160623110417.GK3226@eguan.usersys.redhat.com>
References: <1465893068-1615-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1465893068-1615-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jan Tulak <jtulak@redhat.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 14, 2016 at 10:31:08AM +0200, Jan Tulak wrote:
> mkfs.xfs does not do a very good job of input validation. This test
> is designed to exercise the input validation and test good/bad
> combinations of options being set. It will not pass on an old
> mkfs.xfs binary - it is designed to be the test case for an input
> validation cleanup (merged in spring/summer 2016).

Looks good to me overall, I tested with xfsprogs v4.7-rc1 and it passed
the test, on both x86_64 and ppc64 host. Old xfsprogs failed the test as
expected.

But I'm not sure about all the sub-tests it does, is it enough or not,
is it doing valid tests, etc. Need help from xfs developers.

Some minor issues below.

> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Jan Tulak <jtulak@redhat.com>
> 
> ---
> 
> CHANGES:
>   * Edited commit message to reflect that the cleanup was already merged.
>   * I added other sections - now it should go through all options and check
> conflicting/mandatory combinations when appropriate. I'm not feeding a garbage
> into every option, because now the parsing should be done consistently and the
> same for all options of the same type. However, it is possible I forgot
> something what should be there - in such case, hit me. :-)
> 
> Also, at the moment of submitting this, there are some patches for xfsprogs
> fixing some issues in the mailing list - so expect this to fail with the
> current for-next branch (c5d584c)
> 
> Regarding of the number of this test: I used the number as this test was some
> time half baked and I wanted to avoid conflicts with other new tests. So if it
> is an issue, I can submit it with another number, somewhere in the main
> sequence.
> 
> Cheers,
> Jan
> ---
>  tests/xfs/400-input-validation     | 335 +++++++++++++++++++++++++++++++++++++
>  tests/xfs/400-input-validation.out |   2 +
>  tests/xfs/group                    |   1 +
>  3 files changed, 338 insertions(+)
>  create mode 100755 tests/xfs/400-input-validation
>  create mode 100644 tests/xfs/400-input-validation.out
> 
> diff --git a/tests/xfs/400-input-validation b/tests/xfs/400-input-validation
> new file mode 100755
> index 0000000..c52a4b6
> --- /dev/null
> +++ b/tests/xfs/400-input-validation
> @@ -0,0 +1,335 @@
> +#! /bin/bash
> +# FS QA Test No. xfs/400
> +#
> +# mkfs.xfs input validation test. Designed to break mkfs.xfs if it doesn't
> +# filter garbage input or invalid option combinations correctly.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2014 Red Hat, Inc.  All Rights Reserved.
                   ^^^^ 2016
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
> +status=1        # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +    cd /
> +    rm -f $tmp.*

You're using space for indention in the whole test, please use tab.

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
> +rm $seqres.full || true

rm -f $seqres.full

Otherwise it fails when I ran it for the first time
rm: cannot remove '/root/xfstests/results//xfs/006-input-validation.full': No such file or directory

Thanks,
Eryu
