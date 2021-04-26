Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C97C433ED
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 07:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF0CE61003
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 07:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbhDZHxS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 26 Apr 2021 03:53:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233202AbhDZHvv (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 26 Apr 2021 03:51:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D5ED608FC;
        Mon, 26 Apr 2021 07:51:08 +0000 (UTC)
Date:   Mon, 26 Apr 2021 09:51:04 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     Christian Brauner <brauner@kernel.org>, fstests@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] generic: extend fscaps test
Message-ID: <20210426075104.4cnf7sezivfftjnt@wittgenstein>
References: <20210423111539.3591487-1-brauner@kernel.org>
 <YIUsEQLLCYCvOSE2@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YIUsEQLLCYCvOSE2@desktop>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Apr 25, 2021 at 04:45:05PM +0800, Eryu Guan wrote:
> On Fri, Apr 23, 2021 at 01:15:39PM +0200, Christian Brauner wrote:
> > From: Christian Brauner <christian.brauner@ubuntu.com>
> > 
> > Add a test to verify that setting a v3 fscap that is valid in an
> > ancestor user namespace works.
> 
> The subject is not clear which test it updates, I can only know it's
> generic/633 that calls idmapped-mounts binary to do the test.

Right, sorry. Will add that.

> 
> > 
> > Cc: fstests@vger.kernel.org
> > Cc: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> >  src/idmapped-mounts/idmapped-mounts.c | 56 +++++++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> > 
> > diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
> > index 870a8fe7..4e3252ca 100644
> > --- a/src/idmapped-mounts/idmapped-mounts.c
> > +++ b/src/idmapped-mounts/idmapped-mounts.c
> > @@ -3193,6 +3193,62 @@ static int fscaps_idmapped_mounts_in_userns(void)
> >  		goto out;
> >  	}
> >  
> > +	/*
> > +	 * Verify we can set an v3 fscap for real root this was regressed at
> > +	 * some point. Make sure this doesn't happen again!
> > +	 */
> 
> We usually don't add new test cases to existing tests, as that may
> introduce new failures and let people think there's a regression, then
> find out it's the new case introduced the failure.

Hm, okay. I'm pretty sure that I'll grow the idmapped mount test-suite
quite a bit more so I need to think about how to make this easily
extensible. I want the ability to use the binary itself to run all
tests. So I may just introduce flags to allow for running specific tests
or subsets of tests such as:

idmapped-mounts --fscaps --acl

> 
> But this test was just merged last week, and the test is closely related
> to existing cases and could re-use the test framework/setups, so I think
> it's fine to add this case.
> 
> But as above comment said, this new cases is targeted to a regression
> happened previously, I think it'd be better to put it in a seperate test
> function, not folded into an existing test function.
> 
> And is there a commit that fixed the mentioned regression? Reference it
> in the comments would help people find the correct fix, if there's any.

That is an annoyingly convoluted story involving a buggy "fix" a revert
and then a proper fix. But I'll sure add details. Thank you!

Christian
