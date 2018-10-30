Received: from mx2.suse.de ([195.135.220.15]:51424 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726225AbeJ3SxO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 30 Oct 2018 14:53:14 -0400
Subject: Re: [PATCH v2] fstests: btrfs/057: Fix false alerts due to orphan
 files
References: <20181030090711.10833-1-wqu@suse.com>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <b202ff2e-a74c-5a19-eeda-ebe14e105c3f@suse.com>
Date: Tue, 30 Oct 2018 12:00:24 +0200
MIME-Version: 1.0
In-Reply-To: <20181030090711.10833-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 30.10.18 =D0=B3. 11:07 =D1=87., Qu Wenruo wrote:
> For any recent kernel, there is a chance that btrfs/057 reports false
> errors.
>=20
> The false error would look like:
>   btrfs/057 4s ... - output mismatch (see /home/adam/xfstests-dev/resul=
ts//btrfs/057.out.bad)
>       --- tests/btrfs/057.out	2017-08-21 09:25:33.166666666 +0800
>       +++ /home/adam/xfstests-dev/results//btrfs/057.out.bad	2018-10-29=
 14:07:28.443651293 +0800
>       @@ -1,3 +1,3 @@
>        QA output created by 057
>        4096 4096
>       -4096 4096
>       +28672 28672
>=20
> This is related to the fact that "btrfs subvolume sync" (or
> vanilla sync) will not ensure orphan (unlinked but still exist) files t=
o
> be removed.
>=20
> In fact, for that false error case, if inspecting the fs after umount,
> its qgroup number is correct and btrfs check won't report qgroup error.
>=20
> To fix the false alerts, just skip any manual qgroup number comparison,
> and let fsck done after the test case to detect problem.
>=20
> This also elimiate the necessary of using specified mount and mkfs
> option, allowing us to improve coverage.
>=20
> Reported-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
>   Update commit message to show this is a long existing bug.
> ---
>  tests/btrfs/057     | 17 ++++-------------
>  tests/btrfs/057.out |  3 +--
>  2 files changed, 5 insertions(+), 15 deletions(-)
>=20
> diff --git a/tests/btrfs/057 b/tests/btrfs/057
> index b019f4e1e054..0b5a36d34852 100755
> --- a/tests/btrfs/057
> +++ b/tests/btrfs/057
> @@ -33,12 +33,9 @@ _require_scratch
>  rm -f $seqres.full
> =20
>  # use small leaf size to get higher btree height.
> -run_check _scratch_mkfs "-b 1g --nodesize 4096"
> +run_check _scratch_mkfs "-b 1g"

There was feedback from Filipe on V1 that you also need to delete the
above comment since it's no longer valid.

> =20
> -# inode cache is saved in the FS tree itself for every
> -# individual FS tree,that affects the sizes reported by qgroup show
> -# so we need to explicitly turn it off to get consistent values.
> -_scratch_mount "-o noinode_cache"
> +_scratch_mount
> =20
>  # -w ensures that the only ops are ones which cause write I/O
>  run_check $FSSTRESS_PROG -d $SCRATCH_MNT -w -p 5 -n 1000 \
> @@ -53,14 +50,8 @@ run_check $FSSTRESS_PROG -d $SCRATCH_MNT/snap1 -w -p=
 5 -n 1000 \
>  _run_btrfs_util_prog quota enable $SCRATCH_MNT
>  _run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> =20
> -# remove all file/dir other than subvolume
> -rm -rf $SCRATCH_MNT/snap1/* >& /dev/null
> -rm -rf $SCRATCH_MNT/p* >& /dev/null
> -
> -_run_btrfs_util_prog filesystem sync $SCRATCH_MNT
> -units=3D`_btrfs_qgroup_units`
> -$BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | $SED_PROG -n '/[0-9=
]/p' \
> -	| $AWK_PROG '{print $2" "$3}'
> +echo "Silence is golden"
> +# btrfs check will detect any qgroup number mismatch.
> =20
>  status=3D0
>  exit
> diff --git a/tests/btrfs/057.out b/tests/btrfs/057.out
> index 60cb92d0926c..185023c79961 100644
> --- a/tests/btrfs/057.out
> +++ b/tests/btrfs/057.out
> @@ -1,3 +1,2 @@
>  QA output created by 057
> -4096 4096
> -4096 4096
> +Silence is golden
>=20
