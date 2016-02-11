Received: from mx3-phx2.redhat.com ([209.132.183.24]:54549 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbcBKFTW convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 11 Feb 2016 00:19:22 -0500
Date: Thu, 11 Feb 2016 00:19:22 -0500 (EST)
From: Zirong Lang <zlang@redhat.com>
Message-ID: <1081786358.16844363.1455167962197.JavaMail.zimbra@redhat.com>
In-Reply-To: <20160210160031.GY11419@eguan.usersys.redhat.com>
References: <1455046322-9887-1-git-send-email-zlang@redhat.com> <20160210160031.GY11419@eguan.usersys.redhat.com>
Subject: Re: [PATCH] xfs/169: new case for test default quota lower than
 specific quota
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, sandeen@redhat.com, cmaiolino@redhat.com
List-ID: <fstests@vger.kernel.org>



----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: "Eryu Guan" <eguan@redhat.com>
> =E6=94=B6=E4=BB=B6=E4=BA=BA: "Zorro Lang" <zlang@redhat.com>
> =E6=8A=84=E9=80=81: fstests@vger.kernel.org, sandeen@redhat.com, cmaiol=
ino@redhat.com
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E5=9B=9B, 2016=
=E5=B9=B4 2 =E6=9C=88 11=E6=97=A5 =E4=B8=8A=E5=8D=88 12:00:31
> =E4=B8=BB=E9=A2=98: Re: [PATCH] xfs/169: new case for test default quot=
a lower than specific quota
>=20
> On Wed, Feb 10, 2016 at 03:32:02AM +0800, Zorro Lang wrote:
> > There's a bug for xfs_quota. After mount with uquota,gquota, If
> > set the user/group default quota lower than specific user/group
> > quota, the specific quota can't work well.
>=20
> This description is not so clear to me, and ...
> >=20
> > This bug have an upstream patch:
> >   xfs: Split default quota limits by quota type
>=20
> the commit log in this patch looks much better :) Can you please rewrit=
e
> the description?
>=20
> And there's no need to include test number for new test, the number can
> be changed in commit time. Something like:
>=20
> "xfs: new case for ..."
>=20
> is fine.

Sure, I'm rewriting V2 patch, and will change the commit log.

>=20
> >=20
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> >  tests/xfs/169     | 151
> >  ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/169.out |   5 ++
> >  tests/xfs/group   |   1 +
> >  3 files changed, 157 insertions(+)
> >  create mode 100755 tests/xfs/169
> >  create mode 100644 tests/xfs/169.out
> >=20
> > diff --git a/tests/xfs/169 b/tests/xfs/169
> > new file mode 100755
> > index 0000000..11f33e7
> > --- /dev/null
> > +++ b/tests/xfs/169
> > @@ -0,0 +1,151 @@
> > +#! /bin/bash
> > +# FS QA Test 169
> > +#
> > +# This case for a bug about xfs default quota, after mount with
> > +# uquota,gquota, if the default quota lower than specific quota,
> > +# the specific quota can't work.
> > +
>=20
> Need a "#" in this line.
>=20
> > +# An upstream patch for fix this bug:
> > +#
> > +#   [PATCH] xfs: Split default quota limits by quota type V4
> > +#
> > +#-------------------------------------------------------------------=
----
> > +# Copyright (c) 2016 YOUR NAME HERE.  All Rights Reserved.
>=20
> Replace "YOUR NAME HERE." by "Red Hat Inc."

Wow, I missed that :-P

>=20
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
> > +. ./common/quota
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
>=20
> The empty line and above comment is not needed anymore.
>=20
> > +_supported_fs xfs
> > +_supported_os Linux
> > +_require_scratch
> > +_require_quota
> > +
> > +_require_user fsgqa
> > +_require_group fsgqa
>=20
> fsgqa is the default required user and group in _require_user and
> _require_group, no need to pass fsgqa as argument.

