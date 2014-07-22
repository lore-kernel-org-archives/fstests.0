Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:50834 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932102AbaGVVv4 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 22 Jul 2014 17:51:56 -0400
Date: Tue, 22 Jul 2014 17:51:51 -0400
From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: Problem building xfsprogs
Message-ID: <20140722215151.GO25291@thunk.org>
References: <20140722160641.GU17967@beardog.cce.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140722160641.GU17967@beardog.cce.hp.com>
Sender: fstests-owner@vger.kernel.org
To: scameron@beardog.cce.hp.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jul 22, 2014 at 11:06:41AM -0500, scameron@beardog.cce.hp.com wrote:
> 
> I'm trying to build xfsprogs (in order to run xfstests), and I'm running into this:

What distribution are you building on?  I had a frustrating enough
time getting it to build on Ubuntu and Debian systems a while back
(not xfstests' fault; sometimes the distro doesn't ship all of the
header files or have recent enough libraries) that I created
xfstests-bld which does a hermetic build of xfstests.  That way, it
doesn't depend on anything getting shipped by the distribution.

It's also useful if you are running in a very restrictive run-time
environment, such as what you might find in a highly opimized cloud
data center, and you can't depend on any shared libraries, etc.  Or if
you need to do a build for an embedded platform where again, you can't
depend on anything getting provided by the distribution.

Anyway, give it a try and see if it helps,

	git://git.kernel.org/pub/scm/fs/ext2/xfstests-bld.git

If you have any problems, let me know!

						- Ted
