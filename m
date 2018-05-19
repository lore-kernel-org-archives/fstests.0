Received: from mail.kernel.org ([198.145.29.99]:43128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752417AbeESXvS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 19 May 2018 19:51:18 -0400
Message-ID: <4cb7ba897fd4b5641be680cd599e74dd0c8e41bf.camel@kernel.org>
Subject: Re: What's up with "locks: change POSIX lock ownership on execve
 when files_struct is displaced"?
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 19 May 2018 19:51:15 -0400
In-Reply-To: <20180519194711.GA21362@thunk.org>
References: <20180519194711.GA21362@thunk.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org, ebiederm@xmission.com
List-ID: <fstests@vger.kernel.org>

On Sat, 2018-05-19 at 15:47 -0400, Theodore Y. Ts'o wrote:
> There is quite of noise currently with xfstests failures.  In addition
> to the fsync/EIO failures, there is also something going on with
> dm-thin, etc.  And then there's generic/484, which is failing for all
> ext4 configs.
> 
> According to test script for generic/484, the test failure is fixed by
> the patch:
> 
> locks: change POSIX lock ownership on execve when files_struct is displaced
> 
> From what I can tell, the patch was last submitted on March 17th, with
> comments from Eric Beiderman on April 2nd and 3rd --- but nothing
> since then:
> 
>       https://lists.gt.net/linux/kernel/2941364
> 
> Are you still hoping to land this patch for 4.17?
> 
> Thanks, regards,
> 
> 						- Ted

No, it's not suitable for inclusion. After I sent the above patch, I
realized that it would break some important filesystems (like NFS).

Eric sounded like he had the best approach to fix it, but it's non-
trivial and somewhat outside the bounds of the locking code. I haven't
had time to attempt a patch for it so far.
-- 
Jeff Layton <jlayton@kernel.org>
