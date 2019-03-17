Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:38372 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726438AbfCQWQ7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 17 Mar 2019 18:16:59 -0400
Date: Mon, 18 Mar 2019 09:16:52 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] Documenting the crash-recovery guarantees of Linux
 file systems
Message-ID: <20190317221652.GQ26298@dastard>
References: <1552418820-18102-1-git-send-email-jaya@cs.utexas.edu>
 <20190314011925.GG23020@dastard>
 <CAOQ4uxjNDKjjzzcowy6oFZ=V7hWCkCbSyOQggE2XJirr4JHAyA@mail.gmail.com>
 <20190315030313.GP26298@dastard>
 <CAOQ4uxhyeBhk3DaHO8_oyfWbByidGaSrXJyh7uQE1YMaWTxR5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhyeBhk3DaHO8_oyfWbByidGaSrXJyh7uQE1YMaWTxR5A@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jayashree <jaya@cs.utexas.edu>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-doc@vger.kernel.org, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, Theodore Tso <tytso@mit.edu>, chao@kernel.org, Filipe Manana <fdmanana@gmail.com>, Jonathan Corbet <corbet@lwn.net>
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 15, 2019 at 05:44:49AM +0200, Amir Goldstein wrote:
> On Fri, Mar 15, 2019 at 5:03 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Thu, Mar 14, 2019 at 09:19:03AM +0200, Amir Goldstein wrote:
> > > On Thu, Mar 14, 2019 at 3:19 AM Dave Chinner <david@fromorbit.com> wrote:
> > > > On Tue, Mar 12, 2019 at 02:27:00PM -0500, Jayashree wrote:
> > > > > +Strictly Ordered Metadata Consistency
> > > > > +-------------------------------------
> > > > > +With each file system providing varying levels of persistence
> > > > > +guarantees, a consensus in this regard, will benefit application
> > > > > +developers to work with certain fixed assumptions about file system
> > > > > +guarantees. Dave Chinner proposed a unified model called the
> > > > > +Strictly Ordered Metadata Consistency (SOMC) [5].
> > > > > +
> > > > > +Under this scheme, the file system guarantees to persist all previous
> > > > > +dependent modifications to the object upon fsync().  If you fsync() an
> > > > > +inode, it will persist all the changes required to reference the inode
> > > > > +and its data. SOMC can be defined as follows [6]:
> > > > > +
> > > > > +If op1 precedes op2 in program order (in-memory execution order), and
> > > > > +op1 and op2 share a dependency, then op2 must not be observed by a
> > > > > +user after recovery without also observing op1.
> > > > > +
> > > > > +Unfortunately, SOMC's definition depends upon whether two operations
> > > > > +share a dependency, which could be file-system specific. It might
> > > > > +require a developer to understand file-system internals to know if
> > > > > +SOMC would order one operation before another.
> > > >
> > > > That's largely an internal implementation detail, and users should
> > > > not have to care about the internal implementation because the
> > > > fundamental dependencies are all defined by the directory heirarchy
> > > > relationships that users can see and manipulate.
> > > >
> > > > i.e. fs internal dependencies only increase the size of the graph
> > > > that is persisted, but it will never be reduced to less than what
> > > > the user can observe in the directory heirarchy.
> > > >
> > > > So this can be further refined:
> > > >
> > > >         If op1 precedes op2 in program order (in-memory execution
> > > >         order), and op1 and op2 share a user visible reference, then
> > > >         op2 must not be observed by a user after recovery without
> > > >         also observing op1.
> > > >
> > > > e.g. in the case of the parent directory - the parent has a link
> > > > count. Hence every create, unlink, rename, hard link, symlink, etc
> > > > operation in a directory modifies a user visible link count
> > > > reference.  Hence fsync of one of those children will persist the
> > > > directory link count, and then all of the other preceeding
> > > > transactions that modified the link count also need to be persisted.
> > > >
> > >
> > > One thing that bothers me is that the definition of SOMC (as well as
> > > your refined definition) doesn't mention fsync at all, but all the examples
> > > only discuss use cases with fsync.
> >
> > You can't discuss operational ordering without a point in time to
> > use as a reference for that ordering.  SOMC behaviour is preserved
> > at any point the filesystem checkpoints itself, and the only thing
> > that changes is the scope of that checkpoint. fsync is just a
> > convenient, widely understood, minimum dependecy reference point
> > that people can reason from. All the interesting ordering problems
> > come from minimum dependecy reference point (i.e. fsync()), not from
> > background filesystem-wide checkpoints.
> >
> 
> Yes, I was referring to rename as a commonly used operation used
> by application as "metadata barrier".

What is a "metadata barrier" and what are it's semantics supposed to
be?

> > > I personally find SOMC guaranty *much* more powerful in the absence
> > > of fsync. I have an application that creates sparse files, sets xattrs, mtime
> > > and moves them into place. The observed requirement is that after crash
> > > those files either exist with correct mtime, xattr or not exist.
> 
> I wasn't clear:
> 1. "sparse" meaning no data at all only hole.

That's not sparse, that is an empty file or "contains no data".
"Sparse" means the file has "sparse data" - the data in the file is
separated by holes. A file that is just a single hole does not
contain "sparse data", it contains no data at all.

IOWs, if you mean "file has no data in it", then say that as it is a
clear and unambiguous statement of what the file contains.

> 2. "exist" meaning found at rename destination
> Naturally, its applications responsibility to cleanup temp files that were
> not moved into rename destination.
> 
> >
> > SOMC does not provide the guarantees you seek in the absence of a
> > known data synchronisation point:
> >
> >         a) a background metadata checkpoint can land anywhere in
> >         that series of operations and hence recovery will land in an
> >         intermediate state.
> 
> Yes, that results in temp files that would be cleaned up on recovery.

Ambiguous. "recovery" is something filesystems do to bring the
filesystem into a consistent state after a crash. If you are talking
about applicaiton level behaviour, then you need to make that
explicit.

i.e. I can /assume/ you are talking about application level recovery
from your previous statement, but that assumption is obviously wrong
if the application is using O_TMPFILE and linkat rather than rename,
in which case it will be fileystem level recovery that is doing the
cleanup. Ambiguous, yes?


> >         b) there is data that needs writing, and SOMC provides no
> >         ordering guarantees for data. So after recovery file could
> >         exist with correct mtime and xattrs, but have no (or
> >         partial) data.
> >
> 
> There is no data in my use case, only metadata, that is why
> SOMC without fsync is an option.

Perhaps, but I am not clear on exactly what you are proposing
because I don't know what the hell a "metadata barrier" is, what it
does or what it implies for filesystem integrity operations...

> > > To my understanding, SOMC provides a guaranty that the application does
> > > not need to do any fsync at all,
> >
> > Absolutely not true. If the application has atomic creation
> > requirements that need multiple syscalls to set up, it must
> > implement them itself and use fsync to synchronise data and metadata
> > before the "atomic create" operation that makes it visible to the
> > application.
> >
> > SOMC only guarantees what /metadata/ you see at a fileystem
> > synchronisation point; it does not provide ACID semantics to a
> > random set of system calls into the filesystem.
> >
> 
> So I re-state my claim above after having explained the use case.

With words that I can only guess the meaning of.

Amir, if you are asking a complex question as to whether something
conforms to a specification, then please slow down and take the time
to define all the terms, the initial state, the observable behaviour
that you expect to see, etc in clear, unambiguous and well defined
terms.  Otherwise the question cannot be answered....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
