Return-Path: <SRS0=5Nbd=Y7=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED83C5DF60
	for <linux-fstests@archiver.kernel.org>; Thu,  7 Nov 2019 15:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB542166E
	for <linux-fstests@archiver.kernel.org>; Thu,  7 Nov 2019 15:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3uL/k9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbfKGPtR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:49:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24361 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729656AbfKGPtR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Nov 2019 10:49:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573141755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eOoN3+a4vB0Buzoeu8MK6HCYg+SUHntc1F+DILCAlIw=;
        b=N3uL/k9z9mvdec1iJWzUZknJ6tdEHSn6ZYoOHo1A6m2+tmmp1SyIZeQtIyfUbWXEoRuy+5
        wgSk00ANGRv4ykt1U9mqa+v42ztY5ipQF1N8S+TDF2xtG6YqvffzQBWySpuqBrtDYyMKY5
        Bkt3Az8Eh4f3/uiEBQMMvJLyXkiT3dY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-NHVrv29FMQ6IJHy0beKj_Q-1; Thu, 07 Nov 2019 10:49:14 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C495E477;
        Thu,  7 Nov 2019 15:49:13 +0000 (UTC)
Received: from redhat.com (ovpn-123-234.rdu2.redhat.com [10.10.123.234])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4374A38C5;
        Thu,  7 Nov 2019 15:49:08 +0000 (UTC)
Date:   Thu, 7 Nov 2019 09:49:06 -0600
From:   Bill O'Donnell <billodo@redhat.com>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     fstests <fstests@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH] xfs/207: explicitly test for xflag character
Message-ID: <20191107154906.GA319242@redhat.com>
References: <3ac76079-7a4f-0ad6-80e9-6175c3c55a68@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3ac76079-7a4f-0ad6-80e9-6175c3c55a68@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: NHVrv29FMQ6IJHy0beKj_Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Nov 07, 2019 at 09:07:26AM -0600, Eric Sandeen wrote:
> With a recent change to xfs_io[1], the fsxattr.xflags output line
> has added another flag column, so xfs/207 starts failing.
>=20
> Rather than testing for an exact set of flags, test whether the
> specific flag we are interested in is set or unset.
>=20
> [1] xfs_io/lsattr: expose FS_XFLAG_HASATTR flag
>=20
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Looks fine.
Reviewed-by: Bill O'Donnell <billodo@redhat.com>

> ---
>=20
> diff --git a/tests/xfs/207 b/tests/xfs/207
> index e830534b..ed4e2e52 100755
> --- a/tests/xfs/207
> +++ b/tests/xfs/207
> @@ -37,6 +37,15 @@ _require_cp_reflink
>  _require_xfs_io_command "fiemap"
>  _require_xfs_io_command "cowextsize"
> =20
> +# Takes the fsxattr.xflags line,
> +# i.e. fsxattr.xflags =3D 0x0 [--------------C-]
> +# and tests whether a flag character is set
> +test_xflag()
> +{
> +    local flg=3D$1
> +    grep -q "\[.*${flg}.*\]" && echo "$flg flag set" || echo "$flg flag =
unset"
> +}
> +
>  rm -f $seqres.full
> =20
>  echo "Format and mount"
> @@ -73,14 +82,14 @@ echo "Set cowextsize and check flag"
>  $XFS_IO_PROG -c "cowextsize 1048576" $testdir/file3 | _filter_scratch
>  _scratch_cycle_mount
> =20
> -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | _filter_=
scratch
> +$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xfl=
ag "C"
>  $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
> =20
>  echo "Unset cowextsize and check flag"
>  $XFS_IO_PROG -c "cowextsize 0" $testdir/file3 | _filter_scratch
>  _scratch_cycle_mount
> =20
> -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | _filter_=
scratch
> +$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xfl=
ag "C"
>  $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
> =20
>  status=3D0
> diff --git a/tests/xfs/207.out b/tests/xfs/207.out
> index f6dc17d1..dd2d0958 100644
> --- a/tests/xfs/207.out
> +++ b/tests/xfs/207.out
> @@ -11,8 +11,8 @@ Check extsz and cowextsz settings on 1Mbyte file
>  [0] SCRATCH_MNT/test-207/file2
>  [1048576] SCRATCH_MNT/test-207/file2
>  Set cowextsize and check flag
> -fsxattr.xflags =3D 0x10000 [---------------C]
> +C flag set
>  [1048576] SCRATCH_MNT/test-207/file3
>  Unset cowextsize and check flag
> -fsxattr.xflags =3D 0x0 [----------------]
> +C flag unset
>  [0] SCRATCH_MNT/test-207/file3
>=20

