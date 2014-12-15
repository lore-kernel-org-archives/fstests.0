Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:57530 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882AbaLOUCO (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 15 Dec 2014 15:02:14 -0500
Date: Mon, 15 Dec 2014 15:02:09 -0500
From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] ext4/308,generic/324: require fallocate support
Message-ID: <20141215200209.GK17575@thunk.org>
References: <1418658443-31670-1-git-send-email-tytso@mit.edu>
 <20141215172937.GX15495@dhcp-13-216.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141215172937.GX15495@dhcp-13-216.nay.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Dec 16, 2014 at 01:32:00AM +0800, Eryu Guan wrote:
> On Mon, Dec 15, 2014 at 10:47:23AM -0500, Theodore Ts'o wrote:
> > These tests use the falloc command in xfs_io, and there are some file
> > systems (ext3) or file system configurations (ext4 in ext3
> > compatibility mode) which do not support fallocate.  So add the
> > explicit requirement to avoid false test failures.
> 
> The two tests fail because of no defrag support on ext3 on my test host.
> 
> ext4/308         [not run] defragmentation not supported for fstype "ext3"                                                                                     
> generic/324 19s ... [not run] defragmentation not supported for fstype "ext3"

The problem is if you are using ext4 in compatibility mode for ext3
file system, it does support the defrag ioctl, but it can't support
fallocate for non-extent-mapped files (since we can't mark the blocks
as being uninitialized).  (Well, we could support fallocate in
no-hide-stale mode, but that's only something that Google and Tao Bao
is using, and that patch isn't upstream anyway, since it's been
declared unclean.  :-)

> ext4/308 also uses fiemap command, I think we need another check here
> 
> _require_xfs_io_command "fiemap"

ext4 is always going to support the fiemap ioctl, so I think we're
good there.

Cheers,

					- Ted
