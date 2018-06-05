Received: from mail-yw0-f172.google.com ([209.85.161.172]:34873 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbeFEHpL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 5 Jun 2018 03:45:11 -0400
Received: by mail-yw0-f172.google.com with SMTP id v131-v6so428055ywg.2
        for <fstests@vger.kernel.org>; Tue, 05 Jun 2018 00:45:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180605020522.2697-1-xuhuan.fnst@cn.fujitsu.com>
References: <20180605020522.2697-1-xuhuan.fnst@cn.fujitsu.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 5 Jun 2018 10:45:10 +0300
Message-ID: <CAOQ4uxj=+Znvfif=29=C=UBo6O1Bsi54_ofR=ixb4WJF4rLMgQ@mail.gmail.com>
Subject: Re: [PATCH v2] fix generic 401 on fs without filesystem support
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Xu Huan <xuhuan.fnst@cn.fujitsu.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 5, 2018 at 5:05 AM, Xu Huan <xuhuan.fnst@cn.fujitsu.com> wrote:
> notrun the test if the filesystem is not supported.
> on unsupported fs ,the test may have different result.

Let me post a patch for proper test of unsupported case.

> ---
>  tests/generic/401 | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/tests/generic/401 b/tests/generic/401
> index 74f2bea5..1c790a33 100755
> --- a/tests/generic/401
> +++ b/tests/generic/401
> @@ -3,9 +3,7 @@
>  #
>  # Test filetype feature
>  #
> -# This test does NOT require that file system support the d_type feature.
> -# It verifies that either all file types are reported as DT_UNKNOWN
> -# or all file types are reported correctly.
> +# This test not run if that file system support the d_type feature.
>  #
>  # For fs for which we know how to test the filetype feature (xfs|ext*)
>  # verify getting DT_UNKNOWN IFF feature is disabled.
> @@ -83,12 +81,7 @@ if _supports_filetype $SCRATCH_MNT; then
>         # print real file types
>         src/t_dir_type $testdir | grep -vF '.' | sort
>  else
> -       # print fake dir file type for . and .. if they are DT_UNKNOWN
> -       src/t_dir_type $testdir u | grep -F '.' | \
> -               awk '{ print $1, "d" }' | sort
> -       # list unknown files and print filename as fake file type
> -       src/t_dir_type $testdir u | grep -vF '.' | \
> -               awk '{ print $1, $1 }' | sort
> +       _notrun "test not support on this filesystem"
>  fi
>
>  status=0
> --
> 2.17.0
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
