Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB42C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 23 Jun 2022 18:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiFWS7f (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 23 Jun 2022 14:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiFWS7V (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 23 Jun 2022 14:59:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6679AB8835
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 11:04:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 247FAB82430
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 18:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC788C341C5;
        Thu, 23 Jun 2022 18:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656007470;
        bh=EGvCjkx3VRTPTkLveYpAokCFBRARjexMeXLUDQF+Spg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tmzf7mQ3AcQDoHiYm6nwE5Xk/GLcUFhFEb2yIJ40CEhT1Yr71jNAuvHgwqgpcBkKb
         28NGqL/YRh3odmFsaa+SYGcVtqbQp8pnGhZ9GdjC/DqCpGAaMDpaPQjrgIJsKd7/j6
         y3Roe58pBCojn21sVpEargMO8oiqQURfKSDR9QSaECbFt1g2Q07v7wi0fxFbyw0eVv
         7yw3rKPqnTcONa0rTSTWMxUM7HGceuySPIR2FVCmso07Qxp8vczPKVqj07l0tbMmGK
         HwDNegObZyOQsvxaYXQEIFIho8TaD9Ljf8qWwTptb9/JMJzHj4VQk4K0/5DZgIqpu0
         ldoU4vHWPHgYA==
Date:   Thu, 23 Jun 2022 11:04:30 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Zorro Lang <zlang@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH 3/4] xfs/{422,517}: add missing killall to _cleanup()
Message-ID: <YrSrLgU1OIgaaxiB@magnolia>
References: <20220619134657.1846292-1-amir73il@gmail.com>
 <20220619134657.1846292-4-amir73il@gmail.com>
 <CAOQ4uxj350-k2bzCSD_j35XCH5E-VcdtfHmW3d_ZrSzHxWA5CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj350-k2bzCSD_j35XCH5E-VcdtfHmW3d_ZrSzHxWA5CQ@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 21, 2022 at 07:02:02AM +0300, Amir Goldstein wrote:
> On Sun, Jun 19, 2022 at 4:47 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Those tests failed to cleanup background jobs after test
> > is interrupted.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  tests/xfs/422 | 8 ++++++++
> >  tests/xfs/517 | 1 +
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/tests/xfs/422 b/tests/xfs/422
> > index a83a66df..8e9a3576 100755
> > --- a/tests/xfs/422
> > +++ b/tests/xfs/422
> > @@ -13,6 +13,14 @@ _begin_fstest dangerous_scrub dangerous_online_repair freeze
> >
> >  _register_cleanup "_cleanup" BUS
> >
> > +# Override the default cleanup function.
> > +_cleanup()
> > +{
> > +       $KILLALL_PROG -9 $XFS_IO_PROG $FSSTRESS_PROG > /dev/null 2>&1
> > +       cd /
> > +       rm -rf $tmp.*
> > +}
> > +
> >  # Import common functions.
> >  . ./common/filter
> >  . ./common/fuzzy
> > diff --git a/tests/xfs/517 b/tests/xfs/517
> > index 961668e3..18404248 100755
> > --- a/tests/xfs/517
> > +++ b/tests/xfs/517
> > @@ -14,6 +14,7 @@ _register_cleanup "_cleanup" BUS
> >  # Override the default cleanup function.
> >  _cleanup()
> >  {
> > +       $KILLALL_PROG -9 $XFS_IO_PROG $FSSTRESS_PROG > /dev/null 2>&1
> 
> Besides the missing wait, this cleanup is still racy, because stress_loop
> can spawn a new fstress process after killall /proc iteration.
> 
> Worst, freeze_loop can freeze after killall /proc iteration.
> 
> The correct solution (I think) is to record the pid of the XXX_loop
> sub-shells and kill those, which should also solve the "Terminated"
> false positive error.
> 
> Will give that a shot.

FWIW I already have patches reworking 422 and all the other
scrub-related stress tests:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=race-scrub-and-mount-state-changes

I swear I'll send all these some day, if I ever get caught up...
Delegating LTS maintenance is a big help, but as it is I still can't
stay abreast of all the mainline patchsets /and/ send my own stuff. :(

--D

> Thanks,
> Amir.
