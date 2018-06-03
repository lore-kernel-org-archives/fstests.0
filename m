Received: from imap.thunk.org ([74.207.234.97]:58782 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751159AbeFCRzx (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 3 Jun 2018 13:55:53 -0400
Date: Sun, 3 Jun 2018 13:55:50 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [RFC PATCH 0/2] fstests: boiler plate reductions
Message-ID: <20180603175550.GA1750@thunk.org>
References: <20180529004752.8243-1-david@fromorbit.com>
 <20180603135107.GK6581@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180603135107.GK6581@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Jun 03, 2018 at 09:51:07PM +0800, Eryu Guan wrote:
> > Once we have some consensus on how we want to proceed, I'll do the
> > grunt work and co-ordinate with Eryu on minimising the number of
> > times I have to rebase a patchset that is going to touch around 1500
> > files...
> 
> How would you like to proceed with a minimum number of rebasing times? I
> think that most rebase work would come from new tests that being added
> during the whole process, I think I could do

The simplest thing to do would be to just drop any conversions where
there is a merge conflict, since if you have 95% using the template,
and 5% that doesn't, it doesn't much matter.  Then Dave could do
another pass, and that would probably get the next 95%, etc., and then
we would be close to do.

So I don't think there's any need to suspend adding new tests.  If
there are a few new tests that don't use the template at first, it's
really not the end of the world.

Cheers,

					- Ted
