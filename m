Received: from mx3-phx2.redhat.com ([209.132.183.24]:60600 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbbLKB5k convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 10 Dec 2015 20:57:40 -0500
Date: Thu, 10 Dec 2015 20:57:37 -0500 (EST)
From: Zirong Lang <zlang@redhat.com>
Message-ID: <631400252.34951936.1449799057601.JavaMail.zimbra@redhat.com>
In-Reply-To: <5669BAB3.7040507@sandeen.net>
References: <1449681026-4469-1-git-send-email-zlang@redhat.com> <5669BAB3.7040507@sandeen.net>
Subject: Re: [PATCH 1/2] xfs/133: test project quota name beginning with
 digits
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eric Sandeen <sandeen@sandeen.net>
Cc: fstests@vger.kernel.org, eguan@redhat.com, sandeen@redhat.com
List-ID: <fstests@vger.kernel.org>



----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: "Eric Sandeen" <sandeen@sandeen.net>
> =E6=94=B6=E4=BB=B6=E4=BA=BA: "Zorro Lang" <zlang@redhat.com>, fstests@v=
ger.kernel.org
> =E6=8A=84=E9=80=81: eguan@redhat.com, sandeen@redhat.com
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E4=BA=94, 2015=
=E5=B9=B4 12 =E6=9C=88 11=E6=97=A5 =E4=B8=8A=E5=8D=88 1:47:31
> =E4=B8=BB=E9=A2=98: Re: [PATCH 1/2] xfs/133: test project quota name be=
ginning with digits
>=20
>=20
>=20
> On 12/9/15 11:10 AM, Zorro Lang wrote:
> > There's a known bug of xfsprogs, when a project name beinning with
> > digits, it can't be found by run xfs_quota 'quota -p -v ...' command.
> >=20
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
>=20
> Looks fine to me; however I get a failure that I didn't expect:
>=20
> Query project=3D123456-project Failed
> _check_xfs_filesystem: filesystem on /dev/sdb2 is inconsistent
> ...
> disconnected inode 132, would move to lost+found
> Phase 7 - verify link counts...
>=20
> Is that failure expected?

Thanks for your review:)

There's a known bug on RHEL-6.7, but it has been fixed on kernel of RHEL-=
6.8 by me.
It's an upstream patch: dfcc70a8c868fe03276fa59864149708fb41930b.

I don't know if you tested on RHEL-6.7? More details please check our bug=
 1214185.
If your failure is different with that, please show more messages about y=
our bug.

Thanks,
Zorro


>=20
> > ---
> >  tests/xfs/133     | 101
> >  ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/133.out |   1 +
> >  tests/xfs/group   |   1 +
> >  3 files changed, 103 insertions(+)
> >  create mode 100755 tests/xfs/133
> >  create mode 100644 tests/xfs/133.out
> >=20
> > diff --git a/tests/xfs/133 b/tests/xfs/133
> > new file mode 100755
> > index 0000000..330221f
> > --- /dev/null
> > +++ b/tests/xfs/133
> > @@ -0,0 +1,101 @@
> > +#! /bin/bash
> > +# FS QA Test 133
> > +#
> > +# Test xfs_quota when project names beginning with digits.
> > +#
> > +#-------------------------------------------------------------------=
----
> > +# Copyright (c) 2015 Red Hat Inc.  All Rights Reserved.
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
> > +qa_user=3D""
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
> > +_supported_fs xfs
> > +_supported_os Linux
> > +_require_scratch
> > +_require_xfs_quota
> > +
> > +_scratch_mkfs_xfs >/dev/null 2>&1
> > +
> > +do_project_test()
> > +{
> > +	local qa_project=3D123456-project
> > +	local dir=3D$SCRATCH_MNT/project
> > +
> > +	mkdir $dir 2>/dev/null
> > +
> > +	#project quota files
> > +	cat >$tmp.projects <<EOF
> > +10:$dir
> > +EOF
> > +
> > +	cat >$tmp.projid <<EOF
> > +$qa_project:10
> > +EOF
> > +
> > +	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> > +		-c "project -s $qa_project" $SCRATCH_MNT >>$seqres.full 2>&1
> > +	[ $? -ne 0 ] && _fail "Initalize project=3D$qa_project Failed"
> > +
> > +	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> > +		-c "limit -p bsoft=3D100m bhard=3D200m $qa_project" $SCRATCH_MNT
> > >>$seqres.full 2>&1
> > +	[ $? -ne 0 ] && _fail "Create limit for project=3D$qa_project Faile=
d"
> > +
> > +	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> > +		-c "quota -p -v $qa_project" $SCRATCH_MNT 2>>$seqres.full | grep -=
qw
> > $qa_project
> > +	[ $? -ne 0 ] && _fail "Query project=3D$qa_project Failed"
> > +
> > +	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> > +		-c "report -p" $SCRATCH_MNT 2>>$seqres.full | grep -qw $qa_project
> > +	[ $? -ne 0 ] && _fail "Report project=3D$qa_project Failed"
> > +
> > +	return 0
> > +}
> > +
> > +# Test project
> > +_qmount_option "uquota,pquota"
> > +_qmount
> > +_require_prjquota $SCRATCH_DEV
> > +do_project_test
> > +
> > +# success, all done
> > +status=3D0
> > +exit
> > diff --git a/tests/xfs/133.out b/tests/xfs/133.out
> > new file mode 100644
> > index 0000000..189cb69
> > --- /dev/null
> > +++ b/tests/xfs/133.out
> > @@ -0,0 +1 @@
> > +QA output created by 133
> > diff --git a/tests/xfs/group b/tests/xfs/group
> > index 9884329..bae09de 100644
> > --- a/tests/xfs/group
> > +++ b/tests/xfs/group
> > @@ -130,6 +130,7 @@
> >  130 fuzzers
> >  131 auto quick clone
> >  132 auto quick clone
> > +133 auto quick quota
> >  134 quota auto quick
> >  136 attr2
> >  142 dmapi
> >=20
>=20
