Received: from mx1.redhat.com ([209.132.183.28]:37718 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753171AbbFJMXA (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 10 Jun 2015 08:23:00 -0400
Date: Wed, 10 Jun 2015 14:22:55 +0200 (CEST)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
Subject: Re: [PATCH v2] generic: concurrent IO test with mixed IO types
In-Reply-To: <20150610111153.GX9143@dastard>
Message-ID: <alpine.LFD.2.00.1506101346530.15435@localhost.localdomain>
References: <1433760101-25540-1-git-send-email-eguan@redhat.com> <1433767271-30562-1-git-send-email-eguan@redhat.com> <20150609222933.GC24666@dastard> <alpine.LFD.2.00.1506101013540.15435@localhost.localdomain> <20150610111153.GX9143@dastard>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1829186699-1433938980=:15435"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1829186699-1433938980=:15435
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by aserv0022.oracle.com id t5ACN4pi017498

On Wed, 10 Jun 2015, Dave Chinner wrote:

> Date: Wed, 10 Jun 2015 21:11:53 +1000
> From: Dave Chinner <david@fromorbit.com>
> To: Luk=C3=A1=C5=A1 Czerner <lczerner@redhat.com>
> Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
> Subject: Re: [PATCH v2] generic: concurrent IO test with mixed IO types
>=20
> On Wed, Jun 10, 2015 at 11:01:57AM +0200, Luk=C3=A1=C5=A1 Czerner wrote=
:
> > On Wed, 10 Jun 2015, Dave Chinner wrote:
> >=20
> > > Date: Wed, 10 Jun 2015 08:29:33 +1000
> > > From: Dave Chinner <david@fromorbit.com>
> > > To: Eryu Guan <eguan@redhat.com>
> > > Cc: fstests@vger.kernel.org, lczerner@redhat.com
> > > Subject: Re: [PATCH v2] generic: concurrent IO test with mixed IO t=
ypes
> > >=20
> > > On Mon, Jun 08, 2015 at 08:41:11PM +0800, Eryu Guan wrote:
> > > > Test concurrent buffered I/O, DIO, AIO, mmap I/O and splice I/O o=
n the
> > > > same files.
> > > >=20
> > > > Signed-off-by: Eryu Guan <eguan@redhat.com>
> > > > ---
> > > >=20
> > > > This fio job file has been proven to be potent, it triggers WARNI=
NGs on ext4
> > > > and xfs with 4.1-rc6 kernel.
> > > >=20
> > > > ext4: WARNING: at fs/ext4/inode.c:1328
> > > > xfs: WARNING: CPU: 7 PID: 3090 at fs/xfs/xfs_file.c:726 xfs_file_=
dio_aio_write+0x176/0x2a8 [xfs]()
> > > >=20
> > > > The ext4 issue should be fixed by Lukas's patch
> > > > ext4: fix reservation release on invalidatepage for delalloc fs
> > > >=20
> > > > And it ever paniced kernel in mm code and hung xfs.
> > > >=20
> > > > I reduced the numjobs and iodepth to reduce the test time(~25s on=
 my test host)
> > > > and scale them by $LOAD_FACTOR. And it still could trigger the wa=
rning on ext4
> > > > and xfs with reduced workload.
> > > >=20
> > > > v2:
> > > > - use mktemp to create tmp fio job file
> > > ....
> > > > +seq=3D`basename $0`
> > > > +seqres=3D$RESULT_DIR/$seq
> > > > +echo "QA output created by $seq"
> > > > +
> > > > +here=3D`pwd`
> > > > +fio_config=3D`mktemp`
> > > > +status=3D1	# failure is the default!
> > > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > >=20
> > > By removing the definition of $tmp, you are now dumping all
> > > the temporary files the test harnes creates in /.
> >=20
> > What temp files ? Yes we're sometimes using $tmp even though there
> > is no obvious definition and if we want to rely on the existence of
> > this variable we better define it as environment variable in 'check'
> > script.
>=20
> About 80% of the files in the repository use $tmp in some way.
> And it's used all over the place in common/*, too. e.g mkfs
> and check functions for storing output for parsing....

Ah, come on. There are not that many functions using the $tmp and
some of them even removes the file immediately.

Removes immediatelly
common/attr	_acl_get_max
common/filter	_within_tolerance
common/rc	_check_generic_filesystem
common/rc	_check_xfs_filesystem
common/rc	_check_btrfs_filesystem

Does not remove
common/dump	_check_onl
		_create_dumpdir_stress_num
		_mk_fillconfig1
		_mk_fillconfig2
		_mk_fillconfig_ea
		_mk_fillconfig_xattr
		_mk_fillconfig_multi
		_append_dumpdir_fill
		_do_create_dump_symlinks
		_mk_symlink_config
		_do_dump_restore
		_ls_compare_sub
		_ls_nodate_compare_sub
		_create_dumpdir_stress_num
common/quota	_check_quota_usage
common/rc	_do

Most of the users are in the common/dump, however it's broken anyway
since on _cleanup() it does "rm -f $tmp.*" that'll remove all the
tmp file xfstests supposedly use.

>=20
> > It may be enough to simply add
> >
> > export tmp
> >=20
> > to the 'check' script
>=20
> Then everything uses the same tmp file prefix (i.e. the pid of the
> check script) rather than a test specific pid so we lose out on
> debugging capability there, not to mention that "rm -f $tmp*" in a
> test (like the majority of tests do in their cleanup() routine) will
> remove all the tmp files that the test harness needs to do it's
> stuff....

What debugging ? First of all, all of the $tmp.* files are removed either
immediately or when the script ends and some of them are actually
dumped to the .full report anyway.

But regardless, the "rm -f $tmp*" called from the test _cleanup()
routine will _not_ remove tmp files that the test harness needs as
long as it defined it's own $tmp, so really using 'export' is the
right way for test that does not need their own tmp, or creates a
different name for they temp file, or directory.

Not even mentioning that there is not safety check to prevent us
from overwriting each other tmp files, or even temp files of
completely different unrelated process ( that's why we should use
mktemp).

>=20
> > But regardless of this bug it does not affect this test in any way
> > since it's not calling any of those functions and there are other
> > tests that does not define $tmp as well.
>=20
> Which points out a couple more problems with the test to me. It uses
> SCRATCH_MNT without calling _scratch_mkfs - which uses $tmp when
> FSTYP=3Dxfs - and it doesn't call _scratch_mount, either, so it's
> running on the underlying filesystem rather than the filesystem it
> is supposed to test.

Right, that's a bug. Moreover if the test is the first test, or the
only test you run everything will be ok becuase 'check' script will
_scratch_mkfs and _scratch_mount for you for some reason ...

>=20
> And because it uses _require_scratch(), then ./check will call
> _check_scratch_fs() to check the filesystem, and if FSTYP=3Dxfs then
> _check_xfs_filesystem is called and that uses $tmp....

Not really. 'check' script calls _check_scratch_fs() and the $tmp is
defined there regardless of what the test itself is doing.

Regards,
-Lukas

>=20
> Cheers,
>=20
> Dave.
>=20
--8323328-1829186699-1433938980=:15435--
