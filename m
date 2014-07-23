Return-Path: <fstests-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:32192 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754985AbaGWOJ0 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 23 Jul 2014 10:09:26 -0400
Date: Wed, 23 Jul 2014 09:08:34 -0500
From: scameron@beardog.cce.hp.com
Subject: Re: Problem building xfsprogs
Message-ID: <20140723140834.GJ14599@beardog.cce.hp.com>
References: <20140722160641.GU17967@beardog.cce.hp.com> <20140722215151.GO25291@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140722215151.GO25291@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, scameron@beardog.cce.hp.com
List-ID: <fstests@vger.kernel.org>

On Tue, Jul 22, 2014 at 05:51:51PM -0400, Theodore Ts'o wrote:
> On Tue, Jul 22, 2014 at 11:06:41AM -0500, scameron@beardog.cce.hp.com wrote:
> > 
> > I'm trying to build xfsprogs (in order to run xfstests), and I'm running into this:
> 
> What distribution are you building on?  

RHEL 6 update 5 on x86_64, which I would think is not considered
to be anything exotic.

[relliott@msablackburn include]$ cat /etc/*-release
LSB_VERSION=base-4.0-amd64:base-4.0-noarch:core-4.0-amd64:core-4.0-noarch:graphics-4.0-amd64:graphics-4.0-noarch:printing-4.0-amd64:printing-4.0-noarch
Red Hat Enterprise Linux Server release 6.5 (Santiago)
Red Hat Enterprise Linux Server release 6.5 (Santiago)
[relliott@msablackburn include]$

But, I am not running the usual kernel, but this one

	git://git.infradead.org/users/hch/scsi.git

from this branch:

	remotes/origin/scsi-mq.4

with a ton of patches to the hpsa driver (not that xfsprogs should care about that.).

> I had a frustrating enough
> time getting it to build on Ubuntu and Debian systems a while back
> (not xfstests' fault; sometimes the distro doesn't ship all of the
> header files or have recent enough libraries) that I created
> xfstests-bld which does a hermetic build of xfstests.  That way, it
> doesn't depend on anything getting shipped by the distribution.
> 
> It's also useful if you are running in a very restrictive run-time
> environment, such as what you might find in a highly opimized cloud
> data center, and you can't depend on any shared libraries, etc.  Or if
> you need to do a build for an embedded platform where again, you can't
> depend on anything getting provided by the distribution.
> 
> Anyway, give it a try and see if it helps,
> 
> 	git://git.kernel.org/pub/scm/fs/ext2/xfstests-bld.git
> 
> If you have any problems, let me know!

Thanks.  If other avenues don't work out it is something to try.

-- steve


