Received: from mx6-phx2.redhat.com ([209.132.183.39]:41173 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbcEWJTD convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 23 May 2016 05:19:03 -0400
Date: Mon, 23 May 2016 05:19:01 -0400 (EDT)
From: Zirong Lang <zlang@redhat.com>
Message-ID: <1355848207.53427850.1463995141573.JavaMail.zimbra@redhat.com>
In-Reply-To: <20160523090750.GI5140@eguan.usersys.redhat.com>
References: <1463502981-15593-1-git-send-email-zlang@redhat.com> <1463502981-15593-2-git-send-email-zlang@redhat.com> <20160523090750.GI5140@eguan.usersys.redhat.com>
Subject: Re: [PATCH 2/2] generic/352: new case test mmaped data when
 blocksize less than pagesize
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: "Eryu Guan" <eguan@redhat.com>
> =E6=94=B6=E4=BB=B6=E4=BA=BA: "Zorro Lang" <zlang@redhat.com>
> =E6=8A=84=E9=80=81: fstests@vger.kernel.org
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E4=B8=80, 2016=
=E5=B9=B4 5 =E6=9C=88 23=E6=97=A5 =E4=B8=8B=E5=8D=88 5:07:50
> =E4=B8=BB=E9=A2=98: Re: [PATCH 2/2] generic/352: new case test mmaped d=
ata when blocksize less than pagesize
>=20
> On Wed, May 18, 2016 at 12:36:21AM +0800, Zorro Lang wrote:
> > This case is a regression test for linux commit 90a80202:
> >=20
> >   vfs: fix data corruption when blocksize < pagesize for mmaped data
> >=20
> >   ->page_mkwrite() is used by filesystems to allocate blocks under a =
page
> >   which is becoming writeably mmapped in some process' address space.=
 This
> >   allows a filesystem to return a page fault if there is not enough s=
pace
> >   available, user exceeds quota or similar problem happens, rather th=
an
> >   silently discarding data later when writepage is called.
> >=20
> >   However VFS fails to call ->page_mkwrite() in all the cases where
> >   filesystems need it when blocksize < pagesize. For example when
> >   blocksize =3D 1024, pagesize =3D 4096 the following is problematic:
> >     ftruncate(fd, 0);
> >     pwrite(fd, buf, 1024, 0);
> >     map =3D mmap(NULL, 1024, PROT_WRITE, MAP_SHARED, fd, 0);
> >     map[0] =3D 'a';       ----> page_mkwrite() for index 0 is called
> >     ftruncate(fd, 10000); /* or even pwrite(fd, buf, 1, 10000) */
> >     mremap(map, 1024, 10000, 0);
> >     map[4095] =3D 'a';    ----> no page_mkwrite() called
> >=20
> >   At the moment ->page_mkwrite() is called, filesystem can allocate o=
nly
> >   one block for the page because i_size =3D=3D 1024. Otherwise it wou=
ld create
> >   blocks beyond i_size which is generally undesirable. But later at
> >   ->writepage() time, we also need to store data at offset 4095 but w=
e
> >   don't have block allocated for it.
> >=20
> >   This patch introduces a helper function filesystems can use to have
> >   ->page_mkwrite() called at all the necessary moments.
> >=20
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> >=20
> > Hi,
> >=20
> > After xfsprogs merged commit:
> >   e0a8808 xfs_io: allow mmap command to reserve some free space
> >=20
> > We can reserve(not 100% sure, but pretty high rate) some memory for m=
remap
> > extend the map space. Due to it, I can use xfs_io to implement this
> > case.
> >=20
> > There're 2 problems when I write this case:
> > 1. The reserved memory space can't be kept 100%, especially when
> > system run heavy memory load. But I think it hard to resolve.
> >=20
> > 2. When xfs_io process be killed by SIGBUS, I can't catch the "Bus er=
ror"
> > output(it not on stdout/stderr). But it will printed into .out file. =
So
> > I use a pipe stop it(Generally, that _filter_xfs_io after the pipe is
> > useless. I just need a pipe.). But I'm not sure if it's a good idea.
> > Anyone have better idea?
> >=20
> > (BTW, this case rely on my last patch about _require_xfs_io_command.)
> >=20
> > Thanks,
> > Zorro
> >=20
> >  tests/generic/352     | 109
> >  ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/352.out |   3 ++
> >  tests/generic/group   |   1 +
> >  3 files changed, 113 insertions(+)
> >  create mode 100755 tests/generic/352
> >  create mode 100644 tests/generic/352.out
> >=20
> > diff --git a/tests/generic/352 b/tests/generic/352
> > new file mode 100755
> > index 0000000..5e69127
> > --- /dev/null
> > +++ b/tests/generic/352
> > @@ -0,0 +1,109 @@
> > +#! /bin/bash
> > +# FS QA Test 352
> > +#
> > +# Regression test for linux commit 90a80202, data corruption when
> > +# blocksize < pagesize for mmaped data.
> > +#
> > +#-------------------------------------------------------------------=
----
> > +# Copyright (c) 2016 Red Hat Inc.  All Rights Reserved.
> > +#
> > +# This program is free software; you can redistribute it and/or
> > +# modify it under the terms of the GNU General Public License as
> > +# published by the Free Software Foundation.
> > +#
> > +# This program is distributed in the hope that it would be useful,
> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +# GNU General Public License for more details.
> > +#
> > +# You should have received a copy of the GNU General Public License
> > +# along with this program; if not, write the Free Software Foundatio=
n,
> > +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > +#-------------------------------------------------------------------=
----
> > +#
> > +
> > +seq=3D`basename $0`
> > +seqres=3D$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=3D`pwd`
> > +tmp=3D/tmp/$$
> > +status=3D1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# support fs which can make block size < page size
> > +_supported_fs xfs ext2 ext3 ext4 ext4dev udf
>=20
> No need to filter out other fs, at least we can get some extra test
> coverage on other filesystems, even if they cannot reproduce this bug
>=20
> And all tests in generic dir should have "_supported_fs generic",
> otherwise you should put it to "shared" dir or fs-specific dir.

Because the bug need block size < page size, so I need fs support
mkfs block size.

But this case can run on everyone fs, so if don't care the bug reproduce,
it can support all fs.

>=20
> > +_supported_os Linux
> > +_require_scratch
> > +_require_xfs_io_command mmap "-s <size>"
> > +_require_xfs_io_command mremap
> > +_require_xfs_io_command truncate
> > +_require_xfs_io_command pwrite
> > +_require_xfs_io_command mwrite
> > +
> > +sector_size=3D`blockdev --getss $SCRATCH_DEV`
> > +page_size=3D$(get_page_size)
> > +block_size=3D$((page_size/2))
> > +
> > +if [ $sector_size -gt $block_size ];then
> > +    _notrun "need sector size < page size"
> > +fi
> > +
> > +unset MKFS_OPTIONS
> > +# For save time, 512MiB is enough to reproduce bug
> > +_scratch_mkfs_sized 536870912 $block_size >$seqres.full 2>&1
> > +
> > +# avoid the interference of XFS preallocation
> > +if [ "$FSTYP" =3D xfs ];then
> > +    MOUNT_OPTIONS=3D"$MOUNT_OPTIONS -o allocsize=3D$page_size"
> > +fi
>=20
> All these blocksize vs pagesize checks, mkfs with specific pagesize,
> adding allocsize mount option are not necessary. We want more test
> coverage even if the original bug can not be reproduced in such
> configurations, it's up to the test runner to specify the blocksize,
> mount options etc.

OK, as I said above, if we don't think about bug reproduce 100%, I can
let the tester decide to use what block size in MOUNT_OPTIONS.

>=20
> > +_scratch_mount
> > +
> > +# take one block size space
> > +dd if=3D/dev/zero of=3D$SCRATCH_MNT/testfile bs=3D$block_size count=3D=
1
> > >$seqres.full 2>&1
> > +# fill all free space
> > +dd if=3D/dev/zero of=3D$SCRATCH_MNT/full bs=3D$block_size >$seqres.f=
ull 2>&1
>=20
> We prefer $XFS_IO_PROG over dd in fstests. And please append (>>) the l=
og to
> $seqres.full not overwrite (>) the log.
>=20
> I'd recommend add an explicit "rm -f $seqres.full" and use ">>" to
> append the logs, so you don't have to worry when to use ">" and when to
> use ">>".

OK, I'll change dd to xfs_io pwrite.

>=20
> > +sync
> > +
> > +# truncate 0
> > +# pwrite -S 0x61 0 $block_size
> > +# mmap -rw -s $((page_size * 2)) 0 $block_size
> > +# mwrite -S 0x61 0 1  --> page_mkwrite() for index 0 is called
> > +# truncate $((page_size * 2))
> > +# mremap $((page_size * 2))
> > +# mwrite -S 0x61 $((page_size - 1)) 1  --> [bug] no page_mkwrite() c=
alled
> > +#
> > +# If there's a bug, the last step will be killed by SIGBUS, and it w=
on't
> > +# write a "0x61" on the disk.
>=20
> Please write a different char for the test, e.g. 0x62, so we can easily
> know that it's the test char.

Sure, I can do that:)

