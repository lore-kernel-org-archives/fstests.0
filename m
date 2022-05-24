Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7D4C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 10:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiEXKmb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 06:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiEXKma (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 06:42:30 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154D74DF4D
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 03:42:28 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id dn11so3423946qvb.7
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 03:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zOd2t3ZOKkxwByK9mbiTNPJWmKvL3nJLWctVugPmIDk=;
        b=OJO5srJZH9EbibJkxeHzJXhWK3zaKKwJKWL+ofEYu768VR8Nkiqdbe6xbo1zd7p7kK
         tU75or3z9MzdMEvmi5CO6viUHz0sxW5QSDm7cPJmLLWTbSNOA8eXv6nCx/DQZKRIK9dl
         1gH1wemS4KCZWpGnQwfsMqtZRg2pOcn/u6UJpEtM6GoHmRRttbzl+AhPr4L3oA/j3o3u
         li4rzrxQvejbDU1ALzA4VWHjTUehn8Wuxx2sn0iZppNb41qdD3P9kSt91lyFYjq6eMfl
         Hc79OS5d5gGj0s9cXZP+fn9e0U0uKSlYi1bIbISLy5LzrD0DbRQgRmmSev81bh2zr0JI
         +AYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zOd2t3ZOKkxwByK9mbiTNPJWmKvL3nJLWctVugPmIDk=;
        b=Adkh73wjyKXIVTEhegw4s9jCKGNDsNEBmIvHk35OmOcrx9rrCZ8YFW9MzcSr8HgmiN
         1ehCl9SR6Y8skBTxvCrAPkDTR/LCiQXnlWcwF4BH//AWD8TlQ7Qf2SH2Bz9Br5hWIWxx
         F7KK/lFWm/v40xpP45Jnw5WiE4XuxG6LPiIrDAbG5wuiRbsY1+E8ewoLjr5KunbooCJO
         +67CA3DXvoeBXWHtBy9KrPZskGGcRlrO7qmv1X7zPJsDOy+InjHIiqh5EmxfnSDNrLiM
         USN60dTdHh27N17f4YGGKXRBOsdt/Ema772xyIw9o18F2wfTpuK5Ky0VTEElhWv1YMz7
         /Mdw==
X-Gm-Message-State: AOAM530gh8nrryY6oq5I79jm8v7v5noDW24kckDnh6a3LRAE9wECUuGE
        VSyUsOTQcGJJOswmWPC0heTVgAnCJUS4T0Bq/2QwtGjZanE2cg==
X-Google-Smtp-Source: ABdhPJxX2KBWp/w9uxi3R7yoR7AxOM6JdF2cYRbPLnicUdvRyQnnwgdQIN1oRJU9GWQe3aUUECm3rfoc8JMG/d+aN/U=
X-Received: by 2002:a05:6214:2409:b0:432:bf34:362f with SMTP id
 fv9-20020a056214240900b00432bf34362fmr20690166qvb.66.1653388947087; Tue, 24
 May 2022 03:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220524073411.1943480-1-david@fromorbit.com> <20220524073411.1943480-4-david@fromorbit.com>
In-Reply-To: <20220524073411.1943480-4-david@fromorbit.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 24 May 2022 13:42:15 +0300
Message-ID: <CAOQ4uxgZwngHevX_FXytAi68k=aqp_N-8Buk50rrJKD0UoK+2g@mail.gmail.com>
Subject: Re: [PATCH 3/8] xfs/*: clean up _cleanup override
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 12:41 PM Dave Chinner <david@fromorbit.com> wrote:
>
> From: Dave Chinner <dchinner@redhat.com>
>
> Use a local cleanup function and _register_cleanup properly.
>
> Remove local cleanups that just do what the standard _cleanup and
> test exist does.
>
> Remove local cleanups that just remove test files and then do
> standard _cleanup functionality.

As I mentioned in response to the cover letter, the call to _cleanup()
can and I think should be chained implicitly, but I am still waiting
for your response regarding the tests where generic _cleanup is not
desired.

>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  tests/xfs/004     |  7 -------
>  tests/xfs/006     |  7 ++++---
>  tests/xfs/008     |  9 ++-------
>  tests/xfs/009     |  7 -------
>  tests/xfs/009.out |  1 -
>  tests/xfs/010     |  8 --------
>  tests/xfs/011     | 12 +++---------
>  tests/xfs/012     | 10 ++--------
>  tests/xfs/013     |  8 +++-----
>  tests/xfs/014     |  8 +++-----
>  tests/xfs/016     |  9 ---------
>  tests/xfs/016.out |  1 -
>  tests/xfs/017     |  7 -------
>  tests/xfs/019     |  8 --------
>  tests/xfs/019.out |  1 -
>  tests/xfs/020     |  9 ++++-----
>  tests/xfs/021     |  8 --------
>  tests/xfs/021.out |  1 -
>  tests/xfs/022     |  7 +++----
>  tests/xfs/023     |  7 +++----
>  tests/xfs/024     |  7 +++----
>  tests/xfs/025     |  7 +++----
>  tests/xfs/026     |  7 +++----
>  tests/xfs/027     |  7 +++----
>  tests/xfs/028     |  7 +++----
>  tests/xfs/030     |  8 --------
>  tests/xfs/033     |  8 --------
>  tests/xfs/034     |  9 ---------
>  tests/xfs/034.out |  1 -
>  tests/xfs/035     |  6 +++---
>  tests/xfs/036     |  7 +++----
>  tests/xfs/037     |  7 +++----
>  tests/xfs/038     |  7 +++----
>  tests/xfs/039     |  7 +++----
>  tests/xfs/041     |  8 --------
>  tests/xfs/042     |  7 -------
>  tests/xfs/043     |  7 +++----
>  tests/xfs/046     |  7 +++----
>  tests/xfs/047     |  7 +++----
>  tests/xfs/049     | 21 +++++++++------------
>  tests/xfs/050     |  8 --------
>  tests/xfs/051     |  9 ++++-----
>  tests/xfs/052     |  8 --------
>  tests/xfs/055     |  7 +++----
>  tests/xfs/056     |  7 +++----
>  tests/xfs/057     | 16 ++++++++++------
>  tests/xfs/059     |  7 +++----
>  tests/xfs/060     |  7 +++----
>  tests/xfs/061     |  7 +++----
>  tests/xfs/063     |  7 +++----
>  tests/xfs/064     |  7 +++----
>  tests/xfs/065     |  7 +++----
>  tests/xfs/066     |  9 ++++-----
>  tests/xfs/068     |  7 +++----
>  tests/xfs/070     |  7 +++----
>  tests/xfs/071     |  8 --------
>  tests/xfs/072     |  8 --------
>  tests/xfs/073     | 11 +++++------
>  tests/xfs/074     |  8 ++++----
>  tests/xfs/076     |  8 --------
>  tests/xfs/078     |  9 +++------
>  tests/xfs/079     | 11 +++++------
>  tests/xfs/080     |  7 -------
>  tests/xfs/083     |  7 +++----
>  tests/xfs/085     |  7 +++----
>  tests/xfs/086     |  7 +++----
>  tests/xfs/087     |  7 +++----
>  tests/xfs/088     |  7 +++----
>  tests/xfs/089     |  7 +++----
>  tests/xfs/091     |  7 +++----
>  tests/xfs/093     |  7 +++----
>  tests/xfs/097     |  7 +++----
>  tests/xfs/098     |  7 +++----
>  tests/xfs/099     |  7 +++----
>  tests/xfs/100     |  7 +++----
>  tests/xfs/101     |  7 +++----
>  tests/xfs/102     |  7 +++----
>  tests/xfs/105     |  7 +++----
>  tests/xfs/112     |  7 +++----
>  tests/xfs/113     |  7 +++----
>  tests/xfs/117     |  7 +++----
>  tests/xfs/120     |  7 +++----
>  tests/xfs/123     |  7 +++----
>  tests/xfs/124     |  7 +++----
>  tests/xfs/125     |  7 +++----
>  tests/xfs/126     |  7 +++----
>  tests/xfs/129     |  9 ++++-----
>  tests/xfs/130     |  7 +++----
>  tests/xfs/131     |  8 --------
>  tests/xfs/139     |  7 -------
>  tests/xfs/140     |  7 -------
>  tests/xfs/141     | 11 +++++------
>  tests/xfs/148     |  7 +++----
>  tests/xfs/149     | 15 ++++++++-------
>  tests/xfs/152     | 21 +++++++++------------
>  tests/xfs/153     |  8 --------
>  tests/xfs/157     |  8 ++++----
>  tests/xfs/159     |  8 --------
>  tests/xfs/167     |  9 +++++----
>  tests/xfs/169     |  8 --------
>  tests/xfs/177     |  6 +++---
>  tests/xfs/181     | 10 ++++------
>  tests/xfs/185     | 10 +++++-----
>  tests/xfs/188     |  8 --------
>  tests/xfs/189     |  8 +++-----
>  tests/xfs/194     | 12 ------------
>  tests/xfs/195     |  8 +-------
>  tests/xfs/197     |  7 +------
>  tests/xfs/199     |  7 -------
>  tests/xfs/201     |  6 ------
>  tests/xfs/206     | 12 ++++++------
>  tests/xfs/220     |  7 -------
>  tests/xfs/229     |  7 +------
>  tests/xfs/231     |  7 +++----
>  tests/xfs/232     |  7 +++----
>  tests/xfs/234     |  9 ++++-----
>  tests/xfs/236     |  8 --------
>  tests/xfs/237     | 10 +++++-----
>  tests/xfs/239     |  8 ++++----
>  tests/xfs/240     | 10 +++++-----
>  tests/xfs/241     |  8 ++++----
>  tests/xfs/244     |  8 --------
>  tests/xfs/250     |  6 +++---
>  tests/xfs/253     |  9 ---------
>  tests/xfs/259     |  8 +++++---
>  tests/xfs/260     | 11 +----------
>  tests/xfs/261     |  7 -------
>  tests/xfs/264     |  7 +++----
>  tests/xfs/265     |  8 --------
>  tests/xfs/266     |  7 +++----
>  tests/xfs/267     |  7 +++----
>  tests/xfs/268     |  8 +++-----
>  tests/xfs/269     |  7 -------
>  tests/xfs/271     |  8 ++++----
>  tests/xfs/272     |  8 ++++----
>  tests/xfs/273     |  8 ++++----
>  tests/xfs/274     |  8 ++++----
>  tests/xfs/275     |  8 ++++----
>  tests/xfs/276     |  8 ++++----
>  tests/xfs/277     |  9 +++++----
>  tests/xfs/279     |  9 ++++-----
>  tests/xfs/281     |  7 +++----
>  tests/xfs/282     |  7 +++----
>  tests/xfs/283     |  7 +++----
>  tests/xfs/284     | 10 ++++------
>  tests/xfs/287     |  7 +++----
>  tests/xfs/289     | 17 +++++++++--------
>  tests/xfs/296     |  9 ++++-----
>  tests/xfs/299     |  8 --------
>  tests/xfs/301     |  9 ++++-----
>  tests/xfs/302     |  9 ++++-----
>  tests/xfs/309     |  8 --------
>  tests/xfs/310     |  8 +++-----
>  tests/xfs/311     | 10 ++++------
>  tests/xfs/312     |  8 --------
>  tests/xfs/313     |  8 --------
>  tests/xfs/314     |  8 --------
>  tests/xfs/315     |  8 --------
>  tests/xfs/316     |  8 --------
>  tests/xfs/317     |  8 --------
>  tests/xfs/318     |  8 --------
>  tests/xfs/319     |  8 --------
>  tests/xfs/320     |  8 --------
>  tests/xfs/321     |  8 --------
>  tests/xfs/322     |  8 --------
>  tests/xfs/323     |  8 --------
>  tests/xfs/324     |  8 --------
>  tests/xfs/325     |  8 --------
>  tests/xfs/326     |  8 --------
>  tests/xfs/327     |  8 --------
>  tests/xfs/336     |  7 -------
>  tests/xfs/432     |  8 ++++----
>  tests/xfs/438     | 16 ++++++++++------
>  tests/xfs/442     | 10 +++++-----
>  tests/xfs/447     |  7 +++----
>  tests/xfs/501     |  7 +++----
>  tests/xfs/503     | 10 ++++------
>  tests/xfs/507     | 13 +++++--------
>  tests/xfs/511     |  8 --------
>  tests/xfs/512     |  8 +-------
>  tests/xfs/513     | 15 +++++----------
>  tests/xfs/514     | 10 ++++------
>  tests/xfs/515     | 10 ++++------
>  tests/xfs/516     |  7 -------
>  tests/xfs/517     |  9 +++------
>  tests/xfs/520     |  8 --------
>  tests/xfs/521     |  8 ++++----
>  tests/xfs/522     |  7 -------
>  tests/xfs/523     |  7 -------
>  tests/xfs/524     |  8 ++++----
>  tests/xfs/525     |  7 -------
>  tests/xfs/526     |  7 -------
>  tests/xfs/528     |  6 +++---
>  tests/xfs/530     |  6 +++---
>  tests/xfs/542     |  7 ++++---
>  tests/xfs/543     |  7 -------
>  tests/xfs/544     | 11 ++++++++---
>  197 files changed, 477 insertions(+), 1106 deletions(-)
>

Wow! that cleanup is awesome and huge and was very hard to review!

> diff --git a/tests/xfs/004 b/tests/xfs/004
> index f18316b3..f8cfeb6a 100755
> --- a/tests/xfs/004
> +++ b/tests/xfs/004
> @@ -11,13 +11,6 @@ _begin_fstest db auto quick
>
>  status=0
>
> -# Override the default cleanup function.
> -_cleanup()
> -{
> -       _scratch_unmount
> -       rm -f $tmp.*
> -}
> -
>  _populate_scratch()
>  {
>         echo "=== mkfs output ===" >>$seqres.full
> diff --git a/tests/xfs/006 b/tests/xfs/006
> index cecceaa3..fd8d8071 100755
> --- a/tests/xfs/006
> +++ b/tests/xfs/006
> @@ -11,11 +11,10 @@
>  _begin_fstest auto quick mount eio
>
>  # Override the default cleanup function.
> -_cleanup()
> +_dmerror_cleanup()
>  {
> -       cd /
> -       rm -f $tmp.*
>         _dmerror_cleanup

That looks recursive.
Again, if the call to _cleanup is implicitly chained then
the local function is not needed and trap can call
the global _dmerror_cleanup().

> +       _cleanup
>  }
>
>  # Import common functions.
> @@ -28,6 +27,8 @@ _require_scratch
>  _require_dm_target error
>  _require_fs_sysfs error/fail_at_unmount
>
> +_register_cleanup _dmerror_cleanup
> +
>  _scratch_mkfs > $seqres.full 2>&1
>  _dmerror_init
>  _dmerror_mount
> diff --git a/tests/xfs/008 b/tests/xfs/008
> index a53f6c92..5bef44bb 100755
> --- a/tests/xfs/008
> +++ b/tests/xfs/008
> @@ -12,13 +12,6 @@ _begin_fstest rw ioctl auto quick
>  status=0       # success is the default!
>  pgsize=`$here/src/feature -s`
>
> -# Override the default cleanup function.
> -_cleanup()
> -{
> -    rm -f $tmp.*
> -    rm -rf $TEST_DIR/randholes.$$.*

It's fine to keep the test files behind, but maybe
make that change more clear in commit message
because it was not clear to me that there was a change of
behavior when I read the commit message.

Sorry to drop this extra burden on you, but this seems
important to me and I cannot add this information after the fact.

Also, it was very hard to see in this review if the test files
that are not cleaned in cleanup() are cleaned in the beginning
of the test or if it is not important to clean them because they
are overwritten.

I did my best to try and I think there is a missing cleanup of
${OUTPUT_DIR} in the beginning of xfs/253.
Although that may already be considered a test bug, removing
the cleanup of ${OUTPUT_DIR} from cleanup() will expose this bug.

[...]

> diff --git a/tests/xfs/051 b/tests/xfs/051
> index ea70cb50..4718099d 100755
> --- a/tests/xfs/051
> +++ b/tests/xfs/051
> @@ -11,14 +11,13 @@
>  . ./common/preamble
>  _begin_fstest shutdown auto log metadata
>
> -# Override the default cleanup function.
> -_cleanup()
> +_fsstress_cleanup()
>  {
> -       cd /
> -       rm -f $tmp.*
>         $KILLALL_PROG -9 $FSSTRESS_PROG > /dev/null 2>&1
> -       _scratch_unmount > /dev/null 2>&1
> +       wait

All right. I see that cleanup helpers are not consistent
in calling wait after kill and in using SIGKILL.
I guess we could go either way. So be it.

[...]

> diff --git a/tests/xfs/310 b/tests/xfs/310
> index 3214e04b..c635b39a 100755
> --- a/tests/xfs/310
> +++ b/tests/xfs/310
> @@ -9,14 +9,12 @@
>  . ./common/preamble
>  _begin_fstest auto clone rmap
>
> -# Override the default cleanup function.
> -_cleanup()
> +_dmhuge_cleanup()
>  {
> -       cd /
> -       umount $SCRATCH_MNT > /dev/null 2>&1
>         _dmhugedisk_cleanup
> -       rm -rf $tmp.*
> +       _cleanup
>  }
> +_register_cleanup _dmhuge_cleanup
>


Maybe it's just me, but if the intention is to maybe make this
function global someday then the difference with the name
_dmhugedisk_cleanup() is confusing.

I'd rather keep the local function name local_cleanup
in unclear cases like this one.

Thanks,
Amir.

>  }
> +_register_cleanup local_cleanup
>
>  # Import common functions.
>  . ./common/filter
> --
> 2.35.1
>
