Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0C1C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 13 Apr 2022 23:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiDMX3m (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 13 Apr 2022 19:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbiDMX3l (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 13 Apr 2022 19:29:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B751D305
        for <fstests@vger.kernel.org>; Wed, 13 Apr 2022 16:27:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51CA6B827AC
        for <fstests@vger.kernel.org>; Wed, 13 Apr 2022 23:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43B6C385A3;
        Wed, 13 Apr 2022 23:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649892436;
        bh=PQCqej5jndD60bHgymLcXcwE1yEIkLXFWs21cjzP+MM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fNV/YYl6IXt1EMm3SQALfepp6QyFIucvNbCbeQ0zkCpPrClmn4rCA3f5oKyTHbl6+
         YSi04ClnPwY5+i7/Iyqfpl3C9voKUxSXAyUnZCoy73xbWlgpAHVZYFUZ0Jbj/jTKKK
         TEeeeKgId+2H4HuFHHAXJTchHuDW9miMUqXBP2/GZf9wUi4s98rSVAa/VKquuFgNBt
         CCn8WCnt+scfmN6Z4G1hAcuQq6kR3y5Pi32E9VPNp+gp9BK9xiNaXHwRl4k27CVysh
         nQhAcyIaFYYIlkuSjdleEpYdZ7h11S1kHRAgXqAvkc6/agqQABIvPahMbX+JAs0hqq
         6lPEZgsNnIr8A==
Date:   Wed, 13 Apr 2022 16:27:15 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        David Disseldorp <ddiss@suse.de>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH] generic/019: kill background processes on interrupt
Message-ID: <20220413232715.GC16774@magnolia>
References: <20220411054833.2157779-1-david@fromorbit.com>
 <20220412145942.0a268875@suse.de>
 <20220412142500.ubkbw2fvbxowzo5p@zlang-mailbox>
 <20220413002656.GL1609613@dread.disaster.area>
 <CAOQ4uxi_YY2fBTAoQz4W_jOFvySUWGG0UFhtKjptgiiM1jg7Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi_YY2fBTAoQz4W_jOFvySUWGG0UFhtKjptgiiM1jg7Bg@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Apr 13, 2022 at 10:13:35AM +0300, Amir Goldstein wrote:
> On Wed, Apr 13, 2022 at 4:53 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Tue, Apr 12, 2022 at 10:25:00PM +0800, Zorro Lang wrote:
> > > On Tue, Apr 12, 2022 at 02:59:42PM +0200, David Disseldorp wrote:
> > > > On Mon, 11 Apr 2022 15:48:33 +1000, Dave Chinner wrote:
> > > >
> > > > > From: Dave Chinner <dchinner@redhat.com>
> > > > >
> > > > > If you ctrl-c generic/019, it leaves fsstress processes running.
> > > > > Kill them in the cleanup function so that they don't have to be
> > > > > manually killed after interrupting the test.
> > > > >
> > > > > While touching the _cleanup() function, make it do everything that
> > > > > the generic _cleanup function it overrides does and fix the
> > > > > indenting.
> > > > >
> > > > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > > > ---
> > > > >  tests/generic/019 | 6 ++++--
> > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/tests/generic/019 b/tests/generic/019
> > > > > index db56dac1..cda107f4 100755
> > > > > --- a/tests/generic/019
> > > > > +++ b/tests/generic/019
> > > > > @@ -53,8 +53,10 @@ stop_fail_scratch_dev()
> > > > >  # Override the default cleanup function.
> > > > >  _cleanup()
> > > > >  {
> > > > > -    disallow_fail_make_request
> > > > > -    rm -f $tmp.*
> > > > > + kill $fs_pid $fio_pid &> /dev/null
> > > > > + disallow_fail_make_request
> > > > > + cd /
> > > > > + rm -r -f $tmp.*
> > > > >  }
> > > > >
> > > > >  RUN_TIME=$((20+10*$TIME_FACTOR))
> > > >
> > > > Might be worth unset'ing the "fs_pid" and "fio_pid" variables after the
> > > > wait, but should be fine as-is:
> > >
> > > I agree. Better to avoid killing other system processes. Or how about this place
> > > does (avoid killing system useful processes):
> > > $KILLALL_PROG -q $FSSTRESS_PROG
> > > $KILLALL_PROG -q $FIO_PROG
> > >
> > > Another picky question is, do we need to use a while loop checking, until the
> > > processes really get killed? :)
> >
> > Do we really need to paint the bikeshed over how best to kill a
> > process? I don't have time to do that, this is just a drive-by fix
> > that works for me....
> >
> 
> This is not a kind response to reviewers.
> Does a "drive-by fix" get exempt from the review process?
> The review comments are legit even if they could be dismissed
> on technical grounds, because the risk of pid wraparound is quite low.
> 
> I don't think this is about "bikeshed over how best to kill a process"
> I think this is about how to have better test cleanup practices.

I agree, but this is a broad treewide cleanup, which itself is a
separate project that shouldn't hold up this quick cleanup...

> It would have been nice to have better isolation by having fstests
> run a test without a control group and cleanup the control group
> processes after the test if someone wants to take on this task.

...because there are quite a few places (particularly anything that runs
fsx/fsstress/iogen for fun) where we kick off a group of background
processes and later require a reliable way to shoot them all down.
Fixing all that in a consistent way is a *much* bigger task than what
Dave is trying to accomplish here.

The current "scheme" is that ./check will run each test in its own
systemd scope (if available) to try to improve the reliability of test
program cleanup if the _cleanup method itself fails to kill all the
child tasks.  This isn't foolproof because some people refuse to use
systemd, and the systemd tools themselves can't do a whole lot about
processes stuck in D state.

In the ideal world, whoever takes on cleaning up process cleanup
probably ought to figure out a more general solution, or at least
investigate it more thoroughly than I did to decide if it's worth
reimplementing process control group control via bash script for people
who do not use systemd.

Does anyone want to take on this task?

> I personally prefer the pattern of dedicated cleanup trap for aborting the test
> like generic/251 that leaves the generic _cleanup on EXIT instead of
> duplicating _cleanup (which generic/251 also duplicate incorrectly),
> but no strong feeling about that, so as a "drive-by fix" you may add:
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

For this patch,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
> Thanks,
> Amir.
