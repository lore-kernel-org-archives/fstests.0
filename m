Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34120 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758908AbaLLCwE (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 11 Dec 2014 21:52:04 -0500
Date: Fri, 12 Dec 2014 10:51:59 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] generic/299: various fixes
Message-ID: <20141212025158.GP15495@dhcp-13-216.nay.redhat.com>
References: <1418294952-20035-1-git-send-email-eguan@redhat.com>
 <1418295529-20565-1-git-send-email-eguan@redhat.com>
 <20141211235053.GH24183@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141211235053.GH24183@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Dec 12, 2014 at 10:50:53AM +1100, Dave Chinner wrote:
> On Thu, Dec 11, 2014 at 06:58:49PM +0800, Eryu Guan wrote:
> > Fix three problems in generic/299
> > 
> > 1. Use $XFS_IO_PROG instead of fallocate/truncate, old distros like
> > RHEL5 don't have these commands.
> > 
> > 2. Remove $seqres.full before test, otherwise the file is growing all
> > the time.
> > 
> > 3. Make sure fio really exits, otherwise fio would block umount. $pid is
> > the pid of function run_check not fio, sometimes fio is still there when
> > $pid is dead and blocking umount.
> > 
> > Signed-off-by: Eryu Guan <eguan@redhat.com>
> > ---
> > 
> > v2:
> > - remove $seqres.full before _require_fio, which writes to $seqres.full too
> 
> Does not apply after Eric's earlier patch "[PATCH] use xfs_io
> falloc, not fallocate". Once I push out an updated tree with this
> patch in it, can you rebase this patch and resend it?

Sure, will rebase and resend once the tree is updated.

Thanks,
Eryu
