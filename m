Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCEECCA47E
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Jun 2022 06:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiFXGcA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Jun 2022 02:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiFXGb7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Jun 2022 02:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC99B5DF05
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 23:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656052317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yumagLuEvxzAiEbR0DtX3xBdFOVOmjtNhdUlQzSb9nY=;
        b=aix22s8RxAK9ITCoOy/0qB+d3cW4p+HprQCkmmBdh7Opxwr2sr20pAFQZ70FSeQY3FlKrq
        UDxHU7asQeA/+hhmMCQ50NRZ6ENzyff3HORyzdckg+ywyM6wqp7ZNb4sQ2c4dQFyQFM5z3
        E4e5T6BeOV+0OjzI2EUJvyonAG9BcjE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166--3QJV8LqPo2YkxGUunNS_w-1; Fri, 24 Jun 2022 02:31:56 -0400
X-MC-Unique: -3QJV8LqPo2YkxGUunNS_w-1
Received: by mail-qk1-f200.google.com with SMTP id ay8-20020a05620a178800b006a76e584761so1681055qkb.13
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 23:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yumagLuEvxzAiEbR0DtX3xBdFOVOmjtNhdUlQzSb9nY=;
        b=iqic230YYz9H4fvm192kTyQ13iYOdZuiZ89369f/5lM/AofsF/lT3NeuddOqKO+6Z8
         89G4ph6ueFV3wYF0SDq2klopt3CTtAKaY73AJKxBqMzWvStoudgXl5pjpbNwcU2a6Qrx
         LUOsWOEJJWcijXXme/bMWAF9UDhoacVaJQELn97R0jkEUSbtgueY2Ik24wmnWOeCT0Ku
         dDrqcRPDW4VLhjsM8t1ol26dHrYFr18lZ7XWyrlwedFHGSc76DWJOJ7Q7DBKMlQqVWI+
         k2F/I/ewL4ADHio8+G5x2AnNvV9GaoXNAwlsZegqFW+D4WV6MkFyLXrZuyamRYpJR5wD
         kGNg==
X-Gm-Message-State: AJIora+6eQ0O2hjTWJMOTwjHwPjOg9lRrIkGuJ+x+uRBDV95TWb5HqTN
        Jxzu7cN1va/VBGIdREwZyc+mT3HVrqa+YDQC8UvjDYicrsqED6pwFv5ZmNPAHXwTUt//cF2WA8u
        f4XGYEZRzNX6N8YRqiw==
X-Received: by 2002:ac8:5f46:0:b0:305:fba:c105 with SMTP id y6-20020ac85f46000000b003050fbac105mr11331467qta.169.1656052315403;
        Thu, 23 Jun 2022 23:31:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sDPh29DMlCo+gTcBKStFylonyVuT1YE8Hq0p5V1Yy/o0UO5TJlIVhTfb0cutGasT01Z4N6ew==
X-Received: by 2002:ac8:5f46:0:b0:305:fba:c105 with SMTP id y6-20020ac85f46000000b003050fbac105mr11331462qta.169.1656052315124;
        Thu, 23 Jun 2022 23:31:55 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b13-20020ac85bcd000000b00304ea0a86cesm926790qtb.81.2022.06.23.23.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 23:31:54 -0700 (PDT)
Date:   Fri, 24 Jun 2022 14:31:49 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH 3/4] xfs/{422,517}: add missing killall to _cleanup()
Message-ID: <20220624063149.4ssefnfi5tboogp4@zlang-mailbox>
References: <20220619134657.1846292-1-amir73il@gmail.com>
 <20220619134657.1846292-4-amir73il@gmail.com>
 <CAOQ4uxj350-k2bzCSD_j35XCH5E-VcdtfHmW3d_ZrSzHxWA5CQ@mail.gmail.com>
 <YrSrLgU1OIgaaxiB@magnolia>
 <CAOQ4uxiyWnLFe95YXQ-xzYyK4D50-6pbqpduyZZzttvuXvVETg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiyWnLFe95YXQ-xzYyK4D50-6pbqpduyZZzttvuXvVETg@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jun 24, 2022 at 07:36:51AM +0300, Amir Goldstein wrote:
> On Thu, Jun 23, 2022 at 9:04 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Tue, Jun 21, 2022 at 07:02:02AM +0300, Amir Goldstein wrote:
> > > On Sun, Jun 19, 2022 at 4:47 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > >
> > > > Those tests failed to cleanup background jobs after test
> > > > is interrupted.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >  tests/xfs/422 | 8 ++++++++
> > > >  tests/xfs/517 | 1 +
> > > >  2 files changed, 9 insertions(+)
> > > >
> > > > diff --git a/tests/xfs/422 b/tests/xfs/422
> > > > index a83a66df..8e9a3576 100755
> > > > --- a/tests/xfs/422
> > > > +++ b/tests/xfs/422
> > > > @@ -13,6 +13,14 @@ _begin_fstest dangerous_scrub dangerous_online_repair freeze
> > > >
> > > >  _register_cleanup "_cleanup" BUS
> > > >
> > > > +# Override the default cleanup function.
> > > > +_cleanup()
> > > > +{
> > > > +       $KILLALL_PROG -9 $XFS_IO_PROG $FSSTRESS_PROG > /dev/null 2>&1
> > > > +       cd /
> > > > +       rm -rf $tmp.*
> > > > +}
> > > > +
> > > >  # Import common functions.
> > > >  . ./common/filter
> > > >  . ./common/fuzzy
> > > > diff --git a/tests/xfs/517 b/tests/xfs/517
> > > > index 961668e3..18404248 100755
> > > > --- a/tests/xfs/517
> > > > +++ b/tests/xfs/517
> > > > @@ -14,6 +14,7 @@ _register_cleanup "_cleanup" BUS
> > > >  # Override the default cleanup function.
> > > >  _cleanup()
> > > >  {
> > > > +       $KILLALL_PROG -9 $XFS_IO_PROG $FSSTRESS_PROG > /dev/null 2>&1
> > >
> > > Besides the missing wait, this cleanup is still racy, because stress_loop
> > > can spawn a new fstress process after killall /proc iteration.
> > >
> > > Worst, freeze_loop can freeze after killall /proc iteration.
> > >
> > > The correct solution (I think) is to record the pid of the XXX_loop
> > > sub-shells and kill those, which should also solve the "Terminated"
> > > false positive error.
> > >
> > > Will give that a shot.
> >
> > FWIW I already have patches reworking 422 and all the other
> > scrub-related stress tests:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=race-scrub-and-mount-state-changes
> >
> 
> That looks very nice.
> The cleanup looks very similar to the one I posted for v2,
> but instead of "killall xfs_io fsstress" you would be better off with
> "kill  $__SCRUB_STRESS_FREEZE_PID"
> 
> killing the child process and waiting for its parent bash
> process has the side effect of the bash parent emitting
> "Terminated" or "Killed" message with breaks golden output
> if the inner loop did not already exit, which is the behavior
> that got me started on doing this cleanup.
> 
> > I swear I'll send all these some day, if I ever get caught up...
> > Delegating LTS maintenance is a big help, but as it is I still can't
> > stay abreast of all the mainline patchsets /and/ send my own stuff. :(
> >
> 
> I will respond to that in another email.

Hi Amir,

So ... will you singly resend a V3 patch to remove the xfs/422 changes in this patch?

Thanks,
Zorro

> 
> Thanks,
> Amir.
> 

