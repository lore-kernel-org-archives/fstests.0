Received: from mail-yw1-f66.google.com ([209.85.161.66]:38428 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfEMI2L (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 13 May 2019 04:28:11 -0400
MIME-Version: 1.0
References: <1557727987-3788-1-git-send-email-jefflexu@linux.alibaba.com>
In-Reply-To: <1557727987-3788-1-git-send-email-jefflexu@linux.alibaba.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 13 May 2019 11:27:58 +0300
Message-ID: <CAOQ4uxgPUbrS7W2VvLv2y77xMY5KcRadH2BYUBuZU_iEmu8TEg@mail.gmail.com>
Subject: Re: [PATCH] common/rc: improve _fstyp_has_non_default_seek_data_hole()
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Cc: fstests <fstests@vger.kernel.org>, caspar@linux.alibaba.com, Linux NFS Mailing List <linux-nfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, May 13, 2019 at 9:13 AM Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
>
> commit 34081087 adds more sanity to seek_sanity_test(), where
> some kinds of filesystem type should not only support default
> behavior of SEEK_HOLE, that is, always returns EOF. A hardcoded
> whitelist is maintained to distinguish whether a filesystem type
> is allowed to only support default behavior or not.

Its the other way around.
The whitelist is for filesystems that are allowed to support only
"non default" behavior.
A filesystem that is not whitelisted can support either default or
non-default behavior as far as the test is concerned.

>
> In this whitelist, NFS is not allowed to support default behavior
> only. However as far as I know, nfsv2 and nfsv3 only support
> default behavior of SEEK_HOLE in linux.

Correct.

>
> On the other hand, xfstests uses "mount -t nfs ..." to mount a
> NFS mount point. Normally the mount point is mounted on nfsv4,
> but it can be mounted mandatorily on nfsv3 if we specify
> "Nfsvers=3" in /etc/nfsmount.conf. And in this case, a series of
> tests fail (including generic/285, generic/448, generic/490, et
> cetera) with error message "Default behavior is not allowed.
> Aborting."
>
> So I just make some special handling for NFS in
> _fstyp_has_non_default_seek_data_hole(), that is, default behavior
> of SEEK_HOLE is acceptable for nfsv2 and nfsv3.
>
> I'm not sure how nfsv2 and nfsv3 behave SEEK_HOLE in other OS other
> than linux, and any comment is welcomed if I misunderstand the
> SEEK_HOLE behavior of nfsv2/nfsv3 in linux.

I think you understood well (CC NFS list).
xfstests does not support non Linux OS anymore.

>
> Thanks.
>
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  common/rc | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/common/rc b/common/rc
> index cbd3c59..83e9729 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2315,9 +2315,15 @@ _fstyp_has_non_default_seek_data_hole()
>         fi
>
>         case "$fstyp" in
> -       btrfs|ext4|xfs|ceph|cifs|f2fs|gfs2|nfs*|ocfs2|tmpfs)
> +       btrfs|ext4|xfs|ceph|cifs|f2fs|gfs2|ocfs2|tmpfs)
>                 return 0
>                 ;;
> +       nfs*)
> +               # NFSv2 and NFSv3 only support default behavior of SEEK_HOLE,
> +               # while NFSv4 supports non-default behavior
> +               local nfsvers=`_df_device $TEST_DEV | $AWK_PROG '{ print $2 }'`
> +               [ "$nfsvers" = "nfs4" ] && return 0 || return 1

               [ "$nfsvers" = "nfs4" ]
               return $?

Thanks,
Amir.
