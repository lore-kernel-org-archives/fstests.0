Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:55320 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750992AbeDIKcK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 9 Apr 2018 06:32:10 -0400
Date: Mon, 9 Apr 2018 20:32:07 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] fstests: generic test for fsync after fallocate
Message-ID: <20180409103207.GV23861@dastard>
References: <20180405215614.611-1-fdmanana@kernel.org>
 <20180408020754.GA2932@desktop>
 <20180409095138.GU23861@dastard>
 <CAL3q7H7k_Yw2vsV4anL_7=ZepfT8LdYmgUX6JwoRDMUyZyzV2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7k_Yw2vsV4anL_7=ZepfT8LdYmgUX6JwoRDMUyZyzV2g@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Filipe Manana <fdmanana@kernel.org>
Cc: Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 09, 2018 at 11:00:52AM +0100, Filipe Manana wrote:
> On Mon, Apr 9, 2018 at 10:51 AM, Dave Chinner <david@fromorbit.com> wrote:
> > On Sun, Apr 08, 2018 at 10:07:54AM +0800, Eryu Guan wrote:
> >> On Thu, Apr 05, 2018 at 10:56:14PM +0100, fdmanana@kernel.org wrote:
> > You also cannot assume that two separate preallocations beyond EOF
> > are going to be contiguous (i.e. it could be two separate extents.
> 
> I really don't care about that.
> Just want to check that allocated space is not lost, don't care if
> that space is covered by 1, 2 or more extents, or whether they are
> contiguous or not.

Sure, but that's not what the test does :/

> > What you should just be checking is that there are extents allocated
> > covering EOF to 3MB, not the exactly size, shape and type of extents
> > are allocated.
> 
> How to do such check, for a generic test, without using fiemap?

We already do such checks using fiemap, yes?

i.e. there's a bunch of _filter*fiemap() functions in common/punch
which should show you exactly how to do this i.e. filter all the
unwritten/data extents to be the same name, then they coalesce into
single ranges....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
