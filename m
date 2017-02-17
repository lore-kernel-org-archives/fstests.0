Received: from mail-ot0-f194.google.com ([74.125.82.194]:32866 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932322AbdBQHhz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Feb 2017 02:37:55 -0500
Received: by mail-ot0-f194.google.com with SMTP id t47so3872145ota.0
        for <fstests@vger.kernel.org>; Thu, 16 Feb 2017 23:37:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487306188-2097-7-git-send-email-xzhou@redhat.com>
References: <1487306188-2097-1-git-send-email-xzhou@redhat.com> <1487306188-2097-7-git-send-email-xzhou@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 17 Feb 2017 09:37:54 +0200
Message-ID: <CAOQ4uxgQVoxFxPQ_jjCGbUbjbNthf22+csBU+M-frvB2QsJZrg@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] overlay: test flock after copied up
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests <fstests@vger.kernel.org>, Miklos Szeredi <mszeredi@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Feb 17, 2017 at 6:36 AM, Xiong Zhou <xzhou@redhat.com> wrote:
> Locks of file in lower dir should working after it's
> been copied up.
>
> CC: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> ---
>  tests/overlay/028     | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/overlay/028.out |  2 ++
>  tests/overlay/group   |  1 +
>  3 files changed, 83 insertions(+)
>  create mode 100755 tests/overlay/028
>  create mode 100644 tests/overlay/028.out
>
> diff --git a/tests/overlay/028 b/tests/overlay/028
> new file mode 100755
> index 0000000..2e0995e
> --- /dev/null
> +++ b/tests/overlay/028
> @@ -0,0 +1,80 @@
> +#! /bin/bash
> +# FS QA Test 028
> +#
> +# When file in lower dir is locked and it's been copied up,
> +# make sure the lock is working in overlayfs.
> +#
> +# Kernel commit below fixed it.
> +# c568d68341be locks: fix file locking on overlayfs
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
> +lowerdir=$SCRATCH_DEV/$OVERLAY_LOWER_DIR
> +mkdir -p $lowerdir
> +touch $lowerdir/foo
> +
> +# Mounting overlay
> +_scratch_mount
> +
> +# Testing copyup and flock
> +flock $SCRATCH_MNT/foo sleep 5 &
> +# flock in subshell should fail with no output
> +(sleep 1; echo bar > $SCRATCH_MNT/foo; \
> +  flock -n $SCRATCH_MNT/foo echo LOCKED)

What I meant, though it does not change the correctness of the test,
is that echo is executed only if foo in NOT LOCKED, so its kind of
weird and may be confusing to readers, that echo writes LOCKED.

> +
> +wait

maybe kill %1 to save the impatient among us a few seconds of waiting...

> +echo "Silence is golden"
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/overlay/028.out b/tests/overlay/028.out
> new file mode 100644
> index 0000000..2615f73
> --- /dev/null
> +++ b/tests/overlay/028.out
> @@ -0,0 +1,2 @@
> +QA output created by 028
> +Silence is golden
> diff --git a/tests/overlay/group b/tests/overlay/group
> index 4db6751..cf058fc 100644
> --- a/tests/overlay/group
> +++ b/tests/overlay/group
> @@ -30,3 +30,4 @@
>  025 auto quick attr
>  026 auto attr quick
>  027 auto quick perms
> +028 auto copyup quick
> --
> 1.8.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
