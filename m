Received: from mail-qk1-f195.google.com ([209.85.222.195]:44717 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725759AbeICECk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 3 Sep 2018 00:02:40 -0400
Received: by mail-qk1-f195.google.com with SMTP id d131-v6so4673167qke.11
        for <fstests@vger.kernel.org>; Sun, 02 Sep 2018 16:45:10 -0700 (PDT)
Date: Sun, 2 Sep 2018 20:45:05 -0300
From: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?=
        <ernesto.mnd.fernandez@gmail.com>
Subject: Re: [RFC PATCH] fstests: add support for hfsplus
Message-ID: <20180902234505.2ih75jk2ggbpj727@eaf>
References: <20180901020503.5i4hz4inqtfd3frg@eaf>
 <20180901170957.GF3651@desktop>
 <20180902040337.3bdp224btok5y5xh@eaf>
 <4445a65e-42b7-5e2e-36fa-45f116f99f33@sandeen.net>
 <20180902140529.GI3651@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180902140529.GI3651@desktop>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <guaneryu@gmail.com>
Cc: Eric Sandeen <sandeen@sandeen.net>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Sep 02, 2018 at 10:05:29PM +0800, Eryu Guan wrote:
> On Sun, Sep 02, 2018 at 12:13:26AM -0500, Eric Sandeen wrote:
> >=20
> >=20
> > On 9/1/18 11:03 PM, Ernesto A. Fern=C3=A1ndez wrote:
> > > On Sun, Sep 02, 2018 at 01:09:57AM +0800, Eryu Guan wrote:
> > >> On Fri, Aug 31, 2018 at 11:05:03PM -0300, Ernesto A. Fern=C3=A1nde=
z wrote:
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
>=20
> > >=20
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
>=20
> Yeah, this would be the best way to let _scratch_mkfs_sized() support
> hfsplus :)

mkfs.hfsplus and fsck.hfsplus both come from Apple. Do you think they
would pick up a patch? I'm not sure how to reach them.

I could also just patch these tools for myself. When somebody calls
_scratch_mkfs_sized() on hfsplus with an unpatched version, the test
could _notrun and tell them where to get mine. Is that acceptable?

>=20
> Thanks,
> Eryu
