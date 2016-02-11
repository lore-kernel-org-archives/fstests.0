Received: from imap.thunk.org ([74.207.234.97]:41677 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbcBKPZL (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 11 Feb 2016 10:25:11 -0500
Date: Thu, 11 Feb 2016 10:25:08 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 05/12] xfstests: do not unmount tmpfs during remount
Message-ID: <20160211152508.GA11298@thunk.org>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
 <1455069001-17846-6-git-send-email-tytso@mit.edu>
 <20160210060716.GV19486@dastard>
 <20160210160732.GE26922@thunk.org>
 <20160210230700.GA19486@dastard>
 <20160210232826.GK26922@thunk.org>
 <20160211030751.GE19486@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160211030751.GE19486@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, hughd@google.com, Junho Ryu <jayr@google.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Feb 11, 2016 at 02:07:51PM +1100, Dave Chinner wrote:
> 
> IOWs, s/_scratch_remount/_scratch_cycle_mount/ is the sort of
> no-brainer change that takes less time to write, test and review
> than it did for me to write this email....

Fair enough, I'll make that change in the next rev of the patches.
The current set should reflect all of the other review comments,
though.

						- Ted
