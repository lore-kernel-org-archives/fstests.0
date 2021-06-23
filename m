Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB64EC2B9F4
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Jun 2021 02:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB76B6135A
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Jun 2021 02:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFWCEo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Jun 2021 22:04:44 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52543 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229774AbhFWCEo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Jun 2021 22:04:44 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15N22OhG007894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 22:02:24 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4CBDD15C3CD6; Tue, 22 Jun 2021 22:02:24 -0400 (EDT)
Date:   Tue, 22 Jun 2021 22:02:24 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] ext4/048: skip test of filename wipe if journal
 checkpoint is not supported
Message-ID: <YNKWMO0dY0hrMhqb@mit.edu>
References: <20210621164851.1808923-1-tytso@mit.edu>
 <YNIphT6xiluxLrOm@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNIphT6xiluxLrOm@google.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 22, 2021 at 11:18:45AM -0700, Leah Rumancik wrote:
> > diff --git a/tests/ext4/048 b/tests/ext4/048
> > index 51189618..35e6aa7f 100755
> > --- a/tests/ext4/048
> > +++ b/tests/ext4/048
> > @@ -93,6 +93,14 @@ _scratch_mkfs_sized $((128 * 1024 * 1024)) >> $seqres.full 2>&1
> >  # create scratch dir for testing
> >  # create some files with no name a substr of another name so we can grep later
> >  _scratch_mount >> $seqres.full 2>&1
> > +
> > +# Use the presence of the journal checkpoint ioctl as a proxy of filename
> > +# wipe being supported
> > +if test -x $here/src/checkpoint_journal && \
> > +	! $here/src/checkpoint_journal $SCRATCH_MNT --dry-run ; then
> > +    _notrun "filename wipe not supported"
> > +fi
> 
> What if checkpoint_journal is not there? Should the test be
> skipped in that case as well?

I went back and forth on that one.  In actual practice
checkpoint_journal should always be built in a valid xfstests
installation, so the case of it not existing should rarely if ever
arise.  We don't actually _need_ checkpoint_journal to run the test;
we're just using it as a hint as to whether the filename wipe feature
is present.  So I decided to let the test run if we couldn't find it,
on the theory that in the long run, all future kernels will have the
feature.   But the case could be made in other direction....

	       	   	      	 - Ted
