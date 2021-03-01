Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE67C43332
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Mar 2021 18:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B18DF6509F
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Mar 2021 18:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239450AbhCASIt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 1 Mar 2021 13:08:49 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36376 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238674AbhCASF1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 1 Mar 2021 13:05:27 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 121I4ZUj028286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 1 Mar 2021 13:04:35 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E6DC215C3A88; Mon,  1 Mar 2021 13:04:34 -0500 (EST)
Date:   Mon, 1 Mar 2021 13:04:34 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic: test which tries to exercise AIO/DIO into
 unwritten space
Message-ID: <YD0ssnT0BCnwPXXk@mit.edu>
References: <20210210205818.1494305-1-tytso@mit.edu>
 <20210301171440.GD7269@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301171440.GD7269@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 01, 2021 at 09:14:40AM -0800, Darrick J. Wong wrote:
> On Wed, Feb 10, 2021 at 03:58:18PM -0500, Theodore Ts'o wrote:
> > This test verifies that the an unwritten extent is properly marked as
> > written after writing into it.
> > 
> > There was a hard-to-hit bug which would occasionally trigger with ext4
> > for which this test was a reproducer.  This has been fixed after
> > moving ext4 to use iomap for Direct I/O's, although as of this
> > writing, there are still some occasional failures on ext4 when block
> > size < page size.
> 
> Are there still failures?

Yes.  It's on Ritesh's todo list, but I don't believe it's bubbled up
to the top of his list.

The failure rate is substantially less than what I had been seeing
with 4k block sizes before the move to iomap, and in practice it was
hard to hit in production.  We noticed on Google data center workloads
(but even then it was impossible to reliably repro before I found this
fio recipe); as far as I know no one else had reported seeing this
problem.

So in summary, as of this writing, on 1k and 2k block sizes, this test
is still occasionally failing for ext4 (but not xfs, where it reliably
passes).  On 4k block sizes on x86 with ext4, this test is still
failing in on 5.4 and earler kernels, unless someone has managed to
backport DIO iomap support for ext4 into an enterprise linux kernel.

					- Ted
