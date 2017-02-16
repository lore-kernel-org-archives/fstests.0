Received: from mail-ot0-f194.google.com ([74.125.82.194]:34433 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753618AbdBPMVq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Feb 2017 07:21:46 -0500
Received: by mail-ot0-f194.google.com with SMTP id 73so1492169otj.1
        for <fstests@vger.kernel.org>; Thu, 16 Feb 2017 04:21:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487236435-6222-8-git-send-email-xzhou@redhat.com>
References: <1487236435-6222-1-git-send-email-xzhou@redhat.com> <1487236435-6222-8-git-send-email-xzhou@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 16 Feb 2017 14:21:45 +0200
Message-ID: <CAOQ4uxhMa+u53gvQ2UbVj33SuYbaHF0HM2y5ik_151H6pM6crg@mail.gmail.com>
Subject: Re: [PATCH 8/8] overlay: accessing stacked overlayfs files
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests <fstests@vger.kernel.org>, Miklos Szeredi <mszeredi@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Feb 16, 2017 at 11:13 AM, Xiong Zhou <xzhou@redhat.com> wrote:
> Lower dir comes from another overlayfs dir, then
> accessing files in it should work.
>
> CC: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> ---
>  tests/overlay/029     | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/overlay/029.out |  3 ++
>  tests/overlay/group   |  1 +
>  3 files changed, 96 insertions(+)
>  create mode 100755 tests/overlay/029
>  create mode 100644 tests/overlay/029.out
>
> diff --git a/tests/overlay/029 b/tests/overlay/029
> new file mode 100755
> index 0000000..aedd141
> --- /dev/null
> +++ b/tests/overlay/029
> @@ -0,0 +1,92 @@
> +#! /bin/bash
> +# FS QA Test 029
> +#
> +# There are dirs/files in lower dir and upper dir before
> +# mounting overlayfs. After mounting, use dir in overlayfs
> +# mountpoint as lowerdir to mount another overlayfs, then
> +# access old files through the second overlayfs. It was
> +# not working, kernel commit below fixed it.
> +#
> +# c4fcfc1619ea ovl: fix d_real() for stacked fs
> +#
> +# This reproducer was originally written by
> +#     Miklos Szeredi <mszeredi@redhat.com>
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2017 Red Hat Inc.  All Rights Reserved.
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
> +status=1       # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +       cd /
> +       rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs overlay
> +_supported_os Linux
> +_require_scratch
> +
> +# Remove all files from previous tests
> +_scratch_mkfs
> +
> +# Preparing files
> +upperdir=$SCRATCH_DEV/$OVERLAY_UPPER_DIR
> +lowerdir=$SCRATCH_DEV/$OVERLAY_LOWER_DIR
> +mkdir -p $upperdir/up
> +echo foo > $upperdir/up/foo
> +mkdir -p $lowerdir/low
> +echo bar > $lowerdir/low/bar
> +
> +# mount overlay in SCRATCH_MNT
> +_scratch_mount
> +
> +mkdir -p $tmp/{upper,mnt,work}
> +# mount overlay again using lower dir from SCRATCH_MNT dir
> +_overlay_mount_dirs $SCRATCH_MNT/up $tmp/{upper,work} \

comment and code mismatch lower vs. up

> +  overlay $tmp/mnt
> +# accessing file in the second mount
> +cat $tmp/mnt/foo
> +$UMOUNT_PROG $tmp/mnt
> +

cleanup mount and $tmp/mnt on cleanup()

> +# mount overlay again using upper dir from SCRATCH_MNT dir
> +_overlay_mount_dirs $SCRATCH_MNT/low $tmp/{upper,work} \

comment and code mismatch upper vs. low

> +  overlay $tmp/mnt
> +cat $tmp/mnt/bar
> +$UMOUNT_PROG $tmp/mnt
> +


Suggesting to add:
_overlay_mount_dirs $SCRATCH_MNT/ $tmp/{upper,work} \
  overlay $tmp/mnt
cat $tmp/mnt/up/foo
cat $tmp/mnt/low/bar

This differs from the 2 tests above in 2 ways:
1. $SCRATCH_MNT/ is an overlay root
2. $SCRATCH_MNT/ is a merge dir

You may want to further split these 2 cases by creating up and low under
a common 'ovl' base dir and testing both on $SCRATCH_MNT/ and
$SCRATCH_MNT/ovl - not critical IMO.



> +# success, all done
> +status=0
> +exit
> diff --git a/tests/overlay/029.out b/tests/overlay/029.out
> new file mode 100644
> index 0000000..870fcd9
> --- /dev/null
> +++ b/tests/overlay/029.out
> @@ -0,0 +1,3 @@
> +QA output created by 029
> +foo
> +bar
> diff --git a/tests/overlay/group b/tests/overlay/group
> index cf058fc..7e72a30 100644
> --- a/tests/overlay/group
> +++ b/tests/overlay/group
> @@ -31,3 +31,4 @@
>  026 auto attr quick
>  027 auto quick perms
>  028 auto copyup quick
> +029 auto quick
> --
> 1.8.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
