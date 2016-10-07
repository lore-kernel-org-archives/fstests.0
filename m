Received: from mx1.redhat.com ([209.132.183.28]:43868 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935076AbcJGQyG (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 7 Oct 2016 12:54:06 -0400
Date: Fri, 7 Oct 2016 18:52:51 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH V2 2/2] fs/super.c: don't fool lockdep in
        freeze_super() and thaw_super() paths
Message-ID: <20161007165250.GA1906@redhat.com>
References: <20160926161856.GB32458@quack2.suse.cz> <20160926165525.GA9338@redhat.com> <20160927065135.GA1139@quack2.suse.cz> <20160927172901.GA11879@redhat.com> <20160930171434.GA2373@redhat.com> <20161002214225.GS9806@dastard> <20161003164435.GB6634@redhat.com> <20161004114341.GA8572@redhat.com> <20161004114800.GB32214@dhcp22.suse.cz> <20161006134449.GB13177@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161006134449.GB13177@cmpxchg.org>
Sender: fstests-owner@vger.kernel.org
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, Nikolay Borisov <kernel@kyup.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 10/06, Johannes Weiner wrote:
>
> On Tue, Oct 04, 2016 at 01:48:00PM +0200, Michal Hocko wrote:
> > Johannes is already looking into this
> > http://lkml.kernel.org/r/20161004093216.GA21170@cmpxchg.org
> >
> > On Tue 04-10-16 13:43:43, Oleg Nesterov wrote:
> > > because of kernel bug:
> > >
> > > 	[ 2730.242537] run fstests generic/274 at 2016-10-04 05:17:34
> > > 	[ 2730.738352] XFS (loop1): Mounting V5 Filesystem
> > > 	[ 2730.741451] XFS (loop1): Ending clean mount
> > > 	[ 2744.508698] ------------[ cut here ]------------
> > > 	[ 2744.509190] kernel BUG at ./include/linux/swap.h:276!
> > >
> > > static inline void workingset_node_shadows_dec(struct radix_tree_node *node)
> > > {
> > > 	VM_BUG_ON(!workingset_node_shadows(node));
> > > 	node->count -= 1U << RADIX_TREE_COUNT_SHIFT;
>
> We tracked this one down and Linus merged a fix for this issue:
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=d3798ae8c6f3767c726403c2ca6ecc317752c9dd

Confirm, generic/274 no longer crashes the kernel.

Thanks.

Oleg.

