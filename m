Received: from mail-yw0-f193.google.com ([209.85.161.193]:39803 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751921AbdLCIrW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 3 Dec 2017 03:47:22 -0500
Received: by mail-yw0-f193.google.com with SMTP id y187so5628037ywg.6
        for <fstests@vger.kernel.org>; Sun, 03 Dec 2017 00:47:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1512063084-12105-1-git-send-email-ari@tuxera.com>
References: <1512063084-12105-1-git-send-email-ari@tuxera.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 3 Dec 2017 10:47:21 +0200
Message-ID: <CAOQ4uxgrMpm0kOm85=ekZFBf_daeJ0HZ6HVzWZBBbVHk19Jisw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fsstress: Fix memory leaks
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Ari Sundholm <ari@tuxera.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Nov 30, 2017 at 7:31 PM, Ari Sundholm <ari@tuxera.com> wrote:
> This patch fixes the memory leaks we found when running fsstress under
> valgrind.
>
> Signed-off-by: Ari Sundholm <ari@tuxera.com>
> ---
>  ltp/fsstress.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index 96f48b1..13d5dd5 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -614,6 +614,9 @@ int main(int argc, char **argv)
>                                 return 1;
>                         }
>  #endif
> +
> +                       cleanup_flist();
> +                       free(freq_table);
>                         return 0;
>                 }
>         }
> @@ -640,6 +643,7 @@ int main(int argc, char **argv)
>                 close(fd);
>         }
>
> +       free(freq_table);
>         unlink(buf);
>         return 0;
>  }
> @@ -997,6 +1001,7 @@ doproc(void)
>         }
>  errout:
>         chdir("..");
> +       free(homedir);
>         if (cleanup) {
>                 sprintf(cmd, "rm -rf %s", buf);
>                 system(cmd);


I don't see the point in those cleanups before returning from main()
and I don't see the point in storing homedir in the first place at all
and calling chdir(homedir) before abort.

Amir.
