Received: from mout.gmx.net ([212.227.15.19]:60775 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfBLFOQ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 12 Feb 2019 00:14:16 -0500
Subject: Re: [PATCH v2 2/2] fstests: btrfs: Introduce stress test for deadlock
 between snapshot delete and other read-write operations
References: <20190111050151.982-1-wqu@suse.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <bd51a34e-0d80-0e89-36cd-6256c77067ab@gmx.com>
Date: Tue, 12 Feb 2019 13:14:02 +0800
MIME-Version: 1.0
In-Reply-To: <20190111050151.982-1-wqu@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LJ9UnL0qn6DAFhjE1rnPeyP9K9As3mS52"
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LJ9UnL0qn6DAFhjE1rnPeyP9K9As3mS52
Content-Type: multipart/mixed; boundary="QLIxW8TzNEsBG8VbJJIALFeiDYuDWh1wT";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 fstests@vger.kernel.org
Message-ID: <bd51a34e-0d80-0e89-36cd-6256c77067ab@gmx.com>
Subject: Re: [PATCH v2 2/2] fstests: btrfs: Introduce stress test for deadlock
 between snapshot delete and other read-write operations
References: <20190111050151.982-1-wqu@suse.com>
In-Reply-To: <20190111050151.982-1-wqu@suse.com>

--QLIxW8TzNEsBG8VbJJIALFeiDYuDWh1wT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/1/11 =E4=B8=8B=E5=8D=881:01, Qu Wenruo wrote:
[snip]
> +# FS QA Test 179
> +#
> +# Test if btrfs will lockup at subvolume deletion when qgroups are ena=
bled.
> +#
> +# This bug is going to be fixed by a patch for the kernel titled
> +# "btrfs: qgroup: Don't trigger backref walk at delayed ref insert tim=
e".

Although the test case is already merged, btrfs community is going to
use a much better fix than this.

Should I update the patch in this test case after the fix get merged
upstream?

Thanks,
Qu

> +#
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
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch
> +
> +# default sleep interval
> +sleep_time=3D1
> +
> +# stress test runtime
> +runtime=3D120
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +
> +mkdir -p "$SCRATCH_MNT/snapshots"
> +$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/src" > /dev/null
> +$BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT" > /dev/null
> +$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" > /dev/null
> +
> +fill_workload()
> +{
> +	trap "wait; exit" SIGTERM
> +	local i=3D0
> +	while true; do
> +		_pwrite_byte 0xcd 0 8K "$SCRATCH_MNT/src/large_$i" > /dev/null
> +		_pwrite_byte 0xcd 0 2K "$SCRATCH_MNT/src/inline_$i" > /dev/null
> +
> +		# Randomly remove some files for every 5 loop
> +		if [ $(( $i % 5 )) -eq 0 ]; then
> +			victim=3D$(ls "$SCRATCH_MNT/src" | sort -R | head -n1)
> +			rm "$SCRATCH_MNT/src/$victim"
> +		fi
> +		i=3D$((i + 1))
> +	done
> +}
> +
> +snapshot_workload()
> +{
> +	trap "wait; exit" SIGTERM
> +	local i=3D0
> +	while true; do
> +		sleep $sleep_time
> +		$BTRFS_UTIL_PROG subvolume snapshot "$SCRATCH_MNT/src" \
> +			"$SCRATCH_MNT/snapshots/$i" > /dev/null
> +		i=3D$((i + 1))
> +	done
> +}
> +
> +delete_workload()
> +{
> +	trap "wait; exit" SIGTERM
> +	while true; do
> +		sleep $((sleep_time * 2))
> +		victim=3D$(ls "$SCRATCH_MNT/snapshots" | sort -R | head -n1)
> +		$BTRFS_UTIL_PROG subvolume delete \
> +			"$SCRATCH_MNT/snapshots/$victim" > /dev/null
> +	done
> +}
> +
> +fill_workload &
> +fill_pid=3D$!
> +
> +sleep $((sleep_time * 2))
> +snapshot_workload &
> +snapshot_pid=3D$!
> +delete_workload &
> +delete_pid=3D$!
> +
> +sleep $runtime
> +kill $fill_pid
> +wait $fill_pid
> +kill $snapshot_pid
> +wait $snapshot_pid
> +kill $delete_pid
> +wait $delete_pid
> +
> +# success, all done
> +echo "Silence is golden"
> +
> +status=3D0
> +exit
> diff --git a/tests/btrfs/179.out b/tests/btrfs/179.out
> new file mode 100644
> index 000000000000..cb9eba3d34b1
> --- /dev/null
> +++ b/tests/btrfs/179.out
> @@ -0,0 +1,2 @@
> +QA output created by 179
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 04c0254aa4bf..46dd3c9523c2 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -181,3 +181,4 @@
>  176 auto quick swap volume
>  177 auto quick swap balance
>  178 auto quick send
> +179 auto qgroup dangerous
>=20


--QLIxW8TzNEsBG8VbJJIALFeiDYuDWh1wT--

--LJ9UnL0qn6DAFhjE1rnPeyP9K9As3mS52
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlxiVhoACgkQwj2R86El
/qhqHQf9GAet+YICcPUI4omZXsV0eRoEQGwUiku2ds371XcGqP5ckaOkH1bBYyLY
D65+wrW1a1HSBlI0poZFc2p8wA/BGcDMOAv+j8Dr67Sx2oSw+kJKNFl958vsQUjz
6TL3tmb461I6U2KEQwbyRBH892f6XXzf/lDa1WEpydKEd5MAygnzwiCH1Q1SQF6L
/jShdnlFMgxXY/wOtAf0K5p1EFecra4tvhQbcRmToGpscsAGrghyf7DB6fpLppFj
HwvFS/OW0P/YgkscQXJMTcKubLBg97G/eoyOfrLBeu/bWRaZjx+9BlyjozALdxwJ
ZGm/YkUuYGj8WK16rclyte5Tbms3Iw==
=dgxw
-----END PGP SIGNATURE-----

--LJ9UnL0qn6DAFhjE1rnPeyP9K9As3mS52--
