Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:39771 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726740AbfCSVJE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Mar 2019 17:09:04 -0400
Date: Wed, 20 Mar 2019 08:08:57 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] Documenting the crash-recovery guarantees of Linux
 file systems
Message-ID: <20190319210857.GZ26298@dastard>
References: <1552418820-18102-1-git-send-email-jaya@cs.utexas.edu>
 <20190314011925.GG23020@dastard>
 <CAOQ4uxjNDKjjzzcowy6oFZ=V7hWCkCbSyOQggE2XJirr4JHAyA@mail.gmail.com>
 <20190315030313.GP26298@dastard>
 <CAOQ4uxhyeBhk3DaHO8_oyfWbByidGaSrXJyh7uQE1YMaWTxR5A@mail.gmail.com>
 <20190317221652.GQ26298@dastard>
 <CAOQ4uxgwa9CeyLXJ022VW8dac3h_fGUi9BtF_apMv0T1UjJ3iw@mail.gmail.com>
 <CAHWVdUVFu1s2UCLn2vO1p559pGmio8X4RXK8VSVkSiTQQEcz3A@mail.gmail.com>
 <20190319151709.GB23187@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319151709.GB23187@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Vijay Chidambaram <vijay@cs.utexas.edu>, Amir Goldstein <amir73il@gmail.com>, Jayashree <jaya@cs.utexas.edu>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-doc@vger.kernel.org, chao@kernel.org, Filipe Manana <fdmanana@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Josef Bacik <josef@toxicpanda.com>, Anna Schumaker <Anna.Schumaker@netapp.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 19, 2019 at 11:17:09AM -0400, Theodore Ts'o wrote:
> On Mon, Mar 18, 2019 at 09:37:28PM -0500, Vijay Chidambaram wrote:
> > For new folks on the thread, I'm Vijay Chidambaram, prof at UT Austin
> > and Jayashree's advisor. We recently developed CrashMonkey, a tool for
> > finding crash-consistency bugs in file systems. As part of the
> > research effort, we had a lot of conversations with file-system
> > developers to understand the guarantees provided by different file
> > systems. This patch was inspired by the thought that we should quickly
> > document what we know about the data integrity guarantees of different
> > file systems. We did not expect to spur debate!
> > 
> > Thanks Dave, Amir, and Ted for the discussion. We will incorporate
> > these comments into the next patch. If it is better to wait until a
> > consensus is reached after the LSF meeting, we'd be happy to do so.
> 
> Something to consider is that certain side effects of what fsync(2) or
> fdatasync(2) might drag into the jbd2 transaction might change if we
> were to implement (for example) something like Daejun Park and Dongkun
> Shin's "iJournaling: Fine-grained journaling for improving the latency
> of fsync system call" published in Usenix, ATC 2017:
> 
>    https://www.usenix.org/system/files/conference/atc17/atc17-park.pdf
> 
> That's an example of how if we document synchronization that goes
> beyond POSIX, it might change in the future.

Sure, but again this is orthognal to what we are discussing here:
the user visible ordering of metadata operations after a crash.

If anyone implements a multi-segment or per-inode journal (say, like
NOVA), then it is up to that implementation to maintain the ordering
guarantees that a SOMC model requires. You can implement whatever
fsync() go-fast bits you want, as long as it provides the ordering
behaviour guarantees that the model defines.

IOWs, Ted, I think you have the wrong end of the stick here. This
isn't about optimising fsync() to provide better performance, it's
about guaranteeing order so that fsync() is not necessary and we
improve performance by allowing applications to omit order-only
synchornisation points in their workloads.

i.e. an order-based integrity model /reduces/ the need for a
hyper-optimised fsync operation because applications won't need to
use it as often.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
