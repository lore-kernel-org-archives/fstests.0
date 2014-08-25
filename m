Return-Path: <fstests-owner@vger.kernel.org>
Received: from kanga.kvack.org ([205.233.56.17]:45735 "EHLO kanga.kvack.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756309AbaHYQup (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 25 Aug 2014 12:50:45 -0400
Date: Mon, 25 Aug 2014 12:50:43 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [patch, v3] add an aio test which closes the fd before destroying the ioctx
Message-ID: <20140825165043.GF20070@kvack.org>
References: <x49vbrq6r0c.fsf@segfault.boston.devel.redhat.com> <20140820225701.GG26465@dastard> <x49vbpmwwvc.fsf@segfault.boston.devel.redhat.com> <20140821165750.GA7116@lenny.home.zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140821165750.GA7116@lenny.home.zabbo.net>
Sender: fstests-owner@vger.kernel.org
To: Zach Brown <zab@zabbo.net>
Cc: Jeff Moyer <jmoyer@redhat.com>, Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 21, 2014 at 09:57:50AM -0700, Zach Brown wrote:
> On Wed, Aug 20, 2014 at 07:43:19PM -0400, Jeff Moyer wrote:
> > Hi, Dave,
> > 
> > Dave Chinner <david@fromorbit.com> writes:
> > 
> > > IOWs, we now have two AIO+DIO tests showing the same symptoms that
> > > no other tests show. This tends to point at AIO not being fully
> > > cleaned up and completely freed by the time the processes
> > > dispatching it have exit()d. This failure generally occurs when
> > > there is other load on the system/disks backing the test VM (e.g.
> > > running xfstests in multiple VMs at the same time) so I suspect it
> > > has to do with IO completion taking a long time.
> > 
> > Process exit waits for all outstanding I/O, but maybe it's an rcu thing.
> 
> I thought it did too but it doesn't look like upstream exit_aio() is
> waiting for iocbs to complete.
> 
> Ben, are you digging in to this?  Want me to throw something together?

Something like the following should fix it.  This is only lightly tested.  
Does someone already have a simple test case we can add to the libaio test 
suite to verify this behaviour?  I'm assuming that waiting for one ioctx 
at a time is sufficient and we don't need to parallelise cancellation at 
exit.

		-ben
-- 
"Thought is the essence of where you are now."

diff --git a/fs/aio.c b/fs/aio.c
index 97bc62c..c558e9a 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -732,7 +732,6 @@ static int kill_ioctx(struct mm_struct *mm, struct kioctx *ctx,
 	if (atomic_xchg(&ctx->dead, 1))
 		return -EINVAL;
 
-
 	spin_lock(&mm->ioctx_lock);
 	table = rcu_dereference_raw(mm->ioctx_table);
 	WARN_ON(ctx != table->table[ctx->id]);
@@ -792,6 +791,8 @@ void exit_aio(struct mm_struct *mm)
 		return;
 
 	for (i = 0; i < table->nr; ++i) {
+		struct completion requests_done =
+			COMPLETION_INITIALIZER_ONSTACK(requests_done);
 		struct kioctx *ctx = table->table[i];
 
 		if (!ctx)
@@ -804,7 +805,8 @@ void exit_aio(struct mm_struct *mm)
 		 * that it needs to unmap the area, just set it to 0.
 		 */
 		ctx->mmap_size = 0;
-		kill_ioctx(mm, ctx, NULL);
+		if (!kill_ioctx(mm, ctx, &requests_done))
+			wait_for_completion(&requests_done);
 	}
 
 	RCU_INIT_POINTER(mm->ioctx_table, NULL);
