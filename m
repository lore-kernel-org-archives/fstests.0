Received: from mx2.suse.de ([195.135.220.15]:36741 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754799AbeASIqw (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 19 Jan 2018 03:46:52 -0500
Date: Fri, 19 Jan 2018 09:46:49 +0100
From: Jan Kara <jack@suse.cz>
Subject: Re: ext4 quota tests fail with CONFIG_QFMT_V2=n
Message-ID: <20180119084649.hnbh56v4kdkitplu@quack2.suse.cz>
References: <20180118010936.GA10649@vader>
 <20180118012831.GF6948@thunk.org>
 <20180118122125.pxgqttayxu6msdgl@quack2.suse.cz>
 <20180118160321.GA13944@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180118160321.GA13944@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Omar Sandoval <osandov@osandov.com>, fstests@vger.kernel.org, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Thu 18-01-18 11:03:21, Theodore Ts'o wrote:
> On Thu, Jan 18, 2018 at 01:21:25PM +0100, Jan Kara wrote:
> > Omar's problem is actually that he had no quota format enabled so tools
> > failed miserably to enable quotas although xfstests thought quota should be
> > available. That could be viewed as a bug in _require_quota() macro in xfstests
> > but OTOH userspace has no way of knowing which quota formats are available
> > - it can only try to enable quota on a particular fs and that either fails
> > or not. So implementing proper _require_quota() macro would mean you have
> > to do full quota setup for some filesystem, try to enable quotas, and see if
> > that fails. Doable but frankly I'm not hugely interested in that for such a
> > cornercase...
> 
> Yes, I'd much rather fix it in Kconfig.  The question I was asing is
> really whether we could start deprecating QFMT_V1 by requiring QFMT_V2
> and making QFMT_V1 the only optional format, and then changing the
> tools to strongly bias the user towards using V2 --- and maybe making
> it be impossible to create new QFMT_V1 format quota files at all at
> some point.

E.g. OCFS2 has it's own quota format (it selects only CONFIG_QUOTA,
CONFIG_QUOTA_TREE) so forcing QFMT_V2 would just add unused code. So I'm
not much in favor of forcing a particular quota format in Kconfig. On
userspace side V2 format is the default for a long time and I haven't seen
any setup with V1 quota file for years. So I guess making it harder to
create new V1 files and slowly deprecating the support is a good idea.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
