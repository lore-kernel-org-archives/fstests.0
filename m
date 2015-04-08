Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:55804 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993AbbDHD5P (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 7 Apr 2015 23:57:15 -0400
Date: Tue, 7 Apr 2015 23:57:13 -0400
From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] generic: LVM and ram disks don't play well
Message-ID: <20150408035713.GF21171@thunk.org>
References: <1428371810-11085-1-git-send-email-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1428371810-11085-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Apr 07, 2015 at 11:56:50AM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> The "brd" kernel ram disk abuses BLKFLSBUF to mean "free all memory
> in the ram drive" when in fact it actually means "flush all dirty
> buffers to stable storage".

Actually, what BLKFLSBUF means is to "flush all dirty buffers to
stable storage --- and then invalidate/kill all buffers for the
underyling block device."

The reason why the ramdisk driver has special semantics BLKFLSBUF is
an accident of how it was originally implemented, back in the 0.1x
days of Linux, where it was implemented as a set of buffers in the
buffer cache that weren't actually backed by any device.  Since they
were marked dirty, they wouldn't actually get dropped by the buffer
cache.  It was a dirty hack, but back in the days where they were used
to populate the ramdisk from a floppy disk, it worked well enough.

It happened that how BLKFLSBUF was implemented, without having to do
anything special, the fact that BLKFLSBUF would invalidate all of the
buffers from the buffer cache, userspace code would use this as a way
of causing the ram disk to release memory.

Given the desire not to break userspace, when the brd device was
implemented to no longer depend on the buffer cache, the "special"
semantics of BLKFLSBUF were preserved.  We probably should have
allocated a new ioctl for the explicit purpose of releasing memory,
and then tracked down all users of the magic BLKFLSBUF ioctl.  I don't
think there should be that many --- in fact, it may very well be that
init/do_mounts_initrd.c in the kernel sources might be one of the few
still around, since the days of boot/root floppies are long before us.

Cheers,

						- Ted
						
