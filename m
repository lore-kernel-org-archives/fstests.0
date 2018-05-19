Received: from imap.thunk.org ([74.207.234.97]:55732 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752280AbeESTrQ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 19 May 2018 15:47:16 -0400
Date: Sat, 19 May 2018 15:47:11 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: What's up with "locks: change POSIX lock ownership on execve when
 files_struct is displaced"?
Message-ID: <20180519194711.GA21362@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org, ebiederm@xmission.com
List-ID: <fstests@vger.kernel.org>

There is quite of noise currently with xfstests failures.  In addition
to the fsync/EIO failures, there is also something going on with
dm-thin, etc.  And then there's generic/484, which is failing for all
ext4 configs.

According to test script for generic/484, the test failure is fixed by
the patch:

locks: change POSIX lock ownership on execve when files_struct is displaced

>From what I can tell, the patch was last submitted on March 17th, with
comments from Eric Beiderman on April 2nd and 3rd --- but nothing
since then:

      https://lists.gt.net/linux/kernel/2941364

Are you still hoping to land this patch for 4.17?

Thanks, regards,

						- Ted