Yes, you're right. I added parameter to _require_user and _require_group,=
 but I
forgot fsgqa is as default.

>=20
> > +
> > +do_test()
> > +{
> > +	local qname=3D$1
> > +	local type
> > +	local rc=3D0
> > +
> > +	if [ "$qname" =3D "user" ]
> > +	then
>=20
> We use
>=20
> 	if [ ... ]; then
> 	elif [ ... ]; then
> 	else
> 	fi
> and
> 	for ... ; do
> 	done
>=20
> format in fstests.
OK, I'll follow this format.

>=20
> > +		type=3D"-u"
> > +	elif [ "$qname" =3D "group" ]
> > +	then
> > +		type=3D"-g"
> > +	else
> > +		_fail "wrong quota type name - $qname"
>=20
> No need to _fail, return is enough and test could continue.

OK. But I think that's not important, because this's an internal function=
,
only be used in this case. This case will not give wrong patameter to thi=
s
function. So use _fail or return 1, I think they're all fine.

>=20
> > +	fi
> > +
> > +	xfs_quota -x -c "limit bsoft=3D20M bhard=3D20M isoft=3D200 ihard=3D=
200 $type -d"
> > $SCRATCH_MNT >>$seqres.full 2>&1
>=20
> Replace all "xfs_quota" with $XFS_QUOTA_PROG

OK

>=20
> > +	[ $? -ne 0 ] && _fail "Can't set limit bsoft=3D20M bhard=3D20M isof=
t=3D200
> > ihard=3D200 $type -d to $SCRATCH_MNT"
> > +	DEF_BHARD=3D`xfs_quota -x -c "report $type -N -b" $SCRATCH_MNT | aw=
k
> > '/^root / {print $4}'`
> > +	DEF_IHARD=3D`xfs_quota -x -c "report $type -N -i" $SCRATCH_MNT | aw=
k
> > '/^root / {print $4}'`
> > +
> > +	xfs_quota -x -c "limit bsoft=3D40M bhard=3D40M isoft=3D400 ihard=3D=
400 $type
> > fsgqa" $SCRATCH_MNT >>$seqres.full 2>&1
> > +	[ $? -ne 0 ] && _fail "Can't set limit bsoft=3D40M bhard=3D40M isof=
t=3D400
> > ihard=3D400 $type fsgqa to $SCRATCH_MNT"
> > +	QA_BHARD=3D`xfs_quota -x -c "report $type -N -b" $SCRATCH_MNT | awk
> > '/^fsgqa / {print $4}'`
> > +	QA_IHARD=3D`xfs_quota -x -c "report $type -N -i" $SCRATCH_MNT | awk
> > '/^fsgqa / {print $4}'`
> > +
> > +	if [ "$QA_BHARD" =3D "$DEF_BHARD" -o "$QA_IHARD" =3D "$DEF_IHARD" ]
> > +	then
> > +		_fail "Fail to set specific quota to fsgqa"
> > +	fi
>=20
> You could print expected quota value to stdout and the golden image
> could catch any unexpected qouta value. So you don't need to detect for
> xfs_quota command failure nor xfs_quota -c report output.
>=20
> > +
> > +	## blocks default quota test ##
> > +	sudo -u fsgqa -s dd if=3D/dev/zero of=3D${SCRATCH_MNT}/data bs=3D1M=
 count=3D30
> > >>$seqres.full 2>&1
> > +	sync
>=20
> We already have helper _user_do, and we prefer xfs_io not dd, so
>=20
> 	_user_do "$XFS_IO_PROG -fc \"pwrite 0 30M\" -c \"fsync\" $SCRATCH_MNT/=
data"
> 	>>$seqres.full 2>&1

Oh, sorry I don't know this. I thought maybe someone function named "_sud=
o()", so I
tried to grep sudo, but find nothing:)

