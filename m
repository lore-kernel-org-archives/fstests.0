Received: from aserp2130.oracle.com ([141.146.126.79]:56616 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbfDYCKk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 24 Apr 2019 22:10:40 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH v2] btrfs: fix filtering of scratch device in test case
 048
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20190425003709.28749-1-fdmanana@kernel.org>
Date: Thu, 25 Apr 2019 10:10:05 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <53BDA8EF-BB7A-4F6C-9129-EB1979D01D81@oracle.com>
References: <20190425002457.28648-1-fdmanana@kernel.org>
 <20190425003709.28749-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>


> On 25 Apr 2019, at 8:37 AM, fdmanana@kernel.org wrote:
>=20
> From: Filipe Manana <fdmanana@suse.com>
>=20
> The recent commit 4529b20e1aa8f9 ("btrfs/048: amend property =
validation
> cases"), does not properly filter the scratch device because the error
> messages are sent to stderr and not to stdout, and the pipe filter =
only
> gets input from the stdout of the btrfs utility. We need to redirect =
the
> stderr of the btrfs utility to its stdout.
>=20
> Further, the golden output had the path "/mnt/scratch" hardcoded, =
instead
> of using SCRATCH_MNT. Fix that as well.
>=20
> The test was failing on any setup where the scratch device is not =
mounted
> at "/mnt/scratch".
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Thanks!

Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
>=20
> V2: Fix the formatting of the patch, which was causing git apply / =
path to fail.
>=20
> tests/btrfs/048     | 10 +++++-----
> tests/btrfs/048.out | 10 +++++-----
> 2 files changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/tests/btrfs/048 b/tests/btrfs/048
> index f6de0b8c..8bb10a90 100755
> --- a/tests/btrfs/048
> +++ b/tests/btrfs/048
> @@ -208,21 +208,21 @@ touch $SCRATCH_MNT/sv1/file2
> $BTRFS_UTIL_PROG property get $SCRATCH_MNT/sv1/file2 compression
>=20
> echo -e "\nTesting argument validation, should fail"
> -$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'lz' | =
_filter_scratch
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'lz' 2>&1 | =
_filter_scratch
> echo "***"
> -$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zli' | =
_filter_scratch
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zli' 2>&1 | =
_filter_scratch
> echo "***"
> -$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zst' | =
_filter_scratch
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zst' 2>&1 | =
_filter_scratch
>=20
> echo -e "\nTesting if property is persistent across failed validation"
> $BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'lzo'
> -$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zli' | =
_filter_scratch
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zli' 2>&1 | =
_filter_scratch
> $BTRFS_UTIL_PROG property get $SCRATCH_MNT compression
>=20
> echo -e "\nTesting generation is unchanged after failed validation"
> $BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
> $BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep =
'^generation'
> -$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'lz' | =
_filter_scratch
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'lz' 2>&1 | =
_filter_scratch
> $BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
> $BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep =
'^generation'
>=20
> diff --git a/tests/btrfs/048.out b/tests/btrfs/048.out
> index 00f39bc0..16a785a6 100644
> --- a/tests/btrfs/048.out
> +++ b/tests/btrfs/048.out
> @@ -78,17 +78,17 @@ compression=3Dlzo
> compression=3Dlzo
>=20
> Testing argument validation, should fail
> -ERROR: failed to set compression for /mnt/scratch: Invalid argument
> +ERROR: failed to set compression for SCRATCH_MNT: Invalid argument
> ***
> -ERROR: failed to set compression for /mnt/scratch: Invalid argument
> +ERROR: failed to set compression for SCRATCH_MNT: Invalid argument
> ***
> -ERROR: failed to set compression for /mnt/scratch: Invalid argument
> +ERROR: failed to set compression for SCRATCH_MNT: Invalid argument
>=20
> Testing if property is persistent across failed validation
> -ERROR: failed to set compression for /mnt/scratch: Invalid argument
> +ERROR: failed to set compression for SCRATCH_MNT: Invalid argument
> compression=3Dlzo
>=20
> Testing generation is unchanged after failed validation
> generation		7
> -ERROR: failed to set compression for /mnt/scratch: Invalid argument
> +ERROR: failed to set compression for SCRATCH_MNT: Invalid argument
> generation		7
> --=20
> 2.11.0
>=20
