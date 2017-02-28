Received: from mx1.redhat.com ([209.132.183.28]:60624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750957AbdB1INd (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 28 Feb 2017 03:13:33 -0500
Date: Tue, 28 Feb 2017 10:49:12 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/409: reflink concurrent operations
Message-ID: <20170228024912.GD16443@eguan.usersys.redhat.com>
References: <1487853054-3194-1-git-send-email-nave.vardy@plexistor.com>
 <20170224094706.GF24562@eguan.usersys.redhat.com>
 <1488205583.6778.34.camel@plexistor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1488205583.6778.34.camel@plexistor.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: nave vardy <nave.vardy@plexistor.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 27, 2017 at 04:26:23PM +0200, nave vardy wrote:
> On Fri, 2017-02-24 at 17:47 +0800, Eryu Guan wrote:
> > On Thu, Feb 23, 2017 at 02:30:54PM +0200, Nave Vardy wrote:
> > >=20
> > > reflink: concurrent operations test
> > >=20
> > > perform read operation on the target file while
> > > doing write or fpunch operations on the reflinks.
> > I'm having the same question as Darrick's, is this test reproducing
> > some
> > kind of bugs for you?
> Maybe it would be better if I'll first explain my motivation for
> sending the patch. I am working at Plexistor a company that develops a
> new file-system for persistent memory. The file-system supports cow,
> and we wrote some fstests, we thought to contribute for the community.
> For the test itself, it helped us to found a bug in the development of
> cow, no other generic test currently exists did.

Thanks a lot for writing new tests!

> >=20
> > >=20
> > >=20
> > > Signed-off-by: Nave Vardy <nave.vardy@plexistor.com>
> > > ---
> > > =C2=A0tests/generic/409=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 97
> > > +++++++++++++++++++++++++++++++++++++++++++++++++++
> > > =C2=A0tests/generic/409.out |=C2=A0=C2=A02 ++
> > > =C2=A0tests/generic/group=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A01 +
> > > =C2=A03 files changed, 100 insertions(+)
> > > =C2=A0create mode 100644 tests/generic/409
> > 0755 file mode for new test. This is done automatically if you use
> > "./new generic" to setup new test template.
> >=20
> In the next version of the patch I'll use this.
> > >=20
> > > =C2=A0create mode 100644 tests/generic/409.out
> > >=20
> > > diff --git a/tests/generic/409 b/tests/generic/409
> > > new file mode 100644
> > > index 0000000..eb1da13
> > > --- /dev/null
> > > +++ b/tests/generic/409
> > > @@ -0,0 +1,97 @@
> > > +#!/bin/bash
> > > +# FS QA Test No. 409
> > > +#
> > > +# test for races between write or fpunch operations on reflinked
> > > files
> > > +# to read operations on the targed file
> > > +#
> > > +#-----------------------------------------------------------------
> > > ------
> > > +#
> > > +# Copyright (c) 2017 Plexistor Ltd. All Rights Reserved.
> > > +#
> > > +# This program is free software; you can redistribute it and/or
> > > +# modify it under the terms of the GNU General Public License as
> > > +# published by the Free Software Foundation.
> > > +#
> > > +# This program is distributed in the hope that it would be useful,
> > > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0=C2=A0=
See the
> > > +# GNU General Public License for more details.
> > > +#
> > > +# You should have received a copy of the GNU General Public
> > > License
> > > +# along with this program; if not, write the Free Software
> > > Foundation,
> > > +# Inc.,=C2=A0=C2=A051 Franklin St, Fifth Floor, Boston, MA=C2=A0=C2=
=A002110-1301=C2=A0=C2=A0USA
> > > +#
> > > +#-----------------------------------------------------------------
> > > ------
> > > +
> > > +seq=3D`basename $0`
> > > +seqres=3D$RESULT_DIR/$seq
> > > +echo "QA output created by $seq"
> > > +
> > > +here=3D`pwd`
> > > +tmp=3D/tmp/$$
> > > +status=3D0=C2=A0=C2=A0=C2=A0=C2=A0# success is the default!
> > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > +
> > > +_cleanup()
> > > +{
> > > +	cd /
> > > +	rm -f $tmp.*
> > > +}
> > > +
> > > +# get standard environment, filters and checks
> > > +. ./common/rc
> > > +. ./common/reflink
> > > +
> > > +# remove previous $seqres.full before test
> > > +rm -f $seqres.full
> > > +
> > > +# real QA test starts here
> > > +_supported_fs generic
> > > +_supported_os Linux
> > > +_require_scratch_reflink
> > > +_require_cp_reflink
> > > +
> > > +_scratch_mkfs_sized $((400 * 1024 ** 2)) >> $seqres.full 2>&1 ||
> > > _fail "mkfs failed"
> > Same question on the filesystem size.
> >=20
> I used _scratch_mkfs_sized to avoid enospace in this scenario.=C2=A0
> I took a lager margin than I needed, which I can narrow down.
> The targted file is 10mb and I used 20 reflinks, because the tests
> writes the reflinks, in the end each will take place of max 10mb (it is
> not accurate because I use fpunch for every second block), so we have
> 21 files sum to max size of 210mb, so I think 250mb will be good
> enough.

Then I think, as Darrick suggested, _require_fs_space() is what you need.

> > >=20
> > > +_scratch_mount || _fail "mount failed"
> > > +
> > > +echo "Silence is golden"
> > > +
> > > +workfile=3D${SCRATCH_MNT}/workfile
> > > +light_clone=3D${SCRATCH_MNT}/light_clone
> > > +
> > > +file_size=3D$((10 * 1024 * 1024))
> > > +bs=3D4096
> I used 4096 because this is our file-system copy-on-write granularity,
> this is in order to get maximum effect. I'll be able to use
> _get_file_block_size().
> > > +block_num=3D$((file_size / bs))
> > > +reflinks_num=3D20
> > > +
> > > +$XFS_IO_PROG -f -c "pwrite 0 $file_size" $workfile >> $seqres.full
> > > +
> > > +#create all reflinkfs
> > > +for ((i=3D1; i<reflinks_num; i++));
> > > +do
> > > +	cp --reflink $workfile ${light_clone}_$i
> I'll change this to use _cp_reflink()
> > > +done
> > > +
> > > +#for each block simultaneously write to all reflinks
> > > +for ((block_index=3D0; block_index<block_num; block_index++));
> > > +do
> > > +	for ((i=3D0; i<reflinks_num; i++));
> > > +	do
> > > +		if [ $i -eq 0 ]; then
> > > +			$XFS_IO_PROG -c "pread $((block_index *
> > > bs)) $bs" \
> > > +						$workfile >>
> > > $seqres.full &
> > > +		elif [ $((block_index % 2)) -eq 0 ]; then
> > > +			$XFS_IO_PROG -c "pwrite $((block_index *
> > > bs)) $bs" \
> > > +					${light_clone}_$i=C2=A0=C2=A0>>
> > > $seqres.full &
> > > +		else
> > > +			$XFS_IO_PROG -c "fpunch $((block_index *
> > > bs)) $bs" \
> > > +					${light_clone}_$i >>
> > > $seqres.full &
> > > +		fi
> > I don't see much concurrency in this loop, for each block_index
> > there's
> > only one pread process and reflinks_num processes doing pwrite or
> > fpunch. Seems only pwrites are racing with pwrites and fpunchs are
> > racing with fpunchs. How about:
> >=20
> > for ((block_index=3D0; block_index<block_num; block_index++)); do
> > 	for ((i=3D0; i<reflinks_num; i++)); do
> > 		$XFS_IO_PROG -c "pread ..." ... &
> > 		if [ $((i % 2)) -eq 0 ]; then
> > 			$XFS_IO_PROG -c "pwrite ..." ... &
> > 		else
> > 			$XFS_IO_PROG -c "fpunch ..." ... &
> > 		fi
> > 	done
> > 	wait
> > done
> >=20
> > So for every pwrite or fpunch there's a pread racing with it. But
> > because I don't know if you're reproducing some specific bug with
> > this
> > loop, I'm not sure if my version still works.
> >=20
> I understand your comment and your suggestion, we interntionally didn't
> won't to modify the workfile so we just read it and race the pread with
> the pwrites of the reflinks (or the fpunchs). we wanted that all
> reflinks simultaneously will perform pwrite and in the next iteration
> fpunch (and not half reflinks pwrite and the other half fpunch - which
> is fine but describes another scenario). I think we can combine your
> suggestion with my version, to get more concurrency like this:

