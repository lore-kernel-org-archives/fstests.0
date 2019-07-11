Received: from mail-yb1-f193.google.com ([209.85.219.193]:45284 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfGKGvE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 Jul 2019 02:51:04 -0400
Received: by mail-yb1-f193.google.com with SMTP id j133so1774301ybj.12
        for <fstests@vger.kernel.org>; Wed, 10 Jul 2019 23:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <1562758522-6359-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
In-Reply-To: <1562758522-6359-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 11 Jul 2019 09:50:52 +0300
Message-ID: <CAOQ4uxiw--Jr-rjhgs2gA5=Z_Q=KW=GtMSs+pfwnKyYU7WCBLA@mail.gmail.com>
Subject: Re: [PATCH] generic/553[4]: correct kernel fix commit
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc: Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 11, 2019 at 8:25 AM Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:
>
> commit 96e6e8f4a68d ("vfs: add missing checks to copy_file_range")
> adds checks for immutablefile and swapfile instead of commit a31713517d
> ("vfs: introduce generic_file_rw_checks()").
>
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>

ACK

Thanks for following up.
Amir.

> ---
>  tests/generic/553 | 2 +-
>  tests/generic/554 | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/generic/553 b/tests/generic/553
> index aefb0819..a836e602 100755
> --- a/tests/generic/553
> +++ b/tests/generic/553
> @@ -7,7 +7,7 @@
>  # Check that we cannot copy_file_range() to an immutable file
>  #
>  # This is a regression test for kernel commit:
> -#   a31713517dac ("vfs: introduce generic_file_rw_checks()")
> +#   96e6e8f4a68d ("vfs: add missing checks to copy_file_range")
>  #
>  seq=`basename $0`
>  seqres=$RESULT_DIR/$seq
> diff --git a/tests/generic/554 b/tests/generic/554
> index fa19d580..eaf1f45a 100755
> --- a/tests/generic/554
> +++ b/tests/generic/554
> @@ -7,7 +7,7 @@
>  # Check that we cannot copy_file_range() to a swapfile
>  #
>  # This is a regression test for kernel commit:
> -#   a31713517dac ("vfs: introduce generic_file_rw_checks()")
> +#   96e6e8f4a68d ("vfs: add missing checks to copy_file_range")
>  #
>  seq=`basename $0`
>  seqres=$RESULT_DIR/$seq
> --
> 2.18.1
>
>
>
