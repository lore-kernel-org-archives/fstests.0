Received: from mx1.redhat.com ([209.132.183.28]:38113 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208AbcFGCpt (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 6 Jun 2016 22:45:49 -0400
Date: Tue, 7 Jun 2016 10:45:41 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/015, generic/274: add to the 'enospc' group
Message-ID: <20160607024541.GJ5140@eguan.usersys.redhat.com>
References: <1465208730-3994-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1465208730-3994-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jun 06, 2016 at 06:25:30PM +0800, Wang Xiaoguang wrote:
> From test purpose=EF=BC=8C both two test cases belong to 'enospc' group.
>=20
> Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>

Makes sense to me.

Reviewed-by: Eryu Guan <eguan@redhat.com>
> ---
>  tests/generic/group | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/generic/group b/tests/generic/group
> index 36fb759..c79cacf 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -17,7 +17,7 @@
>  012 auto quick prealloc
>  013 other ioctl udf auto quick
>  014 rw udf auto quick
> -015 other auto quick
> +015 other auto quick enospc
>  016 auto quick prealloc
>  017 auto prealloc
>  018 auto fsr quick
> @@ -276,7 +276,7 @@
>  271 auto quick clone
>  272 auto quick clone
>  273 auto rw
> -274 auto rw prealloc
> +274 auto rw prealloc enospc
>  275 auto rw enospc
>  276 auto quick clone
>  277 auto ioctl quick metadata
> --=20
> 1.8.3.1
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
