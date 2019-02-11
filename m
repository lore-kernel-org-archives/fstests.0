Received: from mail-yb1-f193.google.com ([209.85.219.193]:41741 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfBKHPl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Feb 2019 02:15:41 -0500
Received: by mail-yb1-f193.google.com with SMTP id o81so3787830yba.8
        for <fstests@vger.kernel.org>; Sun, 10 Feb 2019 23:15:40 -0800 (PST)
MIME-Version: 1.0
References: <20190211051932.20542-1-lsahlber@redhat.com> <20190211051932.20542-2-lsahlber@redhat.com>
In-Reply-To: <20190211051932.20542-2-lsahlber@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 11 Feb 2019 09:15:28 +0200
Message-ID: <CAOQ4uxgEkG2hHXcLrc5mB0k5h9kw_QNSw-vJcABt0o7+qccvcA@mail.gmail.com>
Subject: Re: [PATCH] cifs: add test that setfattr -x fails non-existing EAs
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Ronnie Sahlberg <lsahlber@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Hi Ronnie,

CC the correct list <fstests@vger.kernel.org>

On Mon, Feb 11, 2019 at 7:21 AM Ronnie Sahlberg <lsahlber@redhat.com> wrote:
>
> We just fixed a bug in cifs.ko where it would incorrectly return success
> for setfattr -x user.does-not-exist.
>
> This patch adds a test case for this.
>
> Xfstests already have tests for setfattr -x in generic/097
> but we can not yet use that test for cifs since we can only support
> the user namespace.

Mmm... that's not a reason to write a cifs specific test.
1. Your test is not cifs specific so should be generic
2. There is a lot of other test coverage cifs is missing from generic/097

What I suggest is:
- implement _require_trusted_attrs
- replace _require_attrs with  _require_trusted_attrs in the few
  generic tests that use trusted xattrs
- I counted 5 generic tests and there is also generic/079 that
  sets trusted xattr via t_immutable and doesn't currently _require_attrs
  at all. Frankly, it looks like most of those test could use user.* xattrs,
  but whatever.
- Anyway, please stay away from the overlay trusted xattr tests.
- clone generic/097 to a new test that only _require_attrs
  leaving out the trusted xattrs

After that change, cifs will not fail on the trusted xattr tests
and instead those tests will be properly skipped for cifs.

Thanks,
Amir.

>
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
> +status=1       # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +file=$TEST_DIR/foo
> +
> +_cleanup()
> +{
> +       rm -f $tmp.* $file
> +}
> +
> +setfattr()
> +{
> +    echo $SETFATTR_PROG "$@" >>/tmp/foo
> +       $SETFATTR_PROG "$@" |& _filter_test_dir
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
> diff --git a/tests/cifs/002.out b/tests/cifs/002.out
> new file mode 100644
> index 00000000..163eb48a
> --- /dev/null
> +++ b/tests/cifs/002.out
> @@ -0,0 +1,6 @@
> +QA output created by 002
> +
> +create file foo
> +
> +unset EA <does-not-exist>:
> +setfattr: TEST_DIR/foo: No such attribute
> diff --git a/tests/cifs/group b/tests/cifs/group
> index 6d07b1c4..191e6a67 100644
> --- a/tests/cifs/group
> +++ b/tests/cifs/group
> @@ -4,3 +4,4 @@
>  # - comment line before each group is "new" description
>  #
>  001 auto quick
> +002 auto quick
> --
> 2.13.6
>
