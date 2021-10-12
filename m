Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A05C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 12 Oct 2021 17:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D113660F3A
	for <linux-fstests@archiver.kernel.org>; Tue, 12 Oct 2021 17:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhJLRf7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 12 Oct 2021 13:35:59 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37344 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229495AbhJLRf7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 12 Oct 2021 13:35:59 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19CHXq9O026666
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 13:33:53 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7A6FA15C00CA; Tue, 12 Oct 2021 13:33:52 -0400 (EDT)
Date:   Tue, 12 Oct 2021 13:33:52 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Anju T Sudhakar <anju@linux.vnet.ibm.com>, fstests@vger.kernel.org
Subject: Re: [PATCH 4/4] generic/219: Fix test failure on 64k block size
Message-ID: <YWXHAIK4Ol+x2qb+@mit.edu>
References: <20211011075552.196688-1-anju@linux.vnet.ibm.com>
 <20211011075552.196688-5-anju@linux.vnet.ibm.com>
 <20211011083639.GC1164794@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011083639.GC1164794@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Oct 11, 2021 at 07:36:39PM +1100, Dave Chinner wrote:
> On Mon, Oct 11, 2021 at 01:25:52PM +0530, Anju T Sudhakar wrote:
> > Skip this test on 64k, as 4k as taken as the default block size.
> > 
> > Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> > ---
> > But I have a Query:
> > This test fails on ext4&xfs with 64k block size. Do we need to
> > rephrase this test to incorporate the 64k bs scenario as well?
> > If not we can skip this test.
> 
> Right, we should fix the test to use multiples of block size rather
> than fixed byte sizes as we do for all the other tests that need to
> work across different block sizes. e.g. probe the block size after
> mkfs and then convert the "48k" numbers to "$((12 * $bs))".

... and then make sure that you understand what the test is trying to
do, and with those changes, audit the test to make sure it is correct
and valid when the block size is as small as 1k, and as large as 64k.
It might require adjusting other parameters, including the size of the
scratch file system, etc.

Cheers,

					- Ted
