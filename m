Received: from newman.cs.utexas.edu ([128.83.139.110]:35609 "EHLO
        newman.cs.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbfCSChm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 18 Mar 2019 22:37:42 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (authenticated bits=0)
        by newman.cs.utexas.edu (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id x2J2bdhx006756
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
        for <fstests@vger.kernel.org>; Mon, 18 Mar 2019 21:37:40 -0500
Received: by mail-oi1-f178.google.com with SMTP id v7so5050275oie.8
        for <fstests@vger.kernel.org>; Mon, 18 Mar 2019 19:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <1552418820-18102-1-git-send-email-jaya@cs.utexas.edu>
 <20190314011925.GG23020@dastard> <CAOQ4uxjNDKjjzzcowy6oFZ=V7hWCkCbSyOQggE2XJirr4JHAyA@mail.gmail.com>
 <20190315030313.GP26298@dastard> <CAOQ4uxhyeBhk3DaHO8_oyfWbByidGaSrXJyh7uQE1YMaWTxR5A@mail.gmail.com>
 <20190317221652.GQ26298@dastard> <CAOQ4uxgwa9CeyLXJ022VW8dac3h_fGUi9BtF_apMv0T1UjJ3iw@mail.gmail.com>
In-Reply-To: <CAOQ4uxgwa9CeyLXJ022VW8dac3h_fGUi9BtF_apMv0T1UjJ3iw@mail.gmail.com>
From: Vijay Chidambaram <vijay@cs.utexas.edu>
Date: Mon, 18 Mar 2019 21:37:28 -0500
Message-ID: <CAHWVdUVFu1s2UCLn2vO1p559pGmio8X4RXK8VSVkSiTQQEcz3A@mail.gmail.com>
Subject: Re: [PATCH v2] Documenting the crash-recovery guarantees of Linux
 file systems
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, Jayashree <jaya@cs.utexas.edu>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-doc@vger.kernel.org, Theodore Tso <tytso@mit.edu>, chao@kernel.org, Filipe Manana <fdmanana@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Josef Bacik <josef@toxicpanda.com>, Anna Schumaker <Anna.Schumaker@netapp.com>
List-ID: <fstests@vger.kernel.org>

For new folks on the thread, I'm Vijay Chidambaram, prof at UT Austin
and Jayashree's advisor. We recently developed CrashMonkey, a tool for
finding crash-consistency bugs in file systems. As part of the
research effort, we had a lot of conversations with file-system
developers to understand the guarantees provided by different file
systems. This patch was inspired by the thought that we should quickly
document what we know about the data integrity guarantees of different
file systems. We did not expect to spur debate!

Thanks Dave, Amir, and Ted for the discussion. We will incorporate
these comments into the next patch. If it is better to wait until a
consensus is reached after the LSF meeting, we'd be happy to do so.

On Mon, Mar 18, 2019 at 2:14 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Mar 18, 2019 at 12:16 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Fri, Mar 15, 2019 at 05:44:49AM +0200, Amir Goldstein wrote:
> > > On Fri, Mar 15, 2019 at 5:03 AM Dave Chinner <david@fromorbit.com> wrote:
> > > >
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

Dave, how did SOMC come about? Even XFS persists more than the minimum
set required by SOMC. Is SOMC most useful as a sort of intuitive
guideline as to what users should expect to see after recovery?

I found your notes about POSIX SIO interesting, and will incorporate
it into the next version of the patch. Should POSIX SIO be agreed upon
between file systems as the set of guarantees to provide (especially
since this is what glibc assumes)? I think SOMC is stronger than POSIX
SIO.

> In this context I mean that effects of metadata operations before the
> barrier (e.g. setxattr, truncate) must be observed after crash if the effects
> of barrier operation (e.g. file was renamed) are observed after crash.
>
> > > > > I personally find SOMC guaranty *much* more powerful in the absence
> > > > > of fsync. I have an application that creates sparse files, sets xattrs, mtime
> > > > > and moves them into place. The observed requirement is that after crash
> > > > > those files either exist with correct mtime, xattr or not exist.
> > >
> > > I wasn't clear:
> > > 1. "sparse" meaning no data at all only hole.
> >
> > That's not sparse, that is an empty file or "contains no data".
> > "Sparse" means the file has "sparse data" - the data in the file is
> > separated by holes. A file that is just a single hole does not
> > contain "sparse data", it contains no data at all.
> >
> > IOWs, if you mean "file has no data in it", then say that as it is a
> > clear and unambiguous statement of what the file contains.
> >
> > > 2. "exist" meaning found at rename destination
> > > Naturally, its applications responsibility to cleanup temp files that were
> > > not moved into rename destination.
> > >
> > > >
> > > > SOMC does not provide the guarantees you seek in the absence of a
> > > > known data synchronisation point:
> > > >
> > > >         a) a background metadata checkpoint can land anywhere in
> > > >         that series of operations and hence recovery will land in an
> > > >         intermediate state.
> > >
> > > Yes, that results in temp files that would be cleaned up on recovery.
> >
> > Ambiguous. "recovery" is something filesystems do to bring the
> > filesystem into a consistent state after a crash. If you are talking
> > about applicaiton level behaviour, then you need to make that
> > explicit.
> >
> > i.e. I can /assume/ you are talking about application level recovery
> > from your previous statement, but that assumption is obviously wrong
> > if the application is using O_TMPFILE and linkat rather than rename,
> > in which case it will be fileystem level recovery that is doing the
> > cleanup. Ambiguous, yes?
> >
>
> Yes. From the application writers POV, the fact that doing things
> "atomically" is possible is what matters. Whether filesystem provides
> the recovery from incomplete transaction (O_TMPFILE+linkat), or
> application can cleanup leftovers on startup (rename).
> I have some applications that use the former and some that use the
> latter for directories and for portability with OS/fs that don't have
> O_TMPFILE.
>
> >
> > > >         b) there is data that needs writing, and SOMC provides no
> > > >         ordering guarantees for data. So after recovery file could
> > > >         exist with correct mtime and xattrs, but have no (or
> > > >         partial) data.
> > > >
> > >
> > > There is no data in my use case, only metadata, that is why
> > > SOMC without fsync is an option.
> >
> > Perhaps, but I am not clear on exactly what you are proposing
> > because I don't know what the hell a "metadata barrier" is, what it
> > does or what it implies for filesystem integrity operations...
> >
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
> As far as I can tell, there is no "official" API to do what I need
> and there is certainly no documentation about this expected behavior.
> Apologies, if above was not clear, I promise to explain in person
> during LSF to whoever is interested.

