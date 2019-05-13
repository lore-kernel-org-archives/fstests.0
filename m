Received: from mail-yw1-f66.google.com ([209.85.161.66]:32956 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbfEMIes (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 13 May 2019 04:34:48 -0400
Received: by mail-yw1-f66.google.com with SMTP id q11so10380025ywb.0
        for <fstests@vger.kernel.org>; Mon, 13 May 2019 01:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <1557727865-3745-1-git-send-email-jefflexu@linux.alibaba.com>
In-Reply-To: <1557727865-3745-1-git-send-email-jefflexu@linux.alibaba.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 13 May 2019 11:34:36 +0300
Message-ID: <CAOQ4uxgbx0u42tx4AkQ2C5ePqSCfyJ9hzRxUD2N8ejFixFxoXQ@mail.gmail.com>
Subject: Re: [PATCH v2] generic/530: fix shutdown failure of generic/530 in overlay
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Cc: fstests <fstests@vger.kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>

CC: Darrick

On Mon, May 13, 2019 at 9:23 AM Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
>
> Testcases are recommended to use  _require_scratch_shutdown()
> and _scratch_shutdown() pair helper function to test and execute
> shutdown.
>
> generic/530 formmerly used _require_scratch_shutdown() to test
> whether the filesystem supports shutdown or not, while executed
> the shutdown action in a raw binary (src/t_open_tmpfiles) rather
> than the recommended _scratch_shutdown() helper. This will cause
> a "shutdown: Inappropriate ioctl for device" error message when
> testing overlay filesystem.
>
> This patch simply move the shutdown action from the raw binary
> into the packaged _scratch_shutdown() helper. That is, we remove
> the "shutdown" interface of t_open_tmpfiles.c and call
> _scratch_shutdown() in genric/530 and xfs/501.
>
> thx
>
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  src/t_open_tmpfiles.c | 19 -------------------
>  tests/generic/530     |  4 +++-
>  tests/xfs/501         |  4 +++-
>  3 files changed, 6 insertions(+), 21 deletions(-)
>
> diff --git a/src/t_open_tmpfiles.c b/src/t_open_tmpfiles.c
> index da9390f..0393c6b 100644
> --- a/src/t_open_tmpfiles.c
> +++ b/src/t_open_tmpfiles.c
> @@ -24,7 +24,6 @@ static int min_fd = -1;
>  static int max_fd = -1;
>  static unsigned int nr_opened = 0;
>  static float start_time;
> -static int shutdown_fs = 0;
>
>  void clock_time(float *time)
>  {
> @@ -69,22 +68,6 @@ void die(void)
>                                 end_time - start_time);
>                 fflush(stdout);
>
> -               if (shutdown_fs) {
> -                       /*
> -                        * Flush the log so that we have to process the
> -                        * unlinked inodes the next time we mount.
> -                        */
> -                       int flag = XFS_FSOP_GOING_FLAGS_LOGFLUSH;
> -                       int ret;
> -
> -                       ret = ioctl(min_fd, XFS_IOC_GOINGDOWN, &flag);
> -                       if (ret) {
> -                               perror("shutdown");
> -                               exit(2);
> -                       }
> -                       exit(0);
> -               }
> -
>                 clock_time(&start_time);
>                 for (fd = min_fd; fd <= max_fd; fd++)
>                         close(fd);
> @@ -160,8 +143,6 @@ int main(int argc, char *argv[])
>                 if (ret)
>                         perror(argv[1]);
>         }
> -       if (argc > 2 && !strcmp(argv[2], "shutdown"))
> -               shutdown_fs = 1;
>
>         clock_time(&start_time);
>         while (1)
> diff --git a/tests/generic/530 b/tests/generic/530
> index b0d188b..56c6d32 100755
> --- a/tests/generic/530
> +++ b/tests/generic/530
> @@ -49,7 +49,9 @@ ulimit -n $max_files
>
>  # Open a lot of unlinked files
>  echo create >> $seqres.full
> -$here/src/t_open_tmpfiles $SCRATCH_MNT shutdown >> $seqres.full
> +$here/src/t_open_tmpfiles $SCRATCH_MNT >> $seqres.full
> +_scratch_shutdown -f
> +
>
>  # Unmount to prove that we can clean it all
>  echo umount >> $seqres.full
> diff --git a/tests/xfs/501 b/tests/xfs/501
> index 974f341..4be9997 100755
> --- a/tests/xfs/501
> +++ b/tests/xfs/501
> @@ -54,7 +54,9 @@ ulimit -n $max_files
>
>  # Open a lot of unlinked files
>  echo create >> $seqres.full
> -$here/src/t_open_tmpfiles $SCRATCH_MNT shutdown >> $seqres.full
> +$here/src/t_open_tmpfiles $SCRATCH_MNT >> $seqres.full
> +_scratch_shutdown -f
> +
>
>  # Unmount to prove that we can clean it all
>  echo umount >> $seqres.full
> --
> 1.8.3.1
>
