Received: from mx1.redhat.com ([209.132.183.28]:46680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728040AbfIPG1t (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 16 Sep 2019 02:27:49 -0400
Date: Mon, 16 Sep 2019 02:27:49 -0400 (EDT)
From: Jianhong Yin <jiyin@redhat.com>
Message-ID: <1537180030.94268.1568615269021.JavaMail.zimbra@redhat.com>
In-Reply-To: <1163861204.87989.1568610758519.JavaMail.zimbra@redhat.com>
References: <20190904125821.7736-1-yin-jianhong@163.com> <20190915055754.GL2622@desktop> <1163861204.87989.1568610758519.JavaMail.zimbra@redhat.com>
Subject: //Re: [PATCH v2] generic/430: add copy in same file test
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <guaneryu@gmail.com>
Cc: "Jianhong.Yin" <yin-jianhong@163.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: "Jianhong Yin" <jiyin@redhat.com>
> =E6=94=B6=E4=BB=B6=E4=BA=BA: "Eryu Guan" <guaneryu@gmail.com>
> =E6=8A=84=E9=80=81: "Jianhong.Yin" <yin-jianhong@163.com>, fstests@vger=
.kernel.org
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E4=B8=80, 2019=
=E5=B9=B4 9 =E6=9C=88 16=E6=97=A5 =E4=B8=8B=E5=8D=88 1:12:38
> =E4=B8=BB=E9=A2=98: Re: [PATCH v2] generic/430: add copy in same file t=
est
>=20
>=20
> ----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: "Eryu Guan" <guaneryu@gmail.com>
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: "Jianhong.Yin" <yin-jianhong@163.com>
> > =E6=8A=84=E9=80=81: fstests@vger.kernel.org, jiyin@redhat.com
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E6=97=A5, 20=
19=E5=B9=B4 9 =E6=9C=88 15=E6=97=A5 =E4=B8=8B=E5=8D=88 1:58:01
> > =E4=B8=BB=E9=A2=98: Re: [PATCH v2] generic/430: add copy in same file=
 test
> >=20
> > On Wed, Sep 04, 2019 at 08:58:21PM +0800, Jianhong.Yin wrote:
> > > now xfstests has not cover the senario that copy in same file
> > > related bug:
> > >  copy_file_range return "Invalid argument" when copy in the same fi=
le
> > >  https://bugzilla.kernel.org/show_bug.cgi?id=3D202935
> > >=20
> > > step1:
> > >  copy whole file to itself, and compare with original file.
> >=20
> > This is explicitly forbidden by commit 96e6e8f4a68d ("vfs: add missin=
g
> > checks to copy_file_range").
>=20
> Good to know.
>  so this test should be in generic/434 (error checking)
update:
 find that the overlaps test has done by generic/564.

Jianhong.

>=20
> +       /* Don't allow overlapped copying within the same file. */
> +       if (inode_in =3D=3D inode_out &&
> +           pos_out + count > pos_in &&
> +           pos_out < pos_in + count)
> +               return -EINVAL;
>=20
> >=20
> > > step2:
> > >  copy whole file to end of itself, and compare the two halves with =
the
> > >  original file
> > > step3:
> > >  recover from original file.
> > >=20
> > > Signed-off-by: Jianhong Yin <yin-jianhong@163.com>
> > > ---
> > >=20
> > > this is a base function test, I don't think we should add a new
> > > test for it like 553 554, so add it in generic/430
> > > what do you think?
> > >=20
> > >  tests/generic/430     | 12 ++++++++++++
> > >  tests/generic/430.out |  4 ++++
> > >  2 files changed, 16 insertions(+)
> > >=20
> > > diff --git a/tests/generic/430 b/tests/generic/430
> > > index 1b11f60d..4ce0ee26 100755
> > > --- a/tests/generic/430
> > > +++ b/tests/generic/430
> > > @@ -6,6 +6,7 @@
> > >  #
> > >  # Tests vfs_copy_file_range():
> > >  #   - Copy a file
> > > +#   - Copy in same file
> > >  #   - Copy beginning of original to new file
> > >  #   - Copy middle of original to a new file
> > >  #   - Copy end of original to new file
> > > @@ -52,6 +53,17 @@ cmp $testdir/file $testdir/copy
> > >  echo "Original md5sums:"
> > >  md5sum $testdir/{file,copy} | _filter_test_dir
> > > =20
> > > +fsize=3D$(stat -c %s $testdir/copy)
> > > +echo "Copy in same file"
> > > +$XFS_IO_PROG    -c "copy_range -l $fsize $testdir/copy" "$testdir/=
copy"
> > > +cmp $testdir/file $testdir/copy
> > > +$XFS_IO_PROG    -c "copy_range -l $fsize -d $fsize $testdir/copy"
> > > "$testdir/copy"
> > > +cmp -n $fsize $testdir/file $testdir/copy
> > > +cmp -i $fsize:0 $testdir/file $testdir/copy
> >=20
> > We should skip '0' from original file and $fsize from the copy, i.e.
> >=20
> > cmp -i 0:$fsize $testdir/file $testdir/copy
>=20
> yes, had fixed in PATVH v3; will send PATCH v4(remove step 1)
>=20
> Thanks
> Jianhong
>=20
> >=20
> > Thanks,
> > Eryu
> >=20
> > > +$XFS_IO_PROG -f -c "copy_range $testdir/file" "$testdir/copy"
> > > +echo "md5sums after copying in same file and recover:"
> > > +md5sum $testdir/{file,copy} | _filter_test_dir
> > > +
> > >  echo "Copy beginning of original file"
> > >  $XFS_IO_PROG -f -c "copy_range -l 1000 $testdir/file"
> > >  "$testdir/beginning"
> > >  cmp -n 1000 $testdir/file $testdir/beginning
> > > diff --git a/tests/generic/430.out b/tests/generic/430.out
> > > index 4b4ca75d..57584957 100644
> > > --- a/tests/generic/430.out
> > > +++ b/tests/generic/430.out
> > > @@ -3,6 +3,10 @@ Create the original file and then copy
> > >  Original md5sums:
> > >  e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/file
> > >  e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/copy
> > > +Copy in same file
> > > +md5sums after copying in same file and recover:
> > > +e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/file
> > > +e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/copy
> > >  Copy beginning of original file
> > >  md5sums after copying beginning:
> > >  e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/file
> > > --
> > > 2.21.0
> > >=20
> >=20
>=20
