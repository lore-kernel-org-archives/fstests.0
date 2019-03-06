Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:15638 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725790AbfCFVzR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 6 Mar 2019 16:55:17 -0500
Date: Thu, 7 Mar 2019 08:55:14 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] Add new xattr test 532
Message-ID: <20190306215514.GF26298@dastard>
References: <20190305043808.12093-1-lsahlber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305043808.12093-1-lsahlber@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Ronnie Sahlberg <lsahlber@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 05, 2019 at 02:38:08PM +1000, Ronnie Sahlberg wrote:
> This test is cloned from 097 but has had all the tests for trusted.*
> removed.
> This makes it possible to use this test on filesystems that can only
> provide user.* xattrs such as CIFS.

Looks mostly OK, Ronnie. Couple of minor things below.

> Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
> ---
>  tests/generic/532     | 144 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/532.out | 108 +++++++++++++++++++++++++++++++++++++
>  tests/generic/group   |   1 +
>  3 files changed, 253 insertions(+)
>  create mode 100755 tests/generic/532
>  create mode 100644 tests/generic/532.out
> 
> diff --git a/tests/generic/532 b/tests/generic/532
> new file mode 100755
> index 00000000..86adb3a6
> --- /dev/null
> +++ b/tests/generic/532
> @@ -0,0 +1,144 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2000-2004 Silicon Graphics, Inc.  All Rights Reserved.
> +# Copyright (c) 2017 Google, Inc.  All Rights Reserved.
> +# Copyright (c) 2019 Red Hat Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. 526. Modified from 097.

Put the "Modified from 097" in the long description below.

> +#
> +# simple attr tests for user. EAs:
> +#  - set
> +#  - get
> +#  - list
> +#  - remove
> +# Basic testing.

i.e. This is about all that is necessary:

# FS QA Test No. generic/526.
#
# Simple attr smoke tests for user EAs, dereived from generic/097.


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

Usual thing to do here with test files on the TEST_DIR is to append
the test number to them and then leave them hanging around.

> +
> +_cleanup()
> +{
> +	rm -f $tmp.* $file
> +}

i.e.

file=$TEST_DIR/foo.$seq

_cleanup()
{
	cd /
	rm -f $tmp.*
}

I think the test is also missing a:

rm -f $seqres.full

as part of the test initialisation.

> +echo -e "\ncreate file foo"
> +rm -f $file
> +touch $file

because the file is removed at the start of the test anyway.

> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -534,3 +534,4 @@
>  529 auto quick attr
>  530 auto quick unlink
>  531 auto quick unlink
> +532 attr auto quick

"auto quick attr" so the group order list is consistent with most of
the other lines in the file...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
