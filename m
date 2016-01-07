Received: from mail-ig0-f182.google.com ([209.85.213.182]:34495 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbcAGOD7 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 7 Jan 2016 09:03:59 -0500
Received: by mail-ig0-f182.google.com with SMTP id ik10so55997692igb.1
        for <fstests@vger.kernel.org>; Thu, 07 Jan 2016 06:03:59 -0800 (PST)
Subject: Re: [PATCH 1/2] fstests: comments to prevent from adding "/" to the
 end of 2 environment variables
References: <1452148649-22451-1-git-send-email-hejianet@gmail.com>
 <1452148649-22451-2-git-send-email-hejianet@gmail.com>
 <20160107102723.GD21019@eguan.usersys.redhat.com>
From: hejianet <hejianet@gmail.com>
Message-ID: <568E7049.1020508@gmail.com>
Date: Thu, 7 Jan 2016 22:03:53 +0800
MIME-Version: 1.0
In-Reply-To: <20160107102723.GD21019@eguan.usersys.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Eryu Guan
Thanks for the comments,  reasonable to me.
I will add it into v2 patch together with other
=E5=9C=A8 1/7/16 6:27 PM, Eryu Guan =E5=86=99=E9=81=93:
> On Thu, Jan 07, 2016 at 02:37:28PM +0800, Jia He wrote:
>> This adds comments to prevent user from adding "/" to the end of TEST_=
DIR and
>> SCRATCH_MNT
> Instead of adding comments, how about removing the trailing "/" in the
> code, something like:
>
> diff --git a/common/config b/common/config
> index e82d279..cb34fd7 100644
> --- a/common/config
> +++ b/common/config
> @@ -551,5 +551,10 @@ if [ -z "$CONFIG_INCLUDED" ]; then
>   	[ -z "$FSCK_OPTIONS" ] && _fsck_opts
>   fi
>  =20
> +# canonicalize the mount points
> +# this follows symlinks and removes all trailing "/"s
> +export TEST_DIR=3D`readlink -e "$TEST_DIR"`
> +export SCRATCH_MNT=3D`readlink -e "$SCRATCH_MNT"`
> +
Thanks, but maybe it will empty the invalid path and the user doesn't kno=
w
why his TEST_DIR/SCRATCH_MNT are assigned to NULL?

eg.
[root@host ~]# ls /root/not_existed
ls: cannot access /root/not_existed: No such file or directory
[root@host ~]# readlink -e /root/not_existed
[root@host ~]#
>   # make sure this script returns success
>   /bin/true
>
> Thanks,
> Eryu
>

