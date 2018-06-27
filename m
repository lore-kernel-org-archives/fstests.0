Received: from mail-yw0-f194.google.com ([209.85.161.194]:33808 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752642AbeF0LHR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jun 2018 07:07:17 -0400
Received: by mail-yw0-f194.google.com with SMTP id n187-v6so552607ywd.1
        for <fstests@vger.kernel.org>; Wed, 27 Jun 2018 04:07:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180627082103.9662-2-david@fromorbit.com>
References: <20180627082103.9662-1-david@fromorbit.com> <20180627082103.9662-2-david@fromorbit.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 27 Jun 2018 14:07:16 +0300
Message-ID: <CAOQ4uxi9p5AG9x1ZGi3p=fAf1exVBZLJxU9agGZUV112idOaYg@mail.gmail.com>
Subject: Re: [PATCH 1/8] fstests: generic test setup preamble
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 27, 2018 at 11:20 AM, Dave Chinner <david@fromorbit.com> wrote:
> From: Dave Chinner <dchinner@redhat.com>
>
> So many tests chop random bits out of the mandaotry test setup
> preamble which leads to subtle problems and stray files being dumped
> all over the place. Create a common test preamble with hooks for
> local cleanup functions so we can prevent this in future.
>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  common/setup_test | 31 +++++++++++++++++++++++++++++++
>  new               | 35 ++++++++---------------------------
>  soak              | 19 +++++++------------
>  3 files changed, 46 insertions(+), 39 deletions(-)
>  create mode 100644 common/setup_test
>
> diff --git a/common/setup_test b/common/setup_test
> new file mode 100644
> index 000000000000..f25ed11c2306
> --- /dev/null
> +++ b/common/setup_test
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# common test setup preamble
> +# test specific cleanup is done via the cleanup() function now.
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1       # failure is the default!
> +trap "_cleanup_test; exit \$status" 0 1 2 3 15
> +
> +_cleanup_test()
> +{
> +       # call local test cleanup function first, then cleanup tmp files
> +       cleanup
> +       cd /
> +       rm -f $tmp.*
> +}
> +
> +_success()
> +{
> +       status=0
> +       exit
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> diff --git a/new b/new
> index 2bb8ce5055c1..1f11fdad1b8c 100755
> --- a/new
> +++ b/new
> @@ -9,12 +9,11 @@
>  iam=new
>  . ./common/test_names
>
> -trap "rm -f /tmp/$$.; exit" 0 1 2 3 15
>
> -_cleanup()
> -{
> -    :
> +_cleanup() {
> +       rm -f /tmp/$$.
>  }
> +trap "_cleanup; exit" 0 1 2 3 15
>

1. that looks like a bug in 'new' cleanup.
    should be rm -f /tmp/$$.* (or /tmp/$$.group)
2. if we are going with convention that local cleanup is
    without _, may as well stick with this convention here as well
    even though we are not sourcing setup_test

Thanks,
Amir.
