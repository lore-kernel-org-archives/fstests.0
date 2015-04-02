Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37010 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbbDBVFk (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 2 Apr 2015 17:05:40 -0400
Received: by igcxg11 with SMTP id xg11so83981004igc.0
        for <fstests@vger.kernel.org>; Thu, 02 Apr 2015 14:05:40 -0700 (PDT)
MIME-Version: 1.0
Reply-To: fdmanana@gmail.com
In-Reply-To: <1427990168-21503-1-git-send-email-omzg@plexistor.com>
References: <1427990168-21503-1-git-send-email-omzg@plexistor.com>
Date: Thu, 2 Apr 2015 22:05:40 +0100
Message-ID: <CAL3q7H4KPH22AptJaSMFapp1iOECuWHKUjEYznrCwe7mV5SUcg@mail.gmail.com>
Subject: Re: [PATCH] generic/076: fixed incorrect fsstress parameters
From: Filipe David Manana <fdmanana@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Omer Zilberberg <omzg@plexistor.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 2, 2015 at 4:56 PM, Omer Zilberberg <omzg@plexistor.com> wrote:
> Test was not run because directory parameter was omitted.
> Also return value was not tested, so this problem was not caught.
>
> Signed-off-by: Omer Zilberberg <omzg@plexistor.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Tested-by: Filipe Manana <fdmanana@suse.com>

> ---
>  tests/generic/076 | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tests/generic/076 b/tests/generic/076
> index aa0aae0..3e1aa1a 100755
> --- a/tests/generic/076
> +++ b/tests/generic/076
> @@ -74,9 +74,11 @@ echo "*** test concurrent block/fs access"
>  cat $SCRATCH_DEV >/dev/null &
>  pid=$!
>
> -FSSTRESS_ARGS=`_scale_fsstress_args -p 2 -n 2000 $FSSTRESS_AVOID`
> +FSSTRESS_ARGS=`_scale_fsstress_args -d $SCRATCH_MNT -p 2 -n 2000 $FSSTRESS_AVOID`
>  echo "run fsstress with args: $FSSTRESS_ARGS" >>$seqres.full
>  $FSSTRESS_PROG $FSSTRESS_ARGS >>$seqres.full
> +rc=$?
> +[ $rc != 0 ] && echo "fsstress returned $rc - see $seqres.full"

run_check $FSSTRESS_PROG $FSSTRESS_ARGS

Would also do it (some other tests do this).
Just a minor detail.

Thanks.

>  _lets_get_pidst
>
>  echo "*** done"
> --
> 1.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Filipe David Manana,

"Reasonable men adapt themselves to the world.
 Unreasonable men adapt the world to themselves.
 That's why all progress depends on unreasonable men."
