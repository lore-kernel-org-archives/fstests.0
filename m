Received: from imap.thunk.org ([74.207.234.97]:40260 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301AbcFKPqA (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 11 Jun 2016 11:46:00 -0400
Date: Sat, 11 Jun 2016 11:45:55 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] common: ext4's data=journal mode doesn't support O_DIRECT
Message-ID: <20160611154555.GA5489@thunk.org>
References: <1465497762-3333-1-git-send-email-tytso@mit.edu>
 <20160611122026.GT5140@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160611122026.GT5140@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Jun 11, 2016 at 08:20:26PM +0800, Eryu Guan wrote:
> 
> This hunk doesn't apply, there's no detection code for ext4 encryption
> in current master. And do we need to filter out ext3 journal mode as
> well?

Oops, there's another patch this depends upon that I forgot to send
out this time around.  Let me fix up the spaces and tabs, and probably
just combine the two patches.

> Just curious, what's the problem running direct I/O tests on journal
> mode ext4? ext4 falls back to buffered I/O in this case and I don't see
> any test failures caused by it. Perhaps it'd be better to add this
> information to commit log too.

I'll double check but I think there was at least one dmflaky that
failed (or maybe it was just flaky) because the DIO write wasn't
really DIO, and if the device went read-only too early, the data write
wouldn't make it to the disk, and this caused the test failure.

More generally, if a particular file system mode doesn't support
Direct I/O, even if it doesn't cause a test failure, it's likely a
waste of test resources to run a test which expected that writes be
DIO when it really isn't.

					- Ted
