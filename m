Received: from mail-yw0-f194.google.com ([209.85.161.194]:32971 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbeF0LaP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jun 2018 07:30:15 -0400
Received: by mail-yw0-f194.google.com with SMTP id u124-v6so571795ywg.0
        for <fstests@vger.kernel.org>; Wed, 27 Jun 2018 04:30:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180627082103.9662-6-david@fromorbit.com>
References: <20180627082103.9662-1-david@fromorbit.com> <20180627082103.9662-6-david@fromorbit.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 27 Jun 2018 14:30:13 +0300
Message-ID: <CAOQ4uxi7NP-NpK38CnBB=epxhq6Ykt+V-hSwOtAJuac7Gwt3og@mail.gmail.com>
Subject: Re: [PATCH 5/8] btrfs: convert some tests to new setup preamble
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 27, 2018 at 11:21 AM, Dave Chinner <david@fromorbit.com> wrote:
> From: Dave Chinner <dchinner@redhat.com>
>
> Small initial batch to demonstrate conversion.
>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
[...]
> diff --git a/tests/btrfs/007 b/tests/btrfs/007
> index 09f2f011bc77..50ead03acf31 100755
> --- a/tests/btrfs/007
> +++ b/tests/btrfs/007
> @@ -9,37 +9,23 @@
>  # (incr) and send both snapshots to a temp file. Remake the file
>  # system and receive from the files. Check both states with fssum.
>  #
> -# creator
> -owner=list.btrfs@jan-o-sch.net
> +. common/setup_test
>
> -seq=`basename $0`
> -seqres=$RESULT_DIR/$seq
> -echo "QA output created by $seq"
> +# test exit cleanup goes here
> +cleanup() { :; }
>
> -tmp=`mktemp -d`
> -status=1
> -
> -_cleanup()
> -{
> -       echo "*** unmount"
> -       _scratch_unmount 2>/dev/null
> -       rm -f $tmp.*
> -}

Bug in existing test - it does not cleanup $tmp.

> -trap "_cleanup; exit \$status" 0 1 2 3 15
> -
> -# get standard environment, filters and checks
> -. ./common/rc
> -. ./common/filter
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
>
> -# real QA test starts here
> +# include test specific environments here
> +_supported_fs generic
> +_supported_os Linux
>  _supported_fs btrfs
>  _supported_os Linux
>  _require_scratch
>  _require_fssum
>  _require_seek_data_hole
>
> -rm -f $seqres.full
> -
>  workout()
>  {
>         fsz=$1
> @@ -57,18 +43,18 @@ workout()
>
>         _run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr
>
> -       echo "# $BTRFS_UTIL_PROG send $SCRATCH_MNT/base > $tmp/base.snap" \
> +       echo "# $BTRFS_UTIL_PROG send $SCRATCH_MNT/base > $tmp.base.snap" \
>                 >> $seqres.full
> -       $BTRFS_UTIL_PROG send $SCRATCH_MNT/base > $tmp/base.snap 2>> $seqres.full \
> +       $BTRFS_UTIL_PROG send $SCRATCH_MNT/base > $tmp.base.snap 2>> $seqres.full \
>                 || _fail "failed: '$@'"
>         echo "# $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base\
> -               $SCRATCH_MNT/incr > $tmp/incr.snap" >> $seqres.full
> +               $SCRATCH_MNT/incr > $tmp.incr.snap" >> $seqres.full
>         $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base \
> -               $SCRATCH_MNT/incr > $tmp/incr.snap 2>> $seqres.full \
> +               $SCRATCH_MNT/incr > $tmp.incr.snap 2>> $seqres.full \
>                 || _fail "failed: '$@'"
>
> -       run_check $FSSUM_PROG -A -f -w $tmp/base.fssum $SCRATCH_MNT/base
> -       run_check $FSSUM_PROG -A -f -w $tmp/incr.fssum -x $SCRATCH_MNT/incr/base \
> +       run_check $FSSUM_PROG -A -f -w $tmp.base.fssum $SCRATCH_MNT/base
> +       run_check $FSSUM_PROG -A -f -w $tmp.incr.fssum -x $SCRATCH_MNT/incr/base \
>                 $SCRATCH_MNT/incr
>
>         _scratch_unmount >/dev/null 2>&1
> @@ -78,11 +64,11 @@ workout()
>                 || _fail "size=$fsz mkfs failed"
>         _scratch_mount "-o noatime"
>
> -       _run_btrfs_util_prog receive $SCRATCH_MNT < $tmp/base.snap
> -       run_check $FSSUM_PROG -r $tmp/base.fssum $SCRATCH_MNT/base
> +       _run_btrfs_util_prog receive $SCRATCH_MNT < $tmp.base.snap
> +       run_check $FSSUM_PROG -r $tmp.base.fssum $SCRATCH_MNT/base
>
> -       _run_btrfs_util_prog receive $SCRATCH_MNT < $tmp/incr.snap
> -       run_check $FSSUM_PROG -r $tmp/incr.fssum $SCRATCH_MNT/incr
> +       _run_btrfs_util_prog receive $SCRATCH_MNT < $tmp.incr.snap
> +       run_check $FSSUM_PROG -r $tmp.incr.fssum $SCRATCH_MNT/incr
>  }
>

This is better than the s/tmp/workdir conversion in shared/298, but
yet easier is to do:

cleanup() { rm -rf $tmp }

-tmp=`mktemp -d`
+mkdir -p $tmp

Thanks,
Amir.
