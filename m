Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:59133 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750759AbcBJWvk (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 10 Feb 2016 17:51:40 -0500
Date: Thu, 11 Feb 2016 09:51:23 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 04/12] generic: add _require_odirect to three more tests
Message-ID: <20160210225123.GZ19486@dastard>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
 <1455069001-17846-5-git-send-email-tytso@mit.edu>
 <20160210091513.GX11419@eguan.usersys.redhat.com>
 <20160210161135.GG26922@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160210161135.GG26922@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org, hughd@google.com
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 10, 2016 at 11:11:35AM -0500, Theodore Ts'o wrote:
> On Wed, Feb 10, 2016 at 05:15:13PM +0800, Eryu Guan wrote:
> > 
> > generic/125 only runs "./src/ftrunc" and I don't see where O_DIRECT is
> > being used, did I miss anything?
> 
> generic/125 also calls "src/trunc", which does use O_DIRECT.
> 
> (Hmm, and it assumes '.' is in the test's path, which I don't think is
> a safe thing to do.)

Perhaps one should question whether generic/125 is actually testing
anything useful in the first place.

i.e. it's writing 16k, then truncating it back to 1000 bytes, then
reading it with direct IO for 60s to see if it returns the correct
data for that entire time.

What, exactly, is going to cause that test to fail?

Keep in mind this was ported from a CXFS test, where the metadata
server did the truncation operation (including the data zeroing),
but the reads are being done from the client.  i.e. it was designed
to test whether a remote machine is doing a truncate correctly on a
access shared disk.

IMO, I think we just remove the test, src/trunc.c and src/ftrunc.c
because it's 60s of testing that doesn't actually provide any value
to us.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
