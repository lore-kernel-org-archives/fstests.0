Received: from mail-vk1-f193.google.com ([209.85.221.193]:35795 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfFFLQ3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 Jun 2019 07:16:29 -0400
MIME-Version: 1.0
References: <20190606100754.14575-1-jthumshirn@suse.de>
In-Reply-To: <20190606100754.14575-1-jthumshirn@suse.de>
Reply-To: fdmanana@gmail.com
From: Filipe Manana <fdmanana@gmail.com>
Date: Thu, 6 Jun 2019 12:16:17 +0100
Message-ID: <CAL3q7H665Rh7P8bwxNxHJVFibvb6pSg7MeFaqhsRWKx4jMW8JA@mail.gmail.com>
Subject: Re: [PATCH fstests] btrfs: add validation of compression options to btrfs/048
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Eryu Guan <guaneryu@gmail.com>, Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 6, 2019 at 11:10 AM Johannes Thumshirn <jthumshirn@suse.de> wro=
te:
>
> The current btrfs/048 test-case did not check the behavior of properties
> with options like compression and with the compression level supplied.
>
> Add test cases for compression with compression level as well so we can b=
e
> sure we don't regress there.
>
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  tests/btrfs/048     | 15 +++++++++++++++
>  tests/btrfs/048.out | 12 ++++++++++++
>  2 files changed, 27 insertions(+)
>
> diff --git a/tests/btrfs/048 b/tests/btrfs/048
> index 8bb10a904bc9..af2d4ff34414 100755
> --- a/tests/btrfs/048
> +++ b/tests/btrfs/048
> @@ -226,5 +226,20 @@ $BTRFS_UTIL_PROG property set $SCRATCH_MNT compressi=
on 'lz' 2>&1 | _filter_scrat
>  $BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
>  $BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep '^gener=
ation'
>
> +echo -e "\nTesting argument validation with options"
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'lzo:9' 2>&1 | _f=
ilter_scratch
> +echo "***"
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zlib:3' 2>&1 | _=
filter_scratch
> +echo "***"
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zstd:0' 2>&1 | _=
filter_scratch
> +echo "***"

For those 3 cases, there's no need to "2>&1 | _filter_scratch", since
we don't expect any output from the commands in the golden output.

Other than that, looks good to me, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> +
> +echo -e "\nTesting invalid argument validation with options, should fail=
"
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'lz:9' 2>&1 | _fi=
lter_scratch
> +echo "***"
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zli:0' 2>&1 | _f=
ilter_scratch
> +echo "***"
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zst:3' 2>&1 | _f=
ilter_scratch
> +
>  status=3D0
>  exit
> diff --git a/tests/btrfs/048.out b/tests/btrfs/048.out
> index 16a785a642f7..016eba265b01 100644
> --- a/tests/btrfs/048.out
> +++ b/tests/btrfs/048.out
> @@ -92,3 +92,15 @@ Testing generation is unchanged after failed validatio=
n
>  generation             7
>  ERROR: failed to set compression for SCRATCH_MNT: Invalid argument
>  generation             7
> +
> +Testing argument validation with options
> +***
> +***
> +***
> +
> +Testing invalid argument validation with options, should fail
> +ERROR: failed to set compression for SCRATCH_MNT: Invalid argument
> +***
> +ERROR: failed to set compression for SCRATCH_MNT: Invalid argument
> +***
> +ERROR: failed to set compression for SCRATCH_MNT: Invalid argument
> --
> 2.16.4
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
