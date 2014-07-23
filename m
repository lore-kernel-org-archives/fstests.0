Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:51267 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801AbaGWAkx (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 22 Jul 2014 20:40:53 -0400
Date: Tue, 22 Jul 2014 20:38:00 -0400
From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: Problem building xfsprogs
Message-ID: <20140723003800.GV25291@thunk.org>
References: <20140722160641.GU17967@beardog.cce.hp.com>
 <20140722215151.GO25291@thunk.org>
 <20140722220449.GR4453@dastard>
 <20140722221950.GQ25291@thunk.org>
 <20140722230424.GS4453@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140722230424.GS4453@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: scameron@beardog.cce.hp.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 23, 2014 at 09:04:24AM +1000, Dave Chinner wrote:
> 
> I didn't say that.  I'm not sure how you made the leap from being
> asked "can you document the build dependencies you needed to solve"
> to "lets make xfstests run without any external dependencies". I'm
> trying to get someone to document the build dependencies in the
> INSTALL file, not trying to justify the existence of your xfstests
> fork ;)

It's not a fork.  If you look at xfstests-bld, it is an infrastructure
which pulls in via get the latest version of xfstests, and builds it
in a hermetic environment.  Think of it as a distribution independent
packaging infrastructure for xfstests.

It's as much of a fork as Red Hat's varoius source rpms.  And like
many packaging setups, it can be far more convenient for people to use
the package build scripts than to try to build various source packages
from scratch, and having to worry about all of the various
dependencies.

Regards,

						- Ted
