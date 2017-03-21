Received: from mx1.redhat.com ([209.132.183.28]:35466 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757169AbdCUIUt (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 21 Mar 2017 04:20:49 -0400
Date: Tue, 21 Mar 2017 16:20:47 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: generic/407: Use _reflink_range to avoid old
 xfs_io bug
Message-ID: <20170321082047.GW14226@eguan.usersys.redhat.com>
References: <20170321075321.17943-1-quwenruo@cn.fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170321075321.17943-1-quwenruo@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 21, 2017 at 03:53:21PM +0800, Qu Wenruo wrote:
> Old xfs_io has a bug that even its man page shows that reflink can accept
> one parameter, but in fact xfs_io reflink still needs full 4 parameters.
>=20
> In this test case, it only needs to reflink the file and we know the
> size of the file, so use _reflink_range() to replace open-coded reflink,
> which makes the test case pass even its xfs_io is a little old and
> doesn't accept single parameter.

IMO, you need to update your xfsprogs or fix the xfs_io bug (if it's not
fixed yet). I think there's nothing wrong with the test (unless the bug
won't be fixed in near future and blocks the test), it runs and finds a
bug for you :)

Thanks,
Eryu

>=20
> Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
> ---
>  tests/generic/407 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/generic/407 b/tests/generic/407
> index 1103d40..7d5a865 100755
> --- a/tests/generic/407
> +++ b/tests/generic/407
> @@ -65,7 +65,7 @@ echo "before clone: $mtime1 $ctime1" >> $seqres.full
>=20=20
>  # clone to trigger timestamp change
>  sleep 1
> -$XFS_IO_PROG -c "reflink $sourcefile " $destfile >> $seqres.full
> +_reflink_range $sourcefile 0 $destfile 0 4k >> $seqres.full
>=20=20
>  # sample and verify that timestamps have changed.
>  mtime2=3D`stat -c %Y $destfile`
> --=20
> 2.9.3
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp=
-3A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZ=
YR8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&=
m=3DUkEaggDFDpVPIDkJDLTvYe74em5MwQhqJYGutYVZHf4&s=3Dguuv5UVKfSvyacx4xr1BPzI=
VQTN9lD-sEvgY0lxWmj4&e=3D=20
--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3=
A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR=
8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=
=3DUkEaggDFDpVPIDkJDLTvYe74em5MwQhqJYGutYVZHf4&s=3Dguuv5UVKfSvyacx4xr1BPzIV=
QTN9lD-sEvgY0lxWmj4&e=3D=20
