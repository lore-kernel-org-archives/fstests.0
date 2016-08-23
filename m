Received: from mail-ua0-f174.google.com ([209.85.217.174]:34787 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758098AbcHWWFF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 23 Aug 2016 18:05:05 -0400
Received: by mail-ua0-f174.google.com with SMTP id k90so268985225uak.1
        for <fstests@vger.kernel.org>; Tue, 23 Aug 2016 15:05:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1471989099-19099-1-git-send-email-agruenba@redhat.com>
References: <1471989099-19099-1-git-send-email-agruenba@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 24 Aug 2016 00:05:03 +0200
Message-ID: <CAHc6FU4QmR+VLrX3arCdk=Kp-Wya6N+w7PaQayPS2SJo1WYfLw@mail.gmail.com>
Subject: Re: [PATCH] generic/375: Check clearing of SGID in chmod and acl_set_file
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>, Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

On Tue, Aug 23, 2016 at 11:51 PM, Andreas Gruenbacher
<agruenba@redhat.com> wrote:
> Check if SGID is cleared upon chmod / setfacl when the owner is not in
> the owning group.  As of today, the kernel fails to clear SGID in
> setxattr (which is what acl_set_file is implemented on top of) in that
> case; see this patch:
>   https://patchwork.kernel.org/patch/9290507/
>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> Cc: Jan Kara <jack@suse.cz>
> ---
>  tests/generic/375     | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/375.out |  9 ++++++
>  tests/generic/group   |  1 +
>  3 files changed, 90 insertions(+)
>  create mode 100755 tests/generic/375
>  create mode 100644 tests/generic/375.out
>
> diff --git a/tests/generic/375 b/tests/generic/375
> new file mode 100755
> index 0000000..9976c3d
> --- /dev/null
> +++ b/tests/generic/375
> @@ -0,0 +1,80 @@
> +#! /bin/bash
> +# FS QA Test 375
> +#
> +# Check if SGID is cleared upon chmod / setfacl when the owner is not in the
> +# owning group.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2016 Red Hat.  All Rights Reserved.
> +#
> +# Author: Andreas gruenbacher <agruenba@redhat.com>
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
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +_require_test
> +_require_runas
> +
> +cd $TEST_DIR
> +rm -f testfile
> +
> +touch testfile
> +chown 100:100 testfile
> +
> +echo '*** SGID should remain set (twice)'
> +chmod 2755 testfile
> +_runas -u 100 -g 100 -- chmod 2777 testfile
> +stat -c %A testfile
> +chmod 2755 testfile
> +_runas -u 100 -g 100 -- setfacl -m u::rwx,g::rwx,o::rwx testfile
> +stat -c %A testfile
> +
> +echo '*** SGID should be cleared (twice)'
> +chmod 2755 testfile
> +_runas -u 100 -g 101 -- chmod 2777 testfile
> +stat -c %A testfile
> +chmod 2755 testfile
> +_runas -u 100 -g 101 -- setfacl -m u::rwx,g::rwx,o::rwx testfile
> +stat -c %A testfile
> +
> +echo '*** Expected failure'
> +_runas -u 101 -g 101 -- chmod 2777 testfile
> +
> +status=0
> +exit
> diff --git a/tests/generic/375.out b/tests/generic/375.out
> new file mode 100644
> index 0000000..fe812f3
> --- /dev/null
> +++ b/tests/generic/375.out
> @@ -0,0 +1,9 @@
> +QA output created by 375
> +*** SGID should remain set (twice)
> +-rwxrwsrwx
> +-rwxrwsrwx
> +*** SGID should be cleared (twice)
> +-rwxrwxrwx
> +-rwxrwxrwx
> +*** Expected failure
> +chmod: changing permissions of 'f': Operation not permitted

Argh, the above should have been:

chmod: changing permissions of 'testfile': Operation not permitted

> diff --git a/tests/generic/group b/tests/generic/group
> index ef38c35..2d833a2 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -377,3 +377,4 @@
>  372 auto quick clone
>  373 auto quick clone
>  374 auto quick clone dedupe
> +375 auto quick acl
> --
> 2.7.4
>

Thanks,
Andreas
