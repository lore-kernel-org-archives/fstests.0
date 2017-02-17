Received: from mail-ot0-f195.google.com ([74.125.82.195]:33325 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755057AbdBQH3U (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Feb 2017 02:29:20 -0500
Received: by mail-ot0-f195.google.com with SMTP id t47so3859450ota.0
        for <fstests@vger.kernel.org>; Thu, 16 Feb 2017 23:29:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487306188-2097-4-git-send-email-xzhou@redhat.com>
References: <1487306188-2097-1-git-send-email-xzhou@redhat.com> <1487306188-2097-4-git-send-email-xzhou@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 17 Feb 2017 09:29:18 +0200
Message-ID: <CAOQ4uxie4S-YVu61foCqERq_z41p89zwCv43Kn+its1HPJvqGg@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] overlay: permission check with cached acls in tmpfs
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests <fstests@vger.kernel.org>, Miklos Szeredi <mszeredi@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Feb 17, 2017 at 6:36 AM, Xiong Zhou <xzhou@redhat.com> wrote:
> tmpfs does not implement ->get_acl method, overlayfs
> need to get its cached acls in permission check when
> lower or upper fs is tmpfs.
>
> CC: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> ---
>  tests/overlay/025     | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/overlay/025.out |  2 ++
>  tests/overlay/group   |  1 +
>  3 files changed, 88 insertions(+)
>  create mode 100755 tests/overlay/025
>  create mode 100644 tests/overlay/025.out
>
> diff --git a/tests/overlay/025 b/tests/overlay/025
> new file mode 100755
> index 0000000..ad3ebe1
> --- /dev/null
> +++ b/tests/overlay/025
> @@ -0,0 +1,85 @@
> +#! /bin/bash
> +# FS QA Test 025
> +#
> +# Overlayfs failed to get posix acls if lower or upper
> +# fs is tmpfs.
> +# Kernel commit below fixed it.
> +# 5201dc449e4b ovl: use cached acl on underlying layer
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
> +       $UMOUNT_PROG $tmp/tmpfs/mnt
> +       $UMOUNT_PROG $tmp/tmpfs
> +       rm -rf $tmp/tmpfs

rm -rf $tmp

> +       rm -f $tmp.*

I am not so sure you need that anymore since your test is not creating
$tmp.* files.
I think Eryu cleaned up the common functions that create $tmp.* files?
anyway, not all tests have that - only most of them - see for example
generic/251

Eryu?

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
> +_require_user
> +
> +# create a tmpfs under $tmp
> +mkdir -p $tmp/tmpfs
> +$MOUNT_PROG -t tmpfs tmpfs $tmp/tmpfs || \
> +  _notrun "this test requires a valid tmpfs"
> +
> +pushd $tmp/tmpfs > /dev/null 2>&1
> +
> +mkdir -p lower upper work mnt
> +mkdir -p -m 0 upper/testd
> +# grant permission for $qa_user
> +setfacl -m u:$qa_user:rx upper/testd
> +
> +# mount overlay using dirs in tmpfs
> +_overlay_mount_dirs lower upper work overlay mnt
> +
> +popd > /dev/null 2>&1
> +
> +# user accessing test dir, should be Okay
> +_user_do "ls $tmp/tmpfs/mnt/testd"
> +
> +echo "Silence is golden"
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/overlay/025.out b/tests/overlay/025.out
> new file mode 100644
> index 0000000..3d70951
> --- /dev/null
> +++ b/tests/overlay/025.out
> @@ -0,0 +1,2 @@
> +QA output created by 025
> +Silence is golden
> diff --git a/tests/overlay/group b/tests/overlay/group
> index 0563a04..82fe69e 100644
> --- a/tests/overlay/group
> +++ b/tests/overlay/group
> @@ -27,3 +27,4 @@
>  022 auto quick
>  023 auto quick attr
>  024 auto quick
> +025 auto quick attr
> --
> 1.8.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
