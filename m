Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:38657 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726405AbfCNBTh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 13 Mar 2019 21:19:37 -0400
Date: Thu, 14 Mar 2019 12:19:25 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] Documenting the crash-recovery guarantees of Linux
 file systems
Message-ID: <20190314011925.GG23020@dastard>
References: <1552418820-18102-1-git-send-email-jaya@cs.utexas.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1552418820-18102-1-git-send-email-jaya@cs.utexas.edu>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Jayashree <jaya@cs.utexas.edu>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, vijay@cs.utexas.edu, amir73il@gmail.com, tytso@mit.edu, chao@kernel.org, fdmanana@gmail.com, corbet@lwn.net
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 12, 2019 at 02:27:00PM -0500, Jayashree wrote:
> In this file, we document the crash-recovery guarantees
> provided by four Linux file systems - xfs, ext4, F2FS and btrfs. We als=
o
> present Dave Chinner's proposal of Strictly-Ordered Metadata Consistenc=
y
> (SOMC), which is provided by xfs. It is not clear to us if other file s=
ystems
> provide SOMC.

FWIW, new kernel documents should be written in rst markup format,
not plain ascii text.

>=20
> Signed-off-by: Jayashree Mohan <jaya@cs.utexas.edu>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---
>=20
> We would be happy to modify the document if file-system
> developers claim that their system provides (or aims to provide) SOMC.
>=20
> Changes since v1:
>   * Addressed few nits identified in the review
>   * Added the fsync guarantees for F2FS and its SOMC compliance
> ---
>  .../filesystems/crash-recovery-guarantees.txt      | 193 +++++++++++++=
++++++++
>  1 file changed, 193 insertions(+)
>  create mode 100644 Documentation/filesystems/crash-recovery-guarantees=
.txt
>=20
> diff --git a/Documentation/filesystems/crash-recovery-guarantees.txt b/=
Documentation/filesystems/crash-recovery-guarantees.txt
> new file mode 100644
> index 0000000..be84964
> --- /dev/null
> +++ b/Documentation/filesystems/crash-recovery-guarantees.txt
> @@ -0,0 +1,193 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +File System Crash-Recovery Guarantees
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Linux file systems provide certain guarantees to user-space
> +applications about what happens to their data if the system crashes
> +(due to power loss or kernel panic). These are termed crash-recovery
> +guarantees.

These are termed "data integrity guarantees", not "crash recovery
guarantees".

i.e. crash recovery is generic phrase describing the _mechanism_
used by some filesystems to implement the data integrity guarantees
the filesystem provides to userspace applications.=20

> +
> +Crash-recovery guarantees only pertain to data or metadata that has
> +been explicitly persisted to storage with fsync(), fdatasync(), or
> +sync() system calls.

Define data and metadata in terms of what they refer to when we talk
about data integrity guarantees.

Define "persisted to storage".

Also, data integrity guarantees are provided by more interfaces than
you mention. They also apply to syncfs(), FIFREEZE, files/dirs
opened with O_[D]SYNC, readv2/writev2 calls with RWF_[D]SYNC set,
inodes with the S_[DIR]SYNC on-disk attribute, mounts with
dirsync/wsync options, etc. "data integrity guarantees" encompass
all these operations, not just fsync/fdatasync/sync....

> By default, write(), mkdir(), and other
> +file-system related system calls only affect the in-memory state of
> +the file system.

That's a generalisation that is not always correct from the user's
or userspace develper's point of view. e.g.  inodes with the sync
attribute set will default to synchronous on-disk state changes,
applications can use O_DSYNC/O_SYNC by default, etc....

> +The crash-recovery guarantees provided by most Linux file systems are
> +significantly stronger than what is required by POSIX. POSIX is vague,
> +even allowing fsync() to do nothing (Mac OSX takes advantage of
> +this).

Except when _POSIX_SYNCHRONIZED_IO is asserted, and then the
semantics filesystems must provide users are very explicit:

