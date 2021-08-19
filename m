Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C15EC4338F
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Aug 2021 19:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21E5E600D3
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Aug 2021 19:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhHSTqv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 Aug 2021 15:46:51 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41900 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229514AbhHSTqu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Aug 2021 15:46:50 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17JJk81e019612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 15:46:09 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 69B0115C3DBB; Thu, 19 Aug 2021 15:46:08 -0400 (EDT)
Date:   Thu, 19 Aug 2021 15:46:08 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/70: Use scratch device instead of test.
Message-ID: <YR61AOeWnxmyooF4@mit.edu>
References: <20210819131355.304528-1-nborisov@suse.com>
 <20210819150050.jweulrtgjeh57wac@fedora>
 <0b70908b-9b9f-d606-1d49-45bee40df1ea@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b70908b-9b9f-d606-1d49-45bee40df1ea@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Aug 19, 2021 at 05:56:31PM +0300, Nikolay Borisov wrote:
> On 19.08.21 г. 18:00, Zorro Lang wrote:
> > On Thu, Aug 19, 2021 at 04:13:55PM +0300, Nikolay Borisov wrote:
> >> At the end of the test the fsstress work dir is deleted, this suggests
> >> the test really requires a scratch device and not a test device. Change
> >> it accordingly.
> >>
> >> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> >> ---
> > 
> > Hmm... is there any more specific reasons to explain why have to change this
> > TEST_DIR to SCRATCH_MNT? For example, this test hit ENOSPC in TEST_DIR, or
> > it takes too much time to remove $TEST_DIR/fsstress in _cleanup, or use
> > SCRATCH_DEV can cover more things, and so on. I think more specific reason
> > can help to push this patch be merged. After all there's not a rule says
> > if a case don't need to keep its work dir, then must use SCRATCH_DEV. Except
> > the maintainer is more inclined to accept that :)
> 
> None of the reasons above, I just thought that stuff in $TEST_DEV lives
> there so that it can simulate an 'aging' system. In this case this
> doesn't seem to be the reason for it as we delete everything.

Using SCRATCH_DEV requires that the file system be reformatted, since
it doesn't necessarily exist.  So that means extra flash writes, and
extra time to actually do the file system format.  In addition,
sometimes SCRATCH_DEV might not be present for some test environments.

Hence, unless you need to use SCRATCH_DEV (because the file system
needs to be formatted with specific mkfs options, etc.), I think the
preference should be to use TEST_DIR.  It doesn't *hurt* that we
create the work directory, in TEST_DIR and then delete it afterwawrds
--- where as using SCRATCH_DEV dosn't actually buy you anything, and
might actually slow the test down a tiny bit.

Cheers,

					- Ted
