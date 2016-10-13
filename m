Received: from mx1.redhat.com ([209.132.183.28]:43078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933740AbcJMQ73 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 13 Oct 2016 12:59:29 -0400
Date: Thu, 13 Oct 2016 18:58:08 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH V2 2/2] fs/super.c: don't fool lockdep in
        freeze_super() and thaw_super() paths
Message-ID: <20161013165807.GA21138@redhat.com>
References: <20161003164435.GB6634@redhat.com> <20161004114341.GA8572@redhat.com> <20161004194435.GW9806@dastard> <20161005164432.GB15121@redhat.com> <20161006171758.GA21707@redhat.com> <20161006215920.GE9806@dastard> <20161007171517.GA23721@redhat.com> <20161007225231.GY27872@dastard> <20161009161456.GA11737@redhat.com> <20161010010250.GO9806@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161010010250.GO9806@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, Nikolay Borisov <kernel@kyup.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Dave, I am sorry for delay.

On 10/10, Dave Chinner wrote:
>
> So, it's time to waste more time explaining why lockdep is telling
> us about something that *isn't a bug*.
> [... snip ...]

OK, thanks. I am not surprised although I have to admit I wasn't sure.

> Basically, what we are seeing here is yet another case of "lockdep
> is just smart enough to be really dumb" because we cannot fully
> express or cleanly annotate the contexts in which it is being asked
> to validate.

Yes... perhaps we can add the new lockdep helpers to avoid the false-
positives like this one, but so far it is not clear to me what we can do.
Somehow we need to tell it to to avoid check_prev_add() because we know
that the work function won't take sb_internal, but at the same time we
should complain if it actually does this. Lets ignore this patch for now.

Oleg.

