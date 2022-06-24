Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772B6C433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Jun 2022 15:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiFXPJq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Jun 2022 11:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiFXPJq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Jun 2022 11:09:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 614CD4CD7F
        for <fstests@vger.kernel.org>; Fri, 24 Jun 2022 08:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656083373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pFtpMO6rduQFm8cCu00vJojjycqqArRvF6Ej3ZImWYs=;
        b=QhkGs39jm+eAnXvEOAvUdTJEcp8m5DFjd65Bsz7uszoU2kRulPgHg8ADE/bHzjI9qhQIkL
        /8tN6L47xjfPgoD+0IH3fn25ZdtnPgpB0qqes7SUuLKJqIZ1rpAHyVtY+j72xkTS5wguoz
        at2BPj/D+EyGxgEhM0TTKCenJ9cP/ME=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62--sR01dHKOUqHh1Xr7CKsSA-1; Fri, 24 Jun 2022 11:09:30 -0400
X-MC-Unique: -sR01dHKOUqHh1Xr7CKsSA-1
Received: by mail-qk1-f198.google.com with SMTP id w16-20020a376210000000b006af059b17b7so2044456qkb.12
        for <fstests@vger.kernel.org>; Fri, 24 Jun 2022 08:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pFtpMO6rduQFm8cCu00vJojjycqqArRvF6Ej3ZImWYs=;
        b=5Op1MVVGHkZMrKPOe0uLoG4+GgROWoqGA7IBOrdQE+ifBQtB04cWP+qjLzG2fPTg0C
         HDRtKrumLZN+Ez5a7uZLUMZIM8TQ7OpJGS8TTcbuUkyshxM1usyVHV8BkuJ4LSJBHTUJ
         Pl0CConpbeE7cHDUjwRuMpPxAGUr9W1DKTZlSb6krmh5KS9URXekwqdEz3+1a9GusOCG
         cKEGrI9n7aJ63USNq+I8YHcpBII3HDg4DN2jSiupVXBVnc5uVp8uYl5wy9oo69S2NOZq
         4P6hr2SeQZR5i3HEd2qegi9jbOc1D5c2TeWwQzMZaQ0NsS6yVH3d5XH57mvitxLreCYi
         9kCA==
X-Gm-Message-State: AJIora/yps7Fhld/NxWj/3pPALtuU+DCdxSeMUftltPs1c95GknaHRC7
        M/vYtwt4bUwTIhJNTO1KDT0yZ02Wz4fuLKrYBxNxxzqY7DxtgrqnTs6At+xj2s7sxxDBLNypoGe
        dio6nc/kl7mmOTAmAuA==
X-Received: by 2002:a05:620a:40cb:b0:6a7:8477:99c4 with SMTP id g11-20020a05620a40cb00b006a7847799c4mr10838753qko.727.1656083369697;
        Fri, 24 Jun 2022 08:09:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1shl+9LNuphKIk4Fm46R+AAnfGV+ciS+x0RsCIFot7sVA4033zQayG51KBeYKVmWwQzRt+Uow==
X-Received: by 2002:a05:620a:40cb:b0:6a7:8477:99c4 with SMTP id g11-20020a05620a40cb00b006a7847799c4mr10838720qko.727.1656083369155;
        Fri, 24 Jun 2022 08:09:29 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r4-20020ac84244000000b00317ca023e33sm1092516qtm.80.2022.06.24.08.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 08:09:28 -0700 (PDT)
Date:   Fri, 24 Jun 2022 23:09:23 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH 3/4] xfs/{422,517}: add missing killall to _cleanup()
Message-ID: <20220624150923.unodbgknbz7unp62@zlang-mailbox>
References: <20220619134657.1846292-1-amir73il@gmail.com>
 <20220619134657.1846292-4-amir73il@gmail.com>
 <CAOQ4uxj350-k2bzCSD_j35XCH5E-VcdtfHmW3d_ZrSzHxWA5CQ@mail.gmail.com>
 <YrSrLgU1OIgaaxiB@magnolia>
 <CAOQ4uxiyWnLFe95YXQ-xzYyK4D50-6pbqpduyZZzttvuXvVETg@mail.gmail.com>
 <20220624063149.4ssefnfi5tboogp4@zlang-mailbox>
 <CAOQ4uxitptR97n9fV5vPEd_HEVKABg-L=R-2kRNLoi8Ds7eK5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxitptR97n9fV5vPEd_HEVKABg-L=R-2kRNLoi8Ds7eK5A@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jun 24, 2022 at 09:41:34AM +0300, Amir Goldstein wrote:
