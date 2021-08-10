Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B601C4338F
	for <linux-fstests@archiver.kernel.org>; Tue, 10 Aug 2021 14:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F2D461008
	for <linux-fstests@archiver.kernel.org>; Tue, 10 Aug 2021 14:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbhHJOEE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 10 Aug 2021 10:04:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238492AbhHJOEE (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 10 Aug 2021 10:04:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AFEE60E52;
        Tue, 10 Aug 2021 14:03:40 +0000 (UTC)
Date:   Tue, 10 Aug 2021 16:03:31 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>, fstests@vger.kernel.org,
        Eryu Guan <guan@eryu.me>
Subject: Re: [PATCH v2 1/6] idmapped-mounts: prepare for additional tests
Message-ID: <20210810140331.irdmzpny7ro52lap@wittgenstein>
References: <20210731165834.479633-1-brauner@kernel.org>
 <20210731165834.479633-2-brauner@kernel.org>
 <20210810081549.GA20012@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210810081549.GA20012@lst.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 10, 2021 at 10:15:49AM +0200, Christoph Hellwig wrote:
> On Sat, Jul 31, 2021 at 06:58:29PM +0200, Christian Brauner wrote:
> > From: Christian Brauner <christian.brauner@ubuntu.com>
> > 
> > - Use sequential option numbering for option parsing since we're only
> >   using longopts anyway and to easier correlate test parsing in the
> >   switch with the options specified in longopts.
> 
> These sequential options are rally weird.  Why not use getopt_long_only?

Good point! Let me see if I can make that work.

> 
> >
> > - Introduce an explicit command line switch to runs the basic test
> >   suite. This prepares for the introduction of additional command line
> >   switches to run tests.
> > - Update help output.
> > - Use die() when logging test failure.
> 
> Each of these changes really should be a separate patch.

Ok, will split this up.

Thanks for the reviews, much appreciated!
Christian
