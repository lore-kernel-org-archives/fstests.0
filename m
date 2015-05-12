Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:28876 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933877AbbELXkI (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 12 May 2015 19:40:08 -0400
Date: Wed, 13 May 2015 09:40:05 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/126: Test the permission to set file times
Message-ID: <20150512234005.GC4316@dastard>
References: <1431455831-13345-1-git-send-email-andreas.gruenbacher@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1431455831-13345-1-git-send-email-andreas.gruenbacher@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Cc: fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>
List-ID: <fstests@vger.kernel.org>

On Tue, May 12, 2015 at 08:37:11PM +0200, Andreas Gruenbacher wrote:
> Check if setting the file access and modification times to the current time
> and to a specific timestamp is allowed when expected.
> 
> Signed-off-by: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>

I think I'd prefer to see this added as a new test, rather than
extending an existing test and potentially causing it to fail due to
the new things being tested....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
