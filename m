Received: from mx4-phx2.redhat.com ([209.132.183.25]:37416 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbbHMPPE convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 13 Aug 2015 11:15:04 -0400
Date: Thu, 13 Aug 2015 11:15:00 -0400 (EDT)
From: Zirong Lang <zlang@redhat.com>
Message-ID: <109535836.8116036.1439478900232.JavaMail.zimbra@redhat.com>
In-Reply-To: <55CB846C.6070205@sandeen.net>
References: <1439400828-23150-1-git-send-email-zlang@redhat.com> <55CB846C.6070205@sandeen.net>
Subject: Re: [PATCH] xfs/020: use -f option for xfs_repair a fs image
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eric Sandeen <sandeen@sandeen.net>
Cc: fstests@vger.kernel.org, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>



----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: "Eric Sandeen" <sandeen@sandeen.net>
> =E6=94=B6=E4=BB=B6=E4=BA=BA: "Zorro Lang" <zlang@redhat.com>, fstests@v=
ger.kernel.org
> =E6=8A=84=E9=80=81: eguan@redhat.com
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E5=9B=9B, 2015=
=E5=B9=B4 8 =E6=9C=88 13=E6=97=A5 =E4=B8=8A=E5=8D=88 1:37:48
> =E4=B8=BB=E9=A2=98: Re: [PATCH] xfs/020: use -f option for xfs_repair a=
 fs image
>=20
> On 8/12/15 12:33 PM, Zorro Lang wrote:
> > This case creates a 60t image file on TEST_DIR. Generally
> > this's no problem. But if the image sector size is smaller
> > than the TEST_DEV sector size, for example we create the
> > image on hard 4k TEST_DEV, the test will fail.
> >=20
> > So use -f for xfs_repair will helpful.
> >=20
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> >  tests/xfs/020 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/tests/xfs/020 b/tests/xfs/020
> > index dc305c1..120492d 100755
> > --- a/tests/xfs/020
> > +++ b/tests/xfs/020
> > @@ -55,7 +55,7 @@ fsfile=3D$TEST_DIR/fsfile.$seq
> >  rm -f $fsfile
> > =20
> >  $MKFS_PROG -t xfs -d size=3D60t,file,name=3D$fsfile >/dev/null
> > -$XFS_REPAIR_PROG -o ag_stride=3D32 -t 1 $fsfile >/dev/null 2>&1
> > +$XFS_REPAIR_PROG -f -o ag_stride=3D32 -t 1 $fsfile >/dev/null 2>&1
>=20
> Agreed, but we should audit all tests for this problem, I think.
>=20
> FWIW, the latest upstream will do this automatically...
>=20
> So for this change, it's fine:
>=20
> Reviewed-by: Eric Sandeen <sandeen@redhat.com>
>=20
> but will you see if other tests should be fixed as well?

Hi Eric,

I have checked all xfstests cases about xfs_repair, only xfs/020 and
xfs/032 try to repair a file image.

This patch is about xfs/020.=20

But for xfs/032, I think there is no big problem in it. Because always
copy device to a file, if the device's sector size is 4k, the file
image will follow it. Except the TEST_DEV sector size not equal to
SCRATCH_DEV sector size. But yes, add -f will be safe.

Do you need I re-send a patch to add -f in xfs/020 and xfs/032 both?

Or you have another idea to fix this problem, likes add a new function?

Thanks,
Zorro Lang

>=20
> -Eric
>=20
>=20
