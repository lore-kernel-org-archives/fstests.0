Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:45840 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725759AbeICEGk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 3 Sep 2018 00:06:40 -0400
Date: Mon, 3 Sep 2018 09:49:06 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC PATCH] fstests: add support for hfsplus
Message-ID: <20180902234906.GC27618@dastard>
References: <20180901020503.5i4hz4inqtfd3frg@eaf>
 <20180901170957.GF3651@desktop>
 <20180902040337.3bdp224btok5y5xh@eaf>
 <4445a65e-42b7-5e2e-36fa-45f116f99f33@sandeen.net>
 <20180902140529.GI3651@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180902140529.GI3651@desktop>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <guaneryu@gmail.com>
Cc: Eric Sandeen <sandeen@sandeen.net>, Ernesto =?iso-8859-1?Q?A=2E_Fern=E1ndez?= <ernesto.mnd.fernandez@gmail.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Sep 02, 2018 at 10:05:29PM +0800, Eryu Guan wrote:
> On Sun, Sep 02, 2018 at 12:13:26AM -0500, Eric Sandeen wrote:
> >=20
> >=20
> > On 9/1/18 11:03 PM, Ernesto A. Fern=E1ndez wrote:
> > > On Sun, Sep 02, 2018 at 01:09:57AM +0800, Eryu Guan wrote:
> > >> On Fri, Aug 31, 2018 at 11:05:03PM -0300, Ernesto A. Fern=E1ndez w=
rote:
> > >>> It is not possible to set file system size when running mkfs.hfsp=
lus,
> > >>> so use the device mapper as a workaround.
> > >>
> > >> I'd prefer _notrun the test in _scratch_mkfs_sized() instead of th=
is
> > >> workaround, as the harness is expecting to operate $SCRATCH_DEV bu=
t this
> > >> workaround may break this assumption in subtle ways, e.g. now
> > >> _check_scratch_fs fails to create hfsplus-tmp device because
> > >> $SCRATCH_DEV may still be mounted.
> > >=20
> > > I didn't realize $SCRATCH_DEV could still be mounted, sorry. Maybe =
I can
> > > unmount it before _dmsetup_create(), and remount after _dmsetup_rem=
ove()?
> > > Like _check_generic_filesystem() does. Or would that bring other pr=
oblems?
>=20
> I haven't seen other problems yet (after just a few simple test runs),
> but I suspect it may break tests in more subtle ways, the
> _check_scratch_fs failure is just an example. And even it works for now=
,
> and we have to worry about making it continue to work when adding new
> features in the future and that's a maintaining burden we'd better to
> avoid.

Ah, I just replied on the -fsdevel thread saying exactly this....

> > > I know it's ugly, but one test that uses _scratch_mkfs_sized() has =
helped
> > > me find a number of bugs already. It would be really useful to get =
it to
> > > work.
> >=20
> > Has anyone proposed a patch to mkfs.hfsplus to accept a filesystem si=
ze?
> > I'd expect that might be less complicated than this sort of devicemap=
per
> > setup ;)
>
> Yeah, this would be the best way to let _scratch_mkfs_sized() support
> hfsplus :)

.... and this, too. :)

It'll be easy to add a mkfs option check in _scratch_mkfs_sized()
for hfsplus. That should make it work (or not run, as the case
may be) reliably into the future, too.

Cheers,

Dave.
--=20
Dave Chinner
david@fromorbit.com
