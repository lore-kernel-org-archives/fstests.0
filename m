Received: from bombadil.infradead.org ([198.137.202.9]:60088 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500AbcBVHgT (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 22 Feb 2016 02:36:19 -0500
Date: Sun, 21 Feb 2016 23:36:18 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 05/16] generic: remove the generic/125 test
Message-ID: <20160222073618.GA28903@infradead.org>
References: <1455385269-26319-1-git-send-email-tytso@mit.edu>
 <1455385269-26319-6-git-send-email-tytso@mit.edu>
 <20160217100333.GH21482@infradead.org>
 <20160221215230.GD14668@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160221215230.GD14668@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>, Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org, hughd@google.com
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 22, 2016 at 08:52:30AM +1100, Dave Chinner wrote:
> On Wed, Feb 17, 2016 at 02:03:33AM -0800, Christoph Hellwig wrote:
> > The pNFS block layout driver works the same way as CXFS here.  I
> > don't think I ever triggered this test during the development, though.
> > 
> > I'm indifferent on whether we should keep this test or not, but it
> > defintively makes sense to remove it from the auto group.
> 
> Ok, if there's some value to using it for pNFS testing, then lets
> leave it in place, remove the auto group but also add a "pnfs" group
> tag to it to document what it's useful for.

I think it might only be border line useful.  If you two feel better if
it's gone I'm fine with killing it.
