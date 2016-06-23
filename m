Received: from mx1.redhat.com ([209.132.183.28]:38979 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750954AbcFWJvz (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 23 Jun 2016 05:51:55 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1F4E2641
	for <fstests@vger.kernel.org>; Thu, 23 Jun 2016 09:51:54 +0000 (UTC)
Date: Thu, 23 Jun 2016 17:51:53 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v6 1/3] generic/352-360: Add richacl tests
Message-ID: <20160623095153.GG3226@eguan.usersys.redhat.com>
References: <1464725931-27588-1-git-send-email-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1464725931-27588-1-git-send-email-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, May 31, 2016 at 10:18:49PM +0200, Andreas Gruenbacher wrote:
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

[I'm reviewing from the fstests perspective]

> ---
>  common/rc             |  61 ++++++++++++++++++++++
>  tests/generic/352     | 122 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/352.out |  94 +++++++++++++++++++++++++++++++++
>  tests/generic/353     | 114 ++++++++++++++++++++++++++++++++++++++++
>  tests/generic/353.out | 140 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/354     |  95 ++++++++++++++++++++++++++++++++++
>  tests/generic/354.out |  39 ++++++++++++++
>  tests/generic/355     |  83 ++++++++++++++++++++++++++++++
>  tests/generic/355.out |   9 ++++
>  tests/generic/356     |  82 +++++++++++++++++++++++++++++
>  tests/generic/356.out |  11 ++++
>  tests/generic/357     |  81 +++++++++++++++++++++++++++++
>  tests/generic/357.out |  11 ++++
>  tests/generic/358     |  81 +++++++++++++++++++++++++++++
>  tests/generic/358.out |   7 +++
>  tests/generic/359     | 122 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/359.out |  24 +++++++++
>  tests/generic/360     |  86 +++++++++++++++++++++++++++++++
>  tests/generic/360.out |  19 +++++++
>  tests/generic/group   |   9 ++++
>  20 files changed, 1290 insertions(+)
>  create mode 100755 tests/generic/352
>  create mode 100644 tests/generic/352.out
>  create mode 100755 tests/generic/353
>  create mode 100644 tests/generic/353.out
>  create mode 100755 tests/generic/354
>  create mode 100644 tests/generic/354.out
>  create mode 100755 tests/generic/355
>  create mode 100644 tests/generic/355.out
>  create mode 100755 tests/generic/356
>  create mode 100644 tests/generic/356.out
>  create mode 100755 tests/generic/357
>  create mode 100644 tests/generic/357.out
>  create mode 100755 tests/generic/358
>  create mode 100644 tests/generic/358.out
>  create mode 100755 tests/generic/359
>  create mode 100644 tests/generic/359.out
>  create mode 100755 tests/generic/360
>  create mode 100644 tests/generic/360.out
> 
> diff --git a/common/rc b/common/rc
> index 51092a0..ab7d54d 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1989,6 +1989,67 @@ _require_seek_data_hole()
>          _notrun "File system does not support llseek(2) SEEK_DATA/HOLE"
>  }
>  
> +_require_runas()
> +{
> +	[ -x "$here/src/runas" ] \
> +		|| _notrun "$here/src/runas executable not found"
> +}

This can be simplified as:

	_require_runas()
	{
		_require_test_program "runas"
	}

Or calling '_require_test_program "runas"' directly is good enough to me.

> +
> +runas()

Add "_" prefix to common helper functions? i.e. _runas()

> +{
> +	"$here/src/runas" "$@"
> +}
> +
> +_require_richacl_prog()
> +{
> +	GETRICHACL_PROG=`set_prog_path getrichacl`
> +	_require_command "$GETRICHACL_PROG" getrichacl
> +	SETRICHACL_PROG=`set_prog_path setrichacl`
> +	_require_command "$SETRICHACL_PROG" setrichacl

Set GETRICHACL_PROG and SETRICHACL_PROG in common/config, they don't
belong to here. Only two _require_command needed in this helper.

> +}
> +
> +_require_scratch_richacl_xfs()
> +{
> +	_scratch_mkfs_xfs_supported -m richacl=1 >/dev/null 2>&1 \
> +		|| _notrun "mkfs.xfs doesn't have richacl feature"
> +	_scratch_mkfs_xfs -m richacl=1 >/dev/null 2>&1
> +	_scratch_mount >/dev/null 2>&1 \
> +		|| _notrun "kernel doesn't support richacl feature on $FSTYP"
> +	_scratch_unmount
> +}
> +
> +_require_scratch_richacl_ext4()
> +{
> +	_scratch_mkfs -O richacl >/dev/null 2>&1 \
> +		|| _notrun "can't mkfs $FSTYP with option -O richacl"
> +	_scratch_mount >/dev/null 2>&1 \
> +		|| _notrun "kernel doesn't support richacl feature on $FSTYP"
> +	_scratch_unmount
> +}
> +
> +_require_scratch_richacl()
> +{
> +	case "$FSTYP" in
> +	xfs)    _require_scratch_richacl_xfs
> +		;;
> +	ext4)   _require_scratch_richacl_ext4
> +		;;
> +	*)      _notrun "this test requires richacl support on \$SCRATCH_DEV"
> +		;;
> +	esac
> +}
> +
> +_scratch_mkfs_richacl()
> +{
> +	_require_scratch

Tests that call _scratch_mkfs_richacl should call _require_scratch
first, we do all the '_require_xxx' check before doing the actual test.

> +	case "$FSTYP" in
> +	xfs)    _scratch_mkfs_xfs -m richacl=1
> +		;;
> +	ext4)   _scratch_mkfs -O richacl
> +		;;
> +	esac
> +}
> +
>  # check that a FS on a device is mounted
>  # if so, return mount point
>  #
> diff --git a/tests/generic/352 b/tests/generic/352
> new file mode 100755
> index 0000000..0f32ee5
> --- /dev/null
> +++ b/tests/generic/352
> @@ -0,0 +1,122 @@
> +#! /bin/bash
> +# FS QA Test 352
> +#
> +# RichACL apply-masks test
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
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
> +#-----------------------------------------------------------------------
> +#
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
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
> +
> +# real QA test starts here
> +
> +_supported_fs generic
> +_supported_os Linux
> +
> +_require_scratch
> +_require_scratch_richacl
> +_require_richacl_prog
> +
> +_scratch_mkfs_richacl >> $seqres.full

$seqres.full should be removed or truncated before appending logs to it,
otherwise it's accumulating logs over time.

> +_scratch_mount
> +
> +cd $SCRATCH_MNT
> +
> +touch x
> +setrichacl --set 'owner@:rwp::allow group@:rwp::allow everyone@:r::allow' x
> +getrichacl x

$SETRICHACL_PROG and $GETRICHACL_PROG in the tests, you have them set :)
I think one of the advantages is that we can do tweaks in $XXX_PROG if
needed, as what we do to XFS_IO_PROG, we append "-F" option to it when
needed, so we don't have to update all bare xfs_io calls.

Thanks,
Eryu
