Received: from mx2.suse.de ([195.135.220.15]:34713 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751172AbdEaI6P (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 31 May 2017 04:58:15 -0400
Subject: Re: [PATCHv2] src/listxattr: Fix reading past the end of the user
 buffer
References: <1496152288-4101-1-git-send-email-nborisov@suse.com>
 <1496153407-6060-1-git-send-email-nborisov@suse.com>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <70269450-8b2e-3b8f-e7ac-e44221797e34@suse.com>
Date: Wed, 31 May 2017 11:58:12 +0300
MIME-Version: 1.0
In-Reply-To: <1496153407-6060-1-git-send-email-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 30.05.2017 17:10, Nikolay Borisov wrote:
> listxattr reaturns a null-terminated list of entries that represent
> the xattr names. However, if it is passed larger buffer than it
> requires it won't zero-out the rest of the memory. The way the
> loop iterator in listxattr.c is written makes it go print every
> null-terminated entry up to bufsize (which is user passed parameter).
> This can lead to a situation where listxattr users N bytes out of
> M bytes big buffer ( M > N). This will leave the rest (M-N)
> as garbage, which in turn will be printed by listxattr. Fix this
> by converting the 'for' loop to 'while' and properly ensuring
> we are reading at most howevermany elements the syscall reported
> it returned
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> 
> v2: 
>  Rewrite the loop, hopefully making the code a bit more legible.
>  Functionally it's the same as my previous fix
> 
>  src/listxattr.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/src/listxattr.c b/src/listxattr.c
> index cd46637a..584ebb2d 100644
> --- a/src/listxattr.c
> +++ b/src/listxattr.c
> @@ -60,10 +60,10 @@ int main(int argc, char **argv)
>          if (ret < 0) {
>                  perror("listxattr");
>          } else {
> -                char *l;
> -                for (l = buf; l != (buf + bufsize) && *l != '\0';
> -                                l = strchr(l, '\0') + 1) {
> +                char *l = buf;
> +                while (l != (buf + ret)) {

Actually I believe while (l < (buf + ret)) is the correct form.

>                          printf("xattr: %s\n", l);
> +                        l = strchr(l, '\0') + 1;
>                  }
>          }
>  
> 
