Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40499 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726703AbfCSPRe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Mar 2019 11:17:34 -0400
Date: Tue, 19 Mar 2019 11:17:09 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v2] Documenting the crash-recovery guarantees of Linux
 file systems
Message-ID: <20190319151709.GB23187@mit.edu>
References: <1552418820-18102-1-git-send-email-jaya@cs.utexas.edu>
 <20190314011925.GG23020@dastard>
 <CAOQ4uxjNDKjjzzcowy6oFZ=V7hWCkCbSyOQggE2XJirr4JHAyA@mail.gmail.com>
 <20190315030313.GP26298@dastard>
 <CAOQ4uxhyeBhk3DaHO8_oyfWbByidGaSrXJyh7uQE1YMaWTxR5A@mail.gmail.com>
 <20190317221652.GQ26298@dastard>
 <CAOQ4uxgwa9CeyLXJ022VW8dac3h_fGUi9BtF_apMv0T1UjJ3iw@mail.gmail.com>
 <CAHWVdUVFu1s2UCLn2vO1p559pGmio8X4RXK8VSVkSiTQQEcz3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHWVdUVFu1s2UCLn2vO1p559pGmio8X4RXK8VSVkSiTQQEcz3A@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Vijay Chidambaram <vijay@cs.utexas.edu>
Cc: Amir Goldstein <amir73il@gmail.com>, Dave Chinner <david@fromorbit.com>, Jayashree <jaya@cs.utexas.edu>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-doc@vger.kernel.org, chao@kernel.org, Filipe Manana <fdmanana@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Josef Bacik <josef@toxicpanda.com>, Anna Schumaker <Anna.Schumaker@netapp.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Mar 18, 2019 at 09:37:28PM -0500, Vijay Chidambaram wrote:
> For new folks on the thread, I'm Vijay Chidambaram, prof at UT Austin
> and Jayashree's advisor. We recently developed CrashMonkey, a tool for
> finding crash-consistency bugs in file systems. As part of the
> research effort, we had a lot of conversations with file-system
> developers to understand the guarantees provided by different file
> systems. This patch was inspired by the thought that we should quickly
> document what we know about the data integrity guarantees of different
> file systems. We did not expect to spur debate!
> 
> Thanks Dave, Amir, and Ted for the discussion. We will incorporate
> these comments into the next patch. If it is better to wait until a
> consensus is reached after the LSF meeting, we'd be happy to do so.

Something to consider is that certain side effects of what fsync(2) or
fdatasync(2) might drag into the jbd2 transaction might change if we
were to implement (for example) something like Daejun Park and Dongkun
Shin's "iJournaling: Fine-grained journaling for improving the latency
of fsync system call" published in Usenix, ATC 2017:

   https://www.usenix.org/system/files/conference/atc17/atc17-park.pdf

That's an example of how if we document synchronization that goes
beyond POSIX, it might change in the future.  So if it gets
documented, applications might start becoming unreliable on FreeBSD,
MacOS, etc.  And maybe as Linux developers we won't care about that;
since it increases Linux lock-in.  Win!  (If you think like Steve
Ballmer, anyway.  :-)

But then if we were to implement something like incremental journaling
for fsync, and applications were to start assuming that it would also
work, application authors might complain that we had broken their
application So they might call the new feature a *BUG* which broke
backwards compatibility, and then demand that we either withdraw the
new feature, or complicate our testing matrix by adding Yet Another
Mount Option.  (That's especially true since iJournaling is a
performance improvement that doesn't require an on-disk format change.
So this is the sort of thing that we might want to enable by default
eventually, even if initially it's only enabled via a mount option
while we are stablizing the new feature.)

So my concerns are not a theoretical, abstract concern, but something
which is very real.  Implementing something like what Park and Shin
has proposed is something that is very much that we are thinking
about.

    	     		       	       	    - Ted
