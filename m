Received: from ipmail01.adl2.internode.on.net ([150.101.137.133]:23196 "EHLO
        ipmail01.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727341AbfCODDw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 14 Mar 2019 23:03:52 -0400
Date: Fri, 15 Mar 2019 14:03:13 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] Documenting the crash-recovery guarantees of Linux
 file systems
Message-ID: <20190315030313.GP26298@dastard>
References: <1552418820-18102-1-git-send-email-jaya@cs.utexas.edu>
 <20190314011925.GG23020@dastard>
 <CAOQ4uxjNDKjjzzcowy6oFZ=V7hWCkCbSyOQggE2XJirr4JHAyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjNDKjjzzcowy6oFZ=V7hWCkCbSyOQggE2XJirr4JHAyA@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jayashree <jaya@cs.utexas.edu>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-doc@vger.kernel.org, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, Theodore Tso <tytso@mit.edu>, chao@kernel.org, Filipe Manana <fdmanana@gmail.com>, Jonathan Corbet <corbet@lwn.net>
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 14, 2019 at 09:19:03AM +0200, Amir Goldstein wrote:
> On Thu, Mar 14, 2019 at 3:19 AM Dave Chinner <david@fromorbit.com> wrote:
> > On Tue, Mar 12, 2019 at 02:27:00PM -0500, Jayashree wrote:
> > > +Strictly Ordered Metadata Consistency
> > > +-------------------------------------
> > > +With each file system providing varying levels of persistence
> > > +guarantees, a consensus in this regard, will benefit application
> > > +developers to work with certain fixed assumptions about file system
> > > +guarantees. Dave Chinner proposed a unified model called the
> > > +Strictly Ordered Metadata Consistency (SOMC) [5].
> > > +
> > > +Under this scheme, the file system guarantees to persist all previous
> > > +dependent modifications to the object upon fsync().  If you fsync() an
> > > +inode, it will persist all the changes required to reference the inode
> > > +and its data. SOMC can be defined as follows [6]:
> > > +
> > > +If op1 precedes op2 in program order (in-memory execution order), and
> > > +op1 and op2 share a dependency, then op2 must not be observed by a
> > > +user after recovery without also observing op1.
> > > +
> > > +Unfortunately, SOMC's definition depends upon whether two operations
> > > +share a dependency, which could be file-system specific. It might
> > > +require a developer to understand file-system internals to know if
> > > +SOMC would order one operation before another.
> >
> > That's largely an internal implementation detail, and users should
> > not have to care about the internal implementation because the
> > fundamental dependencies are all defined by the directory heirarchy
> > relationships that users can see and manipulate.
> >
> > i.e. fs internal dependencies only increase the size of the graph
> > that is persisted, but it will never be reduced to less than what
> > the user can observe in the directory heirarchy.
> >
> > So this can be further refined:
> >
> >         If op1 precedes op2 in program order (in-memory execution
> >         order), and op1 and op2 share a user visible reference, then
> >         op2 must not be observed by a user after recovery without
> >         also observing op1.
> >
> > e.g. in the case of the parent directory - the parent has a link
> > count. Hence every create, unlink, rename, hard link, symlink, etc
> > operation in a directory modifies a user visible link count
> > reference.  Hence fsync of one of those children will persist the
> > directory link count, and then all of the other preceeding
> > transactions that modified the link count also need to be persisted.
> >
> 
> One thing that bothers me is that the definition of SOMC (as well as
> your refined definition) doesn't mention fsync at all, but all the examples
> only discuss use cases with fsync.

You can't discuss operational ordering without a point in time to
use as a reference for that ordering.  SOMC behaviour is preserved
at any point the filesystem checkpoints itself, and the only thing
that changes is the scope of that checkpoint. fsync is just a
convenient, widely understood, minimum dependecy reference point
that people can reason from. All the interesting ordering problems
come from minimum dependecy reference point (i.e. fsync()), not from
background filesystem-wide checkpoints.

> I personally find SOMC guaranty *much* more powerful in the absence
> of fsync. I have an application that creates sparse files, sets xattrs, mtime
> and moves them into place. The observed requirement is that after crash
> those files either exist with correct mtime, xattr or not exist.

SOMC does not provide the guarantees you seek in the absence of a
known data synchronisation point:

	a) a background metadata checkpoint can land anywhere in
	that series of operations and hence recovery will land in an
	intermediate state.

	b) there is data that needs writing, and SOMC provides no
	ordering guarantees for data. So after recovery file could
	exist with correct mtime and xattrs, but have no (or
	partial) data.

> To my understanding, SOMC provides a guaranty that the application does
> not need to do any fsync at all,

Absolutely not true. If the application has atomic creation
requirements that need multiple syscalls to set up, it must
implement them itself and use fsync to synchronise data and metadata
before the "atomic create" operation that makes it visible to the
application.

SOMC only guarantees what /metadata/ you see at a fileystem
synchronisation point; it does not provide ACID semantics to a
random set of system calls into the filesystem.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
