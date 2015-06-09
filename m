Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:49798 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752115AbbFIW1L (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 9 Jun 2015 18:27:11 -0400
Date: Wed, 10 Jun 2015 08:27:09 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic: concurrent IO test with mixed IO types
Message-ID: <20150609222709.GB24666@dastard>
References: <1433760101-25540-1-git-send-email-eguan@redhat.com>
 <alpine.LFD.2.00.1506081300400.1273@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1506081300400.1273@localhost.localdomain>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: =?utf-8?B?THVrw6HFoQ==?= Czerner <lczerner@redhat.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jun 08, 2015 at 01:02:48PM +0200, Luk=C3=A1=C5=A1 Czerner wrote:
> On Mon, 8 Jun 2015, Eryu Guan wrote:
>=20
> > Date: Mon,  8 Jun 2015 18:41:41 +0800 From: Eryu Guan
> > <eguan@redhat.com> To: fstests@vger.kernel.org Cc:
> > lczerner@redhat.com, Eryu Guan <eguan@redhat.com> Subject:
> > [PATCH] generic: concurrent IO test with mixed IO types
> >=20
> > Test concurrent buffered I/O, DIO, AIO, mmap I/O and splice I/O
> > on the same files.
>=20
> Hi Eryu,
>=20
> Great! Thanks for turning it into a test. Couple of comments
> below.
....
> > + +seq=3D`basename $0` +seqres=3D$RESULT_DIR/$seq +echo "QA output
> > created by $seq" + +here=3D`pwd` +tmp=3D/tmp/$$
>=20
> Not a big deal, but using mktemp woud probably be better.

Not better at all - this reduces the easy of debugging problems.
e.g.  if a test is hung, I know where it's temporary output files
are just by looking at the process listing and grabbing the pid of
the test process being run. IOWs, we *want* deterministic temporary
filenames here - obscuring the temporary file names that tests use
doesn't gain us anything.

Yes, I see that some btrfs tests have used mktemp  and a couple of
generic tests use $TEST_DIR/$$ - they should be reverted to /tmp/$$
so they are consistent with the majority of tests and the new test
template....

Cheers,

Dave.
--=20
Dave Chinner
david@fromorbit.com
