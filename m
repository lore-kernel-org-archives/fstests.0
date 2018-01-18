Received: from mail-pf0-f173.google.com ([209.85.192.173]:45446 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750974AbeARIRQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 18 Jan 2018 03:17:16 -0500
Received: by mail-pf0-f173.google.com with SMTP id a88so12327412pfe.12
        for <fstests@vger.kernel.org>; Thu, 18 Jan 2018 00:17:16 -0800 (PST)
Date: Thu, 18 Jan 2018 00:17:13 -0800
From: Omar Sandoval <osandov@osandov.com>
Subject: Re: ext4 quota tests fail with CONFIG_QFMT_V2=n
Message-ID: <20180118081713.GB10877@vader>
References: <20180118010936.GA10649@vader>
 <20180118012831.GF6948@thunk.org>
 <20180118021610.GA10877@vader>
 <20180118040819.GI6948@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180118040819.GI6948@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Jan Kara <jack@suse.cz>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Jan 17, 2018 at 11:08:19PM -0500, Theodore Ts'o wrote:
> On Wed, Jan 17, 2018 at 06:16:10PM -0800, Omar Sandoval wrote:
> > > I'd like to ask a different question, which is there a reason to
> > > support CONFIG_QFMT_V1 && !CONFIG_QFMT_V2?  Maybe we should just
> > > always enable CONFIG_QFMT_V2, and simplify the test matrix?
> > 
> > FWIW,
> > 
> > # CONFIG_QFMT_V1 is not set
> > # CONFIG_QFMT_V2 is not set
> > 
> > on this kernel.
> 
> Huh.... I don't think that's a valid kernel configuration at all.  Or
> rather, it's allowed by Kconfig, but it shouldn't be, since without
> any quota formats enabled, the quota code is completely useless, and
> you might as well not compile it in, as near as I can tell.
> 
> Was this configuration one that you were deliberately using; and if
> so, what for?   Or was it one that was created accidentally?

It's not intentional. I'm assuming what happened here is we disabled any
modules we weren't using, but CONFIG_QUOTA happened to stay on. Is it
also the case for XFS that quotas are useless without qfmt-v2?

> In any case, ext4's quota feature has to have the V2 quota format
> enabled, or it's not going to work properly.  We should remove
> EXT4_FEATURE_RO_COMPAT_QUOTA from the list of supported features if
> CONFIG_QUOTA or CONFIG_QFMT_V2 are not set.
> 
> 					- Ted
