Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:52866 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726788AbfCSDN0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 18 Mar 2019 23:13:26 -0400
Date: Tue, 19 Mar 2019 14:13:12 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] Documenting the crash-recovery guarantees of Linux
 file systems
Message-ID: <20190319031312.GW26298@dastard>
References: <1552418820-18102-1-git-send-email-jaya@cs.utexas.edu>
 <20190314011925.GG23020@dastard>
 <CAOQ4uxjNDKjjzzcowy6oFZ=V7hWCkCbSyOQggE2XJirr4JHAyA@mail.gmail.com>
 <20190315030313.GP26298@dastard>
 <CAOQ4uxhyeBhk3DaHO8_oyfWbByidGaSrXJyh7uQE1YMaWTxR5A@mail.gmail.com>
 <20190317221652.GQ26298@dastard>
 <CAOQ4uxgwa9CeyLXJ022VW8dac3h_fGUi9BtF_apMv0T1UjJ3iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgwa9CeyLXJ022VW8dac3h_fGUi9BtF_apMv0T1UjJ3iw@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jayashree <jaya@cs.utexas.edu>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-doc@vger.kernel.org, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, Theodore Tso <tytso@mit.edu>, chao@kernel.org, Filipe Manana <fdmanana@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Josef Bacik <josef@toxicpanda.com>, Anna Schumaker <Anna.Schumaker@netapp.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Mar 18, 2019 at 09:13:58AM +0200, Amir Goldstein wrote:
> On Mon, Mar 18, 2019 at 12:16 AM Dave Chinner <david@fromorbit.com> wrote:
> > On Fri, Mar 15, 2019 at 05:44:49AM +0200, Amir Goldstein wrote:
> > > On Fri, Mar 15, 2019 at 5:03 AM Dave Chinner <david@fromorbit.com> wrote:
> > > > On Thu, Mar 14, 2019 at 09:19:03AM +0200, Amir Goldstein wrote:
> > > > > On Thu, Mar 14, 2019 at 3:19 AM Dave Chinner <david@fromorbit.com> wrote:
> > > > > > On Tue, Mar 12, 2019 at 02:27:00PM -0500, Jayashree wrote:
> > > > > > > +Strictly Ordered Metadata Consistency
> > > > > > > +-------------------------------------
> > > > > > > +With each file system providing varying levels of persistence
> > > > > > > +guarantees, a consensus in this regard, will benefit application
> > > > > > > +developers to work with certain fixed assumptions about file system
> > > > > > > +guarantees. Dave Chinner proposed a unified model called the
> > > > > > > +Strictly Ordered Metadata Consistency (SOMC) [5].
> > > > > > > +
> > > > > > > +Under this scheme, the file system guarantees to persist all previous
> > > > > > > +dependent modifications to the object upon fsync().  If you fsync() an
> > > > > > > +inode, it will persist all the changes required to reference the inode
> > > > > > > +and its data. SOMC can be defined as follows [6]:
> > > > > > > +
> > > > > > > +If op1 precedes op2 in program order (in-memory execution order), and
> > > > > > > +op1 and op2 share a dependency, then op2 must not be observed by a
> > > > > > > +user after recovery without also observing op1.
> > > > > > > +
> > > > > > > +Unfortunately, SOMC's definition depends upon whether two operations
> > > > > > > +share a dependency, which could be file-system specific. It might
> > > > > > > +require a developer to understand file-system internals to know if
> > > > > > > +SOMC would order one operation before another.
> > > > > >
> > > > > > That's largely an internal implementation detail, and users should
> > > > > > not have to care about the internal implementation because the
> > > > > > fundamental dependencies are all defined by the directory heirarchy
> > > > > > relationships that users can see and manipulate.
> > > > > >
> > > > > > i.e. fs internal dependencies only increase the size of the graph
> > > > > > that is persisted, but it will never be reduced to less than what
> > > > > > the user can observe in the directory heirarchy.
> > > > > >
> > > > > > So this can be further refined:
> > > > > >
> > > > > >         If op1 precedes op2 in program order (in-memory execution
> > > > > >         order), and op1 and op2 share a user visible reference, then
> > > > > >         op2 must not be observed by a user after recovery without
> > > > > >         also observing op1.
> > > > > >
> > > > > > e.g. in the case of the parent directory - the parent has a link
> > > > > > count. Hence every create, unlink, rename, hard link, symlink, etc
> > > > > > operation in a directory modifies a user visible link count
> > > > > > reference.  Hence fsync of one of those children will persist the
> > > > > > directory link count, and then all of the other preceeding
> > > > > > transactions that modified the link count also need to be persisted.
> > > > > >
> > > > >
> > > > > One thing that bothers me is that the definition of SOMC (as well as
> > > > > your refined definition) doesn't mention fsync at all, but all the examples
> > > > > only discuss use cases with fsync.
> > > >
> > > > You can't discuss operational ordering without a point in time to
> > > > use as a reference for that ordering.  SOMC behaviour is preserved
> > > > at any point the filesystem checkpoints itself, and the only thing
> > > > that changes is the scope of that checkpoint. fsync is just a
> > > > convenient, widely understood, minimum dependecy reference point
> > > > that people can reason from. All the interesting ordering problems
> > > > come from minimum dependecy reference point (i.e. fsync()), not from
> > > > background filesystem-wide checkpoints.
> > > >
> > >
> > > Yes, I was referring to rename as a commonly used operation used
> > > by application as "metadata barrier".
> >
> > What is a "metadata barrier" and what are it's semantics supposed to
> > be?
> >
> 
> In this context I mean that effects of metadata operations before the
> barrier (e.g. setxattr, truncate) must be observed after crash if the effects
> of barrier operation (e.g. file was renamed) are observed after crash.

