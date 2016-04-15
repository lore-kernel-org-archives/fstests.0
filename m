Received: from mail-io0-f170.google.com ([209.85.223.170]:36005 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbcDOLEz (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 15 Apr 2016 07:04:55 -0400
Received: by mail-io0-f170.google.com with SMTP id u185so131011636iod.3
        for <fstests@vger.kernel.org>; Fri, 15 Apr 2016 04:04:54 -0700 (PDT)
MIME-Version: 1.0
Reply-To: fdmanana@gmail.com
In-Reply-To: <20160414230409.GO2187@wotan.suse.de>
References: <20160414230409.GO2187@wotan.suse.de>
Date: Fri, 15 Apr 2016 12:04:53 +0100
Message-ID: <CAL3q7H6+bW60tS4Z5ptM9Sbbk7Hd92vZNcA4n2PWtPZ1vBfvkg@mail.gmail.com>
Subject: Re: [PATCH] btrfs/104: remove ugly sleep
From: Filipe Manana <fdmanana@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Mark Fasheh <mfasheh@suse.de>
Cc: fstests@vger.kernel.org, Dave Chinner <david@fromorbit.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 15, 2016 at 12:04 AM, Mark Fasheh <mfasheh@suse.de> wrote:
> Latest btrfsprogs can now do 'subvolume sync' to wait on snapshots to be
> dropped. Replace the sleep call in btrfs/104 with this. We can also add this
> test to the 'quick' group now.
>
> Signed-off-by: Mark Fasheh <mfasheh@suse.de>
> ---
>  tests/btrfs/104   | 8 +++-----
>  tests/btrfs/group | 2 +-
>  2 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/tests/btrfs/104 b/tests/btrfs/104
> index 6afaa02..627e77b 100755
> --- a/tests/btrfs/104
> +++ b/tests/btrfs/104
> @@ -145,11 +145,9 @@ _scratch_cycle_mount
>  # referenced above.
>  _run_btrfs_util_prog subvolume delete $SCRATCH_MNT/snap1
>
> -# There is no way from userspace to force btrfs_drop_snapshot to run
> -# at a given time (even via mount/unmount). We must wait for it to
> -# start and complete. This is the shortest time on my tests systems I
> -# have found which always allows drop_snapshot to run to completion.
> -sleep 45
> +# Removing snapshots on btrfs is a delayed operation, so we must wait for
> +# btrfs_drop_snapshot to complete.
> +_run_btrfs_util_prog subvolume sync $SCRATCH_MNT

Looks good, except that this will cause a test failure when running
with older versions of btrfs-progs that don't have this command.

We should skip the test with such old versions (it's usually what we
do everywhere) or make it fallback to the sleep.
We have "_require_btrfs <command>" to check if btrfs-progs supports a
specific command, so we could extend it to check for a subcommand too
as an optional argument so we could call
"_require_btrfs subvolume sync" in the test.

>
>  _scratch_unmount
>
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index ef6c260..9403daa 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -104,7 +104,7 @@
>  101 auto quick replace
>  102 auto quick metadata enospc
>  103 auto quick clone compress
> -104 auto qgroup
> +104 auto quick qgroup
>  105 auto quick send
>  106 auto quick clone compress
>  107 auto quick prealloc
> --
> 2.1.4
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
