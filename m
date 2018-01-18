Received: from imap.thunk.org ([74.207.234.97]:33714 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932670AbeARQDZ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 18 Jan 2018 11:03:25 -0500
Date: Thu, 18 Jan 2018 11:03:21 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: ext4 quota tests fail with CONFIG_QFMT_V2=n
Message-ID: <20180118160321.GA13944@thunk.org>
References: <20180118010936.GA10649@vader>
 <20180118012831.GF6948@thunk.org>
 <20180118122125.pxgqttayxu6msdgl@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180118122125.pxgqttayxu6msdgl@quack2.suse.cz>
Sender: fstests-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: Omar Sandoval <osandov@osandov.com>, fstests@vger.kernel.org, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 18, 2018 at 01:21:25PM +0100, Jan Kara wrote:
> Omar's problem is actually that he had no quota format enabled so tools
> failed miserably to enable quotas although xfstests thought quota should be
> available. That could be viewed as a bug in _require_quota() macro in xfstests
> but OTOH userspace has no way of knowing which quota formats are available
> - it can only try to enable quota on a particular fs and that either fails
> or not. So implementing proper _require_quota() macro would mean you have
> to do full quota setup for some filesystem, try to enable quotas, and see if
> that fails. Doable but frankly I'm not hugely interested in that for such a
> cornercase...

Yes, I'd much rather fix it in Kconfig.  The question I was asing is
really whether we could start deprecating QFMT_V1 by requiring QFMT_V2
and making QFMT_V1 the only optional format, and then changing the
tools to strongly bias the user towards using V2 --- and maybe making
it be impossible to create new QFMT_V1 format quota files at all at
some point.

It will take a while --- years no doubt --- but a journey of ten
thousand miles starts with a single step, as the saying goes.

					- Ted
