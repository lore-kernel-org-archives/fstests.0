Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11CB3F8893
	for <fstests@vger.kernel.org>; Mon, 12 Oct 2026 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791804513; cv=none; b=mSjzkyP4CD041jbx6ut27nSSZX5QHe57cH2mNEOf7Syjf/qEBttRxAmZUh+cXR4HXVS9UcT+OQ/jWq5XBzhpBYymk6YwwiKm7hVuzaADC/o30A5Bl2ZW9hUmAIMGOb5byl6ePPTSzSNRm1QfTIrmYlfjDgvBGI5ZfqHmZeld+hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791804513; c=relaxed/simple;
	bh=6yzOJrUEMhlDUrkll9G+nDTYTlAz6l43cfs9koIAu5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3HL4WfCJSwNpwq7nl7rFGS2bJk3wEg99/UzrbUwXnM1OWSEN+k9V3o6T9aIpAGSMgAXfKNeJB1NbK9/quaA4oteE3/r5L2J7767TtEY1ZM7Pfxo4GgRDwcudtOTh29C6ISWGbWIwzCBNxGMrdktgeuuhgAAStSaSNuqidd34zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etGwrHf7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etGwrHf7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92C51F0089C
	for <fstests@vger.kernel.org>; Mon, 12 Oct 2026 11:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791804512;
	bh=7Zo5i72AxGdElv/2awNKoX1ktUA+Ja3R6IJzw3j2v/M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=etGwrHf73R6ej7IqubjzDO8UeP4du3K6Q2Qq4WRVX+X5qYaiCC4tS8U6t+W90wXeu
	 Igtzm6Rn08qq3tVq/I7/PEjRuye8c3JORRlnMWEq54wzHxd5h+wczPSlyTzlApqTGT
	 QJ1W1WCa/HoaVhGh6SaUzZCe8axqJEtSp6Ed6ltn9R6GlhE8+ZmB66bKnk3jc1QbVH
	 aMp1IXqzHMCoi7FkImw/iBiD6RBLbIj+zstW5wF/sJoGZ5/YaTQYpSjKYP8eJi5mVw
	 4GcSKnl2sSFmdbjF8aUuD8jvZseJ1CKFm0dmF96VI7vzJGiZqPzh+qkgDVuHQOYXy3
	 2S+aUbS74/3+w==
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-988f270d308so1133239241.2
        for <fstests@vger.kernel.org>; Mon, 12 Oct 2026 04:28:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzZ8T54VFpn9V152LNbFHOJjXOIjClyNEoCD0ajgK8+2eW1vMe1GswnHktLkBV7ZDxwQixqawZs@vger.kernel.org
X-Gm-Message-State: AFq9FYJRTMTl+aTllyb70mASaHG+D3qc1REquf0LqAqVe+7yyAvtHcDk
	iMOg3He31eaETXHI6y/FAOv48p0XNrrj5YnFDkcoGQY9sVaBRc/UcltRWT0ANZDZvta1SW0eDnQ
	f0A91xe1fKgWqfA/8p6/H0MnBkya16m4=
X-Received: by 2002:a05:6102:2d04:b0:7ca:238d:5a48 with SMTP id
 ada2fe7eead31-7cb372321c8mr2773551137.7.1791804512103; Mon, 12 Oct 2026
 04:28:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011230716.16860-1-wqu@suse.com>
In-Reply-To: <20261011230716.16860-1-wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 12 Oct 2026 12:27:55 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6FQN7oLos1RzVeLCev_nNTsXLdeFkgrMBp56X3qQAW7A@mail.gmail.com>
X-Gm-Features: AclHuK-0b5jAToRq2D-XeVWmKDoCp6dJW6ZyzSYUb8T4TnTlhx8r4R8fvRHicrU
Message-ID: <CAL3q7H6FQN7oLos1RzVeLCev_nNTsXLdeFkgrMBp56X3qQAW7A@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: test if btrfs control file rejects
 unknown ioctls
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 12:08=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> This is a regression test for a recent bug fix, where unsupported ioctls
> are not properly rejected for btrfs control file (normally at
> "/dev/btrfs-control").
>
> The test case itself is super simple, which doesn't even require test or
> scratch device, it just run the "btrfs_ioctl" program using
> "get_subvol_info" ioctl on "/dev/btrfs-control", which should fail as
> that ioctl only makes sense on a mounted btrfs, not the btrfs control
> file.
>
> The error will be outputted to the golden output so that we can catch
> any unexpected success.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  tests/btrfs/359     | 26 ++++++++++++++++++++++++++
>  tests/btrfs/359.out |  2 ++
>  2 files changed, 28 insertions(+)
>  create mode 100755 tests/btrfs/359
>  create mode 100644 tests/btrfs/359.out
>
> diff --git a/tests/btrfs/359 b/tests/btrfs/359
> new file mode 100755
> index 00000000..46457f57
> --- /dev/null
> +++ b/tests/btrfs/359
> @@ -0,0 +1,26 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 SUSE S.A.  All Rights Reserved.
> +#
> +# FS QA Test 359
> +#
> +# Make sure the btrfs control file (/dev/btrfs-control) properly rejects
> +# an unsupported ioctl.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick ioctl
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +       "btrfs: return -ENOTTY for unknown ioctls on the control device"
> +
> +_require_test_program btrfs_ioctl
> +
> +path=3D"/dev/btrfs-control"
> +if [ ! -c "$path" ]; then
> +       _notrun "No btrfs control file at \"$path\""
> +fi
> +
> +# This should fail with -ENOTTY error.
> +$here/src/btrfs_ioctl get_subvol_info "$path" >> $seqres.full
> +
> +_exit 0
> diff --git a/tests/btrfs/359.out b/tests/btrfs/359.out
> new file mode 100644
> index 00000000..89090e22
> --- /dev/null
> +++ b/tests/btrfs/359.out
> @@ -0,0 +1,2 @@
> +QA output created by 359
> +ioctl failed: Inappropriate ioctl for device
> --
> 2.56.0
>
>