>=20
> > +#
> > +# Note: mremap maybe failed when memory load is heavy.
> > +$XFS_IO_PROG -f \
> > +	     -c "truncate 0" \
> > +	     -c "pwrite -S 0x61 0 $block_size" \
> > +	     -c "mmap -rw -s $((page_size * 2)) 0 $block_size" \
> > +	     -c "mwrite -S 0x61 0 1" \
> > +	     -c "truncate $((page_size * 2))" \
> > +	     -c "mremap $((page_size * 2))" \
> > +	     -c "mwrite -S 0x61 $((page_size - 1)) 1" \
> > +	     $SCRATCH_MNT/testfile | _filter_xfs_io
> > +
> > +# we will see 0x61 written by "mwrite -S 0x61 0 1"
> > +# we shouldn't see one more 0x61 by the last mwrite.
> > +hexdump -e '1/1 "%02x "' $SCRATCH_MNT/testfile
>=20
> I personally perfer od here :)

OK, I can't sure which one is better. Let me try to change it to od
if fstests like it.

Thanks,
Zorro

>=20
> Thanks,
> Eryu
>=20
> > +
> > +# success, all done
> > +status=3D0
> > +exit
> > diff --git a/tests/generic/352.out b/tests/generic/352.out
> > new file mode 100644
> > index 0000000..8be005d
> > --- /dev/null
> > +++ b/tests/generic/352.out
> > @@ -0,0 +1,3 @@
> > +QA output created by 352
> > +61 *
> > +00 *
> > diff --git a/tests/generic/group b/tests/generic/group
> > index 36fb759..7a72f6b 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -354,3 +354,4 @@
> >  349 blockdev quick rw
> >  350 blockdev quick rw
> >  351 blockdev quick rw
> > +352 auto quick
> > --
> > 2.5.5
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
