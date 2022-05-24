Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7167CC433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 09:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbiEXJ57 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 05:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbiEXJ55 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 05:57:57 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51D9675220
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 02:57:56 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 94A4C10E6AC2;
        Tue, 24 May 2022 19:57:55 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ntRIZ-00FmxD-3F; Tue, 24 May 2022 19:57:55 +1000
Date:   Tue, 24 May 2022 19:57:55 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [RFC PATCH 0/8] fstests: _cleanup() overrides are a mess
Message-ID: <20220524095755.GH2306852@dread.disaster.area>
References: <20220524073411.1943480-1-david@fromorbit.com>
 <CAOQ4uxi9gFQ4Zr6pfvia8WgjzyQqc2LnAwamw_XDuyR0ndGjBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi9gFQ4Zr6pfvia8WgjzyQqc2LnAwamw_XDuyR0ndGjBQ@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=628cac23
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=7-415B0cAAAA:8
        a=PRnvscKv-KQKIEs8gHgA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 11:29:17AM +0300, Amir Goldstein wrote:
> On Tue, May 24, 2022 at 11:01 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > Hi folks,
> >
> > I pulled on a string a couple of days ago, and it got out of
> > control. It all started when I went to kill a test with ctrl-c and
> > it, once again, left background processes running that I had to hunt
> > down and kill manually.
> >
> > I then started looking a why this keeps happening, and realised that
> > the way we clean up on test completion is messy, inconsistent and
> > frequently buggy. So I started cleaning it all up, starting with the
> > tests/xfs directory because I saw a lot of low hanging fruit there.
> >
> > Essentially, we use _cleanup() functions as a way of overriding the
> > default trap handler we install in _begin_fstest(). Rather than
> > register a new handler, we just redefine the common cleanup function
> > and re-implement it (poorly) in every test that does an override.
> > Often these overrides are completely unnecessary - I think I reduced
> > the total number of overrides in tests/xfs by ~30% (~190 -> ~125),
> > and I reudced the number of *unique overrides by a lot more than
> > that.
> >
> 
> That looks like an awesome improvement!
> 
> > The method for overriding changes to be "stacked cleanups" rather
> > than "duplicated cleanups". That is, tests no longer open code:
> >
> >         cd /
> >         rm -rf $tmp.*
> >
> > THis is what common/preamble::_cleanup() does. We should call that
> > function to do this. Hence if we have a local cleanup that we need
> > to do, it becomes:
> >
> > local_cleanup()
> > {
> >         rm -f $testfile
> >         _cleanup
> > }
> > _register_cleanup local_cleanup
> 
> While removing boilerplate code, we had better not create another boilerplate.
> Instead of expecting test writers to always call _cleanup
> if we always want _cleanup to be called we can always implicitly
> chain it in _register_cleanup():
> 
> --- a/common/preamble
> +++ b/common/preamble
> @@ -20,7 +20,7 @@ _register_cleanup()
>         shift
> 
>         test -n "$cleanup" && cleanup="${cleanup}; "
> -       trap "${cleanup}exit \$status" EXIT HUP INT QUIT TERM $*
> +       trap "${cleanup}_cleanup; exit \$status" EXIT HUP INT QUIT TERM $*
>  }

I considered that, but then I found the _no_cleanup cases. IOWs,
this doesn't work for the cases where we want to prevent the generic
_cleanup function from being run on failure/test exit. Hence the
cleanup function stacking behaviour rather than unconditional
calling of _cleanup as per above.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
