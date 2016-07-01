Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:6175 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751052AbcGABYW (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 30 Jun 2016 21:24:22 -0400
Date: Fri, 1 Jul 2016 11:16:42 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v3] xfstests: Fix installation for extended
Message-ID: <20160701011642.GV27480@dastard>
References: <1467212275-14344-1-git-send-email-jtulak@redhat.com>
 <1467302784-32755-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467302784-32755-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jan Tulak <jtulak@redhat.com>
Cc: fstests@vger.kernel.org, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 30, 2016 at 06:06:24PM +0200, Jan Tulak wrote:
> xfstests supports extended test names like 314-foo-bar, but installation of
> these tests was skipped (not matching a regexp). So this patch fixes the
> makefiles in tests/xfs/.
> 
> This change will have to be repeated later for other directories, as adding it
> now everywhere would cause make install to fail if no such extended name is
> present in the dir.
> 
> Signed-off-by: Jan Tulak <jtulak@redhat.com>
> ---
> UPDATE:
> Let it be just in tests/xfs/.
> 
> NOTE: if tested without at first merging my 400-input-valiation test, make
> install will fail again. :-)

This really should be done in a way that doesn't fail like this so
it can simply be added to all the tests/<fs>/Makefile and then we
can ignore the problem again.

The usual way of doing this from with the makefile is to use
wildcard rules, something like:

INSTALL_FILES = $(wildcard <regex>)

install: $(addsuffix -install,$(INSTALL_FILES))
	[.....]

%-install:
	$(INSTALL) -m 664 $* $(TARGET_DIR)


You can use multiple wildcard matches for INSTALL_FILES if you can't
write a single regex to grab all the filesystem that need
installing.

See, for example, tests/Makefile for an example of exactly this sort
of wildcard matching so that the makefile does not need updating
every time we add a new tests subdirectory.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
