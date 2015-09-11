Received: from mail-io0-f179.google.com ([209.85.223.179]:33047 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754AbbIKMGa (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 11 Sep 2015 08:06:30 -0400
Received: by iofh134 with SMTP id h134so95278582iof.0
        for <fstests@vger.kernel.org>; Fri, 11 Sep 2015 05:06:30 -0700 (PDT)
MIME-Version: 1.0
Reply-To: fdmanana@gmail.com
In-Reply-To: <1441971691-26427-1-git-send-email-xuw2015@gmail.com>
References: <1441971691-26427-1-git-send-email-xuw2015@gmail.com>
Date: Fri, 11 Sep 2015 13:06:30 +0100
Message-ID: <CAL3q7H48_juhy1vagw6KR5MPgjc2GO4Spy7PU8tLMUiaqReCWw@mail.gmail.com>
Subject: Re: [PATCH] generic/027: enlarge fs size for btrfs in bigger
 page-size machine
From: Filipe David Manana <fdmanana@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: xuw2015@gmail.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 11, 2015 at 12:41 PM,  <xuw2015@gmail.com> wrote:
> From: George Wang <xuw2015@gmail.com>
>
> btrfs on bigger page-size machine(such as ppc64/ppc64le), the min fs
> size shoule be more than 480MB. Otherwise, the mount will fail.

Interesting, wasn't aware of that.
How does it fail? What error message do you get?

How did you calculate those values (480Mb and 512Mb)?

thanks

> So we shoud adjust the fs size to 512MB for btrfs to run this test
> correctly. And we also provide a double check: if mount fails, we should
> never run this test.
>
> Signed-off-by: George Wang <xuw2015@gmail.com>
> ---
>  tests/generic/027 | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/tests/generic/027 b/tests/generic/027
> index d2e59d6..c42b9a6 100755
> --- a/tests/generic/027
> +++ b/tests/generic/027
> @@ -65,8 +65,17 @@ _require_scratch
>  rm -f $seqres.full
>  echo "Silence is golden"
>
> -_scratch_mkfs_sized $((256 * 1024 * 1024)) >>$seqres.full 2>&1
> -_scratch_mount
> +loop=100
> +fs_size=$((256 * 1024 * 1024))
> +# btrfs takes much longer time, reduce the loop count
> +# btrfs takes much more space when first mount on bigger page-size machine
> +if [ "$FSTYP" == "btrfs" ]; then
> +       loop=10
> +       fs_size=$((512 * 1024 * 1024))
> +fi
> +
> +_scratch_mkfs_sized $(fs_size) >>$seqres.full 2>&1
> +_scratch_mount || _notrun "scratch dev is not mounted successfully"
>
>  echo "Reserve 2M space" >>$seqres.full
>  $XFS_IO_PROG -f -c "pwrite 0 2m" $SCRATCH_MNT/testfile >>$seqres.full 2>&1
> @@ -75,12 +84,6 @@ $XFS_IO_PROG -f -c "pwrite 0 254m" $SCRATCH_MNT/bigfile >>$seqres.full 2>&1
>  echo "Remove reserved file" >>$seqres.full
>  rm -f $SCRATCH_MNT/testfile
>
> -loop=100
> -# btrfs takes much longer time, reduce the loop count
> -if [ "$FSTYP" == "btrfs" ]; then
> -       loop=10
> -fi
> -
>  dir=$SCRATCH_MNT/testdir
>  echo -n "iteration" >>$seqres.full
>  i=1
> --
> 1.9.3
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
