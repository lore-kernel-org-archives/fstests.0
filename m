Received: from imap.thunk.org ([74.207.234.97]:39282 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756593AbcBWDc4 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 22 Feb 2016 22:32:56 -0500
Date: Mon, 22 Feb 2016 22:32:49 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] generic/135: fix standard error output from _scratch_mkfs
Message-ID: <20160223033249.GH1215@thunk.org>
References: <1456191325-1217-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20160223032652.GC11419@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160223032652.GC11419@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 23, 2016 at 11:26:52AM +0800, Eryu Guan wrote:
> On Tue, Feb 23, 2016 at 09:35:25AM +0800, Xiao Yang wrote:
> > 'mke2fs 1.42.9 (28-Dec-2013)' produces as standard error when
> > we run generic/135 in ext4 file system. This is a regression
> > bug which bring in by commit:
> > 4a5cda8 xfstests: do not unmount tmpfs during remount
> > That patch remove '2>&1', so i bring that back.
> 
> Thanks for the revision! But I noticed that Ted's patch fixed it too,
> 
> "common: filter warning messages from mkfs.ext4"
> 
> which filters the warnings in _scratch_mkfs_ext4, so that other mkfs
> errors can be noticed in the test. So I think it's a better fix :)

Yes, I had revised patch that added the 2>&1 but that wasn't the one
that ended up xfstests repository.  I started with a patch to add it
back that looked much like yours (except I used '2>&1' instead of '>&'),
but I started thinking about the fact that this would cause errors to
be masked which is not cool.

I believe Dave or Cristoph has said that they don't like redirecting
stderr to /dev/null for _scratch_mount, and it seems to me that
assuming my change makes it in, it would probably be good to get rid
of the other stderr redirections to /dev/null.

					- Ted
