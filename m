Received: from mail-pf1-f194.google.com ([209.85.210.194]:39162 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730826AbfIZFv0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 26 Sep 2019 01:51:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id v4so1133880pff.6
        for <fstests@vger.kernel.org>; Wed, 25 Sep 2019 22:51:25 -0700 (PDT)
Date: Thu, 26 Sep 2019 13:51:19 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] generic/442: add sync before dmsetup remove
Message-ID: <20190926055119.GV2622@desktop>
References: <1569400158-5297-1-git-send-email-suyj.fnst@cn.fujitsu.com>
 <20190925130824.GU2622@desktop>
 <7f33fe1f-fe48-6a21-a92a-ca922265cdea@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f33fe1f-fe48-6a21-a92a-ca922265cdea@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Su Yanjun <suyj.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 26, 2019 at 11:05:13AM +0800, Su Yanjun wrote:
>=20
> =E5=9C=A8 2019/9/25 21:08, Eryu Guan =E5=86=99=E9=81=93:
> > On Wed, Sep 25, 2019 at 04:29:18PM +0800, Su Yanjun wrote:
> > > This test case sometime fails. Because "dmsetup remove error-test" =
may
> > > fail when some writeback is going on.
> > >=20
> > > This patch adds sync before dmsetup remove operation.
> > >=20
> > > Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
> > > ---
> > >   tests/generic/442 | 1 +
> > >   1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/tests/generic/442 b/tests/generic/442
> > > index fe6d460..d48ca36 100755
> > > --- a/tests/generic/442
> > > +++ b/tests/generic/442
> > > @@ -43,6 +43,7 @@ $here/src/fsync-err -d $here/src/dmerror $DMERROR=
_DEV
> > fsync-err should have flipped $DMERROR_DEV to working mode and fsync
> > each open fd before exit if fsync-err didn't report any failure. So
> > there should be no on-going writeback.
> > >   # success, all done
> > >   _dmerror_load_working_table
> > > +sync
> > >   _dmerror_cleanup
> > And _dmerror_cleanup umount $DMERROR_DEV first, then tear down the dm
> > device. Could you check if fsync-err returns successfully and umount
> > succeeds as well?
>=20
> I cant find any mount info for $DMERROR_DEV in this test. fsync-err=C2=A0=
 just
> does write or sync test with the raw logical dm device.
>=20
> Am i missing something?

Ah, sorry, I missed that the test uses raw block device..

>=20
> mkfs.xfs: cannot open /dev/sda11: Device or resource busy
> device-mapper: remove ioctl on error-test=C2=A0 failed: Device or resou=
rce busy
> Command failed.
> _check_xfs_filesystem: filesystem on /dev/sda11 has dirty log
> *** xfs_logprint -t output ***
> xfs_logprint: logprint.c:230: main: Assertion `x.logBBsize <=3D 0x7ffff=
fff'
> failed.
> *** end xfs_logprint output
>=20
> From above log, dmsetup remove failed with "Device or resource busy".

I can't reproduce above failure with v5.3 kernel, neither xfs nor ext4.
Does ext4 pass in your setup? I suspect it's a kernel bug that still
holds the block device.

Thanks,
Eryu
