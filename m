Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:6376 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726074AbfBKVvV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Feb 2019 16:51:21 -0500
Date: Tue, 12 Feb 2019 08:51:17 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] cifs: add test that setfattr -x fails non-existing EAs
Message-ID: <20190211215117.GG20493@dastard>
References: <20190211051932.20542-1-lsahlber@redhat.com>
 <20190211051932.20542-2-lsahlber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211051932.20542-2-lsahlber@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Ronnie Sahlberg <lsahlber@redhat.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

[cc fstests@vger.kernel.org]

Hi Ronnie,

Probably better to send this (and any followups) to the fstests
list... :)

On Mon, Feb 11, 2019 at 03:19:32PM +1000, Ronnie Sahlberg wrote:
> We just fixed a bug in cifs.ko where it would incorrectly return success
> for setfattr -x user.does-not-exist.
> 
> This patch adds a test case for this.
> 
> Xfstests already have tests for setfattr -x in generic/097
> but we can not yet use that test for cifs since we can only support
> the user namespace.

'the "user." xattr namespace.'

"user namespace" is an overloaded term.

> Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
> ---
>  tests/cifs/002     | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/cifs/002.out |  6 ++++++
>  tests/cifs/group   |  1 +
>  3 files changed, 60 insertions(+)
>  create mode 100755 tests/cifs/002
>  create mode 100644 tests/cifs/002.out
> 
> diff --git a/tests/cifs/002 b/tests/cifs/002
> new file mode 100755
> index 00000000..80baa66a
> --- /dev/null
> +++ b/tests/cifs/002
> @@ -0,0 +1,53 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2000-2004 Silicon Graphics, Inc.  All Rights Reserved.
> +# Copyright (c) 2017 Google, Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. 002. Modified from generic/097
> +#
> +# simple attr test for deleting a non-existing EA:
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +file=$TEST_DIR/foo
> +
> +_cleanup()
> +{
> +	rm -f $tmp.* $file
> +}
> +
> +setfattr()
> +{
> +    echo $SETFATTR_PROG "$@" >>/tmp/foo

Why? And it doesn't get cleaned up on test exit, either.

> +	$SETFATTR_PROG "$@" |& _filter_test_dir
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/attr
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +
> +_require_test
> +_require_attrs
> +
> +echo -e "\ncreate file foo"
> +rm -f $file
> +touch $file
> +
> +echo -e "\nunset EA <does-not-exist>:"
> +setfattr -x user.does-not-exist $file
> +
> +# success, all done
> +status=0
> +exit

I don't see anything cifs specific in this test.

And why just test this one specific thing you found a bug in? Why
not just copy all of generic/097 and chop out all the non-"user."
xattr namespace bits so you exercise all the different xattr
operations?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
