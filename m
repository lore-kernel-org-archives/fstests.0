Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFA0C38A2D
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Oct 2022 13:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbiJZNrC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Oct 2022 09:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbiJZNq2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Oct 2022 09:46:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1167EFC3
        for <fstests@vger.kernel.org>; Wed, 26 Oct 2022 06:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666791973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bruAT5FN5UzkvBgHAVJeHTZnXfRT2vJaSunCwR3GLy0=;
        b=CAuIXGhRrUJSlZFpP+OLd4K/dzKXi6pXDIGW5wy4YC1WmwiOwM7IIg5gnTIEz2muIwMmQd
        ElKvSTNMxuUSrHLzbVahZezNwH4FVxU+5mSLlzDI86p3N09/tksAVY4YY26B7rJ0C8pCJY
        rli2k4d7UG0IGojAEjCm8HbEob6mw3c=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-58-wAYOwz5eM-K_wSEB0U6odA-1; Wed, 26 Oct 2022 09:46:12 -0400
X-MC-Unique: wAYOwz5eM-K_wSEB0U6odA-1
Received: by mail-pj1-f71.google.com with SMTP id z9-20020a17090a468900b00202fdb32ba1so1245199pjf.1
        for <fstests@vger.kernel.org>; Wed, 26 Oct 2022 06:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bruAT5FN5UzkvBgHAVJeHTZnXfRT2vJaSunCwR3GLy0=;
        b=WDn2x+7M4Wb9scJEdHFIbqgTMiSh9m9lN67rgQyRubq3yUJ5PqMkIwqdtqIqYaujsr
         xKUhKwkjW9lisy1pVIkAR2JDcvsqXMB8vX8jW5etj6U4aAA8RLG5I3Bqp9VrePnxy2wC
         80gqGKats1WAyyDkHQwAE0Gz4/4thgmbGUfYp+4wDTkMhmtU5w8GNmTw90Rkx+ncju+B
         hQ7+AiKg+xZ35PNucAbmZBT623BT8pNedKq5X056A17lzZVN5Y5odbiMbevsKGvGdEYV
         Dc7pB6ybCo25ZFhQJgOdAUgRYbSnnef6i0oGk3BhcvqEF4gxvWo3KQeEfWc4GcNxsnjm
         trgg==
X-Gm-Message-State: ACrzQf1tluTBigc1HnkXNftFSIZAyz8NFATUiU5yILWPtniW07HV5uhF
        faLTQ02L29sNlONXjEJfAoYWQCsQmSYZ8jW5+wFsDs9Yk1D8pDxwRTpYG/+io1rzLUfuiugBQeg
        M8PHyU0SuOEojNwiIaA==
X-Received: by 2002:a63:dc54:0:b0:44c:ce26:fa35 with SMTP id f20-20020a63dc54000000b0044cce26fa35mr38559242pgj.374.1666791970298;
        Wed, 26 Oct 2022 06:46:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4BZAQADVkqt6gsC3mjYWhVJkJMQZXggkbquaa0yqbxe5S/0fYvhYvldFm2KPuwoMP2f2INQQ==
X-Received: by 2002:a63:dc54:0:b0:44c:ce26:fa35 with SMTP id f20-20020a63dc54000000b0044cce26fa35mr38559227pgj.374.1666791970007;
        Wed, 26 Oct 2022 06:46:10 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a187-20020a621ac4000000b0056bcc744bdbsm3005438pfa.203.2022.10.26.06.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 06:46:09 -0700 (PDT)
Date:   Wed, 26 Oct 2022 21:46:04 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org,
        linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] generic/455: add $FSX_AVOID
Message-ID: <20221026134604.ks5pview6j6ly4t4@zlang-mailbox>
References: <20221021211950.510006-1-enwlinux@gmail.com>
 <20221026030827.GT2703033@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026030827.GT2703033@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Oct 26, 2022 at 02:08:27PM +1100, Dave Chinner wrote:
> On Fri, Oct 21, 2022 at 05:19:50PM -0400, Eric Whitney wrote:
> > generic/455 fails when run on an ext4 bigalloc file system.  Its
> > fsx invocations can make insert range and collapse range calls whose
> > arguments are not cluster aligned, and ext4 will fail those calls for
> > bigalloc.  They can be suppressed by adding the FSX_AVOID environment
> > variable to the fsx invocation and setting its value appropriately in
> > the test environment, as is done for other fsx-based tests.  This
> > avoids the need to exclude the test to avoid failures and makes it
> > possible to take advantage of the remainder of its coverage.
> > 
> > Signed-off-by: Eric Whitney <enwlinux@gmail.com>
> > ---
> >  tests/generic/455 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/generic/455 b/tests/generic/455
> > index 649b5410..c13d872c 100755
> > --- a/tests/generic/455
> > +++ b/tests/generic/455
> > @@ -77,7 +77,7 @@ FSX_OPTS="-N $NUM_OPS -d -P $SANITY_DIR -i $LOGWRITES_DMDEV"
> >  seeds=(0 0 0 0)
> >  # Run fsx for a while
> >  for j in `seq 0 $((NUM_FILES-1))`; do
> > -	run_check $here/ltp/fsx $FSX_OPTS -S ${seeds[$j]} -j $j $SCRATCH_MNT/testfile$j &
> > +	run_check $here/ltp/fsx $FSX_OPTS $FSX_AVOID -S ${seeds[$j]} -j $j $SCRATCH_MNT/testfile$j &
> 
> generic/457 needs this fix as well.

Yes,
$ grep -rsn here/ltp/fsx tests/|grep -Ev "FSX_AVOID|replay-ops"
tests/generic/457:86:   run_check $here/ltp/fsx $FSX_OPTS -S 0 -j $j $SCRATCH_MNT/testfile$j &
tests/generic/455:80:   run_check $here/ltp/fsx $FSX_OPTS -S ${seeds[$j]} -j $j $SCRATCH_MNT/testfile$j &

Hi Eric,

May you resend this patch? And you can keep Darrick's RVB in V2.

Thanks,
Zorro

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

