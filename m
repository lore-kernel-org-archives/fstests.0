Received: from mail-vs1-f66.google.com ([209.85.217.66]:35829 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbeJ2Udl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 29 Oct 2018 16:33:41 -0400
MIME-Version: 1.0
References: <20181029063501.21604-1-wqu@suse.com>
In-Reply-To: <20181029063501.21604-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From: Filipe Manana <fdmanana@gmail.com>
Date: Mon, 29 Oct 2018 11:45:10 +0000
Message-ID: <CAL3q7H7whUCd-a97ZvqkLUFO1oe1L2aYhmiECxH1n5Bx6Wf-tg@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/057: Fix false alerts due to orphan files
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <wqu@suse.com>
Cc: fstests <fstests@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, Oct 29, 2018 at 6:35 AM Qu Wenruo <wqu@suse.com> wrote:
>
> For latest kernel, there is a chance that btrfs/057 reports false
> errors.
>
> The false error would look like:
>   btrfs/057 4s ... - output mismatch (see /home/adam/xfstests-dev/results=
//btrfs/057.out.bad)
>       --- tests/btrfs/057.out   2017-08-21 09:25:33.166666666 +0800
>       +++ /home/adam/xfstests-dev/results//btrfs/057.out.bad    2018-10-2=
9 14:07:28.443651293 +0800
>       @@ -1,3 +1,3 @@
>        QA output created by 057
>        4096 4096
>       -4096 4096
>       +28672 28672
>
> This is related to the fact that "btrfs subvolume sync" (or
> vanilla sync) will not ensure orphan (unlinked but still exist) files to
> be removed.
>
> In fact, for that false error case, if inspecting the fs after umount,
> its qgroup number is correct and btrfs check won't report qgroup error.
>
> To fix the false alerts, just skip any manual qgroup number comparison,
> and let fsck done after the test case to detect problem.
>
> This also elimiate the necessary of using specified mount and mkfs
> option, allowing us to improve coverage.
>
> Reported-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
>  tests/btrfs/057     | 17 ++++-------------
>  tests/btrfs/057.out |  3 +--
>  2 files changed, 5 insertions(+), 15 deletions(-)
>
> diff --git a/tests/btrfs/057 b/tests/btrfs/057
> index b019f4e1..0b5a36d3 100755
> --- a/tests/btrfs/057
> +++ b/tests/btrfs/057
> @@ -33,12 +33,9 @@ _require_scratch
>  rm -f $seqres.full
>
>  # use small leaf size to get higher btree height.
> -run_check _scratch_mkfs "-b 1g --nodesize 4096"
> +run_check _scratch_mkfs "-b 1g"

The comment above should go away too.

>
> -# inode cache is saved in the FS tree itself for every
> -# individual FS tree,that affects the sizes reported by qgroup show
> -# so we need to explicitly turn it off to get consistent values.
> -_scratch_mount "-o noinode_cache"
> +_scratch_mount
>
>  # -w ensures that the only ops are ones which cause write I/O
>  run_check $FSSTRESS_PROG -d $SCRATCH_MNT -w -p 5 -n 1000 \
> @@ -53,14 +50,8 @@ run_check $FSSTRESS_PROG -d $SCRATCH_MNT/snap1 -w -p 5=
 -n 1000 \
>  _run_btrfs_util_prog quota enable $SCRATCH_MNT
>  _run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
>
> -# remove all file/dir other than subvolume
> -rm -rf $SCRATCH_MNT/snap1/* >& /dev/null
> -rm -rf $SCRATCH_MNT/p* >& /dev/null
> -
> -_run_btrfs_util_prog filesystem sync $SCRATCH_MNT
> -units=3D`_btrfs_qgroup_units`
> -$BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | $SED_PROG -n '/[0-9]/=
p' \
> -       | $AWK_PROG '{print $2" "$3}'
> +echo "Silence is golden"
> +# btrfs check will detect any qgroup number mismatch.
>
>  status=3D0
>  exit
> diff --git a/tests/btrfs/057.out b/tests/btrfs/057.out
> index 60cb92d0..185023c7 100644
> --- a/tests/btrfs/057.out
> +++ b/tests/btrfs/057.out
> @@ -1,3 +1,2 @@
>  QA output created by 057
> -4096 4096
> -4096 4096
> +Silence is golden
> --
> 2.18.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
