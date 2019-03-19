Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:10107 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbfCSEhc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Mar 2019 00:37:32 -0400
Date: Tue, 19 Mar 2019 15:37:23 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] Documenting the crash-recovery guarantees of Linux
 file systems
Message-ID: <20190319043723.GX26298@dastard>
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
Cc: Amir Goldstein <amir73il@gmail.com>, Jayashree <jaya@cs.utexas.edu>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-doc@vger.kernel.org, Theodore Tso <tytso@mit.edu>, chao@kernel.org, Filipe Manana <fdmanana@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Josef Bacik <josef@toxicpanda.com>, Anna Schumaker <Anna.Schumaker@netapp.com>
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
> 
> On Mon, Mar 18, 2019 at 2:14 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Mon, Mar 18, 2019 at 12:16 AM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Fri, Mar 15, 2019 at 05:44:49AM +0200, Amir Goldstein wrote:
> > > > On Fri, Mar 15, 2019 at 5:03 AM Dave Chinner <david@fromorbit.com> wrote:
> > > > >
> > > > > On Thu, Mar 14, 2019 at 09:19:03AM +0200, Amir Goldstein wrote:
> > > > > > On Thu, Mar 14, 2019 at 3:19 AM Dave Chinner <david@fromorbit.com> wrote:
> > > > > > > On Tue, Mar 12, 2019 at 02:27:00PM -0500, Jayashree wrote:
> > > > > > > > +Strictly Ordered Metadata Consistency
> > > > > > > > +-------------------------------------
> > > > > > > > +With each file system providing varying levels of persistence
> > > > > > > > +guarantees, a consensus in this regard, will benefit application
> > > > > > > > +developers to work with certain fixed assumptions about file system
> > > > > > > > +guarantees. Dave Chinner proposed a unified model called the
> > > > > > > > +Strictly Ordered Metadata Consistency (SOMC) [5].
> > > > > > > > +
> > > > > > > > +Under this scheme, the file system guarantees to persist all previous
> > > > > > > > +dependent modifications to the object upon fsync().  If you fsync() an
> > > > > > > > +inode, it will persist all the changes required to reference the inode
> > > > > > > > +and its data. SOMC can be defined as follows [6]:
> > > > > > > > +
> > > > > > > > +If op1 precedes op2 in program order (in-memory execution order), and
> > > > > > > > +op1 and op2 share a dependency, then op2 must not be observed by a
> > > > > > > > +user after recovery without also observing op1.
> > > > > > > > +
> > > > > > > > +Unfortunately, SOMC's definition depends upon whether two operations
> > > > > > > > +share a dependency, which could be file-system specific. It might
> > > > > > > > +require a developer to understand file-system internals to know if
> > > > > > > > +SOMC would order one operation before another.
> > > > > > >
> > > > > > > That's largely an internal implementation detail, and users should
> > > > > > > not have to care about the internal implementation because the
> > > > > > > fundamental dependencies are all defined by the directory heirarchy
> > > > > > > relationships that users can see and manipulate.
> > > > > > >
> > > > > > > i.e. fs internal dependencies only increase the size of the graph
> > > > > > > that is persisted, but it will never be reduced to less than what
> > > > > > > the user can observe in the directory heirarchy.
> > > > > > >
> > > > > > > So this can be further refined:
> > > > > > >
> > > > > > >         If op1 precedes op2 in program order (in-memory execution
> > > > > > >         order), and op1 and op2 share a user visible reference, then
> > > > > > >         op2 must not be observed by a user after recovery without
> > > > > > >         also observing op1.
> > > > > > >
> > > > > > > e.g. in the case of the parent directory - the parent has a link
> > > > > > > count. Hence every create, unlink, rename, hard link, symlink, etc
> > > > > > > operation in a directory modifies a user visible link count
> > > > > > > reference.  Hence fsync of one of those children will persist the
> > > > > > > directory link count, and then all of the other preceeding
> > > > > > > transactions that modified the link count also need to be persisted.
> 
> Dave, how did SOMC come about? Even XFS persists more than the minimum
> set required by SOMC. Is SOMC most useful as a sort of intuitive
> guideline as to what users should expect to see after recovery?

Lots of things. 15+ years of fixing data and metadata recovery
ordering bugs in XFS, 20 years of reading academic filesystem
papers, many years of hating POSIX and that we should be aiming more
towards database ACID semantics in our filesystems, deciding
~10 years ago that maintainable integrity is far more important than
performance, understanding the block layer/device integrity
requirements and the model smarter people than me came up with for
ensuring integrity with minimal loss of performance, etc.

