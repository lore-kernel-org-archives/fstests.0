Return-Path: <fdmanana@gmail.com>
MIME-Version: 1.0
Reply-To: fdmanana@gmail.com
In-Reply-To: <54EBE29F.2010902@redhat.com>
References: <54EBA093.3050401@redhat.com>
	<54EBAFE4.4080000@sandeen.net>
	<54EBE29F.2010902@redhat.com>
Date: Tue, 24 Feb 2015 11:30:24 +0000
Message-ID: <CAL3q7H7biZVWhzGA0Nt0E3Ja8r9_r=ybYDqz6Ak6D69zddshAA@mail.gmail.com>
Subject: Re: [PATCH V3] create _require_metadata_journaling, and add to tests
 that need it
From: Filipe David Manana <fdmanana@gmail.com>
Content-Type: text/plain; charset=UTF-8
To: Eric Sandeen <sandeen@redhat.com>
Cc: Eric Sandeen <sandeen@sandeen.net>, fstests@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 24, 2015 at 2:31 AM, Eric Sandeen <sandeen@redhat.com> wrote:
> Many tests use dm_flakey to trigger log replay, but for filesystems that
> don't support metadata journaling, this causes failures when it shouldn't.
> (i.e. we can hardly test log replay if there is no log, and the subsequent
> filesystem check will turn up errors).
>
> For some tests they actually sync everything we care about, and find
> inconsistencies elsewhere, but I erred on the side of simply not running
> the test in most cases.
>
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>


Reviewed-by: Filipe Manana <fdmanana@suse.com>
Tested-by: Filipe Manana <fdmanana@suse.com>

Works like a charm.
Thanks very much for this Eric.

> ---
>
> V2: MOAR COLUMNS.  Add default case.
> V3: whoops, dumpe2fs &>1 | grep -q so it doesn't break output when found
>
> diff --git a/common/rc b/common/rc
> index 7449a1d..243cb93 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2340,6 +2340,38 @@ _require_norecovery()
>         _scratch_unmount
>  }
>
> +# Does this filesystem support metadata journaling?
> +# We exclude ones here that don't; otherwise we assume that it does, so the
> +# test will run, fail, and motivate someone to update this test for a new
> +# filesystem.
> +#
> +# It's possible that TEST_DEV and SCRATCH_DEV have different features (it'd be
> +# odd, but possible) so check $TEST_DEV by default, but we can optionall pass
> +# any dev we want.
> +_require_metadata_journaling()
> +{
> +       if [ -z $1 ]; then
> +               DEV=$TEST_DEV
> +       else
> +               DEV=$1
> +       fi
> +
> +       case "$FSTYP" in
> +       ext2|vfat|msdos)
> +               _notrun "$FSTYP does not support metadata journaling"
> +               ;;
> +       ext4)
> +               # ext4 could be mkfs'd without a journal...
> +               _require_dumpe2fs
> +               $DUMPE2FS_PROG -h $DEV 2>&1 | grep -q has_journal || \
> +                       _notrun "$FSTYP on $DEV not configured with metadata journaling"
> +               ;;
> +       *)
> +               # by default we pass; if you need to, add your fs above!
> +               ;;
> +       esac
> +}
> +
>  # Does fiemap support?
>  _require_fiemap()
>  {
>
> diff --git a/tests/generic/034 b/tests/generic/034
> index 4ec1db8..966b3d2 100755
> --- a/tests/generic/034
> +++ b/tests/generic/034
> @@ -53,6 +53,7 @@ _supported_os Linux
>  _need_to_be_root
>  _require_scratch
>  _require_dm_flakey
> +_require_metadata_journaling $SCRATCH_DEV
>
>  rm -f $seqres.full
>
> diff --git a/tests/generic/040 b/tests/generic/040
> index 5f10f48..c841fbc 100755
> --- a/tests/generic/040
> +++ b/tests/generic/040
> @@ -62,6 +62,7 @@ _supported_os Linux
>  _need_to_be_root
>  _require_scratch
>  _require_dm_flakey
> +_require_metadata_journaling $SCRATCH_DEV
>
>  rm -f $seqres.full
>
> diff --git a/tests/generic/041 b/tests/generic/041
> index 36a6f42..f38b662 100755
> --- a/tests/generic/041
> +++ b/tests/generic/041
> @@ -66,6 +66,7 @@ _supported_os Linux
>  _need_to_be_root
>  _require_scratch
>  _require_dm_flakey
> +_require_metadata_journaling $SCRATCH_DEV
>
>  rm -f $seqres.full
>
> diff --git a/tests/generic/056 b/tests/generic/056
> index 9ec00e3..8bb1522 100755
> --- a/tests/generic/056
> +++ b/tests/generic/056
> @@ -55,6 +55,7 @@ _supported_os Linux
>  _need_to_be_root
>  _require_scratch
>  _require_dm_flakey
> +_require_metadata_journaling $SCRATCH_DEV
>
>  rm -f $seqres.full
>
> diff --git a/tests/generic/057 b/tests/generic/057
> index 4c0ffd1..3b9f89e 100755
> --- a/tests/generic/057
> +++ b/tests/generic/057
> @@ -55,6 +55,7 @@ _supported_os Linux
>  _need_to_be_root
>  _require_scratch
>  _require_dm_flakey
> +_require_metadata_journaling $SCRATCH_DEV
>
>  rm -f $seqres.full
>
> diff --git a/tests/generic/311 b/tests/generic/311
> index 85e52e8..d21b6eb 100755
> --- a/tests/generic/311
> +++ b/tests/generic/311
> @@ -56,6 +56,7 @@ _supported_os Linux
>  _need_to_be_root
>  _require_scratch_nocheck
>  _require_dm_flakey
> +_require_metadata_journaling $SCRATCH_DEV
>
>  # xfs_io is not required for this test, but it's the best way to verify
>  # the test system supports fallocate() for allocation
> diff --git a/tests/generic/321 b/tests/generic/321
> index 3bd6b12..c821a23 100755
> --- a/tests/generic/321
> +++ b/tests/generic/321
> @@ -45,6 +45,7 @@ _supported_os Linux
>  _need_to_be_root
>  _require_scratch_nocheck
>  _require_dm_flakey
> +_require_metadata_journaling $SCRATCH_DEV
>
>  rm -f $seqres.full
>
> diff --git a/tests/generic/322 b/tests/generic/322
> index 3ec2387..4c0edf6 100755
> --- a/tests/generic/322
> +++ b/tests/generic/322
> @@ -45,6 +45,7 @@ _supported_os Linux
>  _need_to_be_root
>  _require_scratch_nocheck
>  _require_dm_flakey
> +_require_metadata_journaling $SCRATCH_DEV
>
>  rm -f $seqres.full
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Filipe David Manana,

"Reasonable men adapt themselves to the world.
 Unreasonable men adapt the world to themselves.
 That's why all progress depends on unreasonable men."
