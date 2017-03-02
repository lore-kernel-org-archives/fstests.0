Received: from mx1.redhat.com ([209.132.183.28]:33412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750714AbdCBFjM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 2 Mar 2017 00:39:12 -0500
Date: Thu, 2 Mar 2017 13:32:01 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] generic/414: reflink concurrent operations
Message-ID: <20170302053201.GJ14226@eguan.usersys.redhat.com>
References: <1488377434-12064-1-git-send-email-nave.vardy@plexistor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488377434-12064-1-git-send-email-nave.vardy@plexistor.com>
Sender: fstests-owner@vger.kernel.org
To: Nave Vardy <nave.vardy@plexistor.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 01, 2017 at 04:10:34PM +0200, Nave Vardy wrote:
> reflink: concurrent operations test
> 
> perform read operation on the target file while
> doing write or fpunch operations on the reflinks.
> 
> Signed-off-by: Nave Vardy <nave.vardy@plexistor.com>
> ---
> 
> This is the V2 of [PATCH] generic/409: reflink concurrent operations
> 
> v2:
>  - change file's permissions to 755
>  - use _require_fs_space()
>  - use _get_block_size() instead of hard-coded 4096
>  - use _cp_reflink instead of cp --reflink
>  - increase loop concurrency by doing more preads from the target file
>  - remove test from group quick

Thanks for the update!

> 
>  tests/generic/414     | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/414.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 100 insertions(+)
>  create mode 100755 tests/generic/414
>  create mode 100644 tests/generic/414.out
> 
> diff --git a/tests/generic/414 b/tests/generic/414
> new file mode 100755
> index 0000000..d3c368b
> --- /dev/null
> +++ b/tests/generic/414
> @@ -0,0 +1,97 @@
> +#!/bin/bash
> +# FS QA Test No. 414
> +#
> +# test for races between write or fpunch operations on reflinked files
> +# to read operations on the target file
> +#
> +#-----------------------------------------------------------------------
> +#
> +# Copyright (c) 2017 Plexistor Ltd. All Rights Reserved.
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
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=0    # success is the default!
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
> +. ./common/reflink
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch_reflink
> +_require_cp_reflink
> +_require_fs_space $SCRATCH_MNT $((250 * 1024))

We should check SCRATCH_MNT free space *after* mounting SCRATCH_DEV,
i.e. _scratch_mount

> +
> +_scratch_mkfs_sized $((250 * 1024 ** 2)) >> $seqres.full 2>&1 \

We use _require_fs_space to make sure there's enough space, no need to
mkfs a specific sized filesystem then.

> +					|| _fail "mkfs failed"
> +_scratch_mount || _fail "mount failed"

So this part should be like:

_scratch_mkfs
_scratch_mount
_require_fs_space $SCRATCH_MNT $((250 * 1024))

> +
> +echo "Silence is golden"
> +
> +workfile=${SCRATCH_MNT}/workfile
> +light_clone=${SCRATCH_MNT}/light_clone
> +
> +file_size=$((10 * 1024 * 1024))
> +bs=`_get_block_size $SCRATCH_MNT`
> +block_num=$((file_size / bs))
> +reflinks_num=20
> +
> +$XFS_IO_PROG -f -c "pwrite 0 $file_size" $workfile >> $seqres.full
> +
> +for ((i=1; i<=reflinks_num; i++));
> +do

fstests prefers putting "do" to the end of for loop :)

No need to send a new version, I can fix them at commit time.

Thanks,
Eryu
