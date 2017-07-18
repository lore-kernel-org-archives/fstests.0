Received: from mx1.redhat.com ([209.132.183.28]:46328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750931AbdGREOk (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 18 Jul 2017 00:14:40 -0400
Date: Tue, 18 Jul 2017 12:14:38 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [xfstests PATCH v3] generic: add test of file mode when setfacl
 fails
Message-ID: <20170718041438.GT2478@eguan.usersys.redhat.com>
References: <20170714225506.GA4414@debian.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170714225506.GA4414@debian.home>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
Cc: fstests@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net, reiserfs-devel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jul 14, 2017 at 07:55:09PM -0300, Ernesto A. Fern=C3=A1ndez wrote=
:
> Check that the group permission bits of a file are not altered when set=
facl
> fails. At the time of this patch the test fails for at least ext2, ext4=
 and
> jfs.
>=20
> Note that this test is not meaningful for all filesystems, because some
> will still succeed in setting the acls. This does not mean they don't h=
ave
> a bug in how they would handle an error.
>=20
> Signed-off-by: Ernesto A. Fern=C3=A1ndez <ernesto.mnd.fernandez@gmail.c=
om>
> ---
> Changes in v3:
>   - Several fixes requested by Eryu Guan (thank you for your review), m=
ost
>     importantly:
>     - Place the jfs support in a separate patch, already sent.
>     - Make the test fail when the scratch device does not mount, so roo=
tfs
>       won't be filled.
>     - Add the test to auto and quick groups.
> Changes in v2:
>   - Use the scratch dev instead of the test dev so we can make a small =
fs and
>     fill it faster. As suggested by Christoph Hellwig.
>   - Make jfs work with _scratch_mkfs_sized, needed for the above.
>   - Remove the mention to an issue with reiserfs, since I now believe t=
he
>     problem is on their side.

Thanks for the update! But I had a second thought about what to do when
setfacl succeeded, please see below.

>=20
>  tests/generic/447     | 88 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/generic/447.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 91 insertions(+)
>  create mode 100755 tests/generic/447
>  create mode 100644 tests/generic/447.out
>=20
> diff --git a/tests/generic/447 b/tests/generic/447
> new file mode 100755
> index 0000000..c3062c8
> --- /dev/null
> +++ b/tests/generic/447
> @@ -0,0 +1,88 @@
> +#! /bin/bash
> +# FS QA Test 447
> +#
> +# Fill the device and set as many extended attributes to a file as
> +# possible. Then call setfacl on it and, if this fails for lack of
> +# space, test that the permissions remain the same.
> +#
> +#---------------------------------------------------------------------=
--
> +# Copyright (c) 2017 Ernesto A. Fernandez.  All Rights Reserved.
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#---------------------------------------------------------------------=
--
> +#
> +
> +seq=3D`basename $0`
> +seqres=3D$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=3D`pwd`
> +tmp=3D/tmp/$$
> +status=3D1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/attr
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +_require_test
> +_require_acls
> +_require_attrs
> +
> +_scratch_mkfs_sized $((50 * 1024 * 1024)) >> $seqres.full 2>&1
> +_scratch_mount || _fail "mount failed"
> +
> +TFILE=3D$SCRATCH_MNT/testfile.$seq
> +
> +# Create the test file and choose its permissions
> +touch $TFILE
> +chmod u+rwx $TFILE
> +chmod go-rwx $TFILE
> +
> +# Try to run out of space so setfacl will fail
> +$XFS_IO_PROG -c "pwrite 0 50m" $TFILE >>$seqres.full 2>&1
> +i=3D1
> +while setfattr -n user.$i $TFILE &>/dev/null; do
> +	((++i))
> +done
> +
> +if setfacl -m m:r $TFILE &>/dev/null; then
> +	# setfacl succeeded, so the test was meaningless
> +	# The filesystem might still have an issue
> +	status=3D0
> +	echo "-rwx------"
> +	exit

I think we should call _notrun here instead of making up the correct
output. If the test is meaningless, don't run it makes more sense to me.
e.g.

if setfacl -m m:r $TFILE &>/dev/null; then
	# setfacl succeeded, so the test was meaningless
	# The filesystem might still have an issue
	_notrun "<notrun reason here>"=09
fi

Sorry, I didn't bring this up in my first review..

Thanks,
Eryu

> +fi
> +
> +# Since setfacl failed, the permissions should not have changed
> +stat -c %A $TFILE
> +
> +status=3D0
> +exit
> diff --git a/tests/generic/447.out b/tests/generic/447.out
> new file mode 100644
> index 0000000..adec877
> --- /dev/null
> +++ b/tests/generic/447.out
> @@ -0,0 +1,2 @@
> +QA output created by 447
> +-rwx------
> diff --git a/tests/generic/group b/tests/generic/group
> index 8c1e21a..a3ec390 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -449,3 +449,4 @@
>  444 auto quick acl
>  445 auto quick rw
>  446 auto quick rw dangerous
> +447 auto quick acl
> --=20
> 2.1.4
>=20
