Received: from mx2.suse.de ([195.135.220.15]:42758 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726896AbfCSLE0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 19 Mar 2019 07:04:26 -0400
Subject: Re: [PATCH] btrfs: Extend btrfs/003 device removal test
References: <20190319105842.9227-1-nborisov@suse.com>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <30507ca4-dcf4-86be-123e-ef6445f74d77@suse.com>
Date: Tue, 19 Mar 2019 13:04:23 +0200
MIME-Version: 1.0
In-Reply-To: <20190319105842.9227-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, guaneryu@gmail.com
List-ID: <fstests@vger.kernel.org>



On 19.03.19 =D0=B3. 12:58 =D1=87., Nikolay Borisov wrote:
> When a device is deleted/removed from a btrfs filesystem the kernel
> ensures all superblocks on said device are zeroed out. Test for this
> behavior. Since btrfs inspect-internal dump-super always return success
> I cannot test for the return value of the command. Instead there are 2
> cases to handle:
>=20
>     1. When the device is smaller than the requested super block copy, =
i.e.
>     super block copy 2 resides at 256GB. In such cases btrfs command ju=
st
>     returns blank screen
>=20
>     2. When the device is removed and a valid offset of the super block=
 is
>     queried btrfs command returns a textual error to stderr.
>=20
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---

Disregard this version and check v2.

>  tests/btrfs/003 | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/tests/btrfs/003 b/tests/btrfs/003
> index 22aa57aad0b9..938030ef4c65 100755
> --- a/tests/btrfs/003
> +++ b/tests/btrfs/003
> @@ -161,6 +161,13 @@ _test_remove()
>  	dev_del=3D`echo ${SCRATCH_DEV_POOL} | awk '{print $NF}'`
>  	$BTRFS_UTIL_PROG device delete $dev_del $SCRATCH_MNT || _fail "btrfs =
device delete failed"
>  	$BTRFS_UTIL_PROG filesystem show $SCRATCH_DEV 2>&1 | grep $dev_del >>=
 $seqres.full && _fail "btrfs still shows the deleted dev"
> +	for i in {0..2}; do
> +		local output=3D$($BTRFS_UTIL_PROG inspect-internal dump-super -s $i =
$dev_del 2>&1)
> +		$BTRFS_UTIL_PROG inspect-internal dump-super -s $i $dev_del 2>&1 | g=
rep -q "bad magic"
> +		if [[ "$output" !=3D "" && $ret -eq 1 ]]; then
> +			_fail "Delete dev superblocks not scratched"
> +		fi
> +	done
>  	_scratch_unmount
>  }
> =20
>=20