> On Fri, Jun 24, 2022 at 9:31 AM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Fri, Jun 24, 2022 at 07:36:51AM +0300, Amir Goldstein wrote:
> > > On Thu, Jun 23, 2022 at 9:04 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > >
> > > > On Tue, Jun 21, 2022 at 07:02:02AM +0300, Amir Goldstein wrote:
> > > > > On Sun, Jun 19, 2022 at 4:47 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > >
> > > > > > Those tests failed to cleanup background jobs after test
> > > > > > is interrupted.
> > > > > >
> > > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > > ---
> > > > > >  tests/xfs/422 | 8 ++++++++
> > > > > >  tests/xfs/517 | 1 +
> > > > > >  2 files changed, 9 insertions(+)
> > > > > >
> > > > > > diff --git a/tests/xfs/422 b/tests/xfs/422
> > > > > > index a83a66df..8e9a3576 100755
> > > > > > --- a/tests/xfs/422
> > > > > > +++ b/tests/xfs/422
> > > > > > @@ -13,6 +13,14 @@ _begin_fstest dangerous_scrub dangerous_online_repair freeze
> > > > > >
> > > > > >  _register_cleanup "_cleanup" BUS
> > > > > >
> > > > > > +# Override the default cleanup function.
> > > > > > +_cleanup()
> > > > > > +{
> > > > > > +       $KILLALL_PROG -9 $XFS_IO_PROG $FSSTRESS_PROG > /dev/null 2>&1
> > > > > > +       cd /
> > > > > > +       rm -rf $tmp.*
> > > > > > +}
> > > > > > +
> > > > > >  # Import common functions.
> > > > > >  . ./common/filter
> > > > > >  . ./common/fuzzy
> > > > > > diff --git a/tests/xfs/517 b/tests/xfs/517
> > > > > > index 961668e3..18404248 100755
> > > > > > --- a/tests/xfs/517
> > > > > > +++ b/tests/xfs/517
> > > > > > @@ -14,6 +14,7 @@ _register_cleanup "_cleanup" BUS
> > > > > >  # Override the default cleanup function.
> > > > > >  _cleanup()
> > > > > >  {
> > > > > > +       $KILLALL_PROG -9 $XFS_IO_PROG $FSSTRESS_PROG > /dev/null 2>&1
> > > > >
> > > > > Besides the missing wait, this cleanup is still racy, because stress_loop
> > > > > can spawn a new fstress process after killall /proc iteration.
> > > > >
> > > > > Worst, freeze_loop can freeze after killall /proc iteration.
> > > > >
> > > > > The correct solution (I think) is to record the pid of the XXX_loop
> > > > > sub-shells and kill those, which should also solve the "Terminated"
> > > > > false positive error.
> > > > >
> > > > > Will give that a shot.
> > > >
> > > > FWIW I already have patches reworking 422 and all the other
> > > > scrub-related stress tests:
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=race-scrub-and-mount-state-changes
> > > >
> > >
> > > That looks very nice.
> > > The cleanup looks very similar to the one I posted for v2,
> > > but instead of "killall xfs_io fsstress" you would be better off with
> > > "kill  $__SCRUB_STRESS_FREEZE_PID"
> > >
> > > killing the child process and waiting for its parent bash
> > > process has the side effect of the bash parent emitting
> > > "Terminated" or "Killed" message with breaks golden output
> > > if the inner loop did not already exit, which is the behavior
> > > that got me started on doing this cleanup.
> > >
> > > > I swear I'll send all these some day, if I ever get caught up...
> > > > Delegating LTS maintenance is a big help, but as it is I still can't
> > > > stay abreast of all the mainline patchsets /and/ send my own stuff. :(
> > > >
> > >
> > > I will respond to that in another email.
> >
> > Hi Amir,
> >
> > So ... will you singly resend a V3 patch to remove the xfs/422 changes in this patch?
> >
> 
> I don't understand.
> 
> V2 patch should be reviewed
> 
> https://lore.kernel.org/fstests/20220621173729.2135249-1-amir73il@gmail.com/
> 
> The fact that Darrick has future work pending to cleanup xfs/422
> should not stop a cleanup patch to be applied now.

Oh, maybe I misunderstood. I thought Darrick meant his patchset (which haven't
been sent out) contains what you did on xfs/422. If that's misunderstanding,
I'll review and merge your V2 :)

Thanks,
Zorro


> 
> Am I missing something?
> 
> Thanks,
> Amir.
> 

