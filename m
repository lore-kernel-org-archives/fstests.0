Received: from mx1.redhat.com ([209.132.183.28]:42077 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017AbcGPJeB (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 16 Jul 2016 05:34:01 -0400
Date: Sat, 16 Jul 2016 17:33:58 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 6/6] xfstests: Add mkfs input validation tests
Message-ID: <20160716093358.GL2432@eguan.usersys.redhat.com>
References: <1468500214-6237-1-git-send-email-jtulak@redhat.com>
 <1468500214-6237-7-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1468500214-6237-7-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jan Tulak <jtulak@redhat.com>
Cc: fstests@vger.kernel.org, Dave Chinner <david@fromorbit.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 14, 2016 at 02:43:34PM +0200, Jan Tulak wrote:
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
> Use common/rc feature check for mkfs version testing.
> 
> Cheers,
> Jan
> 
> Signed-off-by: Jan Tulak <jtulak@redhat.com>
> ---
>  tests/xfs/400-input-validation     | 338 +++++++++++++++++++++++++++++++++++++
>  tests/xfs/400-input-validation.out |   2 +
>  tests/xfs/group                    |   1 +
>  3 files changed, 341 insertions(+)
>  create mode 100755 tests/xfs/400-input-validation
>  create mode 100644 tests/xfs/400-input-validation.out
> 
> diff --git a/tests/xfs/400-input-validation b/tests/xfs/400-input-validation
> new file mode 100755
> index 0000000..83a4ff9
> --- /dev/null
> +++ b/tests/xfs/400-input-validation
> @@ -0,0 +1,338 @@
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
[snip]
> +do_mkfs_fail -l internal=1,logdev=$fsimg $SCRATCH_DEV
> +do_mkfs_fail -l lazy-count=1garbage $SCRATCH_DEV
> +do_mkfs_fail -l lazy-count=2 $SCRATCH_DEV
> +do_mkfs_fail -l lazy-count=0 -m crc=1 $SCRATCH_DEV
> +do_mkfs_fail -l version=1 -m crc=1 $SCRATCH_DEV

This test fails in my DAX testing, where SCRATCH_DEV is ramdisk. The
mkfs itself should fail, but it passed. Log version 2 was used
automatically, instead of prompting "V2 logs always enabled for CRC
enabled filesytems"

[root@dhcp-66-86-11 xfstests]# mkfs -t xfs -f -l version=1 -m crc=1 /dev/ram0
meta-data=/dev/ram0              isize=512    agcount=1, agsize=4096 blks
         =                       sectsz=4096  attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=0
data     =                       bsize=4096   blocks=4096, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=1605, version=2
         =                       sectsz=4096  sunit=1 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0

Is it a mkfs.xfs bug or the test case should handle the special case?

Thanks,
Eryu
