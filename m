Received: from imap.thunk.org ([74.207.234.97]:59568 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753531AbeAREIY (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 17 Jan 2018 23:08:24 -0500
Date: Wed, 17 Jan 2018 23:08:19 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: ext4 quota tests fail with CONFIG_QFMT_V2=n
Message-ID: <20180118040819.GI6948@thunk.org>
References: <20180118010936.GA10649@vader>
 <20180118012831.GF6948@thunk.org>
 <20180118021610.GA10877@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180118021610.GA10877@vader>
Sender: fstests-owner@vger.kernel.org
To: Omar Sandoval <osandov@osandov.com>
Cc: fstests@vger.kernel.org, Jan Kara <jack@suse.cz>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Jan 17, 2018 at 06:16:10PM -0800, Omar Sandoval wrote:
> > I'd like to ask a different question, which is there a reason to
> > support CONFIG_QFMT_V1 && !CONFIG_QFMT_V2?  Maybe we should just
> > always enable CONFIG_QFMT_V2, and simplify the test matrix?
> 
> FWIW,
> 
> # CONFIG_QFMT_V1 is not set
> # CONFIG_QFMT_V2 is not set
> 
> on this kernel.

Huh.... I don't think that's a valid kernel configuration at all.  Or
rather, it's allowed by Kconfig, but it shouldn't be, since without
any quota formats enabled, the quota code is completely useless, and
you might as well not compile it in, as near as I can tell.

Was this configuration one that you were deliberately using; and if
so, what for?   Or was it one that was created accidentally?

In any case, ext4's quota feature has to have the V2 quota format
enabled, or it's not going to work properly.  We should remove
EXT4_FEATURE_RO_COMPAT_QUOTA from the list of supported features if
CONFIG_QUOTA or CONFIG_QFMT_V2 are not set.

					- Ted
