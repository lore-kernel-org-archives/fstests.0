Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:6703 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753512AbbFJLL5 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 10 Jun 2015 07:11:57 -0400
Date: Wed, 10 Jun 2015 21:11:53 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] generic: concurrent IO test with mixed IO types
Message-ID: <20150610111153.GX9143@dastard>
References: <1433760101-25540-1-git-send-email-eguan@redhat.com>
 <1433767271-30562-1-git-send-email-eguan@redhat.com>
 <20150609222933.GC24666@dastard>
 <alpine.LFD.2.00.1506101013540.15435@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1506101013540.15435@localhost.localdomain>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: =?utf-8?B?THVrw6HFoQ==?= Czerner <lczerner@redhat.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 10, 2015 at 11:01:57AM +0200, Luk=C3=A1=C5=A1 Czerner wrote:
> On Wed, 10 Jun 2015, Dave Chinner wrote:
>=20
> > Date: Wed, 10 Jun 2015 08:29:33 +1000
> > From: Dave Chinner <david@fromorbit.com>
> > To: Eryu Guan <eguan@redhat.com>
> > Cc: fstests@vger.kernel.org, lczerner@redhat.com
> > Subject: Re: [PATCH v2] generic: concurrent IO test with mixed IO typ=
es
> >=20
> > On Mon, Jun 08, 2015 at 08:41:11PM +0800, Eryu Guan wrote:
> > > Test concurrent buffered I/O, DIO, AIO, mmap I/O and splice I/O on =
the
> > > same files.
> > >=20
> > > Signed-off-by: Eryu Guan <eguan@redhat.com>
> > > ---
> > >=20
> > > This fio job file has been proven to be potent, it triggers WARNING=
s on ext4
> > > and xfs with 4.1-rc6 kernel.
> > >=20
> > > ext4: WARNING: at fs/ext4/inode.c:1328
> > > xfs: WARNING: CPU: 7 PID: 3090 at fs/xfs/xfs_file.c:726 xfs_file_di=
o_aio_write+0x176/0x2a8 [xfs]()
> > >=20
> > > The ext4 issue should be fixed by Lukas's patch
> > > ext4: fix reservation release on invalidatepage for delalloc fs
> > >=20
> > > And it ever paniced kernel in mm code and hung xfs.
> > >=20
> > > I reduced the numjobs and iodepth to reduce the test time(~25s on m=
y test host)
> > > and scale them by $LOAD_FACTOR. And it still could trigger the warn=
ing on ext4
> > > and xfs with reduced workload.
> > >=20
> > > v2:
> > > - use mktemp to create tmp fio job file
> > ....
> > > +seq=3D`basename $0`
> > > +seqres=3D$RESULT_DIR/$seq
> > > +echo "QA output created by $seq"
> > > +
> > > +here=3D`pwd`
> > > +fio_config=3D`mktemp`
> > > +status=3D1	# failure is the default!
> > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> >=20
> > By removing the definition of $tmp, you are now dumping all
> > the temporary files the test harnes creates in /.
>=20
> What temp files ? Yes we're sometimes using $tmp even though there
> is no obvious definition and if we want to rely on the existence of
> this variable we better define it as environment variable in 'check'
> script.

About 80% of the files in the repository use $tmp in some way.
And it's used all over the place in common/*, too. e.g mkfs
and check functions for storing output for parsing....

> It may be enough to simply add
>
> export tmp
>=20
> to the 'check' script

Then everything uses the same tmp file prefix (i.e. the pid of the
check script) rather than a test specific pid so we lose out on
debugging capability there, not to mention that "rm -f $tmp*" in a
test (like the majority of tests do in their cleanup() routine) will
remove all the tmp files that the test harness needs to do it's
stuff....

> But regardless of this bug it does not affect this test in any way
> since it's not calling any of those functions and there are other
> tests that does not define $tmp as well.

Which points out a couple more problems with the test to me. It uses
SCRATCH_MNT without calling _scratch_mkfs - which uses $tmp when
FSTYP=3Dxfs - and it doesn't call _scratch_mount, either, so it's
running on the underlying filesystem rather than the filesystem it
is supposed to test.

And because it uses _require_scratch(), then ./check will call
_check_scratch_fs() to check the filesystem, and if FSTYP=3Dxfs then
_check_xfs_filesystem is called and that uses $tmp....

Cheers,

Dave.
--=20
Dave Chinner
david@fromorbit.com
