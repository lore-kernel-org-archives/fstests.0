Received: from imap.thunk.org ([74.207.234.97]:48930 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751031AbcBLFlx (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 12 Feb 2016 00:41:53 -0500
Date: Fri, 12 Feb 2016 00:41:50 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 13/13] common: remove unneeded mount options for ext4
Message-ID: <20160212054150.GE11298@thunk.org>
References: <1455170182-32587-1-git-send-email-tytso@mit.edu>
 <1455170182-32587-14-git-send-email-tytso@mit.edu>
 <20160212035709.GY14668@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160212035709.GY14668@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, hughd@google.com
List-ID: <fstests@vger.kernel.org>

On Fri, Feb 12, 2016 at 02:57:09PM +1100, Dave Chinner wrote:
> On Thu, Feb 11, 2016 at 12:56:22AM -0500, Theodore Ts'o wrote:
> > Ext4 has turned on acls and xattrs by default for a long, long time
> > (even the 3.10 kernel has it on by default).
> > 
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> 
> Hmmm - aren't these really there for transparent support of older
> distros that still require these mount options? e.g. RHEL6, older
> SLES kernels, etc?

Good point.  I had forgotten (traumatic memory suppression, no doubt)
that there are poor souls who still have to support 2.6.32 kernels.
Only four more years before it goes EOL --- in 2020.  I'm so glad I
don't work in the enterprise space any more.  And I thought things
were bad with cell phones shipping with 3.10 kernels in 2016.  :-)

						- Ted
