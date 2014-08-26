Return-Path: <fstests-owner@vger.kernel.org>
Received: from tetsuo.zabbo.net ([50.193.208.193]:41193 "EHLO tetsuo.zabbo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971AbaHZR1l (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 26 Aug 2014 13:27:41 -0400
Date: Tue, 26 Aug 2014 10:27:40 -0700
From: Zach Brown <zab@zabbo.net>
Subject: Re: [patch, v3] add an aio test which closes the fd before
 destroying the ioctx
Message-ID: <20140826172740.GA18337@lenny.home.zabbo.net>
References: <x49vbrq6r0c.fsf@segfault.boston.devel.redhat.com>
 <20140820225701.GG26465@dastard>
 <x49vbpmwwvc.fsf@segfault.boston.devel.redhat.com>
 <20140821165750.GA7116@lenny.home.zabbo.net>
 <20140825165043.GF20070@kvack.org>
 <x49oav76xu0.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49oav76xu0.fsf@segfault.boston.devel.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Aug 26, 2014 at 12:05:11PM -0400, Jeff Moyer wrote:
> Benjamin LaHaise <bcrl@kvack.org> writes:
> 
> > Does someone already have a simple test case we can add to the libaio test 
> > suite to verify this behaviour?
> 
> I can't reproduce this problem using a loop device, which is what the
> libaio test suite uses.  Even when using real hardware, you have to have
> disks that are slow enough in order for this to trigger reliably (or
> at all).

I wonder if you could use something like dm suspend to abuse indefinite
latencies.

> I could write a more targeted test within xfstests, but I don't think
> that's strictly necessary (it would just make it more clear what the
> expectations are, and maybe bump the hit rate percentage up).

I think it'd be worth it (he says, not commiting *his* time).  It would
have been nice if a targeted test helped Dave raise the alarm
immediately rather than gnaw away at his brain with inconsistent mostly
unrelated failures for months.

- z
