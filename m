Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:44767 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752290AbbE1Bc0 convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 27 May 2015 21:32:26 -0400
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/2] fsstress: add the [-l loops] option
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <1432774726-26824-1-git-send-email-tytso@mit.edu>
Date: Wed, 27 May 2015 20:32:23 -0500
Content-Transfer-Encoding: 8BIT
Message-Id: <DD1100D8-2CD7-49B8-A046-B18BC68A87B5@sandeen.net>
References: <1432774726-26824-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>



> On May 27, 2015, at 7:58 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> 
> This feature is in the ltp version of fsstress; port it into
> xfstests.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
> ltp/fsstress.c | 17 +++++++++++++----
> 1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index aa3e0c3..ad0c65f 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -330,7 +330,8 @@ int main(int argc, char **argv)
>    int             nousage = 0;
>    xfs_error_injection_t            err_inj;
>    struct sigaction action;
> -    const char    *allopts = "d:e:f:i:m:M:n:o:p:rs:S:vVwx:X:zH";
> +    int        loops = 1;
> +    const char    *allopts = "d:e:f:i:l:m:M:n:o:p:rs:S:vVwx:X:zH";
> 
>    errrange = errtag = 0;
>    umask(0);
> @@ -372,6 +373,9 @@ int main(int argc, char **argv)
>                exit(1);
>            }
>            break;
> +        case 'l':
> +            loops = atoi(optarg);
> +            break;
>        case 'n':
>            operations = atoi(optarg);
>            break;
> @@ -538,7 +542,8 @@ int main(int argc, char **argv)
>                }
>            }
>            procid = i;
> -            doproc();
> +            for (i = 0; !loops || (i < loops); i++)
> +                doproc();
>            return 0;
>        }
>    }
> @@ -896,10 +901,12 @@ doproc(void)
>            rval = stat64(".", &statbuf);
>            if (rval == EIO)  {
>                fprintf(stderr, "Detected EIO\n");
> -                return;
> +                goto errout;
>            }
>        }
>    }
> +errout:
> +    chdir("..");

This seems unrelated, no?

Eric


> }
> 
> /*
> @@ -1572,7 +1579,7 @@ void
> usage(void)
> {
>    printf("Usage: %s -H   or\n", myprog);
> -    printf("       %s [-d dir][-e errtg][-f op_name=freq][-n nops]\n",
> +    printf("       %s [-d dir][-e errtg][-f op_name=freq][-l loops][-n nops]\n",
>        myprog);
>    printf("          [-p nproc][-r len][-s seed][-v][-w][-x cmd][-z][-S][-X ncmd]\n");
>    printf("where\n");
> @@ -1582,6 +1589,8 @@ usage(void)
>    printf("                    the valid operation names are:\n");
>    show_ops(-1, "                        ");
>    printf("   -i filenum       get verbose output for this nth file object\n");
> +    printf("   -l loops         specifies the no. of times the testrun should loop.\n");
> +    printf("                     *use 0 for infinite (default 1)\n");
>    printf("   -m modulo        uid/gid modulo for chown/chgrp (default 32)\n");
>    printf("   -n nops          specifies the no. of operations per process (default 1)\n");
>    printf("   -o logfile       specifies logfile name\n");
> -- 
> 2.3.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
