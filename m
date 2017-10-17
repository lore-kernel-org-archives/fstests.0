Received: from mail-qt0-f195.google.com ([209.85.216.195]:49687 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933044AbdJQLyR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 Oct 2017 07:54:17 -0400
Received: by mail-qt0-f195.google.com with SMTP id k31so2817684qta.6
        for <fstests@vger.kernel.org>; Tue, 17 Oct 2017 04:54:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508210445-27135-1-git-send-email-houtao1@huawei.com>
References: <1508210445-27135-1-git-send-email-houtao1@huawei.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 17 Oct 2017 14:54:16 +0300
Message-ID: <CAOQ4uxjZzkWNzYKyFFBab0+pY=0=mHpA3ASc2UMJqn3AYrrNqg@mail.gmail.com>
Subject: Re: [PATCH] log-writes: fix possible infinite loop in zero_range()
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Hou Tao <houtao1@huawei.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Oct 17, 2017 at 6:20 AM, Hou Tao <houtao1@huawei.com> wrote:
> Found it when trying to remove the limitation of log->max_zero_size.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  src/log-writes/log-writes.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/src/log-writes/log-writes.c b/src/log-writes/log-writes.c
> index fab447a..0939157 100644
> --- a/src/log-writes/log-writes.c
> +++ b/src/log-writes/log-writes.c
> @@ -65,6 +65,9 @@ static int zero_range(struct log *log, u64 start, u64 len)
>
>         memset(buf, 0, bufsize);
>         while (len) {
> +               if (len < bufsize)
> +                       bufsize = len;
> +
>                 ret = pwrite(log->replayfd, buf, bufsize, start);
>                 if (ret != bufsize) {
>                         fprintf(stderr, "Error zeroing file: %d\n", errno);
> --
> 2.5.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
