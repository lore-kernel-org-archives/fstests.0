Received: from bombadil.infradead.org ([65.50.211.133]:48810 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754518AbdLGOxg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Dec 2017 09:53:36 -0500
Date: Thu, 7 Dec 2017 15:53:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: False lockdep completion splats with loop device
Message-ID: <20171207145325.47bt3wdd3pm4rvxu@hirez.programming.kicks-ass.net>
References: <20171205030352.6xdopj7cpy5zlwzv@thunk.org>
 <de4d8fd6-48a2-60b6-bab4-d2006e48d828@lge.com>
 <20171205150741.xsbp4mtilqfrsukl@thunk.org>
 <20171205210956.GZ5858@dastard>
 <b0efd17c-eb56-36bf-5be0-06e5bba23c06@lge.com>
 <CAOQ4uxgCREdY5B4TyujM6zi=E7kwcKWpAqJeLaRuLKZBN6=FWQ@mail.gmail.com>
 <da627345-1356-d0b0-b552-de7e288712f9@lge.com>
 <CAOQ4uxg8+P1r_z_9DGYCJivBY5EPpVNnDRKxqPoph_J41JrOmQ@mail.gmail.com>
 <CAOQ4uxi76Er-a4-oejA894ws4t5w1OvLFBofJG03Tf6Ot+Usdg@mail.gmail.com>
 <20171207143329.ioir5cx3fzyqpo4g@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171207143329.ioir5cx3fzyqpo4g@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Amir Goldstein <amir73il@gmail.com>, Byungchul Park <byungchul.park@lge.com>, Dave Chinner <david@fromorbit.com>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, mingo@redhat.com, kernel-team@lge.com
List-ID: <fstests@vger.kernel.org>

On Thu, Dec 07, 2017 at 09:33:29AM -0500, Theodore Ts'o wrote:
> Let me ask a potentially stupid question, Can someone give an example
> of the problem this completion lockdep is actually trying to *catch*.
> The lockdep message is sufficiently confusing it's not even clear what
> *good* it is in the first place.


	lock(A)			lock(A)
	wait_for_completion(C)	complete(C);


> Is there an example of a bug that this lockdep feature hasf actually
> caught in real life, as opposed to false positives?

Yes, it caught a fair bunch of real deadlocks in cpu hotplug, watchdog,
and other places I can't remember.

Here's one in the mm:

  https://lkml.kernel.org/r/20171030152200.ayfnewoqkxbuk4zh@hirez.programming.kicks-ass.net

I have at least one open issue in perf that I've no real idea what to do
about:

  https://lkml.kernel.org/r/20171027153336.GC3857@worktop


Yes lockdep is a pain...
