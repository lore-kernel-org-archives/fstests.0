Received: from mx2.suse.de ([195.135.220.15]:48323 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932931AbeAXKo2 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 24 Jan 2018 05:44:28 -0500
Date: Wed, 24 Jan 2018 11:44:25 +0100
From: Jan Kara <jack@suse.cz>
Subject: Re: ext4 quota tests fail with CONFIG_QFMT_V2=n
Message-ID: <20180124104425.qhsnjywna4fjukji@quack2.suse.cz>
References: <20180118010936.GA10649@vader>
 <20180118012831.GF6948@thunk.org>
 <20180118122125.pxgqttayxu6msdgl@quack2.suse.cz>
 <20180118160321.GA13944@thunk.org>
 <20180119084649.hnbh56v4kdkitplu@quack2.suse.cz>
 <20180119171457.GA31450@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180119171457.GA31450@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Omar Sandoval <osandov@osandov.com>, fstests@vger.kernel.org, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Fri 19-01-18 12:14:57, Theodore Ts'o wrote:
> On Fri, Jan 19, 2018 at 09:46:49AM +0100, Jan Kara wrote:
> > 
> > E.g. OCFS2 has it's own quota format (it selects only CONFIG_QUOTA,
> > CONFIG_QUOTA_TREE) so forcing QFMT_V2 would just add unused code. So I'm
> > not much in favor of forcing a particular quota format in Kconfig. On
> > userspace side V2 format is the default for a long time and I haven't seen
> > any setup with V1 quota file for years. So I guess making it harder to
> > create new V1 files and slowly deprecating the support is a good idea.
> 
> Thanks, I didn't know that.  Given that both OCFS2 and XFS have their
> config option for quota, I wonder if it might not be a good idea for
> EXT4 to also add a CONFIG_EXT4_QUOTA which selects CONFIG_QUOTA,
> CONFIG_QUOTA_TREE, and QFMT_V2.
> 
> The alternative would be to have ext4 silently disable support for the
> "quota" feature (since the built-in quota inodes have to be V2) if
> CONFIG_QFMT_V2 is not selected.
> 
> I think the first option is superior; do you agree?

Yeah, I agree that CONFIG_EXT4_QUOTA is a good idea.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
