Return-Path: <SRS0=5J60=4B=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB662C2BA83
	for <linux-fstests@archiver.kernel.org>; Thu, 13 Feb 2020 13:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954672168B
	for <linux-fstests@archiver.kernel.org>; Thu, 13 Feb 2020 13:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgBMNTP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:19:15 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43865 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbgBMNTP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 13 Feb 2020 08:19:15 -0500
Received: from mail-ua1-f70.google.com ([209.85.222.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mauricio.oliveira@canonical.com>)
        id 1j2EOf-0001eZ-9s
        for fstests@vger.kernel.org; Thu, 13 Feb 2020 13:19:13 +0000
Received: by mail-ua1-f70.google.com with SMTP id b18so1376803uaj.3
        for <fstests@vger.kernel.org>; Thu, 13 Feb 2020 05:19:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VzTRz87obxNP9+VuL9PW/virBqPgd0lR6fLLBPjYKB0=;
        b=TJ2BPl/CaLss/YICwK2QSuk6nZ366UOXtkQqowgSP+a08Nc+4BZZXQOpVdmdsA2+6j
         QR3xTWlpqli75FYr+l2fitNeL6wQn7/snNM7iNE3MmLLYXNwzeBOi2azYwh8vBNaLGAi
         Sul8ZArLKo+uvAZ5H+2GqSEVppIHYXAQc66qGwBnrKf7w3yMugLMvDKvAsI0mDR2K/Xv
         UnAEQeLJ08BJBCDM4l82ynkW6qGfllMPz96jnXAISu41FzUaMF8n7FRuuyRpVUnTTjNr
         CEdJbGN1/YUeN8jvkrGiVxIqFLRhPgEIYzjsGEFzuf4zn9RZd0ghco7HnV8Uy92WBWiu
         JXEQ==
X-Gm-Message-State: APjAAAUVLYL/07Nca3hRVr6ijh9MnetDbPBRoSpFO8WjdmkcxiRH5d52
        I+EEpf1Dzzk+HiSgpupqIJ5AeSFLYB9qJ3l+8twTGvo5SWR4ZFS9lG1Lwm9VeJHlItxgrUhOkb5
        8XVk7Ho5rDzMBst4bwYvZraV2ZtkOUSTNo+iMgoDcRew4IS1iFQg=
X-Received: by 2002:a67:80d3:: with SMTP id b202mr1983445vsd.142.1581599952261;
        Thu, 13 Feb 2020 05:19:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqzGMpGL2JGr2xZEHEAirJVeB9zuqDZdYyHx4NfIb5X3Hqg0Pp1MDQocKlcCCHoHpRz+KrBd31Fc+J4p139t+9s=
X-Received: by 2002:a67:80d3:: with SMTP id b202mr1983426vsd.142.1581599951876;
 Thu, 13 Feb 2020 05:19:11 -0800 (PST)
MIME-Version: 1.0
References: <20200213000406.4966-1-mfo@canonical.com> <CAOQ4uxjA4n7uJSUTHpRx_228HuBTtt5nNV8H0JmeKmczK_QBMA@mail.gmail.com>
In-Reply-To: <CAOQ4uxjA4n7uJSUTHpRx_228HuBTtt5nNV8H0JmeKmczK_QBMA@mail.gmail.com>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Thu, 13 Feb 2020 10:19:00 -0300
Message-ID: <CAO9xwp0QMXCXAB4qQ=0hzSb_dd9gGm9xK3gGXd8eUuz-KHnAXw@mail.gmail.com>
Subject: Re: [PATCH] common/overlay,rc: introduce OVL_ALT_FSTYP for testing aufs
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Feb 13, 2020 at 6:57 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Feb 13, 2020 at 2:05 AM Mauricio Faria de Oliveira
> <mfo@canonical.com> wrote:
> >
> > Recently looking for an aufs test suite. The author clarified that
> > 'There is no public test suite specific to aufs.' [1] at this time,
> > and it looks like 'xfstests/tests/generic' should be enough [1, 2],
> > and is clearly an improvement in terms of publicly available tests.
> >
> > Thus, building on top of the existing infrastructure for overlay,
> > just introduce OVL_ALT_FSTYP that can be set to "aufs" to use it.
> > (using overlay's upperdir as rw-branch and lowerdir as ro-branch).
> >
> > This is indeed a workaround^W simple change that does the job vs.
> > creating a new FSTYP "aufs" and mechanically changing the number
> > of places that check for "overlay" to just handle "aufs" as well.
> > (so the effort is still small as aufs has no specific tests now.)
>
> Very nice!
> Please update README.overlay.
>

Hi Amir, thanks for reviewing!
Sure, will do in v2 with your other comments.

> FYI, I made a similar small change to enable testing of fuse.overlay
> with unionmount-testsuite:
> https://github.com/amir73il/unionmount-testsuite/commit/a72c274e0f5d6d05ad7c563fc7eff42356bffd15
> Therefore:
> 1. Your changes could be useful for testing fuse.overlay with xfstests
> 2. You can just as easily test aufs with unionmount-testsuite -
> The test coverage is mostly orthogonal to that of xfstests
> (patches are welcome)

Glad that you mentioned it; I didn't know about unionmount-testsuite yet.
Right, both points are easy to address.  I'll work on the changes here.

> >
> > Currently, running the generic + overlay (i.e., ./check -overlay)
> > tests (and excluding a few [3] which either hang or keep looping)
> > the numbers for aufs on loop devices on v5.4-based Ubuntu kernel
> > show a relatively good starting base in terms of exercising code:
> >
> >   - Ran: 645 tests
> >   - Not run: 483 tests
> >   - Failures: 21 tests
>
> I'd be interested to know the stats for the overlay/* tests.

Out of the 71 tests in tests/overlay/*, 70 tests are listed in the log
(overlay/061 isn't, not sure why yet.)
Out of the 70 tests listed: 41 not run, 18 passed, 10 output mismatch,
1 expunged (overlay/019 hangs.)
If you're interested in the individual test results, just let me know
and I'll send the details as well.

>
> >
> > So, hopefully this may be a starting point as an aufs test suite.
> >
> > [1] https://sourceforge.net/p/aufs/mailman/message/36918721/
> > [2] https://sourceforge.net/p/aufs/mailman/message/36918932/
> > [3] Steps:
> >
> >   $ export OVL_ALT_FSTYP=aufs
> >   $ export FSTYP=ext4
> >   $ export TEST_DEV=/dev/loop0
> >   $ export TEST_DIR=/mnt/test
> >   $ export SCRATCH_DEV=/dev/loop1
> >   $ export SCRATCH_MNT=/mnt/scratch
> >
> >   $ sudo mkfs.$FSTYP -F $TEST_DEV
> >   $ sudo mkfs.$FSTYP -F $SCRATCH_DEV
> >   $ sudo mkdir $TEST_DIR $SCRATCH_MNT
> >
> >   $ cat <<EOF >/tmp/exclude-tests
> >   generic/013
> >   generic/070
> >   generic/075
> >   generic/112
> >   generic/127
> >   generic/461
> >   generic/476
> >   generic/522
> >   generic/530
> >   overlay/019
> >   EOF
> >
> >   $ sudo -E ./check -overlay -E /tmp/exclude-tests
> > ---
> >  common/overlay | 6 ++++++
> >  common/rc      | 4 ++++
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/common/overlay b/common/overlay
> > index 65c639e9c6d8..3b3351ed040e 100644
> > --- a/common/overlay
> > +++ b/common/overlay
> > @@ -20,6 +20,12 @@ _overlay_mount_dirs()
> >         local workdir=$3
> >         shift 3
> >
> > +       if [ -n "$OVL_ALT_FSTYP" -a "$OVL_ALT_FSTYP" = "aufs" ]; then
> > +               $MOUNT_PROG -t aufs -o br=$upperdir=rw:$lowerdir=ro \
> > +                       `_common_dev_mount_options $*`
> > +               return $?
> > +       fi
> > +
> >         $MOUNT_PROG -t overlay -o lowerdir=$lowerdir -o upperdir=$upperdir \
> >                     -o workdir=$workdir `_common_dev_mount_options $*`
>
> I think it would be better to define (in common/config):
>
> export OVL_FSTYP=${OVL_FSTYP:="overlay"}
>
> And make sure to always mount -t $OVL_FSTYP
> then you won't need to check if  OVL_ALT_FSTYP is non empty.
> and setting OVL_FSTYP to "fuse.overlay" should mostly work.
>

Indeed, that's better.

> I did find 5 overlay tests that do mount -t overlay not via any
> of the common helpers, so you'll need to handle those, possibly
> with another common helper that supports middle layers:
> tests/overlay/011
> tests/overlay/035
> tests/overlay/052
> tests/overlay/053
> tests/overlay/062

Thanks for bringing that up, I didn't imagine to look at other mount calls.

I'll work on your suggestions and send out a v2 (and look at
unionmount-testsuite.)
Again, thanks for reviewing, and for the constructive feedback.

cheers,

>
> Thanks,
> Amir.



-- 
Mauricio Faria de Oliveira
