Received: from mail-yw0-f196.google.com ([209.85.161.196]:38216 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751664AbdH2O5M (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 Aug 2017 10:57:12 -0400
Received: by mail-yw0-f196.google.com with SMTP id e9so2201264ywh.5
        for <fstests@vger.kernel.org>; Tue, 29 Aug 2017 07:57:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170829133715.12275-2-tuomas.tynkkynen@iki.fi>
References: <20170829133715.12275-1-tuomas.tynkkynen@iki.fi> <20170829133715.12275-2-tuomas.tynkkynen@iki.fi>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 29 Aug 2017 17:57:11 +0300
Message-ID: <CAOQ4uxgsjkB+47qam5o77ZPf=AVczeG6DYj+f1AfXFZmS0UTfQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] fsx: Fix -Wformat-security warnings
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Aug 29, 2017 at 4:37 PM, Tuomas Tynkkynen
<tuomas.tynkkynen@iki.fi> wrote:
> Some distros (NixOS) have their build environment enable
> -Werror=format-security by default for security/hardening reasons.
> Currently fsx fails to build due to this:
>
> fsx.c: In function 'prt':
> fsx.c:215:18: error: format not a string literal and no format arguments [-Werror=format-security]
>   fprintf(stdout, buffer);
>                   ^
> fsx.c:217:20: error: format not a string literal and no format arguments [-Werror=format-security]
>    fprintf(fsxlogf, buffer);
>                     ^
> Indeed the compiler is correct here, if the message-to-be-printed were
> to contain a '%', unpredictable things would happen. Fix this.
>
> Signed-off-by: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
> ---
>  ltp/fsx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 3713bbe3..fba2b4d8 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -212,9 +212,9 @@ prt(const char *fmt, ...)
>         va_start(args, fmt);
>         vsnprintf(buffer, BUF_SIZE, fmt, args);
>         va_end(args);
> -       fprintf(stdout, buffer);
> +       fprintf(stdout, "%s", buffer);
>         if (fsxlogf)
> -               fprintf(fsxlogf, buffer);
> +               fprintf(fsxlogf, "%s", buffer);
>  }

Might as well be fputs, eitherwise looks good to me
