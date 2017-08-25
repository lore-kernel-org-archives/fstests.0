Received: from mail-yw0-f193.google.com ([209.85.161.193]:35261 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754565AbdHYJTI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 25 Aug 2017 05:19:08 -0400
Received: by mail-yw0-f193.google.com with SMTP id x21so1012830ywg.2
        for <fstests@vger.kernel.org>; Fri, 25 Aug 2017 02:19:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1503503357-26234-4-git-send-email-amir73il@gmail.com>
References: <1503503357-26234-1-git-send-email-amir73il@gmail.com> <1503503357-26234-4-git-send-email-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 25 Aug 2017 12:19:07 +0300
Message-ID: <CAOQ4uxid_pV=J4c3GwTKownM=Yk_HMPYoEsE3++wjOYRhB7oTg@mail.gmail.com>
Subject: Re: [RFC][PATCH 3/8] fsx: fixes to random seed
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 23, 2017 at 6:49 PM, Amir Goldstein <amir73il@gmail.com> wrote:
> Not sure why, but with initstate()/setstate(), sfx generates
> same events regadless of the input seed argument.
>
> Change to use srandom() to fix the problem.
>
> Add pid to auto random seed, so parallel fsx executions with auto
> seed will use different seed values.
>
> At this time there are 6 tests that use sfx, out of which:
> 2 use -S 0 as seed (gettime()) - generic/{075,112}
> 2 do not specify seed (default = 1) - generic/{091,263}
> 1 uses explicit constant seed - generic/127
> 1 uses explicit $RANDOM seed - generic/231
>
> This change affects all those tests.
> The tests that intended to randomize the seed will now really
> randomize the seed.
> The tests that intended to use a constant seed will still use
> a constant seed, but resulting event sequence will be different
> than before this change.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Eryu,

While the rest of the series make take longer time to land,
I think you should consider applying this patch, or at least test
how it affects test results on your test systems.

Please let me know if you observe the same behavior as I do
(you  can use fsx -d to output all events to stdout)

I wonder what is your opinion of randomized seed vs. constant
seed in xfstest... anyway, the tests 075,112,231 seem to have
been using effectively constant seed up to now, not as author
intended.

Cheers,
Amir.

> ---
>  ltp/fsx.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 3713bbe..572df75 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -116,7 +116,6 @@ int fd;                             /* fd for our test file */
>  blksize_t      block_size = 0;
>  off_t          file_size = 0;
>  off_t          biggest = 0;
> -char           state[256];
>  unsigned long  testcalls = 0;          /* calls to function "test" */
>
>  unsigned long  simulatedopcount = 0;   /* -b flag */
> @@ -1909,8 +1908,10 @@ main(int argc, char **argv)
>                          break;
>                 case 'S':
>                          seed = getnum(optarg, &endp);
> -                       if (seed == 0)
> +                       if (seed == 0) {
>                                 seed = time(0) % 10000;
> +                               seed += (int)getpid();
> +                       }
>                         if (!quiet)
>                                 fprintf(stdout, "Seed set to %d\n", seed);
>                         if (seed < 0)
> @@ -1948,8 +1949,7 @@ main(int argc, char **argv)
>         signal(SIGUSR1, cleanup);
>         signal(SIGUSR2, cleanup);
>
> -       initstate(seed, state, 256);
> -       setstate(state);
> +       srandom(seed);
>         fd = open(fname,
>                 O_RDWR|(lite ? 0 : O_CREAT|O_TRUNC)|o_direct, 0666);
>         if (fd < 0) {
> --
> 2.7.4
>
