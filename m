Received: from mail-io0-f193.google.com ([209.85.223.193]:36059 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759383AbcCDJbe (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 4 Mar 2016 04:31:34 -0500
Received: by mail-io0-f193.google.com with SMTP id m184so4545864iof.3
        for <fstests@vger.kernel.org>; Fri, 04 Mar 2016 01:31:33 -0800 (PST)
MIME-Version: 1.0
Reply-To: fdmanana@gmail.com
In-Reply-To: <6dbf926cd05b145a54044c48c1c2b04ebe6b3e3d.1457028701.git.dsterba@suse.com>
References: <cover.1457028701.git.dsterba@suse.com>
	<6dbf926cd05b145a54044c48c1c2b04ebe6b3e3d.1457028701.git.dsterba@suse.com>
Date: Fri, 4 Mar 2016 09:31:32 +0000
Message-ID: <CAL3q7H5j4bQx6ZB9XQcNQaZkp29is0qTvcZbj2eMtAK6JtQaQw@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs/048: user filter for property error messages
From: Filipe Manana <fdmanana@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: David Sterba <dsterba@suse.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 3, 2016 at 6:16 PM, David Sterba <dsterba@suse.com> wrote:
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

(btw it would be better to cc the btrfs list for btrfs specific
changes to xfstests)

> ---
>  tests/btrfs/048 | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tests/btrfs/048 b/tests/btrfs/048
> index c2cb4a63b095..4a36303632eb 100755
> --- a/tests/btrfs/048
> +++ b/tests/btrfs/048
> @@ -41,6 +41,7 @@ _cleanup()
>  # get standard environment, filters and checks
>  . ./common/rc
>  . ./common/filter
> +. ./common/filter.btrfs
>
>  # real QA test starts here
>  _supported_fs btrfs
> @@ -70,7 +71,8 @@ $BTRFS_UTIL_PROG property set $SCRATCH_MNT label ''
>  $BTRFS_UTIL_PROG property get $SCRATCH_MNT label
>  echo "***"
>  mkdir $SCRATCH_MNT/testdir
> -$BTRFS_UTIL_PROG property get $SCRATCH_MNT/testdir label
> +$BTRFS_UTIL_PROG property get $SCRATCH_MNT/testdir label 2>&1 |
> +       _filter_btrfs_prop_error label
>  echo "***"
>
>  echo -e "\nTesting subvolume ro property"
> --
> 1.8.4.5
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
