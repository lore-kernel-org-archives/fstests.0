Received: from mx2.suse.de ([195.135.220.15]:41567 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754070AbeARMV2 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 18 Jan 2018 07:21:28 -0500
Date: Thu, 18 Jan 2018 13:21:25 +0100
From: Jan Kara <jack@suse.cz>
Subject: Re: ext4 quota tests fail with CONFIG_QFMT_V2=n
Message-ID: <20180118122125.pxgqttayxu6msdgl@quack2.suse.cz>
References: <20180118010936.GA10649@vader>
 <20180118012831.GF6948@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180118012831.GF6948@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Omar Sandoval <osandov@osandov.com>, fstests@vger.kernel.org, Jan Kara <jack@suse.cz>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Wed 17-01-18 20:28:31, Theodore Ts'o wrote:
> On Wed, Jan 17, 2018 at 05:09:36PM -0800, Omar Sandoval wrote:
> > Hello,
> > 
> > If I run xfstests on ext4 with a kernel with CONFIG_QFMT_V2=n, the following
> > tests fail:
> > 
> > generic/082
> > generic/219
> > generic/230
> > generic/231
> > generic/232
> > generic/233
> > generic/234
> > generic/235
> > generic/244
> > generic/270
> > generic/382
> > 
> > Would it be possible to handle this case and skip the test instead?
> 
> I'd like to ask a different question, which is there a reason to
> support CONFIG_QFMT_V1 && !CONFIG_QFMT_V2?  Maybe we should just
> always enable CONFIG_QFMT_V2, and simplify the test matrix?

Well, with ancient setups you could be using V1 quota format and then you
don't need CONFIG_QFMT_V2. So I don't see a great reason to force enabling
of CONFIG_QFMT_V2...

Omar's problem is actually that he had no quota format enabled so tools
failed miserably to enable quotas although xfstests thought quota should be
available. That could be viewed as a bug in _require_quota() macro in xfstests
but OTOH userspace has no way of knowing which quota formats are available
- it can only try to enable quota on a particular fs and that either fails
or not. So implementing proper _require_quota() macro would mean you have
to do full quota setup for some filesystem, try to enable quotas, and see if
that fails. Doable but frankly I'm not hugely interested in that for such a
cornercase...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
