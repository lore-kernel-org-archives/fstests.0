Received: from cn.fujitsu.com ([59.151.112.132]:37869 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753240AbcHQDJv (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 16 Aug 2016 23:09:51 -0400
Message-ID: <57B3D53C.2080605@cn.fujitsu.com>
Date: Wed, 17 Aug 2016 11:08:44 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] xfs/191: skip tests on older xfsprogs
References: <1471181701-23877-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <1471181701-23877-1-git-send-email-yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="GB2312"
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: fstests@vger.kernel.org
Cc: jtulak@redhat.com
List-ID: <fstests@vger.kernel.org>

Sorry=A3=AC please ingore it, I will resend it.
On 2016/08/14 21:35, Xiao Yang wrote:
> From: root <root@localhost.localdomain>
>
> If we don't have /tmp/foo file on xfsprogs 3.2.2, _require_xfs_mkfs_val=
idation
> will fail because mkfs.xfs can't create this file.  We need to skip tes=
ts
> before xfsprogs 4.7.0, so fix it.  the feature has been introduced sinc=
e
> xfsprogs 4.2.0:
> commit 20cec860e16b267ea0c71a2f648fa2b26aad2e65
> Author: Eric Sandeen <sandeen@sandeen.net>
> Date: Fri Jul 31 09:04:11 2015 +1000
>
>   mkfs.xfs: always use underlying fs sector size when mkfs'ing a file
>
> Signed-off-by: root <root@localhost.localdomain>
> ---
>  common/rc | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/common/rc b/common/rc
> index b19b698..db99794 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3889,6 +3889,9 @@ _get_fs_sysfs_attr()
>  # number of failed cases.
>  _mkfs_validation_check()
>  {
> +	if [ ! -f /tmp/foo ]; then
> +		touch /tmp/foo
> +	fi
>  	local cmd=3D"$MKFS_XFS_PROG -f -N -d file,name=3D/tmp/foo,size=3D$((1=
024 * 1024 * 1024))"
>  	$cmd -s size=3D2s >/dev/null 2>&1
>  	local sum=3D$?



