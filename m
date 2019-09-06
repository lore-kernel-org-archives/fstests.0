Received: from mx1.redhat.com ([209.132.183.28]:59478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbfIFC1M (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 5 Sep 2019 22:27:12 -0400
Date: Fri, 6 Sep 2019 10:34:15 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] generic/43{0,1,2,3}: add -t option when create
 $testdir/copy file
Message-ID: <20190906023415.GF7239@dhcp-12-102.nay.redhat.com>
References: <20190905013921.13396-1-yin-jianhong@163.com>
 <20190906012645.GE7239@dhcp-12-102.nay.redhat.com>
 <1122800099.12989044.1567736136243.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
In-Reply-To: <1122800099.12989044.1567736136243.JavaMail.zimbra@redhat.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Jianhong Yin <jiyin@redhat.com>
Cc: "Jianhong.Yin" <yin-jianhong@163.com>, fstests@vger.kernel.org, darrick wong <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 05, 2019 at 10:15:36PM -0400, Jianhong Yin wrote:
>=20
>=20
> ----- =D4=AD=CA=BC=D3=CA=BC=FE -----
> > =B7=A2=BC=FE=C8=CB: "Zorro Lang" <zlang@redhat.com>
> > =CA=D5=BC=FE=C8=CB: "Jianhong.Yin" <yin-jianhong@163.com>
> > =B3=AD=CB=CD: fstests@vger.kernel.org, "darrick wong" <darrick.wong@o=
racle.com>, jiyin@redhat.com
> > =B7=A2=CB=CD=CA=B1=BC=E4: =D0=C7=C6=DA=CE=E5, 2019=C4=EA 9 =D4=C2 06=C8=
=D5 =C9=CF=CE=E7 9:26:45
> > =D6=F7=CC=E2: Re: [PATCH] generic/43{0,1,2,3}: add -t option when cre=
ate $testdir/copy file
> >=20
> > On Thu, Sep 05, 2019 at 09:39:21AM +0800, Jianhong.Yin wrote:
> > > to avoid there's already a copy file before run test,
> > > it might break test.
>=20
> ^^ Hi Zorro, see here.
> if there there is already a copy file and it's size > src_file,
> test will get fail without truncate

Yeah, I know what you mean. But the thing is whether or not xfstests can =
hit
this issue normally? If you think about un-normal situation, you should
truncate(0) all target files, not only $testdir/copy.

For example, generic/430 has more other target file, likes $testdir/begin=
ning,
$testdir/middle, $testdir/end, $testdir/beyond and $testdir/hole. If as y=
ou
thought, you should use '-t' to all of them, right? But generally there w=
on't
be an *existed* files at there, anyway if you really care about all uncle=
ar test
environment, you should truncate nearly all copy_range's target files bef=
ore do
the copy.

Thanks,
Zorro

>=20
> > >=20
> > > I know now in xfs_io->copy_range there's a hidden truncate action
> > > to do that, but we are taking about remove it, see:
> > >  https://www.spinics.net/lists/linux-xfs/msg31292.html
> > >  https://www.spinics.net/lists/linux-xfs/msg31327.html
> > >=20
> > > Signed-off-by: Jianhong Yin <yin-jianhong@163.com>
> > > ---
> >=20
> > Hi,
> >=20
> > By checking the code logic of generic/430, I don't think it needs to =
truncate
> > the target file before copy_range. To make sure that, I did below tes=
t[1],
> > then
> > nothing fails. I tested with upstream kernel and xfsprogs(with your p=
atches).
> >=20
> > I didn't do more test than that, if I missed something please feel fr=
ee to
> > tell me.
> >=20
> > Thanks,
> > Zorro
> >=20
> > [1]
> > # git am $your_patches
> > # git log --oneline
> > 22c1ab98 (HEAD -> for-next) xfsprogs: copy_range: let =3D (src_size -
> > src_offset) if len omitted
> > 792d4bfb xfsprogs: copy_range don't truncate dstfile
> > ...
> > # make -j8 && make -j8 install && make -j8 install-dev
> > # grep -rsnl copy_range tests/|grep -v .out
> > tests/generic/group
> > tests/generic/434
> > tests/generic/430
> > tests/generic/431
> > tests/generic/432
> > tests/generic/433
> > tests/generic/553
> > tests/generic/554
> > tests/generic/564
> > tests/generic/565
> > # ./check generic/430 generic/431 generic/432 generic/433 generic/434
> > generic/553 generic/554 generic/564 generic/565
> > FSTYP         -- xfs (debug)
> > PLATFORM      -- Linux/x86_64 ibm-x3650m4-10 5.3.0-rc6-xfs-for-next #=
12 SMP
> > Thu Sep 5 07:35:55 EDT 2019
> > MKFS_OPTIONS  -- -f -bsize=3D4096 /dev/mapper/xxx-xxx-xxxxx-xfscratch
> > MOUNT_OPTIONS -- -o context=3Dsystem_u:object_r:root_t:s0
> > /dev/mapper/xxx-xxx-xxxx-xfscratch /mnt/scratch
> >=20
> > generic/430 2s ...  2s
> > generic/431 3s ...  2s
> > generic/432 3s ...  3s
> > generic/433 2s ...  3s
> > generic/434      2s
> > generic/553      2s
> > generic/554      8s
> > generic/564      3s
> > generic/565      5s
> > Ran: generic/430 generic/431 generic/432 generic/433 generic/434 gene=
ric/553
> > generic/554 generic/564 generic/565
> > Passed all 9 tests
> >=20
> >=20
> >=20
> > >  tests/generic/430 | 2 +-
> > >  tests/generic/431 | 2 +-
> > >  tests/generic/432 | 2 +-
> > >  tests/generic/433 | 2 +-
> > >  4 files changed, 4 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/tests/generic/430 b/tests/generic/430
> > > index 1b11f60d..71c6d438 100755
> > > --- a/tests/generic/430
> > > +++ b/tests/generic/430
> > > @@ -47,7 +47,7 @@ $XFS_IO_PROG -f -c 'pwrite -S 0x62 1000 1000'
> > > $testdir/file >> $seqres.full 2>&1
> > >  $XFS_IO_PROG -f -c 'pwrite -S 0x63 2000 1000' $testdir/file >>
> > >  $seqres.full 2>&1
> > >  $XFS_IO_PROG -f -c 'pwrite -S 0x64 3000 1000' $testdir/file >>
> > >  $seqres.full 2>&1
> > >  $XFS_IO_PROG -f -c 'pwrite -S 0x65 4000 1000' $testdir/file >>
> > >  $seqres.full 2>&1
> > > -$XFS_IO_PROG -f -c "copy_range $testdir/file" "$testdir/copy"
> > > +$XFS_IO_PROG -t -f -c "copy_range $testdir/file" "$testdir/copy"
> > >  cmp $testdir/file $testdir/copy
> > >  echo "Original md5sums:"
> > >  md5sum $testdir/{file,copy} | _filter_test_dir
> > > diff --git a/tests/generic/431 b/tests/generic/431
> > > index f04ae215..4b22a8ff 100755
> > > --- a/tests/generic/431
> > > +++ b/tests/generic/431
> > > @@ -40,7 +40,7 @@ rm -f $seqres.full
> > > =20
> > >  echo "Create the original file and then copy"
> > >  echo -n "abcde" > $testdir/file
> > > -$XFS_IO_PROG -f -c "copy_range $testdir/file" "$testdir/copy"
> > > +$XFS_IO_PROG -t -f -c "copy_range $testdir/file" "$testdir/copy"
> > >  echo -n "abcde" | cmp $testdir/copy
> > >  echo "Original md5sums:"
> > >  md5sum $testdir/{file,copy} | _filter_test_dir
> > > diff --git a/tests/generic/432 b/tests/generic/432
> > > index 6200af86..a2fecf37 100755
> > > --- a/tests/generic/432
> > > +++ b/tests/generic/432
> > > @@ -46,7 +46,7 @@ $XFS_IO_PROG -f -c 'pwrite -S 0x62 1000 1000'
> > > $testdir/file >> $seqres.full 2>&1
> > >  $XFS_IO_PROG -f -c 'pwrite -S 0x63 2000 1000' $testdir/file >>
> > >  $seqres.full 2>&1
> > >  $XFS_IO_PROG -f -c 'pwrite -S 0x64 3000 1000' $testdir/file >>
> > >  $seqres.full 2>&1
> > >  $XFS_IO_PROG -f -c 'pwrite -S 0x65 4000 1000' $testdir/file >>
> > >  $seqres.full 2>&1
> > > -$XFS_IO_PROG -f -c "copy_range $testdir/file" "$testdir/copy"
> > > +$XFS_IO_PROG -t -f -c "copy_range $testdir/file" "$testdir/copy"
> > >  cmp $testdir/file  $testdir/copy
> > >  echo "Original md5sums:"
> > >  md5sum $testdir/{file,copy} | _filter_test_dir
> > > diff --git a/tests/generic/433 b/tests/generic/433
> > > index 1238419a..6204f339 100755
> > > --- a/tests/generic/433
> > > +++ b/tests/generic/433
> > > @@ -42,7 +42,7 @@ rm -f $seqres.full
> > > =20
> > >  echo "Create the original file and then copy"
> > >  echo -n "abcde" > $testdir/file
> > > -$XFS_IO_PROG -f -c "copy_range $testdir/file" "$testdir/copy"
> > > +$XFS_IO_PROG -t -f -c "copy_range $testdir/file" "$testdir/copy"
> > >  cmp $testdir/file $testdir/copy
> > >  echo "Original md5sums:"
> > >  md5sum $testdir/{file,copy} | _filter_test_dir
> > > --
> > > 2.21.0
> > >=20
> >=20