At the risk of being ambiguous in the same way as Amir:

Some applications may only care about ordering of metadata operations,
not whether they are persistent. Application-level correctness is
closely tied to ordering of different operations. Since SOMC gives us
the guarantee that if operation X is seen after recovery, all
dependent ops are also seen on recovery, this might be enough to
create a consistent application. For example, an application may not
care when file X was persisted to storage, as long as file Y was
persisted before it.

> Judging by the volume and passion of this thread, I think a
> session on LSF fs track would probably be a good idea.
> [CC Josef and Anna.]

+1 to discussion at LSF. We would be interested in hearing about the
results of the discussion.

> I find our behavior as a group of filesystem developers on this matter
> slightly bi-polar - on the one hand we wish to maintain implementation
> freedom for future performance improvements and don't wish to commit
> to existing behavior by documenting it. On the other hand, we wish to
> not break existing application, whose expectations from filesystems are
> far from what filesystems guaranty in documentation.
>
> There is no one good answer that fits all aspects of this subject and I
> personally agree with Ted on not wanting to document the ext4 "hacks"
> that are meant to cater misbehaving applications.

Completely agree with Amir here. There is a lot to be gained by
documentation data integrity guarantees of current file systems. We
currently do not know what each file system supports, without the
developers themselves weighing in. There have been multiple instances
where users/researchers like us and kernel developers like Amir were
confused about the guarantees provided by a given file system;
documentation would erase such confusion. If a standard like POSIX SIO
or SOMC is agreed upon, this allows optimizations while not breaking
application behavior.

I agree with being careful about committing to a set of guarantees,
but the ext4 "hacks" are now 10 years old. I'm not sure if they were
meant to be temporary, but clearly they are not. I highly doubt that
they are going to change anytime soon without breaking many
applications.

All I'm asking for is documenting the minimal set of guarantees each
file system already provides (or should provide in the absence of
bugs). It is alright if the file system provides more than what is
documented. The original patch does not talk about the rename hack
that Ted mentions.

> I think it is good that Jayashree posted this patch as a basis for discussion
> of what needs to be documented and how.
> Eventually, instead of trying to formalize filesystem expected behavior, it
> might be better to just encode the expected crash behavior tests
> in a readable manner, as Jayashree already started to do.
> Or maybe there is room for both documentation and tests.

Thanks for the support Amir!
