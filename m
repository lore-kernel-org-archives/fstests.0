Received: from mail-ot0-f196.google.com ([74.125.82.196]:33397 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932120AbdBPLtB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Feb 2017 06:49:01 -0500
Received: by mail-ot0-f196.google.com with SMTP id t47so1420673ota.0
        for <fstests@vger.kernel.org>; Thu, 16 Feb 2017 03:49:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487236435-6222-3-git-send-email-xzhou@redhat.com>
References: <1487236435-6222-1-git-send-email-xzhou@redhat.com> <1487236435-6222-3-git-send-email-xzhou@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 16 Feb 2017 13:48:59 +0200
Message-ID: <CAOQ4uxgdEpbUYE0bsk8ANgofpnVLuy3GfbTfEu1_sNSxUAr8yg@mail.gmail.com>
Subject: Re: [PATCH 3/8] overlay: test workdir cleanup in mounting
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests <fstests@vger.kernel.org>, Miklos Szeredi <mszeredi@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Feb 16, 2017 at 11:13 AM, Xiong Zhou <xzhou@redhat.com> wrote:
> "work" directory in workdir should be cleaned up
> and recreated while overlayfs mounting. Or overlayfs
> will be mounted read-only.
>
> CC: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> ---
>  tests/overlay/024     | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/overlay/024.out |  2 ++
>  tests/overlay/group   |  1 +
>  3 files changed, 78 insertions(+)
>  create mode 100755 tests/overlay/024
>  create mode 100644 tests/overlay/024.out
>
> diff --git a/tests/overlay/024 b/tests/overlay/024
> new file mode 100755
> index 0000000..a1d306e
> --- /dev/null
> +++ b/tests/overlay/024
> @@ -0,0 +1,75 @@
> +#! /bin/bash
> +# FS QA Test 024
> +#
> +# "work" directory under workdir should be cleaned up
> +# well on overlayfs startup, or overlayfs will be mounted
> +# read-only.
> +# Kernel commit below fixes it.
> +# eea2fb4851e9 ovl: proper cleanup of workdir
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
> +# making workdir
> +wkdir=$SCRATCH_DEV/$OVERLAY_WORK_DIR
> +mkdir -p $wkdir/work/foo
> +
> +_scratch_mount
> +
> +# try writing to mountpoint
> +touch $SCRATCH_MNT/bar
> +

This doesn't really prove that workdir was cleaned, only that overlay mount
did not error.

Maybe also check that $wkdir/work/foo was really removed?

> +echo "Silence is golden"
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/overlay/024.out b/tests/overlay/024.out
> new file mode 100644
> index 0000000..fd6fbb1
> --- /dev/null
> +++ b/tests/overlay/024.out
> @@ -0,0 +1,2 @@
> +QA output created by 024
> +Silence is golden
> diff --git a/tests/overlay/group b/tests/overlay/group
> index 09da1be..0563a04 100644
> --- a/tests/overlay/group
> +++ b/tests/overlay/group
> @@ -26,3 +26,4 @@
>  021 auto quick copyup
>  022 auto quick
>  023 auto quick attr
> +024 auto quick
> --
> 1.8.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
