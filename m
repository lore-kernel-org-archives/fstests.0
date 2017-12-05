Received: from imap.thunk.org ([74.207.234.97]:33376 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750995AbdLEDEG (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 4 Dec 2017 22:04:06 -0500
Date: Mon, 4 Dec 2017 22:03:52 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: False lockdep completion splats with loop device
Message-ID: <20171205030352.6xdopj7cpy5zlwzv@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Byungchul Park <byungchul.park@lge.com>, peterz@infradead.org, mingo@redhat.com
List-ID: <fstests@vger.kernel.org>

There are a ton of false lockdep splats that were introduced with
commit 2dcd5adfb740: "locking/lockdep: Remove the BROKEN flag from
CONFIG_LOCKDEP_CROSSRELEASE and CONFIG_LOCKDEP_COMPLETIONS".

I'm seeing this triggered by a number of xfstests tests, including
shared/298.  I see there was some discussion about this here:

  https://www.spinics.net/lists/linux-xfs/msg10832.html

... but I don't see any solution yet.  Is anyone working on this?

Failing that can we please make the completion lockdep something which
is optional since the false positives are incredibly !@#@!?! annoying?
That way I can still use most of lockdep, instead of being forced to
completely disable lockdep?

Thanks,

						- Ted
