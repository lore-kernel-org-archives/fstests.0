Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:11449 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726712AbfCSUnf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Mar 2019 16:43:35 -0400
Date: Wed, 20 Mar 2019 07:43:30 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] Documenting the crash-recovery guarantees of Linux
 file systems
Message-ID: <20190319204330.GY26298@dastard>
References: <1552418820-18102-1-git-send-email-jaya@cs.utexas.edu>
 <20190314011925.GG23020@dastard>
 <CAOQ4uxjNDKjjzzcowy6oFZ=V7hWCkCbSyOQggE2XJirr4JHAyA@mail.gmail.com>
 <20190315030313.GP26298@dastard>
 <CAOQ4uxhyeBhk3DaHO8_oyfWbByidGaSrXJyh7uQE1YMaWTxR5A@mail.gmail.com>
 <20190317221652.GQ26298@dastard>
 <CAOQ4uxgwa9CeyLXJ022VW8dac3h_fGUi9BtF_apMv0T1UjJ3iw@mail.gmail.com>
 <20190319031312.GW26298@dastard>
 <CAOQ4uxjyrYO8bmY04-AE9t3kQ=0B-m1A8yLRXtsyevrxCfyLxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjyrYO8bmY04-AE9t3kQ=0B-m1A8yLRXtsyevrxCfyLxg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jayashree <jaya@cs.utexas.edu>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-doc@vger.kernel.org, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, Theodore Tso <tytso@mit.edu>, chao@kernel.org, Filipe Manana <fdmanana@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Josef Bacik <josef@toxicpanda.com>, Anna Schumaker <Anna.Schumaker@netapp.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 19, 2019 at 09:35:19AM +0200, Amir Goldstein wrote:
> On Tue, Mar 19, 2019 at 5:13 AM Dave Chinner <david@fromorbit.com> wrote:
> > That is, sync_file_range() is only safe to use for this specific
> > sort of ordered data integrity algorithm when flushing the entire
> > file.(*)
> >
> > create
> > setxattr
> > write                                   metadata volatile
> >   delayed allocation                    data volatile
> > ....
> > sync_file_range(fd, 0, 0, SYNC_FILE_RANGE_WAIT_BEFORE |
> >                 SYNC_FILE_RANGE_WRITE | SYNC_FILE_RANGE_WAIT_AFTER);
> >   Extent Allocation                     metadata volatile
> >                   ----> device -+
> >                                         data volatile
> >                   <-- complete -+
> > ....
> > rename                                  metadata volatile
> >
> > And so at this point, we only need a device cache flush to
> > make the data persistent and a journal flush to make the rename
> > persistent. And so it ends up the same case as non-AIO O_DIRECT.
> >
> 
> Funny, I once told that story and one Dave Chinner told me
> "Nice story, but wrong.":
> https://patchwork.kernel.org/patch/10576303/#22190719
> 
> You pointed to the minor detail that sync_file_range() uses
> WB_SYNC_NONE.

Ah, I forgot about that. That's what I get for not looking at the
code. Did I mention that SFR is a complete crock of shit when it
comes to data integrity operations? :/

> So yes, I agree, it is a nice story and we need to make it right,
> by having an API (perhaps SYNC_FILE_RANGE_ALL).
> When you pointed out my mistake, I switched the application to
> use the FIEMAP_FLAG_SYNC API as a hack.

Yeah, that 's a nasty hack :/

> Besides tests and documentation what could be useful is a portable
> user space library that just does the right thing for every filesystem.

*nod*

but before that, we need the model to be defined and documented.
And once we have a library, the fun part of convincing the world
that it should be the glibc default behaviour can begin....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
