Received: from mx1.redhat.com ([209.132.183.28]:52936 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753536AbdBDEQz (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 3 Feb 2017 23:16:55 -0500
Date: Sat, 4 Feb 2017 12:15:26 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 1/2] generic/407: check that destination timestamps are
 updated on clone
Message-ID: <20170204041526.GF1859@eguan.usersys.redhat.com>
References: <20170203095839.8007-1-hch@lst.de>
 <20170203095839.8007-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170203095839.8007-2-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Feb 03, 2017 at 10:58:38AM +0100, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/generic/407     | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/407.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 88 insertions(+)
>  create mode 100755 tests/generic/407
>  create mode 100644 tests/generic/407.out
> 
> diff --git a/tests/generic/407 b/tests/generic/407
> new file mode 100755
> index 00000000..0fd111ca
> --- /dev/null
> +++ b/tests/generic/407
> @@ -0,0 +1,85 @@
> +#! /bin/bash
> +# FS QA Test No. 407
> +#
> +# Verify that mtime is updated when cloning files
> +#
> +#-----------------------------------------------------------------------
> +#
> +# Copyright (c) 2017 Christoph Hellwig.  All Rights Reserved.
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
> +status=0
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $sourcefile
> +	rm -f $destfile
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. common/reflink

For consistency, ". ./common/reflink" looks better.

> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +
> +_require_test
> +_require_test_reflink
> +_require_cp_reflink

This seems not necessary, cp is not used and xfs_io reflink command is
checked in _require_test_reflink.

Otherwise looks good to me. I can fix them at commit time.

Thanks,
Eryu
