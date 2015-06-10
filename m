Received: from mx1.redhat.com ([209.132.183.28]:52866 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965023AbbFJO0H (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 10 Jun 2015 10:26:07 -0400
Date: Wed, 10 Jun 2015 16:26:03 +0200 (CEST)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
Subject: Re: [PATCH v2] generic: concurrent IO test with mixed IO types
In-Reply-To: <20150610135928.GZ9143@dastard>
Message-ID: <alpine.LFD.2.00.1506101612110.15435@localhost.localdomain>
References: <1433760101-25540-1-git-send-email-eguan@redhat.com> <1433767271-30562-1-git-send-email-eguan@redhat.com> <20150609222933.GC24666@dastard> <alpine.LFD.2.00.1506101013540.15435@localhost.localdomain> <20150610111153.GX9143@dastard>
 <alpine.LFD.2.00.1506101346530.15435@localhost.localdomain> <20150610135928.GZ9143@dastard>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1760558658-1433946367=:15435"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1760558658-1433946367=:15435
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by aserv0022.oracle.com id t5AEQaO3015380

On Wed, 10 Jun 2015, Dave Chinner wrote:

> Date: Wed, 10 Jun 2015 23:59:28 +1000
> From: Dave Chinner <david@fromorbit.com>
> To: Luk=C3=A1=C5=A1 Czerner <lczerner@redhat.com>
> Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
> Subject: Re: [PATCH v2] generic: concurrent IO test with mixed IO types
>=20
> On Wed, Jun 10, 2015 at 02:22:55PM +0200, Luk=C3=A1=C5=A1 Czerner wrote=
:
> > On Wed, 10 Jun 2015, Dave Chinner wrote:
> >=20
> > > Date: Wed, 10 Jun 2015 21:11:53 +1000
> > > From: Dave Chinner <david@fromorbit.com>
> > > To: Luk=C3=A1=C5=A1 Czerner <lczerner@redhat.com>
> > > Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
> > > Subject: Re: [PATCH v2] generic: concurrent IO test with mixed IO t=
ypes
> > >=20
> > > On Wed, Jun 10, 2015 at 11:01:57AM +0200, Luk=C3=A1=C5=A1 Czerner w=
rote:
> > > > On Wed, 10 Jun 2015, Dave Chinner wrote:
> > > >=20
> > > > > Date: Wed, 10 Jun 2015 08:29:33 +1000
> > > > > From: Dave Chinner <david@fromorbit.com>
> > > > > To: Eryu Guan <eguan@redhat.com>
> > > > > Cc: fstests@vger.kernel.org, lczerner@redhat.com
> > > > > Subject: Re: [PATCH v2] generic: concurrent IO test with mixed =
IO types
> > > > >=20
> > > > > On Mon, Jun 08, 2015 at 08:41:11PM +0800, Eryu Guan wrote:
> > > > > > Test concurrent buffered I/O, DIO, AIO, mmap I/O and splice I=
/O on the
> > > > > > same files.
> > > > > >=20
> > > > > > Signed-off-by: Eryu Guan <eguan@redhat.com>
> > > > > > ---
> > > > > >=20
> > > > > > This fio job file has been proven to be potent, it triggers W=
ARNINGs on ext4
> > > > > > and xfs with 4.1-rc6 kernel.
> > > > > >=20
> > > > > > ext4: WARNING: at fs/ext4/inode.c:1328
> > > > > > xfs: WARNING: CPU: 7 PID: 3090 at fs/xfs/xfs_file.c:726 xfs_f=
ile_dio_aio_write+0x176/0x2a8 [xfs]()
> > > > > >=20
> > > > > > The ext4 issue should be fixed by Lukas's patch
> > > > > > ext4: fix reservation release on invalidatepage for delalloc =
fs
> > > > > >=20
> > > > > > And it ever paniced kernel in mm code and hung xfs.
> > > > > >=20
> > > > > > I reduced the numjobs and iodepth to reduce the test time(~25=
s on my test host)
> > > > > > and scale them by $LOAD_FACTOR. And it still could trigger th=
e warning on ext4
> > > > > > and xfs with reduced workload.
> > > > > >=20
> > > > > > v2:
> > > > > > - use mktemp to create tmp fio job file
> > > > > ....
> > > > > > +seq=3D`basename $0`
> > > > > > +seqres=3D$RESULT_DIR/$seq
> > > > > > +echo "QA output created by $seq"
> > > > > > +
> > > > > > +here=3D`pwd`
> > > > > > +fio_config=3D`mktemp`
> > > > > > +status=3D1	# failure is the default!
> > > > > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > > >=20
> > > > > By removing the definition of $tmp, you are now dumping all
> > > > > the temporary files the test harnes creates in /.
> > > >=20
> > > > What temp files ? Yes we're sometimes using $tmp even though ther=
e
> > > > is no obvious definition and if we want to rely on the existence =
of
> > > > this variable we better define it as environment variable in 'che=
ck'
> > > > script.
> > >=20
> > > About 80% of the files in the repository use $tmp in some way.
> > > And it's used all over the place in common/*, too. e.g mkfs
> > > and check functions for storing output for parsing....
> >=20
> > Ah, come on. There are not that many functions using the $tmp and
> > some of them even removes the file immediately.
>=20
> $ git grep -lw "^tmp=3D" |wc -l
> 484
> $ git grep -lw "\$tmp" |wc -l
> 417
>=20
> That's roughly 80% of files that use $tmp /in some way/. The tests
> are all suppose dto define $tmp the same way, and they are all
> expected to clean up after themselves, thereby making it possible to
> safely use $tmp in linrary functions, whether they clean up after
> tehmselves or not.
>=20
> You're spending way more time and effort than is necessary on basic
> infrastructure that has worked for 15 years and, quite frankly,
> *doesn't need fixing because it's not broken*.

Strongly disagree and patch like that just proves that it is
broken. But frankly you're right in that I am spending too much time
and effort arguing with you.

Regards,
-Lukas
--8323328-1760558658-1433946367=:15435--
