Received: from mx1.redhat.com ([209.132.183.28]:44340 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752133AbbHNJX4 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 14 Aug 2015 05:23:56 -0400
Date: Fri, 14 Aug 2015 17:23:54 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs/020: use -f option for xfs_repair a fs image
Message-ID: <20150814092354.GN17933@dhcp-13-216.nay.redhat.com>
References: <1439400828-23150-1-git-send-email-zlang@redhat.com>
 <55CB846C.6070205@sandeen.net>
 <109535836.8116036.1439478900232.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <109535836.8116036.1439478900232.JavaMail.zimbra@redhat.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Zirong Lang <zlang@redhat.com>
Cc: Eric Sandeen <sandeen@sandeen.net>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 13, 2015 at 11:15:00AM -0400, Zirong Lang wrote:
>=20
>=20
> ----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: "Eric Sandeen" <sandeen@sandeen.net>
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: "Zorro Lang" <zlang@redhat.com>, fstests=
@vger.kernel.org
> > =E6=8A=84=E9=80=81: eguan@redhat.com
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E5=9B=9B, 20=
15=E5=B9=B4 8 =E6=9C=88 13=E6=97=A5 =E4=B8=8A=E5=8D=88 1:37:48
> > =E4=B8=BB=E9=A2=98: Re: [PATCH] xfs/020: use -f option for xfs_repair=
 a fs image
> >=20
> > On 8/12/15 12:33 PM, Zorro Lang wrote:
> > > This case creates a 60t image file on TEST_DIR. Generally
> > > this's no problem. But if the image sector size is smaller
> > > than the TEST_DEV sector size, for example we create the
> > > image on hard 4k TEST_DEV, the test will fail.
> > >=20
> > > So use -f for xfs_repair will helpful.
> > >=20
> > > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > > ---
> > >  tests/xfs/020 | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/tests/xfs/020 b/tests/xfs/020
> > > index dc305c1..120492d 100755
> > > --- a/tests/xfs/020
> > > +++ b/tests/xfs/020
> > > @@ -55,7 +55,7 @@ fsfile=3D$TEST_DIR/fsfile.$seq
> > >  rm -f $fsfile
> > > =20
> > >  $MKFS_PROG -t xfs -d size=3D60t,file,name=3D$fsfile >/dev/null
> > > -$XFS_REPAIR_PROG -o ag_stride=3D32 -t 1 $fsfile >/dev/null 2>&1
> > > +$XFS_REPAIR_PROG -f -o ag_stride=3D32 -t 1 $fsfile >/dev/null 2>&1
> >=20
> > Agreed, but we should audit all tests for this problem, I think.
> >=20
> > FWIW, the latest upstream will do this automatically...
> >=20
> > So for this change, it's fine:
> >=20
> > Reviewed-by: Eric Sandeen <sandeen@redhat.com>
> >=20
> > but will you see if other tests should be fixed as well?
>=20
> Hi Eric,
>=20
> I have checked all xfstests cases about xfs_repair, only xfs/020 and
> xfs/032 try to repair a file image.
>=20
> This patch is about xfs/020.=20
>=20
> But for xfs/032, I think there is no big problem in it. Because always
> copy device to a file, if the device's sector size is 4k, the file
> image will follow it. Except the TEST_DEV sector size not equal to
> SCRATCH_DEV sector size. But yes, add -f will be safe.
>=20
> Do you need I re-send a patch to add -f in xfs/020 and xfs/032 both?

I think the current version of this patch is OK, as xfs/020 is the only
affected case.

Thanks,
Eryu
