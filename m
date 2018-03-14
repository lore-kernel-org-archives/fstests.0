Received: from mail-yw0-f194.google.com ([209.85.161.194]:40932 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751015AbeCNKGl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 14 Mar 2018 06:06:41 -0400
MIME-Version: 1.0
In-Reply-To: <20180314090230.25055-2-wqu@suse.com>
References: <20180314090230.25055-1-wqu@suse.com> <20180314090230.25055-2-wqu@suse.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 14 Mar 2018 12:06:40 +0200
Message-ID: <CAOQ4uxgCLauUk=RMk2sqhhmxQy-RZMMnBoWd0rytvCShozZacg@mail.gmail.com>
Subject: Re: [PATCH 2/3] fstests: log-writes: Add support for METADATA flag
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <wqu@suse.com>
Cc: Linux Btrfs <linux-btrfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 14, 2018 at 11:02 AM, Qu Wenruo <wqu@suse.com> wrote:
> Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  src/log-writes/log-writes.c | 3 ++-
>  src/log-writes/log-writes.h | 9 +++++----
>  2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/src/log-writes/log-writes.c b/src/log-writes/log-writes.c
> index a872429d..5dc22c24 100644
> --- a/src/log-writes/log-writes.c
> +++ b/src/log-writes/log-writes.c
> @@ -130,7 +130,8 @@ struct flags_to_str_entry {
>         DEFINE_LOG_FLAGS_STR_ENTRY(FLUSH),
>         DEFINE_LOG_FLAGS_STR_ENTRY(FUA),
>         DEFINE_LOG_FLAGS_STR_ENTRY(DISCARD),
> -       DEFINE_LOG_FLAGS_STR_ENTRY(MARK)
> +       DEFINE_LOG_FLAGS_STR_ENTRY(MARK),
> +       DEFINE_LOG_FLAGS_STR_ENTRY(METADATA)
>  };
>
>  #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> diff --git a/src/log-writes/log-writes.h b/src/log-writes/log-writes.h
> index 35ca3583..75fb8ac0 100644
> --- a/src/log-writes/log-writes.h
> +++ b/src/log-writes/log-writes.h
> @@ -20,10 +20,11 @@ typedef __u32 u32;
>  /*
>   * Constants copied from kernel file drivers/md/dm-log-writes.c
>   */
> -#define LOG_FLUSH_FLAG (1 << 0)
> -#define LOG_FUA_FLAG (1 << 1)
> -#define LOG_DISCARD_FLAG (1 << 2)
> -#define LOG_MARK_FLAG (1 << 3)
> +#define LOG_FLUSH_FLAG         (1 << 0)
> +#define LOG_FUA_FLAG           (1 << 1)
> +#define LOG_DISCARD_FLAG       (1 << 2)
> +#define LOG_MARK_FLAG          (1 << 3)
> +#define LOG_METADATA_FLAG      (1 << 4)
>
>  #define WRITE_LOG_VERSION 1
>  #define WRITE_LOG_MAGIC 0x6a736677736872
> --
> 2.15.1
>
