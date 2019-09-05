Received: from mx1.redhat.com ([209.132.183.28]:36904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbfIEBu5 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 4 Sep 2019 21:50:57 -0400
Date: Wed, 4 Sep 2019 21:50:56 -0400 (EDT)
From: Jianhong Yin <jiyin@redhat.com>
Message-ID: <931295303.12720960.1567648256472.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190905014606.GZ7239@dhcp-12-102.nay.redhat.com>
References: <20190904130134.7842-1-yin-jianhong@163.com> <20190905014606.GZ7239@dhcp-12-102.nay.redhat.com>
Subject: Re: [PATCH v3] generic/430: add copy in same file test
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Zorro Lang <zlang@redhat.com>
Cc: "Jianhong.Yin" <yin-jianhong@163.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: "Zorro Lang" <zlang@redhat.com>
> =E6=94=B6=E4=BB=B6=E4=BA=BA: "Jianhong.Yin" <yin-jianhong@163.com>
> =E6=8A=84=E9=80=81: fstests@vger.kernel.org, jiyin@redhat.com
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E5=9B=9B, 2019=
=E5=B9=B4 9 =E6=9C=88 05=E6=97=A5 =E4=B8=8A=E5=8D=88 9:46:06
> =E4=B8=BB=E9=A2=98: Re: [PATCH v3] generic/430: add copy in same file t=
est
>=20
> On Wed, Sep 04, 2019 at 09:01:34PM +0800, Jianhong.Yin wrote:
> > now xfstests has not cover the senario that copy in same file
> > related bug:
> >  copy_file_range return "Invalid argument" when copy in the same file
> >  https://bugzilla.kernel.org/show_bug.cgi?id=3D202935
> >=20
> > step1:
> >  copy whole file to itself, and compare with original file.
> > step2:
> >  copy whole file to end of itself, and compare the two halves with th=
e
> >  original file
> > step3:
> >  recover from original file.
> >=20
> > Signed-off-by: Jianhong Yin <yin-jianhong@163.com>
> > ---
> >=20
> > this is a base function test, I don't think we should add a new
> > test for it like 553 554, so add it in generic/430
> > what do you think?
> >=20
> >  tests/generic/430     | 12 ++++++++++++
> >  tests/generic/430.out |  4 ++++
> >  2 files changed, 16 insertions(+)
> >=20
> > diff --git a/tests/generic/430 b/tests/generic/430
> > index 1b11f60d..4ce0ee26 100755
> > --- a/tests/generic/430
> > +++ b/tests/generic/430
> > @@ -6,6 +6,7 @@
> >  #
> >  # Tests vfs_copy_file_range():
> >  #   - Copy a file
> > +#   - Copy in same file
> >  #   - Copy beginning of original to new file
> >  #   - Copy middle of original to a new file
> >  #   - Copy end of original to new file
> > @@ -52,6 +53,17 @@ cmp $testdir/file $testdir/copy
> >  echo "Original md5sums:"
> >  md5sum $testdir/{file,copy} | _filter_test_dir
> > =20
> > +fsize=3D$(stat -c %s $testdir/copy)
>=20
> I don't think you need to do `stat` to get the file size, due to this c=
ase
> has definite fixed file size (5000 bytes). If it fails to write 5000 by=
tes,
> the case should be failed for something wrong.
I don't think you are right, here.

>=20
> > +echo "Copy in same file"
> > +$XFS_IO_PROG    -c "copy_range -l $fsize $testdir/copy" "$testdir/co=
py"
> > +cmp $testdir/file $testdir/copy
> > +$XFS_IO_PROG    -c "copy_range -l $fsize -d $fsize $testdir/copy"
> > "$testdir/copy"
> > +cmp -n $fsize $testdir/file $testdir/copy
> > +cmp -i 0:$fsize $testdir/file $testdir/copy
>=20
> I think test once on same file is enough, but I don't have objection if=
 you
> and
> maintainer preper twice.
>=20
> > +$XFS_IO_PROG -f -c "copy_range $testdir/file" "$testdir/copy"
> > +echo "md5sums after copying in same file and recover:"
> > +md5sum $testdir/{file,copy} | _filter_test_dir
>=20
> This test base on an implicit operation that xfs_io copy_range command =
always
> truncates target file to 0 before doing copy_file_range, if there's not
> -l or -d or -s specified.
>=20
> So I think if you'd like to do this test, I prefer truncating $testdir/=
copy
> by an explicit operation (e.g: use -t option, or -c 'truncate 0', or ev=
en
> rm -f $testdir/copy).

Yes, we are talking about this in linux-xfs channel:
 https://www.spinics.net/lists/linux-xfs/msg31327.html
 https://www.spinics.net/lists/linux-xfs/msg31292.html


patch v4 is comming.
>=20
> And as above, I don't think this test is necessary, but I don't have
> objection
> if you and maintainer preper that.
>=20
> Thanks,
> Zorro
>=20
> > +
> >  echo "Copy beginning of original file"
> >  $XFS_IO_PROG -f -c "copy_range -l 1000 $testdir/file" "$testdir/begi=
nning"
> >  cmp -n 1000 $testdir/file $testdir/beginning
> > diff --git a/tests/generic/430.out b/tests/generic/430.out
> > index 4b4ca75d..57584957 100644
> > --- a/tests/generic/430.out
> > +++ b/tests/generic/430.out
> > @@ -3,6 +3,10 @@ Create the original file and then copy
> >  Original md5sums:
> >  e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/file
> >  e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/copy
> > +Copy in same file
> > +md5sums after copying in same file and recover:
> > +e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/file
> > +e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/copy
> >  Copy beginning of original file
> >  md5sums after copying beginning:
> >  e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/file
> > --
> > 2.21.0
> >=20
>=20
