Received: from aserp1040.oracle.com ([141.146.126.69]:20505 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835AbcBKRg0 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 11 Feb 2016 12:36:26 -0500
Date: Thu, 11 Feb 2016 09:36:12 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 05/12] xfstests: do not unmount tmpfs during remount
Message-ID: <20160211173612.GD6346@birch.djwong.org>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
 <1455069001-17846-6-git-send-email-tytso@mit.edu>
 <20160210060716.GV19486@dastard>
 <20160210160732.GE26922@thunk.org>
 <20160210230700.GA19486@dastard>
 <20160210232826.GK26922@thunk.org>
 <20160211030751.GE19486@dastard>
 <20160211152508.GA11298@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160211152508.GA11298@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org, hughd@google.com, Junho Ryu <jayr@google.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Feb 11, 2016 at 10:25:08AM -0500, Theodore Ts'o wrote:
> On Thu, Feb 11, 2016 at 02:07:51PM +1100, Dave Chinner wrote:
> > 
> > IOWs, s/_scratch_remount/_scratch_cycle_mount/ is the sort of
> > no-brainer change that takes less time to write, test and review
> > than it did for me to write this email....
> 
> Fair enough, I'll make that change in the next rev of the patches.
> The current set should reflect all of the other review comments,
> though.

You might wait for the latest batch of reflink tests (the huge batch Dave
referred to earlier in this thread) to land, as I use _scratch_remount in most
of them.

--D

> 
> 						- Ted
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
