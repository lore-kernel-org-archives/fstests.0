Received: from mail-pg0-f65.google.com ([74.125.83.65]:46391 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752969AbeF0EwH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jun 2018 00:52:07 -0400
Received: by mail-pg0-f65.google.com with SMTP id q14-v6so372871pgt.13
        for <fstests@vger.kernel.org>; Tue, 26 Jun 2018 21:52:06 -0700 (PDT)
Date: Wed, 27 Jun 2018 12:52:01 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] fstests: add SPDX license comments for src/log-writes/*
Message-ID: <20180627045201.GQ2780@desktop>
References: <20180626170758.3348-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626170758.3348-1-josef@toxicpanda.com>
Sender: fstests-owner@vger.kernel.org
To: Josef Bacik <josef@toxicpanda.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 26, 2018 at 01:07:58PM -0400, Josef Bacik wrote:
> I apparently never bothered to put copyright or license info with this
> code, just tag it as GPL 2 and I'll fix the upstream stuff as well.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Thanks for completing the license!

Eryu

> ---
>  src/log-writes/log-writes.c | 1 +
>  src/log-writes/log-writes.h | 1 +
>  src/log-writes/replay-log.c | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/src/log-writes/log-writes.c b/src/log-writes/log-writes.c
> index 5dc22c244cea..aa53473974d9 100644
> --- a/src/log-writes/log-writes.c
> +++ b/src/log-writes/log-writes.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <linux/fs.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> diff --git a/src/log-writes/log-writes.h b/src/log-writes/log-writes.h
> index 75fb8ac0bf79..b9f571ac3b23 100644
> --- a/src/log-writes/log-writes.h
> +++ b/src/log-writes/log-writes.h
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #ifndef _LOG_WRITES_H_
>  #define _LOG_WRITES_H_
>  
> diff --git a/src/log-writes/replay-log.c b/src/log-writes/replay-log.c
> index 8457937578d5..c16df40e5741 100644
> --- a/src/log-writes/replay-log.c
> +++ b/src/log-writes/replay-log.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <unistd.h>
>  #include <getopt.h>
> -- 
> 2.14.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
