Received: from mail-yb0-f195.google.com ([209.85.213.195]:38522 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752979AbeF0KeI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jun 2018 06:34:08 -0400
Received: by mail-yb0-f195.google.com with SMTP id f12-v6so559041ybp.5
        for <fstests@vger.kernel.org>; Wed, 27 Jun 2018 03:34:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180627082103.9662-3-david@fromorbit.com>
References: <20180627082103.9662-1-david@fromorbit.com> <20180627082103.9662-3-david@fromorbit.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 27 Jun 2018 13:34:07 +0300
Message-ID: <CAOQ4uxgxt8LTCaN-7OS+Qp=npponARGYGfqco0xgaZ4oN5uf8w@mail.gmail.com>
Subject: Re: [PATCH 2/8] tests: convert various test dirs to setup preamble
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 27, 2018 at 11:20 AM, Dave Chinner <david@fromorbit.com> wrote:
> From: Dave Chinner <dchinner@redhat.com>
>
> Convert all the test dirs with a very small number of tests in one
> go.
>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
[...]

> -rm -f $seqres.full
> +echo "Silence is golden"
> +
> +fio_config=$tmp.fio
> +fio_results=$tmp.json
>
>  _size=$((16 * $LOAD_FACTOR))
>  cat >$fio_config <<EOF
> @@ -60,5 +56,5 @@ $FIO_PROG --output-format=json --output=$fio_results $fio_config
>  _scratch_unmount
>  cat $fio_results >> $seqres.full
>  _fio_results_compare $seq $fio_results
> -echo "Silence is golden"
> -status=0; exit
> +
> +_success

I realize that without status=0 test will not pass, but it always
annoys me that echo "Silence is golden" before the end of the test.

How about _success_silent to further reduce the boilerplate echo
"Silence is golden"?

Thanks,
Amir.
