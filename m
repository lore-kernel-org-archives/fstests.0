Received: from mx1.redhat.com ([209.132.183.28]:43754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754552AbdIGHzN (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 7 Sep 2017 03:55:13 -0400
Date: Thu, 7 Sep 2017 15:55:11 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v3 13/13] fstests: regression test for xfs leftover CoW
 extent error
Message-ID: <20170907075511.GP8034@eguan.usersys.redhat.com>
References: <1504638680-25682-1-git-send-email-amir73il@gmail.com>
 <1504638680-25682-14-git-send-email-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504638680-25682-14-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <jbacik@fb.com>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 05, 2017 at 10:11:20PM +0300, Amir Goldstein wrote:
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Better to have some more descriptions or background information on this
test, either in commit log or in test description.

> ---
>  tests/generic/503     | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/503.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 72 insertions(+)
>  create mode 100755 tests/generic/503
>  create mode 100644 tests/generic/503.out
> 
> diff --git a/tests/generic/503 b/tests/generic/503
> new file mode 100755
> index 0000000..ebda756
> --- /dev/null
> +++ b/tests/generic/503
> @@ -0,0 +1,69 @@
> +#! /bin/bash
> +# FS QA Test No. 503
> +#
> +# Regression test for xfs leftover CoW extents error
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (C) 2017 CTERA Networks. All Rights Reserved.
> +# Author: Amir Goldstein <amir73il@gmail.com>
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
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/reflink
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch_reflink
> +_require_cp_reflink
> +
> +rm -f $seqres.full
> +
> +_scratch_mkfs >/dev/null 2>&1
> +_scratch_mount
> +
> +$XFS_IO_PROG -f -c "pwrite 0 0x40000" \
> +	$SCRATCH_MNT/foo > /dev/null 2>&1
> +
> +cp --reflink $SCRATCH_MNT/foo $SCRATCH_MNT/bar

_cp_reflink

> +
> +$XFS_IO_PROG -f -c "fzero -k 0x169f 0x387c" \
> +		-c "fcollapse 0x29000 0xd000" \
> +		-c "finsert 0 0x8000" \
> +		-c "truncate 0x8000" \
> +	$SCRATCH_MNT/foo > /dev/null 2>&1

_require_xfs_io_command these commands first, fzero, fcollapse, finsert.

Above two nits apply to generic/502 too.

Thanks,
Eryu

> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/503.out b/tests/generic/503.out
> new file mode 100644
> index 0000000..6c1400a
> --- /dev/null
> +++ b/tests/generic/503.out
> @@ -0,0 +1,2 @@
> +QA output created by 503
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 4324775..7a9cd78 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -460,3 +460,4 @@
>  500 auto log replay
>  501 auto quick metadata
>  502 auto log replay clone
> +503 auto quick clone
> -- 
> 2.7.4
> 