>=20
> > +
> > +	USED_B=3D`xfs_quota -x -c "report $type -N -b" $SCRATCH_MNT | awk '=
/^fsgqa
> > / {print $2}'`
> > +	if [ $USED_B -gt $DEF_BHARD -a $USED_B -le $QA_BHARD ]
> > +	then
> > +		echo "$qname blocks quota test pass"
> > +	else
> > +		rc=3D1
> > +		echo "$qname blocks quota test fail"
> > +	fi
>=20
> The block check can also be done by the golden image.

Yeah, that's a good idea.

>=20
> > +
> > +	rm -f ${SCRATCH_MNT}/data >/dev/null 2>&1
> > +
> > +	## inode default quota test ##
> > +	for ((i=3D0; i<300; i++))
> > +	do
> > +		sudo -u fsgqa -s touch ${SCRATCH_MNT}/file${i} >>$seqres.full 2>&1
>=20
> "echo -n >$SCRATCH_MNT/file$i" is much faster to create new empty file

If use "echo", I should write "bash -c "echo -n >$SCRATCH_MNT/file$i"". O=
r these
files will created by root.

I feel create 300 files is not heavy workload, so "touch" is not so bad.

>=20
> > +	done
> > +	sync
> > +
> > +	USED_I=3D`xfs_quota -x -c "report $type -N -i" $SCRATCH_MNT | awk '=
/^fsgqa
> > / {print $2}'`
> > +	if [ $USED_I -gt $DEF_IHARD -a $USED_I -le $QA_IHARD ]
> > +	then
> > +		echo "$qname inode quota test pass"
> > +	else
> > +		rc=3D1
> > +		echo "$qname inode quota test fail"
> > +	fi
>=20
> Here too, use golden image.
>=20
> > +
> > +	rm -f ${SCRATCH_MNT}/file* >/dev/null 2>&1
> > +
> > +	return $rc
> > +}
> > +
> > +### user default quota test ###
> > +_scratch_mkfs_xfs >/dev/null 2>&1
> > +PAGESIZE=3D`src/feature -s`
> > +_qmount_option "uquota,gquota,allocsize=3D$PAGESIZE"
> > +_qmount
> > +chmod ugo+rwx $SCRATCH_MNT
>=20
> The chmod part is done in _qmount

Oh, yes, _qmount really do that:)

>=20
> > +
> > +do_test user || exit
>=20
> Continue the test, don't exit.

OK.

>=20
> > +
> > +### group default quota test ###
> > +umount $SCRATCH_MNT
>=20
> _scratch_unmount
>=20
> > +_scratch_mkfs_xfs >/dev/null 2>&1
> > +_qmount_option "gquota,uquota,allocsize=3D$PAGESIZE"
> > +_qmount
> > +chmod ugo+rwx $SCRATCH_MNT
> > +
> > +do_test group || exit
>=20
> Here too, remove chmod call and continue the test on failure.
>=20
> Thanks,
> Eryu

Thanks for your review. I'll send V2 later.

Thansk,
Zorro

>=20
> > +
> > +# success, all done
> > +status=3D0
> > +exit
> > diff --git a/tests/xfs/169.out b/tests/xfs/169.out
> > new file mode 100644
> > index 0000000..0d81280
> > --- /dev/null
> > +++ b/tests/xfs/169.out
> > @@ -0,0 +1,5 @@
> > +QA output created by 169
> > +user blocks quota test pass
> > +user inode quota test pass
> > +group blocks quota test pass
> > +group inode quota test pass
> > diff --git a/tests/xfs/group b/tests/xfs/group
> > index 2db3520..ffaca65 100644
> > --- a/tests/xfs/group
> > +++ b/tests/xfs/group
> > @@ -166,6 +166,7 @@
> >  166 rw metadata auto quick
> >  167 rw metadata auto stress
> >  168 dmapi
> > +169 auto quick quota
> >  170 rw filestreams auto quick
> >  171 rw filestreams
> >  172 rw filestreams
> > --
> > 1.9.3
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
