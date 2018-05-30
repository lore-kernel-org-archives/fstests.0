Received: from mail-yw0-f194.google.com ([209.85.161.194]:46756 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932076AbeE3Tbo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 May 2018 15:31:44 -0400
Received: by mail-yw0-f194.google.com with SMTP id v197-v6so5087858ywc.13
        for <fstests@vger.kernel.org>; Wed, 30 May 2018 12:31:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1527646267-2257-1-git-send-email-xuhuan.fnst@cn.fujitsu.com>
References: <1527646267-2257-1-git-send-email-xuhuan.fnst@cn.fujitsu.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 30 May 2018 22:31:42 +0300
Message-ID: <CAOQ4uxjU_bJ+5cNwcr96G=K6R_PWSWtaCU4P-Kv0vNLORAX23w@mail.gmail.com>
Subject: Re: [PATCH] fix generic 401 on fs without filesystem support
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Huan Xu <xuhuan.fnst@cn.fujitsu.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, May 30, 2018 at 5:11 AM, Huan Xu <xuhuan.fnst@cn.fujitsu.com> wrote:
> From: Xu Huan <xuhuan.fnst@cn.fujitsu.com>
>
> in generic 401 when test on fs without filesystem support
> list DT_UNKNOWN file . and .. , then list all file without
> . and ..
>
> following  is test result on nfs
>
> generic/401     QA output created by 401
> . d
> .. d
>  - output mismatch (see /var/lib/xfstests/results//generic/401.out.bad)
>     --- tests/generic/401.out   2018-05-22 04:22:11.641999979 -0400
>     +++ /var/lib/xfstests/results//generic/401.out.bad  2018-05-28 23:22:42.312999931 -0400
>     @@ -1,9 +1,3 @@
>      QA output created by 401
>      . d
>      .. d
>     -b b
>     -c c
>     -d d
>     -f f
> ---
>  tests/generic/401 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/generic/401 b/tests/generic/401
> index 74f2bea5..26938864 100755
> --- a/tests/generic/401
> +++ b/tests/generic/401
> @@ -86,8 +86,8 @@ else
>         # print fake dir file type for . and .. if they are DT_UNKNOWN
>         src/t_dir_type $testdir u | grep -F '.' | \
>                 awk '{ print $1, "d" }' | sort
> -       # list unknown files and print filename as fake file type
> -       src/t_dir_type $testdir u | grep -vF '.' | \
> +       # list all files without . and .. and print filename as fake file type
> +       src/t_dir_type $testdir | grep -vF '.' | \
>                 awk '{ print $1, $1 }' | sort
>  fi
>

This makes the test pass by definition for unsupported dir type -
it tests that the names of files in the directory is the files we created -
nothing more.

Its fine that you want to make NFS not fail this test, but what do you
want to test? Look at the header comment - it says what the test does
for xfs/ext4 and dir type feature is disabled and this change is breaking
those verifications.

The way I see it there are 2 options:
1. implement _require_filetype and notrun this test at all if file type is
not supported. Basically that's the result of your patch, but it reports
pass instead of notrun.
2. change the verification of not supported case to allow for either
DT_UNKNOWN or the expected type

I personally don't object to the easier option #1, but options #2 gives
better test coverage.

Thanks,
Amir.
