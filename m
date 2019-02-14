Received: from ipmail02.adl2.internode.on.net ([150.101.137.139]:63811 "EHLO
        ipmail02.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391431AbfBNBrd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 13 Feb 2019 20:47:33 -0500
Date: Thu, 14 Feb 2019 12:47:28 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: Documenting the crash consistency guarantees of file systems
Message-ID: <20190214014728.GQ20493@dastard>
References: <CA+EzBbDyoPF8=mZyG8HQAoHTm4h4MSCe=5WX_SBqRwPej=4uFg@mail.gmail.com>
 <CAOQ4uxh7OayzbGFk0cxoZf_t9jGxesv9k6zPPOA=+5MDsqWOzA@mail.gmail.com>
 <CA+EzBbC5c-O0ZBuC+UaL7Ftp2Vh8K8d46_6HTBWetY2Otd=tiA@mail.gmail.com>
 <CAOQ4uxi=riQHbaaBxK64SdWdQ1bbHPrPTyXaoOrinG1zggK5gQ@mail.gmail.com>
 <CAHWVdUUQ4=jWJj3eJMyv54n3O3svT8S_BJM9E8gbY4UCc1Rwow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHWVdUUQ4=jWJj3eJMyv54n3O3svT8S_BJM9E8gbY4UCc1Rwow@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Vijay Chidambaram <vijay@cs.utexas.edu>
Cc: Amir Goldstein <amir73il@gmail.com>, Jayashree Mohan <jaya@cs.utexas.edu>, fstests <fstests@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Filipe Manana <fdmanana@gmail.com>, Chris Mason <clm@fb.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-doc@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 13, 2019 at 12:35:16PM -0600, Vijay Chidambaram wrote:
> On Wed, Feb 13, 2019 at 12:22 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > On Wed, Feb 13, 2019 at 7:06 PM Jayashree Mohan <jaya@cs.utexas.edu> wrote:
> AFAIK, any file system which persists things out of order to increase
> performance does not provide strictly ordered metadata semantics.

Define "things", please.

And while you are there, define "persist", please.

XFS can "persist" "things" out of order because it has a multi-phase
checkpointing subsystem and we can't control IO ordering during
concurrent checkpoint writeout. The out of order checkpoints don't
get put back in order until recovery is run - it reorders everything
that is in the journal into correct sequence order before it starts
recovery.

IOWs, the assertion that we must "persist" things in strict order to
maintain ordered metadata semantics is incorrect. /Replay/ of the
changes being recovered must be done in order, but that does not
require them to be persisted to stable storage in strict order.

> These semantics seem to indicate a total ordering among all
> operations, and an fsync should persist all previous operations (as
> ext3 used to do).

No, absolutely not.

You're talking about /globally ordered metadata/. This was the
Achille's Heel of ext3, resulting in fsync being indistinguishable
from sync and hence being horrifically slow. This caused a
generation of linux application developers to avoid using fsync and
causing users (and fs developers who got blamed for losing data)
endless amounts of pain when files went missing after crashes.
Hindsight teaches us that ext3's behaviour was a horrible mistake
and not one we want to repeat.

Strictly ordered metadata only requires persisting all the previous
dependent modifications to the objects we need to persist.
i.e. if you fsync an inode we just allocated, then we also have to
persist the changes in the same transaction and then all the
previous changes that are dependent on that set of objects, and so
one all the way back to objects being clean on disk. If we crash,
we can then rebuild all of the information the user persisted
correctly.

There is no requirement for any other newly created inode elsewhere
in the filesystem to be present after fsync of the first file.
Indepdnent file creation will only be persisted by the fsync if
there is a shared object modification dependency between those two
files elsewhere in metadata. e.g. they are both in the same inode
cluster so share an inode btree block modification that marks them
as used, hence if one it persisted, the btree block is persisted,
and hence the other inode and all it's dependencies need to be
persisted as well.

That dependency tree is the "strict ordering" we talk about. At
times it can look like "globally ordered metadata", but for
indepedent changes it will only result in the small number of
dependencies being persisted and not the entire filesystem (as per
ext3).

> Note that Jayashree and I aren't arguing file systems should provide
> this semantics, merely that ext4 and btrfs violate it at certain
> points.

As does XFS.

http://xfs.org/index.php/XFS_FAQ#Q:_Why_do_I_see_binary_NULLS_in_some_files_after_recovery_when_I_unplugged_the_power.3F

ext4 inherited all it's delalloc vs metadata ordering issues from
XFS as ext4 really just copied the XFS design without understanding
all the problems it had. Then when users started reporting problems
the problems we'd fixed with XFS they copied a number of the
mitigations from XFS as well....


-- 
Dave Chinner
david@fromorbit.com
