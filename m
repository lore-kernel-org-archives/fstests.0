Received: from mail-yw0-f194.google.com ([209.85.161.194]:39914 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752039AbdLCIIa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 3 Dec 2017 03:08:30 -0500
Received: by mail-yw0-f194.google.com with SMTP id y187so5614153ywg.6
        for <fstests@vger.kernel.org>; Sun, 03 Dec 2017 00:08:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1512063084-12105-2-git-send-email-ari@tuxera.com>
References: <1512063084-12105-1-git-send-email-ari@tuxera.com> <1512063084-12105-2-git-send-email-ari@tuxera.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 3 Dec 2017 10:08:28 +0200
Message-ID: <CAOQ4uxgzXgJXnGY2QRfQBxHib+q-DEAKH=hFKTBX9=q-0jbdUA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fsstress: getcwd() return value fixes
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Ari Sundholm <ari@tuxera.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Nov 30, 2017 at 7:31 PM, Ari Sundholm <ari@tuxera.com> wrote:
> Add a check for the return value of getcwd(). Fix another check
> which mistakenly checks if the return value is less than zero
> instead of checking whether the return value is NULL.
>
> Signed-off-by: Ari Sundholm <ari@tuxera.com>
> ---
>  ltp/fsstress.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index 13d5dd5..028c232 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -495,7 +495,7 @@ int main(int argc, char **argv)
>
>         (void)mkdir(dirname, 0777);
>         if (logname && logname[0] != '/') {
> -               if (getcwd(rpath, sizeof(rpath)) < 0){
> +               if (!getcwd(rpath, sizeof(rpath))){
>                         perror("getcwd failed");
>                         exit(1);
>                 }
> @@ -970,6 +970,10 @@ doproc(void)
>         }
>         top_ino = statbuf.st_ino;
>         homedir = getcwd(NULL, 0);
> +       if (!homedir) {
> +               perror("getcwd failed");
> +               _exit(1);
> +       }
>         seed += procid;
>         srandom(seed);
>         if (namerand)

The change itself looks correct, but I have no idea what's the purpose
of saving homedir. It is only used in DEBUG code to chdir(homedir)
before abort().
Is there any obscure meaning to that chdir() that I don't understand?

Amir.
