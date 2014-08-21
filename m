Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:34453 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754257AbaHUJXq (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 21 Aug 2014 05:23:46 -0400
Date: Thu, 21 Aug 2014 19:23:44 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/6] common: _scratch_mkfs_sized should inherent default
 block size from test_dev
Message-ID: <20140821092344.GK26465@dastard>
References: <1408194791-1797-1-git-send-email-dmonakhov@openvz.org>
 <1408194791-1797-2-git-send-email-dmonakhov@openvz.org>
 <20140820231450.GI26465@dastard>
 <87mwayqooo.fsf@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mwayqooo.fsf@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 21, 2014 at 11:36:39AM +0400, Dmitry Monakhov wrote:
> On Thu, 21 Aug 2014 09:14:50 +1000, Dave Chinner <david@fromorbit.com> wrote:
> > On Sat, Aug 16, 2014 at 05:13:07PM +0400, Dmitry Monakhov wrote:
> > > Currently default block size is frozen to 4096 which is bad for
> > > various reasons for example:
> > > 1) It ignores MKFS_OPT
> > 
> > It still ignores MKFS_OPTIONS. The test device is not made with
> > those parameters unless you specifically remake it before every
> > xfstests run with a different configuration.
> Yes. Usually I recreate test_dev after config was updated.
> And I tend to agree that this may not be suitable for others.
> In order to fix original issue I'll remove block_size argument from
> _scratch_mkfs_sized and pass MKFS_OPTIONS instead. This will be valid

_scratch_mkfs_sized already appends MKFS_OPTIONS to the mkfs
command. So, really, it seems like you are trying to solve the wrong
problem. i.e. if MKFS_OPTIONS already specifies a block size, then
this code is causing it to be specified twice?

i.e. this code works for XFS because it checks MKFS_OPTIONS for a
custom block size and lets that override the test specified default.
It can do this because it uses $fssize for the siz eof the
filesystem to create, not a block count. For ext4, you need to first
determine if ther eis a block size in MKFS_OPTIONS, extract it if
there is, then use that to calculate the size of the fs in blocks to
pass to mkfs.ext4....

What you want the code already does for XFS - you just need to make
the ext4 (and any other fs you care about) also work correctly with
MKFS_OPTIONS....

> change because currently no one pass block_size to _scratch_mkfs_sized anyway.

perhaps because it already does the right thing for XFS... ;)

> > > 2) Not works for architectures where PG_SIZE != 4096
> > 
> > That I don't understand. 4k block size filesystems work just fine
> > on architectures with page size > 4k....
> Off course. But I meant to say that this arch may use different
> block_size by default.

Typically default block size is set by mkfs, not the arch mkfs is
run on.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
