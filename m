Received: from mail-ua1-f66.google.com ([209.85.222.66]:44959 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfAVWkV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Jan 2019 17:40:21 -0500
Received: by mail-ua1-f66.google.com with SMTP id d19so60127uaq.11
        for <fstests@vger.kernel.org>; Tue, 22 Jan 2019 14:40:20 -0800 (PST)
MIME-Version: 1.0
References: <20190121163316.20616-1-jeffm@suse.com> <20190121163316.20616-5-jeffm@suse.com>
In-Reply-To: <20190121163316.20616-5-jeffm@suse.com>
Reply-To: fdmanana@gmail.com
From: Filipe Manana <fdmanana@gmail.com>
Date: Tue, 22 Jan 2019 22:40:09 +0000
Message-ID: <CAL3q7H6g2vA0WrELPGeoYoUfURO1VW4gNOfw99CFwr=NkjuhUg@mail.gmail.com>
Subject: Re: [PATCH 5/7] btrfs/023: skip trying to test raid56 without kernel support
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
> Older kernels don't support raid56.  This test is still valid for
> other profiles, so skip raid56 if the kernel doesn't support it.
>
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good. Since it's a btrfs specific change/fix, it would have been
a good idea to cc linux-btrfs.

> ---
>  tests/btrfs/023 | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tests/btrfs/023 b/tests/btrfs/023
> index 6d9cc443..6c02113b 100755
> --- a/tests/btrfs/023
> +++ b/tests/btrfs/023
> @@ -63,11 +63,13 @@ check_group_profile "RAID1"
>  create_group_profile "raid10"
>  check_group_profile "RAID10"
>
> -create_group_profile "raid5"
> -check_group_profile "RAID5"
> +if [ -e "/sys/fs/btrfs/features/raid56" ]; then
> +       create_group_profile "raid5"
> +       check_group_profile "RAID5"
>
> -create_group_profile "raid6"
> -check_group_profile "RAID6"
> +       create_group_profile "raid6"
> +       check_group_profile "RAID6"
> +fi
>
>  # success, all done
>  echo "Silence is golden"
> --
> 2.16.4
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
