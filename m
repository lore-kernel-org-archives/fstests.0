Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59950 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728927AbfFXNHw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Jun 2019 09:07:52 -0400
Date: Mon, 24 Jun 2019 09:07:30 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Removing the shared class of tests
Message-ID: <20190624130730.GD1805@mit.edu>
References: <20190612184033.21845-1-krisman@collabora.com>
 <20190612184033.21845-2-krisman@collabora.com>
 <20190616144440.GD15846@desktop>
 <20190616200154.GA7251@mit.edu>
 <20190620112903.GF15846@desktop>
 <20190620162116.GA4650@mit.edu>
 <20190620175035.GA5380@magnolia>
 <20190624071610.GA10195@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190624071610.GA10195@infradead.org>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>, Eryu Guan <guaneryu@gmail.com>, Gabriel Krisman Bertazi <krisman@collabora.com>, fstests@vger.kernel.org, linux-ext4@vger.kernel.org, "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
List-ID: <fstests@vger.kernel.org>

On Mon, Jun 24, 2019 at 12:16:10AM -0700, Christoph Hellwig wrote:
>=20
> As for the higher level question?  The shared tests always confused the
> heck out of me.  generic with the right feature checks seem like a much
> better idea.

Agreed.  I've sent out a patch series to bring the number of patches
in shared down to four.  Here's what's left:

shared/002 --- needs a feature test to somehow determine whether a
	file system supports thousads of xattrs in a file (currently
	on btrfs and xfs)

shared/011 --- needs some way of determining that a file system
	supports cgroup-aware writeback (currently enabled only for
	ext4 and btrfs).  Do we consider lack of support of
	cgroup-aware writeback a bug?  If so, maybe it doesn't need a
	feature test at all?

shared/032 --- needs a feature test to determine whether or not a file
	system's mkfs supports detection of "foreign file systems".
	e.g., whether or not it warns if you try overwrite a file
	system w/o another file system.  (Currently enabled by xfs and
	btrfs; it doesn't work for ext[234] because e2fsprogs, because
	I didn't want to break existing shell scripts, only warns when
	it is used interactively.  We could a way to force it to be
	activated it points out this tests is fundamentally testing
	implementation choices of the userspace utilities of a file
	system.  Does it belong in xfstests?   : =C2=AF\_(=E3=83=84)_/=C2=AF )

shared/289 --- contains ext4, xfs, and btrfs mechanisms for
	determining blocks which are unallocated.  Has hard-coded
	invocations to dumpe2fs, xfs_db, and /bin/btrfs.

These don't have obvious solutions.  We could maybe add a _notrun if
adding the thousands of xattrs fails with an ENOSPC or related error
(f2fs uses something else).

Maybe we just move shared/011 and move it generic/ w/o a feature test.

Maybe we remove shared/032 altogether, since for e2fsprogs IMHO
the right place to put it is the regression test in e2fsprogs --- but
I know xfs has a different test philosophy for xfsprogs; and tha begs
the question of what to do for mkfs.btrfs.

And maybe we just split up shared/289 to three different tests in
ext4/, xfs/, and btrfs/, since it would make the test script much
simpler to understand?

What do people think?

						- Ted