A big influence has also been that the "crash lost data" bug reports
we get from users are generally not a result of data being lost,
they are a result of incomplete and/or inconsistent recreation of
the state before the crash occurred.  e.g. files that exist with a
non-zero size but have no data in them, even though it had been
minutes between writing the data and crashing and other files were
just fine.

i.e. people don't tend to notice "stuff I just wrote is missing"
after a crash - they expect that. What they notice and complain
about is inconsistent state after recovery. e.g. file A was fine,
but file B was empty, even though I wrote file B before file A!

This is the sort of thing that Ted was refering to when he talked
about having to add hacks to ext4 to make sure certain "expected
behaviours" were maintained. ext4 inherited quite a few unrealistic
expectations from ext3, which had a much stricter data vs
metadata ordering model than ext4 does....

With XFS, the problems we've had with lost data/files have
invariably been a result of code that violated ordering semantics
for what were once considered performance benefits (hence my comment
about "integrity is more important than performance").  Those sorts
of problems (and there's been quite a others w.r.t. the XFS recovery
algorithm) have all been solved by journalling all metadata changes
(hence strict ordering against other metadata), improving the
journal format and the information we log in it, and delaying
data-dependent metadata updates until after the data IO completes.

And from that perspective, SOMC is really just a further
generalisation of the dependency and atomicity model that underlies
the existing XFS transaction engine.

> I found your notes about POSIX SIO interesting, and will incorporate
> it into the next version of the patch. Should POSIX SIO be agreed upon
> between file systems as the set of guarantees to provide (especially
> since this is what glibc assumes)? I think SOMC is stronger than POSIX
> SIO.

SOMC is stronger than POSIX SIO. POSIX SIO is still a horribly
ambiguous standard, even though it does define "data integrity"
and "file integrity" in a meaningful manner. It's an improvement,
but I still think it is terrible from efficiency and performance
perspectives.

> > The more complex question has do to with explicit "data dependency"
> > operation. At the moment, I will not explain what that means in details,
> > but I am sure you can figure it out.
> > With fdatasync+rename, fdatasync created a dependency between
> > data and metadata of the file, so with SOMC, if file is observed after
> > crash in rename destination, it also contains the data changes before
> > fdatasync. But fdatasync gives a stringer guaranty than what
> > my application actually needs, because in many cases it will cause
> > journal flush. What it really needs is filemap_write_and_wait().
> > Metadata doesn't need to be flushed as rename takes care of
> > metadata ordering guaranties.
> > As far as I can tell, there is no "official" API to do what I need
> > and there is certainly no documentation about this expected behavior.
> > Apologies, if above was not clear, I promise to explain in person
> > during LSF to whoever is interested.
> 
> At the risk of being ambiguous in the same way as Amir:
> 
> Some applications may only care about ordering of metadata operations,
> not whether they are persistent. Application-level correctness is
> closely tied to ordering of different operations. Since SOMC gives us
> the guarantee that if operation X is seen after recovery, all
> dependent ops are also seen on recovery, this might be enough to
> create a consistent application. For example, an application may not
> care when file X was persisted to storage, as long as file Y was
> persisted before it.

*nod*

Application developers have been asking for this sort of integrity
guarantee from filesystems for a long time. The problem has always
been that we've been unable to agree on a defined model that allows
us to guarantee such behaviour to userspace. Every ~5 years,
somebody comes up with a new userspace transaction proposal that
ends up going nowhere because it cannot be applied to most of the
underlying linux filesystems without severe compromises.

However, this discussion is leading me to belive that the benefits
of having a well defined and documented behavioural model (such as
SOMC) are starting to be realised. i.e. a well defined model allows
kernel and userspace to optimise indepedently but still provide the
exact integrity semantics each other requires. And that we can
expose that model as a set of tests in fstests, hence enabling both
fs developers and users to understand where filesystems behave
according to the model and where they may need further improvement.

So I think we are definitely headed in the right direction here.
That said....

> All I'm asking for is documenting the minimal set of guarantees each
> file system already provides (or should provide in the absence of
> bugs). It is alright if the file system provides more than what is
> documented. The original patch does not talk about the rename hack
> that Ted mentions.

... I'm really not that interested in documenting the limitations of
existing filesystems because that entirely backwards looking. I'm
looking forwards and aiming to provide a model that we can build
filesystems and applications around to fully exploit the performance
potential of modern storage hardware...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