Ok, so you've just arbitrarily denoted a specific rename operation
to be a "recovery barrier" for your application?

In terms of SOMC, there is no operation that is an implied
"barrier". There are explicitly ordered checkpoints via data
integrity operations (i.e. sync, fsync, etc), but between those
points it's just dependency based ordering...

IOWs, if there is no direct relationship between two objects in
depnendency grpah, then then rename of one or the other does not
create a "metadata ordering barrier" between those two objects. They
are still independent, and so rename isn't a barrier in the true
sense (i.e. that it is an ordering synchronisation point).

At best rename can define a point in a dependency graph where an
independent dependency branch is merged atomically into the main
graph. This is still a powerful tool, and likely exactly what you
are wanting to know if it will work or not....

> > > > > To my understanding, SOMC provides a guaranty that the application does
> > > > > not need to do any fsync at all,
> > > >
> > > > Absolutely not true. If the application has atomic creation
> > > > requirements that need multiple syscalls to set up, it must
> > > > implement them itself and use fsync to synchronise data and metadata
> > > > before the "atomic create" operation that makes it visible to the
> > > > application.
> > > >
> > > > SOMC only guarantees what /metadata/ you see at a fileystem
> > > > synchronisation point; it does not provide ACID semantics to a
> > > > random set of system calls into the filesystem.
> > > >
> > >
> > > So I re-state my claim above after having explained the use case.
> >
> > With words that I can only guess the meaning of.
> >
> > Amir, if you are asking a complex question as to whether something
> > conforms to a specification, then please slow down and take the time
> > to define all the terms, the initial state, the observable behaviour
> > that you expect to see, etc in clear, unambiguous and well defined
> > terms.  Otherwise the question cannot be answered....
> >
> 
> Sure. TBH, I didn't even dare to ask the complex question yet,
> because it was hard for me to define all terms. I sketched the
> use case with the example of create+setxattr+truncate+rename
> because I figured it is rather easy to understand.
> 
> The more complex question has do to with explicit "data dependency"
> operation. At the moment, I will not explain what that means in details,
> but I am sure you can figure it out.
> With fdatasync+rename, fdatasync created a dependency between
> data and metadata of the file, so with SOMC, if file is observed after
> crash in rename destination, it also contains the data changes before
> fdatasync. But fdatasync gives a stringer guaranty than what
> my application actually needs, because in many cases it will cause
> journal flush. What it really needs is filemap_write_and_wait().
> Metadata doesn't need to be flushed as rename takes care of
> metadata ordering guaranties.

Ok, so what you are actually asking is whether SOMC provides a
guarantee that data writes that have completed before the rename
will be present on disk if the rename is present on disk? i.e.:

create+setxattr+write()+fdatawait()+rename

is atomic on a SOMC filesystem without a data integrity operation
being performed?

I don't think we've defined how data vs metadata ordering
persistence works in the SOMC model at all. We've really only been
discussing the metadata ordering and so I haven't really thought
all the different cases through.

OK, let's try to define how it works through examples.  Let's start
with the simple one: non-AIO O_DIRECT writes, because they send the
data straight to the device. i.e.

create
setxattr
write
  Extent Allocation
		  ----> device -+
					data volatile
		  <-- complete -+
write completion
rename					metadata volatile

At this point, we may have no direct dependency between the
write completion and the rename operation. Normally we would do
(O_DSYNC case)

write completion
    device cache flush
		  ----> device -+
		  <-- complete -+	data persisted
    journal FUA write
		  ----> device -+
		  <-- complete -+	file metadata persisted

and so we are guaranteed to have the data on disk before the rename
is started (i.e. POSIX compliance). Hence regardless of whether the
rename exists or not, we'll have the data on disk.

However, if we require a data completion rule similar to the IO
completion to device flush rule we have in the kernel:

	If data is to be ordered against a specific metadata
	operation, then the dependent data must be issued and
	completed before executing the ordering metadata operation.
	The application is responsibile for ensuring the necessary
	data has been flushed to storage and signalled complete, but
	it does not need to ensure it is persistent.

	When the ordering metadata operation is to be made
	persistent, the filesystem must ensure the dependent data is
	persistent before starting the ordered metadata persistence
	operation. It must also ensure that any data dependent
	metadata is captured and persisted in the pending ordered
	metadata persistence operation so all the metadata required
	to access the dependent data is persisted correctly.

Then we create the conditions where it is possible for data to be
ordered amongst the metadata with the same ordering guarantees
as the metadata. The above O_DIRECT example ends up as:

