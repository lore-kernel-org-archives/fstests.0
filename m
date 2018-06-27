Received: from mail-yw0-f196.google.com ([209.85.161.196]:33777 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933627AbeF0K4a (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jun 2018 06:56:30 -0400
Received: by mail-yw0-f196.google.com with SMTP id u124-v6so541554ywg.0
        for <fstests@vger.kernel.org>; Wed, 27 Jun 2018 03:56:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180627082103.9662-4-david@fromorbit.com>
References: <20180627082103.9662-1-david@fromorbit.com> <20180627082103.9662-4-david@fromorbit.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 27 Jun 2018 13:56:29 +0300
Message-ID: <CAOQ4uxj90rifsdgi67aMnqGzzX5P+oNQz_kRnpF73+wTjuq9kA@mail.gmail.com>
Subject: Re: [PATCH 3/8] shared: use new test setup preamble
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 27, 2018 at 11:20 AM, Dave Chinner <david@fromorbit.com> wrote:
> From: Dave Chinner <dchinner@redhat.com>
>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
[...]
> diff --git a/tests/shared/298 b/tests/shared/298
> index e7b7b233de45..fc2d090a2f66 100755
> --- a/tests/shared/298
> +++ b/tests/shared/298
> @@ -6,15 +6,22 @@
>  #
>  # Test that filesystem sends discard requests only on free blocks
>  #
> -seq=`basename $0`
> -seqres=$RESULT_DIR/$seq
> -echo "QA output created by $seq"
> +. common/setup_test
>
> -status=1       # failure is the default!
> -trap "_cleanup; exit \$status" 0 1 2 3 15
> +# test exit cleanup goes here
> +cleanup() {
> +       $UMOUNT_PROG $loop_dev &> /dev/null
> +       _destroy_loop_device $loop_dev
> +       if [ $status -eq 0 ]; then
> +               rm $img_file
> +               rm -rf $workdir
> +       fi
> +}
>
> -. ./common/rc
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
>
> +# include test specific environments here
>  _supported_fs ext4 xfs
>  _supported_os Linux
>  _require_test
> @@ -24,15 +31,8 @@ _require_xfs_io_command "fiemap"
>  _require_fs_space $TEST_DIR 307200
>  [ "$FSTYP" = "ext4" ] && _require_dumpe2fs
>
> -_cleanup()
> -{
> -       $UMOUNT_PROG $loop_dev &> /dev/null
> -       _destroy_loop_device $loop_dev
> -       if [ $status -eq 0 ]; then
> -               rm -rf $tmp
> -               rm $img_file
> -       fi
> -}
> +workdir=$TEST_DIR/$$
> +mkdir -p $workdir

:-/ I don't like this s/tmp/workdir conversion and don't like the idea
of having to do the same thing for 16 btrfs tests + 1 generic test.
IIUC, you changed the test from using tmpdir under $here to
tmpdir under $TEST_DIR. Why not change it to tmpdir under /tmp?

Only change you will need to do is:
-tmp=`mktemp -d`
+mkdir -p $tmp

Thanks,
Amir.
