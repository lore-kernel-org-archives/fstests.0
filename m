Received: from mx4-phx2.redhat.com ([209.132.183.25]:34168 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbbHMB7t convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 12 Aug 2015 21:59:49 -0400
Date: Wed, 12 Aug 2015 21:59:46 -0400 (EDT)
From: Zirong Lang <zlang@redhat.com>
Message-ID: <1052072462.7834190.1439431186908.JavaMail.zimbra@redhat.com>
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

Thanks for review.

>=20
> but will you see if other tests should be fixed as well?

I saw you fixed one in commit ddd55d5.

Sure, I will help to find all cases should be fixed.

Maybe add -f automatically for xfs_repair will be better, if it
try to repair an image file?

Or maybe add a function likes mkfs_image_file(), try to find the
sector size of the device contain the image file at first?

Thanks,
Zorro


>=20
> -Eric
>=20
>=20