create
setxattr
write
  Extent Allocation			metadata volatile
		  ----> device -+
					data volatile
		  <-- complete -+
write completion
rename					metadata volatile
.....
<journal flush>
    device cache flush
		  ----> device -+
		  <-- complete -+	data persisted
    journal FUA write
		  ----> device -+
		  <-- complete -+	metadata persisted
<flush completion>


With AIO based O_DIRECT, then we cannot issue the ordering rename
until after the AIO completion has been delivered to the
application. Once that has been delivered, then it is the same case
as non AIO O_DIRECT.

BUffered IO is a bit harder, because we need flush-and-wait
primitives that don't provide data integrity guarantees. SO, after
soundly smacking down the user of sync_file_range() this morning
because it's not a data integrity operation and it has massive
gaping holes in it's behaviour, it may actually be useful here in a
very limited scope.

That is, sync_file_range() is only safe to use for this specific
sort of ordered data integrity algorithm when flushing the entire
file.(*)

create
setxattr
write					metadata volatile
  delayed allocation			data volatile
....
sync_file_range(fd, 0, 0, SYNC_FILE_RANGE_WAIT_BEFORE |
		SYNC_FILE_RANGE_WRITE | SYNC_FILE_RANGE_WAIT_AFTER);
  Extent Allocation			metadata volatile
		  ----> device -+
					data volatile
		  <-- complete -+
....
rename					metadata volatile

And so at this point, we only need a device cache flush to
make the data persistent and a journal flush to make the rename
persistent. And so it ends up the same case as non-AIO O_DIRECT.

So, yeah, I think this model will work to order completed data
writes against future metadata operations such that this is
observed:

	If a metadata operation is performed after dependent data
	has been flushed and signalled complete to userspace, then
	if that metadata operation is present after recovery the
	dependent data will also be present.

The good news here is what I described above is exactly what XFS
implements with it's journal flushes - it uses REQ_PREFLUSH |
REQ_FUA for journal writes, and so it follows the rules I outlined
above.  A quick grep shows that ext4/jbd2, f2fs and gfs2 also use
the same flags for journal and/or critical ordering IO. I can't tell
whether btrfs follows these rules or not.

> As far as I can tell, there is no "official" API to do what I need
> and there is certainly no documentation about this expected behavior.

Oh, userspace controlled data flushing is exactly what
sync_file_range() was intended for back when it was implemented back
in 2.6.17.

Unfortunately, the implementation was completely botched because it
was written from a top down "clean the page cache" perspective, not
a bottom up filesystem data integrity mechanism and by the time we
realised just how awful it was there were applications dependent on
it's existing behaviour....

> I find our behavior as a group of filesystem developers on this matter
> slightly bi-polar - on the one hand we wish to maintain implementation
> freedom for future performance improvements and don't wish to commit
> to existing behavior by documenting it. On the other hand, we wish to
> not break existing application, whose expectations from filesystems are
> far from what filesystems guaranty in documentation.

Personally I want the SOMC model to be explicitly documented so that
we can sanely discuss how we can provide sane optimisations to
userspace. It's the first step towards a model where
applications can run filesystem operations completely asynchronously
yet still provide large scale ordering and integrity guarantees
without needing copious amounts of fine-grained fsync
operations.(**)

I really don't care about the crazy vagaries of POSIX right now -
POSIX is a shit specification when it comes to integrity. The
sooner we move beyond it, the better off we'll be. And the beauty of
the SOMC model is that POSIX compliance falls out of it for free,
yet it allows us much more freedom for optimisation because we
can reason about integrity in terms of ordering and dependencies
rather than in terms of what fsync() must provide.

> There is no one good answer that fits all aspects of this subject and I
> personally agree with Ted on not wanting to document the ext4 "hacks"
> that are meant to cater misbehaving applications.

Applications "misbehave" largely because there is no definitive
documentation on what filesystems actually provide userspace. The
man pages document API behaviour, they /can't/ document things like
SOMC, which filesystems can provide it and how to use it to avoid
fsync()....

> I think it is good that Jayashree posted this patch as a basis for discussion
> of what needs to be documented and how.
> Eventually, instead of trying to formalize filesystem expected behavior, it
> might be better to just encode the expected crash behavior tests
> in a readable manner, as Jayashree already started to do.
> Or maybe there is room for both documentation and tests.

It needs documentation. crash tests do not document algorithms
behaviour, intentions, application programming models, constraints,
etc....

Cheers,

Dave.

(*) Using sync_file_range() for sub file ranges are simply broken when
it comes to data integrity style flushes as there is no guarantee it
will capture all the dirty ranges that need to be flushed (e.g.
write starting 100kb beyond EOF, then sync the range starting 100kb
beyond EOF, and it won't sync the sub-block zeroing that was done at
the old EOF, thereby exposing stale data....)

(**) That featherstitch paper I linked to earlier? Did you notice
the userspace defined "patch group" transaction interface?
http://featherstitch.cs.ucla.edu/

-- 
Dave Chinner
david@fromorbit.com
