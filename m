Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:56579 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756727AbcHBXUJ (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 2 Aug 2016 19:20:09 -0400
Date: Wed, 3 Aug 2016 09:20:04 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] check: allow comments in exclude files
Message-ID: <20160802232004.GP12670@dastard>
References: <a860d00b5fdc3d88b0ce692585d0046e259c71c4.1470001873.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a860d00b5fdc3d88b0ce692585d0046e259c71c4.1470001873.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: Omar Sandoval <osandov@osandov.com>
Cc: fstests@vger.kernel.org, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

On Sun, Jul 31, 2016 at 02:53:44PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Sometimes it's useful to keep track of why we're excluding a particular
> test. Technically, we can include whatever explanation we want in the
> exclude file since we just grep for the test names, but properly
> supporting comments is a little more robust. This patch makes it so that
> the rest of a line after a '#' is ignored.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

seems reasonable to me.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
