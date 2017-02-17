Received: from mail-ot0-f194.google.com ([74.125.82.194]:35690 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755711AbdBQHTL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Feb 2017 02:19:11 -0500
Received: by mail-ot0-f194.google.com with SMTP id y13so3830019oty.2
        for <fstests@vger.kernel.org>; Thu, 16 Feb 2017 23:19:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487306188-2097-1-git-send-email-xzhou@redhat.com>
References: <1487306188-2097-1-git-send-email-xzhou@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 17 Feb 2017 09:19:09 +0200
Message-ID: <CAOQ4uxiAEoKOELYFxoMCBLVc+e3gqdrb7F=CMq2OGdvN8QNBFA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] overlay: disallow overlayfs as upperdir
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests <fstests@vger.kernel.org>, Miklos Szeredi <mszeredi@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Feb 17, 2017 at 6:36 AM, Xiong Zhou <xzhou@redhat.com> wrote:
> Using overlayfs dir as upperdir to mount another
> overlayfs should fail.
>
> CC: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> ---
>  tests/overlay/022     | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/overlay/022.out |  2 ++
>  tests/overlay/group   |  1 +
>  3 files changed, 85 insertions(+)
>  create mode 100755 tests/overlay/022
>  create mode 100644 tests/overlay/022.out
>
> diff --git a/tests/overlay/022 b/tests/overlay/022
> new file mode 100755
> index 0000000..ee1d1e5
> --- /dev/null
> +++ b/tests/overlay/022
> @@ -0,0 +1,82 @@
> +#! /bin/bash
> +# FS QA Test 022
> +#
> +# Regression test for kernel commit:
> +#     76bc8e2 ovl: disallow overlayfs as upperdir
> +#
> +# This reproducer was originally written by
> +#     Miklos Szeredi <mszeredi@redhat.com>
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2017 Red Hat Inc. All Rights Reserved.
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
> +       rm -rf $tmp/{lower,mnt}
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
> +upperdir=$SCRATCH_DEV/$OVERLAY_UPPER_DIR
> +mkdir -p $upperdir/upper
> +mkdir -p $upperdir/work
> +# mount overlay with dirs in upper
> +_scratch_mount
> +
> +mkdir -p $tmp/{lower,mnt}
> +# mount overlay using upper from another overlay upper
> +# should fail
> +_overlay_mount_dirs $tmp/lower $SCRATCH_MNT/upper \
> +  $SCRATCH_MNT/work overlay $tmp/mnt > /dev/null 2>&1
> +if [ $? -ne 0 ] ; then
> +       echo "Silence is golden"
> +else
> +       echo "Test Fail"
> +       echo "Overlay upperdir can't be another overlay upperdir"
> +       $UMOUNT_PROG $tmp/mnt

Better unmount and rm -rf $tmp in cleanup()
to be sure we are not leaving a dangling tmpfs mount

> +fi
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/overlay/022.out b/tests/overlay/022.out
> new file mode 100644
> index 0000000..394c6a7
> --- /dev/null
> +++ b/tests/overlay/022.out
> @@ -0,0 +1,2 @@
> +QA output created by 022
> +Silence is golden
> diff --git a/tests/overlay/group b/tests/overlay/group
> index 5bcc25e..45768f5 100644
> --- a/tests/overlay/group
> +++ b/tests/overlay/group
> @@ -24,3 +24,4 @@
>  019 auto stress
>  020 auto quick copyup perms
>  021 auto quick copyup
> +022 auto quick
> --
> 1.8.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
