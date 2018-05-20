Received: from imap.thunk.org ([74.207.234.97]:57182 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752485AbeETBOA (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 19 May 2018 21:14:00 -0400
Date: Sat, 19 May 2018 21:13:56 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: What's up with "locks: change POSIX lock ownership on execve
 when files_struct is displaced"?
Message-ID: <20180520011356.GD23448@thunk.org>
References: <20180519194711.GA21362@thunk.org>
 <4cb7ba897fd4b5641be680cd599e74dd0c8e41bf.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cb7ba897fd4b5641be680cd599e74dd0c8e41bf.camel@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org, ebiederm@xmission.com
List-ID: <fstests@vger.kernel.org>

On Sat, May 19, 2018 at 07:51:15PM -0400, Jeff Layton wrote:
> 
> No, it's not suitable for inclusion. After I sent the above patch, I
> realized that it would break some important filesystems (like NFS).
> 
> Eric sounded like he had the best approach to fix it, but it's non-
> trivial and somewhat outside the bounds of the locking code. I haven't
> had time to attempt a patch for it so far.

Thanks, I'll suppress generic/484 for my ext4 testing for now.

	     	      		      	      - Ted
