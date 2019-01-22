Received: from mail-vs1-f67.google.com ([209.85.217.67]:34491 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfAVWje (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Jan 2019 17:39:34 -0500
Received: by mail-vs1-f67.google.com with SMTP id y27so147638vsi.1
        for <fstests@vger.kernel.org>; Tue, 22 Jan 2019 14:39:33 -0800 (PST)
MIME-Version: 1.0
References: <20190121163316.20616-1-jeffm@suse.com> <20190121163316.20616-4-jeffm@suse.com>
In-Reply-To: <20190121163316.20616-4-jeffm@suse.com>
Reply-To: fdmanana@gmail.com
From: Filipe Manana <fdmanana@gmail.com>
Date: Tue, 22 Jan 2019 22:39:20 +0000
Message-ID: <CAL3q7H6US8m4PmgGawZQjS41VgSc3_qFBgMN0NObbGAc9kyKww@mail.gmail.com>
Subject: Re: [PATCH 4/7] btrfs: require feature raid56 for raid56 tests
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Jeff Mahoney <jeffm@suse.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 21, 2019 at 4:33 PM <jeffm@suse.com> wrote:
>
> From: Jeff Mahoney <jeffm@suse.com>
>
> btrfs/125, btrfs/148, btrfs/157, and btrfs/158 test for raid56
> behavior.  We shouldn't run if the kernel doesn't have support for them.
>
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good. Since it's a btrfs specific change/fix, it would have been
a good idea to cc linux-btrfs.

> ---
>  tests/btrfs/125 | 1 +
>  tests/btrfs/148 | 1 +
>  tests/btrfs/157 | 1 +
>  tests/btrfs/158 | 1 +
>  4 files changed, 4 insertions(+)
>
> diff --git a/tests/btrfs/125 b/tests/btrfs/125
> index 5ac68b67..847fa62a 100755
> --- a/tests/btrfs/125
> +++ b/tests/btrfs/125
> @@ -51,6 +51,7 @@ _supported_os Linux
>  _require_scratch_dev_pool 3
>  _test_unmount
>  _require_loadable_fs_module "btrfs"
> +_require_btrfs_fs_feature raid56
>
>  _scratch_dev_pool_get 3
>
> diff --git a/tests/btrfs/148 b/tests/btrfs/148
> index d0e554c2..3fd8616f 100755
> --- a/tests/btrfs/148
> +++ b/tests/btrfs/148
> @@ -30,6 +30,7 @@ _supported_os Linux
>  _require_scratch
>  _require_scratch_dev_pool 4
>  _require_odirect
> +_require_btrfs_fs_feature raid56
>
>  _scratch_dev_pool_get 4
>
> diff --git a/tests/btrfs/157 b/tests/btrfs/157
> index d9ea4b7b..7f75c407 100755
> --- a/tests/btrfs/157
> +++ b/tests/btrfs/157
> @@ -49,6 +49,7 @@ _supported_fs btrfs
>  _supported_os Linux
>  _require_scratch_dev_pool 4
>  _require_btrfs_command inspect-internal dump-tree
> +_require_btrfs_fs_feature raid56
>
>  get_physical_stripe0()
>  {
> diff --git a/tests/btrfs/158 b/tests/btrfs/158
> index fe2dd956..603e8bea 100755
> --- a/tests/btrfs/158
> +++ b/tests/btrfs/158
> @@ -41,6 +41,7 @@ _supported_fs btrfs
>  _supported_os Linux
>  _require_scratch_dev_pool 4
>  _require_btrfs_command inspect-internal dump-tree
> +_require_btrfs_fs_feature raid56
>
>  get_physical_stripe0()
>  {
> --
> 2.16.4
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
