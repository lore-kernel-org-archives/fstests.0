Return-Path: <SRS0=5J60=4B=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502CFC2BA83
	for <linux-fstests@archiver.kernel.org>; Thu, 13 Feb 2020 09:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203542073C
	for <linux-fstests@archiver.kernel.org>; Thu, 13 Feb 2020 09:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IButqSES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgBMJ5y (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:57:54 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:42475 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729422AbgBMJ5y (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 13 Feb 2020 04:57:54 -0500
Received: by mail-il1-f193.google.com with SMTP id x2so4431914ila.9
        for <fstests@vger.kernel.org>; Thu, 13 Feb 2020 01:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hfQq+GyezI/Vi1KpBUdrNwV4jCZuWDxu6fB4iGXg8zk=;
        b=IButqSESVtF5VGa4wrkQk4LtdhOBlf0yZX4iSf0AaMah52C19wODhT+HmVxzhsbJ/1
         MPA2PPw+S6+GbXzGK7/giTfzIaBCWYVGfRDmjkPQ/N4Ilx1plrf6JlMQGVofbhTUrg/m
         VihFJpLrWIBGD6SQ2/vR2gwucfjl9vURT7Z1gr2AQ55QqtGpJAyZfqHt9rgzckoqcS0H
         /enEmZxW6DFtsn7dHT0As/MEqxh48fxBZx3bYIovKBwDlR0KEO1V42j1suCF8ZdWqlQg
         Q1i6B5tmVyYQqnzrC2v8gd3YYJr5drdZDvkdttf3x6nl/NC13yMTD4XFKl4u5lSBMvs+
         ydAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hfQq+GyezI/Vi1KpBUdrNwV4jCZuWDxu6fB4iGXg8zk=;
        b=d6r14RzkHcg9pbFrNc3mKsgHYt4xvz8dLbcz+J23N0QI0bdvahm1dG+HE+Chit0JRb
         z3BqMESu8bCPiHkYFTYegLDEKu7WsQpQrjhxa2RssanIWX8mw4wDm2aIeDtUwfuCKtzW
         pa5aWEfYaECj+mUttEV3SNVGeEYa9SArRfcnUd2Xz6xOiY2haDOXuIhXtFh1fF61K+Mr
         lb1C7CjvcyzEiHDujPSYSaNxxR/6xQ0NLGf9MRYPxFi+0TmL60p60Yw48G6Qk4awW2Ro
         z3xnf48KSg83uid9m6Bp9h2r/iokmsSjfXwln+oLvDHAb32eHfRG6GGDh2qe5o4fbA6R
         kkTg==
X-Gm-Message-State: APjAAAX+OlklZRt3mu58iPLnpNJuLp8VDGJuhG3VmE4mBti/K4IprEXJ
        qaBWwApAS5tkql2Y7XbO1PUe98W/S/8ryo1JX+U=
X-Google-Smtp-Source: APXvYqy86czCn9Tcvvx9TZyLkFooBVVG1DP+ATqX81Y0ZSY+oTBHyHDQaXAtjcch8KGx//2KN5kHlSehQqmbTlp8el0=
X-Received: by 2002:a92:8656:: with SMTP id g83mr15836459ild.9.1581587873983;
 Thu, 13 Feb 2020 01:57:53 -0800 (PST)
MIME-Version: 1.0
References: <20200213000406.4966-1-mfo@canonical.com>
In-Reply-To: <20200213000406.4966-1-mfo@canonical.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 13 Feb 2020 11:57:42 +0200
Message-ID: <CAOQ4uxjA4n7uJSUTHpRx_228HuBTtt5nNV8H0JmeKmczK_QBMA@mail.gmail.com>
Subject: Re: [PATCH] common/overlay,rc: introduce OVL_ALT_FSTYP for testing aufs
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Feb 13, 2020 at 2:05 AM Mauricio Faria de Oliveira
<mfo@canonical.com> wrote:
>
> Recently looking for an aufs test suite. The author clarified that
> 'There is no public test suite specific to aufs.' [1] at this time,
> and it looks like 'xfstests/tests/generic' should be enough [1, 2],
> and is clearly an improvement in terms of publicly available tests.
>
> Thus, building on top of the existing infrastructure for overlay,
> just introduce OVL_ALT_FSTYP that can be set to "aufs" to use it.
> (using overlay's upperdir as rw-branch and lowerdir as ro-branch).
>
> This is indeed a workaround^W simple change that does the job vs.
> creating a new FSTYP "aufs" and mechanically changing the number
> of places that check for "overlay" to just handle "aufs" as well.
> (so the effort is still small as aufs has no specific tests now.)

Very nice!
Please update README.overlay.

FYI, I made a similar small change to enable testing of fuse.overlay
with unionmount-testsuite:
https://github.com/amir73il/unionmount-testsuite/commit/a72c274e0f5d6d05ad7c563fc7eff42356bffd15
Therefore:
1. Your changes could be useful for testing fuse.overlay with xfstests
2. You can just as easily test aufs with unionmount-testsuite -
The test coverage is mostly orthogonal to that of xfstests
(patches are welcome)

>
> Currently, running the generic + overlay (i.e., ./check -overlay)
> tests (and excluding a few [3] which either hang or keep looping)
> the numbers for aufs on loop devices on v5.4-based Ubuntu kernel
> show a relatively good starting base in terms of exercising code:
>
>   - Ran: 645 tests
>   - Not run: 483 tests
>   - Failures: 21 tests

I'd be interested to know the stats for the overlay/* tests.

>
> So, hopefully this may be a starting point as an aufs test suite.
>
> [1] https://sourceforge.net/p/aufs/mailman/message/36918721/
> [2] https://sourceforge.net/p/aufs/mailman/message/36918932/
> [3] Steps:
>
>   $ export OVL_ALT_FSTYP=aufs
>   $ export FSTYP=ext4
>   $ export TEST_DEV=/dev/loop0
>   $ export TEST_DIR=/mnt/test
>   $ export SCRATCH_DEV=/dev/loop1
>   $ export SCRATCH_MNT=/mnt/scratch
>
>   $ sudo mkfs.$FSTYP -F $TEST_DEV
>   $ sudo mkfs.$FSTYP -F $SCRATCH_DEV
>   $ sudo mkdir $TEST_DIR $SCRATCH_MNT
>
>   $ cat <<EOF >/tmp/exclude-tests
>   generic/013
>   generic/070
>   generic/075
>   generic/112
>   generic/127
>   generic/461
>   generic/476
>   generic/522
>   generic/530
>   overlay/019
>   EOF
>
>   $ sudo -E ./check -overlay -E /tmp/exclude-tests
> ---
>  common/overlay | 6 ++++++
>  common/rc      | 4 ++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/common/overlay b/common/overlay
> index 65c639e9c6d8..3b3351ed040e 100644
> --- a/common/overlay
> +++ b/common/overlay
> @@ -20,6 +20,12 @@ _overlay_mount_dirs()
>         local workdir=$3
>         shift 3
>
> +       if [ -n "$OVL_ALT_FSTYP" -a "$OVL_ALT_FSTYP" = "aufs" ]; then
> +               $MOUNT_PROG -t aufs -o br=$upperdir=rw:$lowerdir=ro \
> +                       `_common_dev_mount_options $*`
> +               return $?
> +       fi
> +
>         $MOUNT_PROG -t overlay -o lowerdir=$lowerdir -o upperdir=$upperdir \
>                     -o workdir=$workdir `_common_dev_mount_options $*`

I think it would be better to define (in common/config):

export OVL_FSTYP=${OVL_FSTYP:="overlay"}

And make sure to always mount -t $OVL_FSTYP
then you won't need to check if  OVL_ALT_FSTYP is non empty.
and setting OVL_FSTYP to "fuse.overlay" should mostly work.

I did find 5 overlay tests that do mount -t overlay not via any
of the common helpers, so you'll need to handle those, possibly
with another common helper that supports middle layers:
tests/overlay/011
tests/overlay/035
tests/overlay/052
tests/overlay/053
tests/overlay/062

Thanks,
Amir.
