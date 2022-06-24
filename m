Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F39FC433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Jun 2022 06:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiFXGlt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Jun 2022 02:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiFXGls (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Jun 2022 02:41:48 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6641062C33
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 23:41:47 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id 184so1487814vsz.2
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 23:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kiOdsfq9BfcWUhAwCL6OI+smmytdXoJSLNdmVVWV378=;
        b=drJxOQhBm6iNzXUT3wDn1799i3UrHdkjX0kdANo7CZiCqj/Dzpc5m4Sap8KgTPWw2s
         itaNDnQ3gJo1z3kZafYIajL3nOn6+s9LnvrI4xCDjKa91mNv/AXEkcREuVQu+SY2oJT+
         NWxJZaROr4pl2RDJP1bHoGwLDMy++dK6rmINjYnNtCX89V4kaNvOwTzu0hzSReVOIfbk
         sSU3UFMOoIBdcpi/rcQLGjwABcTD/Q0EH4VX+c8DVjiXxLtp7vVoalmg/dQ1wx94D8D9
         gKauhVayLR109YmH4JTol/PUSQ6KVZY6xDcNmJXlE7SXWGzo5ELU+6YMlIueSmXpSAr5
         Cn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kiOdsfq9BfcWUhAwCL6OI+smmytdXoJSLNdmVVWV378=;
        b=R9eRCTrhxKYDE+fUZX113c1zJ9KEcbIsjqFTPq5ecmnRWVSDXkmhxW9MGcrh714Hch
         Q+7bIXxkjQ5NpgOlH5Xj6usff1aVzFGxClo2oW6W4zGPsaqLlplb5ictaf6IfP9pKmG+
         KEacCjm/2pXpY9uw3S/59VwqQ5oKuL6u14pM0Rzmqawr0Q/NLxDG7Gm6tHEaTLtdKNBu
         qLS/7ChXxRtpT3rvPywxym9oIX+0KzQ/xeDcNV6BVeyxfBA7N2tBCkavZAMDMEau1EJp
         ziyMXfdS0VFP7AhtWTVv1y7gM2nhK20P77mkcnWCLzdK3x4lBsvJNu3guD35fIAvtH2C
         kZoQ==
X-Gm-Message-State: AJIora+fRGM8Ec+/+sidjuztMAcKgMnhwduGt88p7nuP/7LV7b/qcDOr
        n4Qgq5BQ1yyMOLS+BRORhXsfKXfV5sPZgZP7BPVtBhY4/BlmPQ==
X-Google-Smtp-Source: AGRyM1vWcrCy2Wk3uhsGkshmIHKS+h3Cwuu2Oxph5D8t3GnHkc0bkExzFzozXinN++SD7dDR2gK+0ww3x49Qywsb/4g=
X-Received: by 2002:a05:6102:5dc:b0:354:63f1:df8d with SMTP id
 v28-20020a05610205dc00b0035463f1df8dmr6405291vsf.72.1656052906419; Thu, 23
 Jun 2022 23:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220619134657.1846292-1-amir73il@gmail.com> <20220619134657.1846292-4-amir73il@gmail.com>
 <CAOQ4uxj350-k2bzCSD_j35XCH5E-VcdtfHmW3d_ZrSzHxWA5CQ@mail.gmail.com>
 <YrSrLgU1OIgaaxiB@magnolia> <CAOQ4uxiyWnLFe95YXQ-xzYyK4D50-6pbqpduyZZzttvuXvVETg@mail.gmail.com>
 <20220624063149.4ssefnfi5tboogp4@zlang-mailbox>
In-Reply-To: <20220624063149.4ssefnfi5tboogp4@zlang-mailbox>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 24 Jun 2022 09:41:34 +0300
Message-ID: <CAOQ4uxitptR97n9fV5vPEd_HEVKABg-L=R-2kRNLoi8Ds7eK5A@mail.gmail.com>
Subject: Re: [PATCH 3/4] xfs/{422,517}: add missing killall to _cleanup()
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jun 24, 2022 at 9:31 AM Zorro Lang <zlang@redhat.com> wrote:
>
> On Fri, Jun 24, 2022 at 07:36:51AM +0300, Amir Goldstein wrote:
> > On Thu, Jun 23, 2022 at 9:04 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > >
> > > On Tue, Jun 21, 2022 at 07:02:02AM +0300, Amir Goldstein wrote:
> > > > On Sun, Jun 19, 2022 at 4:47 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > >
> > > > > Those tests failed to cleanup background jobs after test
> > > > > is interrupted.
> > > > >
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > ---
> > > > >  tests/xfs/422 | 8 ++++++++
> > > > >  tests/xfs/517 | 1 +
> > > > >  2 files changed, 9 insertions(+)
> > > > >
> > > > > diff --git a/tests/xfs/422 b/tests/xfs/422
> > > > > index a83a66df..8e9a3576 100755
> > > > > --- a/tests/xfs/422
> > > > > +++ b/tests/xfs/422
> > > > > @@ -13,6 +13,14 @@ _begin_fstest dangerous_scrub dangerous_online_repair freeze
> > > > >
> > > > >  _register_cleanup "_cleanup" BUS
> > > > >
> > > > > +# Override the default cleanup function.
> > > > > +_cleanup()
> > > > > +{
> > > > > +       $KILLALL_PROG -9 $XFS_IO_PROG $FSSTRESS_PROG > /dev/null 2>&1
> > > > > +       cd /
> > > > > +       rm -rf $tmp.*
> > > > > +}
> > > > > +
> > > > >  # Import common functions.
> > > > >  . ./common/filter
> > > > >  . ./common/fuzzy
> > > > > diff --git a/tests/xfs/517 b/tests/xfs/517
> > > > > index 961668e3..18404248 100755
> > > > > --- a/tests/xfs/517
> > > > > +++ b/tests/xfs/517
> > > > > @@ -14,6 +14,7 @@ _register_cleanup "_cleanup" BUS
> > > > >  # Override the default cleanup function.
> > > > >  _cleanup()
> > > > >  {
> > > > > +       $KILLALL_PROG -9 $XFS_IO_PROG $FSSTRESS_PROG > /dev/null 2>&1
> > > >
> > > > Besides the missing wait, this cleanup is still racy, because stress_loop
> > > > can spawn a new fstress process after killall /proc iteration.
> > > >
> > > > Worst, freeze_loop can freeze after killall /proc iteration.
> > > >
> > > > The correct solution (I think) is to record the pid of the XXX_loop
> > > > sub-shells and kill those, which should also solve the "Terminated"
> > > > false positive error.
> > > >
> > > > Will give that a shot.
> > >
> > > FWIW I already have patches reworking 422 and all the other
> > > scrub-related stress tests:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=race-scrub-and-mount-state-changes
> > >
> >
> > That looks very nice.
> > The cleanup looks very similar to the one I posted for v2,
> > but instead of "killall xfs_io fsstress" you would be better off with
> > "kill  $__SCRUB_STRESS_FREEZE_PID"
> >
> > killing the child process and waiting for its parent bash
> > process has the side effect of the bash parent emitting
> > "Terminated" or "Killed" message with breaks golden output
> > if the inner loop did not already exit, which is the behavior
> > that got me started on doing this cleanup.
> >
> > > I swear I'll send all these some day, if I ever get caught up...
> > > Delegating LTS maintenance is a big help, but as it is I still can't
> > > stay abreast of all the mainline patchsets /and/ send my own stuff. :(
> > >
> >
> > I will respond to that in another email.
>
> Hi Amir,
>
> So ... will you singly resend a V3 patch to remove the xfs/422 changes in this patch?
>

I don't understand.

V2 patch should be reviewed

https://lore.kernel.org/fstests/20220621173729.2135249-1-amir73il@gmail.com/

The fact that Darrick has future work pending to cleanup xfs/422
should not stop a cleanup patch to be applied now.

Am I missing something?

Thanks,
Amir.
