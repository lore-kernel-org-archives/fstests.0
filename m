Received: from mail-ot0-f196.google.com ([74.125.82.196]:36787 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753285AbdBPMlR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Feb 2017 07:41:17 -0500
Received: by mail-ot0-f196.google.com with SMTP id l26so1530379ota.3
        for <fstests@vger.kernel.org>; Thu, 16 Feb 2017 04:41:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487236435-6222-5-git-send-email-xzhou@redhat.com>
References: <1487236435-6222-1-git-send-email-xzhou@redhat.com> <1487236435-6222-5-git-send-email-xzhou@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 16 Feb 2017 14:41:16 +0200
Message-ID: <CAOQ4uxif0Z_xnxOr_jKqwYeVF4rHbX78X5hYY=wrGUOq_eA6ag@mail.gmail.com>
Subject: Re: [PATCH 5/8] overlay: filter out xattr starts with "trusted.overlay."
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests <fstests@vger.kernel.org>, Miklos Szeredi <mszeredi@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Feb 16, 2017 at 11:13 AM, Xiong Zhou <xzhou@redhat.com> wrote:
> Not "trusted.overlay".
>   "trusted.overlayxxx" is allowed.
>   "trusted.overlay.xxx" is not allowed.
>
> CC: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> ---
>  tests/overlay/026     | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/overlay/026.out |  2 ++
>  tests/overlay/group   |  1 +
>  3 files changed, 91 insertions(+)
>  create mode 100755 tests/overlay/026
>  create mode 100644 tests/overlay/026.out
>
> diff --git a/tests/overlay/026 b/tests/overlay/026
> new file mode 100755
> index 0000000..d409286
> --- /dev/null
> +++ b/tests/overlay/026
> @@ -0,0 +1,88 @@
> +#! /bin/bash
> +# FS QA Test 026
> +#
> +# Overlayfs should only filter out xattr starting with
> +# "trusted.overlay.", not "trusted.overlay".
> +# Setting acls like "trusted.overlay.xxx" is not allowed.
> +# Setting acls like "trusted.overlayxxx" is allowed.

Those are not acls. they are xattr.

> +#
> +# Kernel commit below fixed it.
> +# fe2b75952347 ovl: Fix OVL_XATTR_PREFIX
> +#

That commit also changes the behavior of getxattr, so maybe check
that as well is this test.

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
> +. ./common/attr
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
> +_require_attrs
> +
> +# Remove all files from previous tests
> +_scratch_mkfs
> +
> +# Mounting overlay
> +_scratch_mount
> +touch $SCRATCH_MNT/testf0
> +touch $SCRATCH_MNT/testf1
> +
> +# The first setfattr should pass silently
> +$SETFATTR_PROG -n "trusted.overlayfsrz" -v "n" \
> +  $SCRATCH_MNT/testf0
> +

Suggesting to add:
$GETFATTR_PROG -n "trusted.overlayxxx" \
  $SCRATCH_MNT/testf0 2>&1 | grep "No such attribute" | _filter_scratch

and expect "No such attribute" in output.
either "not supported" or "not permitted" will fail to match the output.

> +# The second setfattr should fail, the reason not using
> +# filter SCRATCH here is errno returned varies between
> +# kernel versions, "not supported" vs "not permitted".
> +$SETFATTR_PROG -n "trusted.overlay.fsz" -v "n" \
> +  $SCRATCH_MNT/testf1 > /dev/null 2>&1
> +if [ $? -eq 0 ] ; then
> +       echo "Test Fail"
> +else
> +       echo "Silence is golden"
> +fi

For $GETFATTR_PROG -n "trusted.overlay.xxx"
you can also grep for "No such attribute" and expect no output.

> +# success, all done
> +status=0
> +exit
> diff --git a/tests/overlay/026.out b/tests/overlay/026.out
> new file mode 100644
> index 0000000..e45c6a3
> --- /dev/null
> +++ b/tests/overlay/026.out
> @@ -0,0 +1,2 @@
> +QA output created by 026
> +Silence is golden
> diff --git a/tests/overlay/group b/tests/overlay/group
> index 82fe69e..92afa8d 100644
> --- a/tests/overlay/group
> +++ b/tests/overlay/group
> @@ -28,3 +28,4 @@
>  023 auto quick attr
>  024 auto quick
>  025 auto quick attr
> +026 auto attr quick
> --
> 1.8.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