"[SIO] [Option Start] If _POSIX_SYNCHRONIZED_IO is defined, the
fsync() function shall force all currently queued I/O operations
associated with the file indicated by file descriptor fildes to the
synchronized I/O completion state. All I/O operations shall be
completed as defined for synchronized I/O file integrity completion.
[Option End]"

glibc asserts _POSIX_SYNCHRONIZED_IO (I'll use SIO from now on):

$ getconf _POSIX_SYNCHRONIZED_IO
200809
$

This means fsync() on Linux is supposed to conform to Section 3.376
"Synchronized I/O File Integrity Completion" of the specification,
which is a superset of the 3.375 "Synchronized I/O Data Integrity
Completion". Section 3.375 says:

"For write, when the operation has been completed or diagnosed if
unsuccessful. The write is complete only when the data specified in
the write request is successfully transferred and all file system
information required to retrieve the data is successfully
transferred."

https://pubs.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap03.html#=
tag_03_375

The key phrase here is "all the file system information required to
retrieve the data". If the directory entry that points at the file
is not persisted with the file itself, then you can't retreive the
data after a crash.  i.e. when _POSIX_SYNCHRONIZED_IO is asserted by
the system, the filesystem must guarantee this:

# touch A/foo
# echo "hello world" > A/foo
# fsync A/foo

persists the foo entry in the directory A, because that is
"filesystem information required to retreive the data in the file
A/foo". i.e. if we crash here and A/foo is not present after
restart, then we've violated the POSIX specification for SIO.

IOWs, POSIX fsync w/ SIO semantics does not allow fsync() to do
nothing, but instead has explicit definitions of the behaviour
applications can expect.  The only "wiggle room" in this
specification whether the meaning of "data transfer" includes
physically persisting the data to storage media or just moving it
into the device's volatile cache. On Linux, we've explicitly chosen
the former, because the latter does not provide SIO semantics as
data or referencing metadata can still be lost from the device's
volatile cache after transfer.

> However, the guarantees provided by file systems are not
> +documented, and vary between file systems. This document seeks to
> +describe the current crash-recovery guarantees provided by major Linux
> +file systems.
> +
> +What does the fsync() operation guarantee?
> +----------------------------------------------------
> +fsync() operation is meant to force the physical write of data
> +corresponding to a file from the buffer cache, along with the file
> +metadata. Note that the guarantees mentioned for each file system belo=
w
> +are in addition to the ones provided by POSIX.

a. what is a "physical write"?
b. Linux does not have a buffer cache. What about direct IO?
c. Exactly what "file metadata" are you talking about here?
e. Actually, it's not "in addtion" to posix - what you are
documenting here is where filesystems do not conform to
the POSIX SIO specification....

> +POSIX
> +-----
> +fsync(file) : Flushes the data and metadata associated with the
> +file.  However, if the directory entry for the file has not been
> +previously persisted, or has been modified, it is not guaranteed to be
> +persisted by the fsync of the file [1].

These are the semantics defined in the linux fsync(3) man page, and
as per the above, they are substantially /weaker/ than the POSIX
SIO specification glibc says we implement.

> What this means is, if a file
> +is newly created, you will have to fsync(parent directory) in addition
> +to fsync(file) in order to ensure that the file's directory entry has
> +safely reached the disk.

Define "safely reached disk" or use the same terms as previously
defined (i.e. "persisted to storage").

> +
> +fsync(dir) : Flushes directory data and directory entries. However if
> +you created a new file within the directory and wrote data to the
> +file, then the file data is not guaranteed to be persisted, unless an
> +explicit fsync() is issued on the file.

You talk about file metadata, then ignore what fsync does with
directory metadata...

> +ext4
> +-----
> +fsync(file) : Ensures that a newly created file's directory entry is
> +persisted (no need to explicitly persist the parent directory). Howeve=
r,
> +if you create multiple names of the file (hard links), then their dire=
ctory
> +entries are not guaranteed to persist unless each one of the parent
> +directory entries are persisted [2].

So you use a specific example to indicate an exception where ext4
needs an explicit parent directory fsync (i.e. hard links to a
single file across multiple directories). That implies ext4 POSIX
SIO compliance is questionable, and it is definitely not SOMC
compliant. Further, it implies that transactional change atomicity
requirements are also violated. i.e. the inode is journalled with a
link count equivalent to all links existing, but not all the dirents
that point to the inode are persisted at the same time.

So from this example, ext4 is not SOMC compliant.

> +fsync(dir) : All file names within the persisted directory will exist,
> +but does not guarantee file data.

what about the inodes that were created, removed or hard linked?
Does it ensure they exist (or have been correctly freed) after
fsync(dir), too?  (that hardlink behaviour makes me question
everything related to transaction atomicity in ext4 now)

> +xfs
> +----
> +fsync(file) : Ensures that a newly created file's directory entry is
> +persisted.

Actually, it ensures the path all the way up to the root inode is
persisted. i.e. it guarantees the inode can be found after crash via
a path walk. Basically, XFS demonstrates POSIX SIO compliant
behaviour.

> Additionally, all the previous dependent modifications to
> +this file are also persisted.

That's the mechanism that provides the behaviour, not sure that's
relevant here.

FWIW, this description is pretty much useless to a reader who knows
nothing about XFS and what these terms actually mean.  IOWs, you
need to define "previous dependent modifications", "modification
dependency", etc before using them. Essentially, you need to
describe the observable behaviour here, not the implementation that
creates the behaviour.

> If any file shares an object
> +modification dependency with the fsync-ed file, then that file's
> +directory entry is also persisted.

Which you need to explain with references to the ext4 hardlink
failure and how XFS will persist all the hard link directory entries
for each hardlink all the way back up to the root. i.e. don't
describe the implementation, describe the observable behaviour.

> +fsync(dir) : All file names within the persisted directory will exist,
> +but does not guarantee file data. As with files, fsync(dir) also persi=
sts
> +previous dependent metadata operations.
>
> +btrfs
> +------
> +fsync(file) : Ensures that a newly created file's directory entry
> +is persisted, along with the directory entries of all its hard links.
> +You do not need to explicitly fsync individual hard links to the file.

So how is that different to XFS? Why explicitly state the hard link
behaviour, but then not mention anything about dependencies and
propagation? Especially after doing exactly the opposite when
describing XFS....

> +fsync(dir) : All the file names within the directory will persist. All=
 the
> +rename and unlink operations within the directory are persisted. Due
> +to the design choices made by btrfs, fsync of a directory could lead
> +to an iterative fsync on sub-directories, thereby requiring a full
> +file system commit. So btrfs does not advocate fsync of directories
> +[2].

I don't think this "recommendation" is appropriate for a document
describing behaviour. It's also indicative of btrfs not having SOMC
behaviour.

> +F2FS
> +----
> +fsync(file) or fsync(dir) : In the default mode (fsync-mode=3Dposix),
> +F2FS only guarantees POSIX behaviour. However, it provides xfs-like

What does "only guarantees POSIX behaviour" actually mean? because
it can mean "loses all your data on crash"....

> +guarantees if mounted with fsync-mode=3Dstrict option.

So, by default, f2fs will lose all your data on crash? And they call
that "POSIX" behaviour, despite glibc telling applications that the
system provides data integrity preserving fsync functionality?

Seems like a very badly named mount option and a terrible default -
basically we have "fast-and-loose" behaviour which has "eats your
data" data integrity semantics and "strict" which should be POSIX
SIO conformant.


> +fsync(symlink)
> +-------------
> +A symlink inode cannot be directly opened for IO, which means there is
> +no such thing as fsync of a symlink [3]. You could be tricked by the
> +fact that open and fsync of a symlink succeeds without returning a
> +error, but what happens in reality is as follows.
> +
> +Suppose we have a symlink =E2=80=9Cfoo=E2=80=9D, which points to the f=
ile =E2=80=9CA/bar=E2=80=9D
> +
> +fd =3D open(=E2=80=9Cfoo=E2=80=9D, O_CREAT | O_RDWR)
> +fsync(fd)
> +
> +Both the above operations succeed, but if you crash after fsync, the
> +symlink could be still missing.
> +
> +When you try to open the symlink =E2=80=9Cfoo=E2=80=9D, you are actual=
ly trying to
> +open the file that the symlink resolves to, which in this case is
> +=E2=80=9CA/bar=E2=80=9D. When you fsync the inode returned by the open=
 system call, you
> +are actually persisting the file =E2=80=9CA/bar=E2=80=9D and not the s=
ymlink. Note
> +that if the file =E2=80=9CA/bar=E2=80=9D does not exist and you try th=
e open the
> +symlink =E2=80=9Cfoo=E2=80=9D without the O_CREAT flag, then file open=
 will fail. To
> +obtain the file descriptor associated with the symlink inode, you
> +could open the symlink using =E2=80=9CO_PATH | O_NOFOLLOW=E2=80=9D fla=
gs. However, the
> +file descriptor obtained this way can be only used to indicate a
> +location in the file-system tree and to perform operations that act
> +purely at the file descriptor level. Operations like read(), write(),
> +fsync() etc cannot be performed on such file descriptors.
> +
> +Bottomline : You cannot fsync() a symlink.

You can fsync() the parent dir after it is created or removed
to persist that operation.

> +fsync(special files)
> +--------------------
> +Special files in Linux include block and character device files
> +(created using mknod), FIFO (created using mkfifo) etc. Just like the
> +behavior of fsync on symlinks described above, these special files do
> +not have an fsync function defined. Similar to symlinks, you
> +cannot fsync a special file [4].

You can fsync() the parent dir after it is created or removed
to persist that operation.

> +Strictly Ordered Metadata Consistency
> +-------------------------------------
> +With each file system providing varying levels of persistence
> +guarantees, a consensus in this regard, will benefit application
> +developers to work with certain fixed assumptions about file system
> +guarantees. Dave Chinner proposed a unified model called the
> +Strictly Ordered Metadata Consistency (SOMC) [5].
> +
> +Under this scheme, the file system guarantees to persist all previous
> +dependent modifications to the object upon fsync().  If you fsync() an
> +inode, it will persist all the changes required to reference the inode
> +and its data. SOMC can be defined as follows [6]:
> +
> +If op1 precedes op2 in program order (in-memory execution order), and
> +op1 and op2 share a dependency, then op2 must not be observed by a
> +user after recovery without also observing op1.
> +
> +Unfortunately, SOMC's definition depends upon whether two operations
> +share a dependency, which could be file-system specific. It might
> +require a developer to understand file-system internals to know if
> +SOMC would order one operation before another.

That's largely an internal implementation detail, and users should
not have to care about the internal implementation because the
fundamental dependencies are all defined by the directory heirarchy
relationships that users can see and manipulate.

i.e. fs internal dependencies only increase the size of the graph
that is persisted, but it will never be reduced to less than what
the user can observe in the directory heirarchy.

So this can be further refined:

	If op1 precedes op2 in program order (in-memory execution
	order), and op1 and op2 share a user visible reference, then
	op2 must not be observed by a user after recovery without
	also observing op1.

e.g. in the case of the parent directory - the parent has a link
count. Hence every create, unlink, rename, hard link, symlink, etc
operation in a directory modifies a user visible link count
reference.  Hence fsync of one of those children will persist the
directory link count, and then all of the other preceeding
transactions that modified the link count also need to be persisted.

But keep in mind this defines ordering, not the persistence set:

# touch {a,b,c,d}
# touch {1,2,3,4}
# fsync d
<crash>

SOMC doesn't require {1,2,3,4} to be in the persistence set and
hence present after recovery. It only requires {a,b,c,d} to be in
the persistence set.

If you observe XFS behaviour, it will result in {1,2,3,4} also being
included in the persistence set, because it aggregates all the changes to=
 the parent
directory into a single change per journal checkpoint sequence and
hence it cannot separate them at fsync time.

This, however, is a XFS journal implementation detail and not
something required by SOMC. The resulting behaviour is that XFS
generally persists more than SOMC requires, but the persistence set
that XFS calculates always maintains SOMC semantics so should always
does the right thing.

IOWs, a finer grained implementation of change dependencies could
result in providing exact, minimal persistence SOMC behaviour in
every situation, but don't expect that from XFS. It is likely that
experimental, explicit change depedency graph based filesystems like
featherstitch would provide minimal scope SOMC persistence
behaviour, but that's out of the scope of this document.

(*) http://featherstitch.cs.ucla.edu/
http://featherstitch.cs.ucla.edu/publications/featherstitch-sosp07.pdf
https://lwn.net/Articles/354861/

> It is worth noting
> +that a file system can be crash-consistent (according to POSIX),
> +without providing SOMC [7].

"crash-consistent" doesn't mean "data integrity preserving", and
posix only talks about data integrity beahviour. "crash-consistent"
just means the filesystem is not in a corrupt state when it
recovers.

> +As an example, consider the following test case from xfstest
> +generic/342 [8]
> +-------
> +touch A/foo
> +echo =E2=80=9Chello=E2=80=9D >  A/foo
> +sync
> +
> +mv A/foo A/bar
> +echo =E2=80=9Cworld=E2=80=9D > A/foo
> +fsync A/foo
> +CRASH

[whacky utf-8(?) symbols.  Plain ascii text for documents, please.]

> +What would you expect on recovery, if the file system crashed after
> +the final fsync returned successfully?
> +
> +Non-SOMC file systems will not persist the file
> +A/bar because it was not explicitly fsync-ed. But this means, you will
> +find only the file A/foo with data =E2=80=9Cworld=E2=80=9D after crash=
, thereby losing
> +the previously persisted file with data =E2=80=9Chello=E2=80=9D. You w=
ill need to
> +explicitly fsync the directory A to ensure the rename operation is
> +safely persisted on disk.
> +
> +Under SOMC, to correctly reference the new inode via A/foo,
> +the previous rename operation must persist as well. Therefore,
> +fsync() of A/foo will persist the renamed file A/bar as well.
> +On recovery you will find both A/bar (with data =E2=80=9Chello=E2=80=9D=
)
> +and A/foo (with data =E2=80=9Cworld=E2=80=9D).

You should describe the SOMC behaviour up front in the document,
because that is the behaviour this document is about.  Then describe
how the "man page fsync behaviour" and individual filesystems differ
from SOMC behaviour.

it would also be worth contrasting SOMC to historic ext3 behaviour
(globally ordered metadata and data), because that is the behaviour
that many application devleopers and users still want current
filesystems to emulate.

> +It is noteworthy that xfs, ext4, F2FS (when mounted with fsync_mode=3D=
strict)
> +and btrfs provide SOMC-like behaviour in this particular example.
> +However, in writing, only XFS claims to provide SOMC. F2FS aims to pro=
vide
> +SOMC when mounted with fsync_mode=3Dstrict. It is not clear if ext4 an=
d
> +btrfs provide strictly ordered metadata consistency.

btrfs does not provide SOMC w.r.t. fsync() - that much is clear from
the endless stream of fsync bugs that are being found and fixed.

Also, the hard link behaviour described for ext4 indicates that it
is not truly SOMC, either. From this, I'd consider ext4 a "mostly
SOMC" implementation, but it seems that there are aspects of
ext4/jbd2 dependency and/or atomicity tracking that don't fully
resolve cross-object transactional atomicity dependencies correctly.

Cheers,

Dave.
--=20
Dave Chinner
david@fromorbit.com
