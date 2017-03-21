Received: from mx1.redhat.com ([209.132.183.28]:50780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755004AbdCUIoT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 21 Mar 2017 04:44:19 -0400
Date: Tue, 21 Mar 2017 16:44:11 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2 3/3] fstests: btrfs: Test inband dedupe with data
 balance.
Message-ID: <20170321084411.GX14226@eguan.usersys.redhat.com>
References: <20170316090851.21608-1-quwenruo@cn.fujitsu.com>
 <20170316090851.21608-4-quwenruo@cn.fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170316090851.21608-4-quwenruo@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 16, 2017 at 05:08:51PM +0800, Qu Wenruo wrote:
> Btrfs balance will reloate date extent, but its hash is removed too late
                     ^^^^^^^ relocate
> at run_delayed_ref() time, which will cause extent ref increased
> during balance, cause either find_data_references() gives WARN_ON()
> or even run_delayed_refs() fails and cause transaction abort.
>=20
> Add such concurrency test for inband dedupe and data balance.
>=20
> Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
> ---
>  tests/btrfs/202     | 109 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  tests/btrfs/202.out |   3 ++
>  tests/btrfs/group   |   1 +
>  3 files changed, 113 insertions(+)
>  create mode 100755 tests/btrfs/202
>  create mode 100644 tests/btrfs/202.out
>=20
> diff --git a/tests/btrfs/202 b/tests/btrfs/202
> new file mode 100755
> index 0000000..60bb924
> --- /dev/null
> +++ b/tests/btrfs/202
> @@ -0,0 +1,109 @@
> +#! /bin/bash
> +# FS QA Test 203
> +#
> +# Btrfs inband dedupe with balance concurrency test
> +#
> +# This can spot inband dedupe error which will increase delayed ref on
> +# an data extent inside RO block group
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2017 Fujitsu.  All Rights Reserved.
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
> +	kill $populate_pid &> /dev/null
> +	kill $balance_pid &> /dev/null
> +	wait
> +	# Check later comment for reason
> +	$BTRFS_UTIL_PROG balance cancel $SCRATCH_MNT &> /dev/null
> +	rm -f $tmp.*

I sometimes saw "btrfs balance start" hold $SCRATCH_MNT from umounting
and result in fs inconsistency after test. Some debug codes show that
the "btrfs balance start $SCRATCH_MNT" is still running. If I add what
btrfs/061 does:

        while ps aux | grep "balance start" | grep -qv grep; do=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                sleep 1=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
        done

test finishes fine. But btrfs-balance(8) says balance cancel should
block and wait for the backgroud balance process to finish. Seems like a
"balance cancel" bug?

Otherwise these three patches look fine to me overall, except the wanted
"dedupe feature check", and btrfs/200 is quick enough to fit in 'quick'
group.

I think the "dedupe feature check" should _notrun the tests if current
btrfs has incompatible features set, e.g. compress and/or nodatacow.

Thanks,
Eryu
--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3=
A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR=
8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=
=3DnWE-jTyw1r30et0l_N3AaUr-ObwCVWjbke3PEOdNLCM&s=3DhZq9UUBzZ-MIMAICK1qbDima=
NfIbO4S-cmSSyc8OsfA&e=3D=20
