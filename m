Received: from mx1.redhat.com ([209.132.183.28]:46394 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754350AbdIGHwY (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 7 Sep 2017 03:52:24 -0400
Date: Thu, 7 Sep 2017 15:52:21 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v3 11/13] fstests: regression test for ext4 crash
 consistency bug
Message-ID: <20170907075221.GO8034@eguan.usersys.redhat.com>
References: <1504638680-25682-1-git-send-email-amir73il@gmail.com>
 <1504638680-25682-12-git-send-email-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504638680-25682-12-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <jbacik@fb.com>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 05, 2017 at 10:11:18PM +0300, Amir Goldstein wrote:
> This test is motivated by a bug found in ext4 during random crash
> consistency tests.
> 
> This test uses device mapper flakey target to demonstrate the bug
> found using device mapper log-writes target.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  tests/generic/501     | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/501.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 83 insertions(+)
>  create mode 100755 tests/generic/501
>  create mode 100644 tests/generic/501.out
> 
> diff --git a/tests/generic/501 b/tests/generic/501
> new file mode 100755
> index 0000000..ccb513d
> --- /dev/null
> +++ b/tests/generic/501
> @@ -0,0 +1,80 @@
> +#! /bin/bash
> +# FS QA Test No. 501
> +#
> +# This test is motivated by a bug found in ext4 during random crash
> +# consistency tests.
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
> +	_cleanup_flakey
> +	cd /
> +	rm -f $tmp.*
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/dmflakey
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +_require_dm_target flakey
> +_require_metadata_journaling $SCRATCH_DEV

This should be moved after _scratch_mkfs, otherwise it's checking
scratch device from previous test.

> +
> +rm -f $seqres.full
> +
> +_scratch_mkfs >> $seqres.full 2>&1

Thanks,
Eryu

> +
> +_init_flakey
> +_mount_flakey
> +
> +fsxops=$tmp.fsxops
> +cat <<EOF > $fsxops
> +write 0x137dd 0xdc69 0x0
> +fallocate 0xb531 0xb5ad 0x21446
> +collapse_range 0x1c000 0x4000 0x21446
> +write 0x3e5ec 0x1a14 0x21446
> +zero_range 0x20fac 0x6d9c 0x40000 keep_size
> +mapwrite 0x216ad 0x274f 0x40000
> +EOF
> +run_check $here/ltp/fsx -d --replay-ops $fsxops $SCRATCH_MNT/testfile
> +
> +_flakey_drop_and_remount
> +_unmount_flakey
> +_cleanup_flakey
> +_check_scratch_fs
> +
> +echo "Silence is golden"
> +
> +status=0
> +exit
> diff --git a/tests/generic/501.out b/tests/generic/501.out
> new file mode 100644
> index 0000000..00133b6
> --- /dev/null
> +++ b/tests/generic/501.out
> @@ -0,0 +1,2 @@
> +QA output created by 501
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index c857153..1e1b524 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -458,3 +458,4 @@
>  453 auto quick dir
>  454 auto quick attr
>  500 auto log replay
> +501 auto quick metadata
> -- 
> 2.7.4
> 