Looks reasonable, please add some comments to describe this workload.

>=20
> for ((block_index=3D0; block_index<block_num; block_index++)); do
> =C2=A0 =C2=A0 =C2=A0for ((i=3D0; i<reflinks_num; i++)); do

Perhaps we can start with i=3D1 then remove the "$i -ne 0" check?

Thanks,
Eryu

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $XFS_IO_PROG -c "pread $((block_inde=
x * 	bs)) $bs" \
> 					$workfile >> $seqres.full &
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ $i -ne 0 ]; then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ $((block_index % =
2)) -eq 0 ]; then
> 		=C2=A0 $XFS_IO_PROG -c "pwrite $((block_index * bs)) $bs" \ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ${light_clone}_$i >> $seqres.full &
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $XFS_IO_=
PROG -c "fpunch $((block_index * bs)) $bs" \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ${light_clone}_$i >>=
 $seqres.full &
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fi
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
> =C2=A0 =C2=A0 =C2=A0 =C2=A0wait
> =C2=A0 =C2=A0 =C2=A0 =C2=A0done
> done		=C2=A0
> > > +	wait
> > > +done
> > > +
> > > +# success, all done
> > > +status=3D0
> > > +exit
> > > diff --git a/tests/generic/409.out b/tests/generic/409.out
> > > new file mode 100644
> > > index 0000000..6f11537
> > > --- /dev/null
> > > +++ b/tests/generic/409.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 409
> > > +Silence is golden
> > > diff --git a/tests/generic/group b/tests/generic/group
> > > index d14f221..27ff229 100644
> > > --- a/tests/generic/group
> > > +++ b/tests/generic/group
> > > @@ -411,3 +411,4 @@
> > > =C2=A0406 auto quick dangerous
> > > =C2=A0407 auto quick clone metadata
> > > =C2=A0408 auto quick clone dedupe metadata
> > > +409 auto quick clone
> > If you decide to increase the concurrency/workload, probably the test
> > will not be quick enough to fit in quick group :)
> >=20
> It is not too important if it would only be in clone and auto
> > Thanks,
> > Eryu
> >=20
> > >=20
