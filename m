Received: from mail-ot0-f196.google.com ([74.125.82.196]:36259 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbdBEICF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 5 Feb 2017 03:02:05 -0500
Received: by mail-ot0-f196.google.com with SMTP id 36so7090198otx.3
        for <fstests@vger.kernel.org>; Sun, 05 Feb 2017 00:02:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170205065336.14994-1-tytso@mit.edu>
References: <20170205065336.14994-1-tytso@mit.edu>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 5 Feb 2017 10:02:03 +0200
Message-ID: <CAOQ4uxisNW+zew4NgKtykJQs8dcC==u1rMvWVZwH=Mnp7r0SkA@mail.gmail.com>
Subject: Re: [PATCH 1/3] generic: honor the FSSTRESS_AVOID environment variable
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sun, Feb 5, 2017 at 8:53 AM, Theodore Ts'o <tytso@mit.edu> wrote:
> Make sure all tests which run fsstress, and which do not have a very
> specific custom profile of which file system operations to run,

Can you elaborate about this criteria?
Specifically, what about overlay/019? and several other {xfs,btrfs}/* stress
tests. Why do they not qualify?

> honor the FSSTRESS_AVOID environment variable.
>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  tests/generic/051 | 2 +-
>  tests/generic/232 | 2 +-
>  tests/generic/388 | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tests/generic/051 b/tests/generic/051
> index b0c37824..7b807b9f 100755
> --- a/tests/generic/051
> +++ b/tests/generic/051
> @@ -63,7 +63,7 @@ PROCS=$((2 * LOAD_FACTOR))
>  load_dir=$SCRATCH_MNT/test
>
>  # let this run for a while
> -$FSSTRESS_PROG -n10000000 -p $PROCS -d $load_dir >> $seqres.full 2>&1 &
> +$FSSTRESS_PROG $FSSTRESS_AVOID -n10000000 -p $PROCS -d $load_dir >> $seqres.full 2>&1 &
>  sleep $SLEEP_TIME
>  $KILLALL_PROG -q $FSSTRESS_PROG
>  wait
> diff --git a/tests/generic/232 b/tests/generic/232
> index 6b197791..f4853f72 100755
> --- a/tests/generic/232
> +++ b/tests/generic/232
> @@ -53,7 +53,7 @@ _fsstress()
>
>         out=$SCRATCH_MNT/fsstress.$$
>         count=2000
> -       args=`_scale_fsstress_args -d $out -n $count -p 7`
> +       args=`_scale_fsstress_args -d $out -n $count -p 7 $FSSTRESS_AVOID`
>
>         echo "fsstress $args" >> $seqres.full
>         if ! $FSSTRESS_PROG $args | tee -a $seqres.full | _filter_num
> diff --git a/tests/generic/388 b/tests/generic/388
> index 9d4ba9d6..3729aa5b 100755
> --- a/tests/generic/388
> +++ b/tests/generic/388
> @@ -65,7 +65,7 @@ _scratch_mkfs >> $seqres.full 2>&1
>  _scratch_mount || _fail "mount failed"
>
>  for i in $(seq 1 50); do
> -       ($FSSTRESS_PROG -d $SCRATCH_MNT -n 999999 -p 4 >> $seqres.full &) \
> +       ($FSSTRESS_PROG $FSSTRESS_AVOID -d $SCRATCH_MNT -n 999999 -p 4 >> $seqres.full &) \
>                 > /dev/null 2>&1
>
>         # purposely include 0 second sleeps to test shutdown immediately after
> --
> 2.11.0.rc0.7.gbe5a750
>
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
