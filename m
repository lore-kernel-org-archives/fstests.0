Received: from mx2.suse.de ([195.135.220.15]:39532 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754656AbeARMIm (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 18 Jan 2018 07:08:42 -0500
Date: Thu, 18 Jan 2018 13:08:41 +0100
From: Jan Kara <jack@suse.cz>
Subject: Re: ext4 quota tests fail with CONFIG_QFMT_V2=n
Message-ID: <20180118120841.fv7yevvraybbchr4@quack2.suse.cz>
References: <20180118010936.GA10649@vader>
 <20180118012831.GF6948@thunk.org>
 <20180118021610.GA10877@vader>
 <20180118040819.GI6948@thunk.org>
 <20180118081713.GB10877@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180118081713.GB10877@vader>
Sender: fstests-owner@vger.kernel.org
To: Omar Sandoval <osandov@osandov.com>
Cc: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org, Jan Kara <jack@suse.cz>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Thu 18-01-18 00:17:13, Omar Sandoval wrote:
> On Wed, Jan 17, 2018 at 11:08:19PM -0500, Theodore Ts'o wrote:
> > On Wed, Jan 17, 2018 at 06:16:10PM -0800, Omar Sandoval wrote:
> > > > I'd like to ask a different question, which is there a reason to
> > > > support CONFIG_QFMT_V1 && !CONFIG_QFMT_V2?  Maybe we should just
> > > > always enable CONFIG_QFMT_V2, and simplify the test matrix?
> > > 
> > > FWIW,
> > > 
> > > # CONFIG_QFMT_V1 is not set
> > > # CONFIG_QFMT_V2 is not set
> > > 
> > > on this kernel.
> > 
> > Huh.... I don't think that's a valid kernel configuration at all.  Or
> > rather, it's allowed by Kconfig, but it shouldn't be, since without
> > any quota formats enabled, the quota code is completely useless, and
> > you might as well not compile it in, as near as I can tell.
> > 
> > Was this configuration one that you were deliberately using; and if
> > so, what for?   Or was it one that was created accidentally?
> 
> It's not intentional. I'm assuming what happened here is we disabled any
> modules we weren't using, but CONFIG_QUOTA happened to stay on. Is it
> also the case for XFS that quotas are useless without qfmt-v2?

No, they can be used without CONFIG_QFMT_V2 but also without CONFIG_QUOTA.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
