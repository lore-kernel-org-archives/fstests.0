Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75EE1F5437
	for <fstests@vger.kernel.org>; Tue,  2 Dec 2025 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764687480; cv=none; b=pQTrNKHmwa55rhxQ/ierxXJjfMqRaeviZ8vItAtZDKVUEsMtNSpNSr+oNAJGmTTghgcKWxxKjNX96YedJQFWQS+JG5rF8UqQCdonYtw7Ik6Zcq5F+ExEgA1g21mtt46OUCzsgV4yXBuWoc8IjJlIrnwwJ+B2Pglr28BamYnoxYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764687480; c=relaxed/simple;
	bh=4Mmaw/xekYlO7xPuelC7+yUysMyzKGDjGm/tlxVU8rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZCfQYXK4IwbmrGiZcW+30tSjuVji80utm8cqyImswu540qoPiAVILwxm0mAXBI+tsYiAo375YfbdI7SrI/5jp3EASzIzF4/TqEUFZheK6tnl1WSow79APDfcSqN4yNW5GsWxVFk07j4wVE2CgdH1CEKUZvo9Zv/eOWz0RFwwWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mj4+Uf77; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mj4+Uf77"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0DBC116B1
	for <fstests@vger.kernel.org>; Tue,  2 Dec 2025 14:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764687477;
	bh=4Mmaw/xekYlO7xPuelC7+yUysMyzKGDjGm/tlxVU8rg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mj4+Uf77kXV16sYUY9aXBk6kW/f1AGRKxOleGl8/9HFufwEGrpk44Ug2UoJ5r32zn
	 PdTTxCV29XCvhdnTkKGkM8VAPXcN+u3tZJ+VZ+jQ2nF7rvJ2PGFVbCnbpHvlXy6uUW
	 +U9Ye/B3Abjg270wmAbyB8uZezTEIerVxLa/C5JGctBSQ7TNqgCKpwTY3xihZcQSmr
	 0FMveA2tPaqrDmOSrOIvsm0hm1FpicjAVKhtqqAt5KkCy27bhG9erryDzcg9G8ZlIc
	 eTns2bZztjPVkx7IspNlClbVWbjF2sRJwnEzvVD4vL+O1hK3x9V/PXL5n5TARGZ/Rx
	 FF7s7RBLnosQA==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b725ead5800so745034066b.1
        for <fstests@vger.kernel.org>; Tue, 02 Dec 2025 06:57:57 -0800 (PST)
X-Gm-Message-State: AOJu0YxDUamnqFpchKewQ4cLDU6HF9S00VSKBROroYSW38ZMn8euoYoa
	nkNwEvLAsHLOxi0XburbK2Jp7Axawmv0T9/CL7MjWUl3OdNmFz7Gdtfjkz7bz29PzRhiW/66ZrR
	nL5aQ2gB920PaZKj6xSCnQ7FKWkVV2OM=
X-Google-Smtp-Source: AGHT+IFm0gTPol9yzAiHq+byP7AzBRcYWn+DmugATZRVByH5U+Hn097ExERDcgalLKYGqfrzdytHupCrOCVF2RDcGBQ=
X-Received: by 2002:a17:907:809:b0:b73:7280:7821 with SMTP id
 a640c23a62f3a-b76c558f338mr3210852766b.60.1764687476023; Tue, 02 Dec 2025
 06:57:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119052843.35108-1-realwakka@gmail.com>
In-Reply-To: <20251119052843.35108-1-realwakka@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 2 Dec 2025 14:57:19 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5e6R5XzFQTfx9hpxsiaVoQoiXgsqSTRO9GQAhmv+-rng@mail.gmail.com>
X-Gm-Features: AWmQ_blQxkX7WQnjUh7vyz6dBeisxAGVhsMnrUcsL98n9EN4gv8Wv5uy3jCCamY
Message-ID: <CAL3q7H5e6R5XzFQTfx9hpxsiaVoQoiXgsqSTRO9GQAhmv+-rng@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] btrfs/339: test receive dump stream for different user
To: Sidong Yang <realwakka@gmail.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 5:30=E2=80=AFAM Sidong Yang <realwakka@gmail.com> w=
rote:
>
> Test receive to dump stream file from different user.
>
> This is a regression test for the btrfs-progs commit cd933616d485
> ("btrfs-progs: receive: don't use O_NOATIME to open stream for
> dumping").
>
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
> v2:
> - forward to $seqres.full rather than -q
> - use $tmp for stream file
> ---
>  tests/btrfs/339     | 40 ++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/339.out |  2 ++
>  2 files changed, 42 insertions(+)
>  create mode 100755 tests/btrfs/339
>  create mode 100644 tests/btrfs/339.out
>
> diff --git a/tests/btrfs/339 b/tests/btrfs/339
> new file mode 100755
> index 00000000..0df24577
> --- /dev/null
> +++ b/tests/btrfs/339
> @@ -0,0 +1,40 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Sidong Yang.  All Rights Reserved.
> +#
> +# FS QA Test 339
> +#
> +# Test btrfs receive dump stream from different user
> +#
> +. ./common/preamble
> +_begin_fstest auto quick send snapshot
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +       cd /
> +       rm -r -f $tmp.*
> +}

This does the same as the default _cleanup function, so there's no
need to have it, just remove it.

> +
> +. ./common/filter
> +. ./common/quota

Why include the quota file? It's not needed, the test doesn't use
anything from it, just remove it.

> +
> +_require_scratch
> +_require_user
> +
> +_fixed_by_git_commit btrfs-progs cd933616d485 \
> +       "btrfs-progs: receive: don't use O_NOATIME to open stream for dum=
ping"
> +
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +stream=3D$tmp.fsv.ss
> +
> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap >>=
 $seqres.full

Nowadays we use _btrfs, it's shorter and does the same (including the
stdout redirection):

_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap

> +$BTRFS_UTIL_PROG send -f $stream $SCRATCH_MNT/snap >> $seqres.full 2>&1 =
|| _fail "send failed"

And here:

_btrfs send -f $stream $SCRATCH_MNT/snap

There's no need to:  || _fail "send failed"
That is generally discouraged in fstests. A failure will just cause a
mismatch with the golden output and make the test fail.

But _btrfs already calls _fail and redirects to the .full file anyway.

Otherwise it looks good, thanks.



> +chmod a+r $stream
> +_su $qa_user -c "$BTRFS_UTIL_PROG receive --dump -f $stream" >> $seqres.=
full
> +
> +# success, all done
> +echo "Silence is golden"
> +_exit 0
> diff --git a/tests/btrfs/339.out b/tests/btrfs/339.out
> new file mode 100644
> index 00000000..293ea808
> --- /dev/null
> +++ b/tests/btrfs/339.out
> @@ -0,0 +1,2 @@
> +QA output created by 339
> +Silence is golden
> --
> 2.43.0
>
>
