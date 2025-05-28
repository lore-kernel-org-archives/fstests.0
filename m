Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E20220296C
	for <fstests@vger.kernel.org>; Wed, 28 May 2025 10:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748429831; cv=none; b=D2km/4rTqAwM5fhAVL0CFGm4ToDSn1BuFm8n8Mvp8yLKR9OlauWVWNSH48RZ0SCDufl/L0YsoW4keVGMjXFzPvbGzbhcmhXqhGTEmzF3OxUOhgKE3MRpzvsbWmO5LLafSPhP4+4fFlZDy9fbuEOqTJXIfaSNV4mPh4NS6ILWtlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748429831; c=relaxed/simple;
	bh=zbTqDxOvVCT6lte5t1p4tLfofKPZIkU77mZFLaH9a3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNGPxV1U4pMB3siwa2/eFeHCa9Ut6C+H0GTMbvqc7zeReFAit71bsmYWhW+JkdWcZUxSjvZdpRD6rzIXt/9E2O9adZrMSC7lFJIgVxbdm1EPTVmpX3XviX/13TwXPRPYiYLsAr9O/IK2AKVk88sF+Q9cwtxpRN/ndDh4rt4k12Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1MV/cZT; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1MV/cZT"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad1b94382b8so739991066b.0
        for <fstests@vger.kernel.org>; Wed, 28 May 2025 03:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748429827; x=1749034627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rd1GLBOHt9My0bNdPvfXvl81UuLXLpQU9wG4GcSf9M4=;
        b=Z1MV/cZTp/jm7+U644+jPeNXKEVKqFdM9RGeG2nduAK9J8y9LzkRkU3ChoEMVT/6Ci
         TNnUwbxU47KVRjP1LgaG9sbDkhLtQcFGQFUuPGlDBzHzSOfpgCjmkkwzO/8ZCDjL9Nn9
         obJTjciGTxfSQQ1KeC2gFce04wchlH4vrm5EHt1EugTL2sRg83pPVfaHd0f5JzO4XwGD
         irEfcv2sVa1rYHq3YsdmyMIAzAAa144JCUZ14EdgHQxzQSu1M4e0F7FYjn3XQFhtMbzC
         aOZwc8fbNbGtfan4Ap8LENT1MvFkB24i4KVj63XNzYTzBC9hmNE1CZJI9E72JxZ6LeLP
         Mu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748429827; x=1749034627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rd1GLBOHt9My0bNdPvfXvl81UuLXLpQU9wG4GcSf9M4=;
        b=q9L8WIo44GzV2UkkE8P9nEP6nQKfjZpGGgYrqWzZRQcIkyhtBmT2ZdC+RBQazb8rby
         615rqrhnraFVpDQpGoqe6sPOhEZ8oev9GjML2mu4Mfnl5lnF3HDSK5ttQmim24r+jFAD
         ukl6K7yFRvP9rUQ+ZHAcEvhScdipfJBp5SoeIES/CGFH5c3woxpEZE5IVmr1nZ0X8qht
         2z8JI+S13a+nroOW2aZ0rn4PEZW6XDedhZFjwiXpxR0VFwr54ZRxjF42nHbRqxRSOfey
         GQgPaM1ADH8gMYaEWgmVue7w6p5M+UDFRZIIYMcUB6EUnG2HWg/bMNcylTCJlXXAEJhf
         45Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUBICgHfyulkMVnsIISBznh15V3/52W+d5gb+Qu+zlKD5PP0EXHWphNhIPa1DKD50jeS6xLtZoH@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8uhIjYnH7W4oIVWeqKPn24rBAy2UFESXz78dCQ+BK72BlM+KH
	fPmiRHW8vjThtUKTM8oW5ib+9g70vnCCGY7/yDnYlkHm+T3Oli1wS1Q60WiQf92W5ciWw03LRN6
	xfocei46F+437qvODoKPgKhZ/mm7+PxU=
X-Gm-Gg: ASbGncv0Uvcaz0Apm7zCEXCgSbRcRqVvAs7jlFO/z/9VGDUaAhbkLXDvkaKPKsyjX1U
	CVzu76LkcZ0xtjd8j+Rs/rTjpYqCL4db9PE/4Kmz3/GwP6basiR3sQkX+NJPLiu+hmmuoVErqfS
	OojzAQELDKAPV1CwO5Al39YvYy0E88OZj0ABgxieejzOg=
X-Google-Smtp-Source: AGHT+IG568BEC0VHepwBzhsxbOWq4phy+By5tCLRgu0U4y6U2Q6N1zMMMoUCnRha4tFtl0mUtF5xZykMBp0zokOKGGg=
X-Received: by 2002:a17:907:6e8d:b0:ad8:a935:b8f7 with SMTP id
 a640c23a62f3a-ad8a935c984mr29463866b.12.1748429827234; Wed, 28 May 2025
 03:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528091530.1218188-1-Yuezhang.Mo@sony.com> <20250528091530.1218188-8-Yuezhang.Mo@sony.com>
In-Reply-To: <20250528091530.1218188-8-Yuezhang.Mo@sony.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 May 2025 12:56:55 +0200
X-Gm-Features: AX0GCFs8AoOMg8RXJ3-cBBLfR_COi3Wm8W0zu7lxhplhQbqpqFRJpnE9hU4OH5c
Message-ID: <CAOQ4uxihwu9-rqFEUboDaDV9onaip4N5QsbdU_xTZQ7MnBDCzA@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] generic/633: add test requirements
To: Yuezhang Mo <Yuezhang.Mo@sony.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, friendy.su@sony.com, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 11:15=E2=80=AFAM Yuezhang Mo <Yuezhang.Mo@sony.com>=
 wrote:
>
> Since the following test requirements are required by the following
> sub-tests, this commit adds them to this test to avoid failures on
> filesystems that do not support them.
>
> requirement | sub-tests
> ------------+-------------------------------------------------------
> hardlink    | hardlink_crossing_mounts tcore_fsids_mapped
>             | tcore_hardlink_crossing_idmapped_mounts
>             | tcore_hardlink_from_idmapped_mount
>             | tcore_hardlink_from_idmapped_mount_in_userns
> ------------|-------------------------------------------------------
> symlink     | protected_symlinks symlink_regular_mounts
>             | tcore_create_in_userns tcore_symlink_idmapped_mounts
>             | tcore_symlink_idmapped_mounts_in_userns
> ------------|-------------------------------------------------------
> chown       | hardlink_crossing_mounts rename_crossing_mounts
>             | setid_binaries sticky_bit_unlink
>             | symlink_regular_mounts tcore_acls
>             | tcore_hardlink_crossing_idmapped_mounts
>             | tcore_hardlink_from_idmapped_mount
>             | tcore_protected_symlinks_idmapped_mounts
>             | tcore_rename_crossing_idmapped_mounts
>             | tcore_rename_from_idmapped_mount
>             | tcore_setattr_truncate_idmapped_in_userns
>             | tcore_setid_binaries_idmapped_mounts
>             | tcore_setid_binaries_idmapped_mounts_in_userns
>             | tcore_setid_binaries_idmapped_mounts_in_userns_separate_use=
rns
>             | tcore_sticky_bit_unlink_idmapped_mounts
>             | tcore_sticky_bit_unlink_idmapped_mounts_in_userns
>             | tcore_sticky_bit_rename_idmapped_mounts
>             | tcore_sticky_bit_rename_idmapped_mounts_in_userns
> ------------|-------------------------------------------------------
> chmod       | protected_symlinks
>             | tcore_protected_symlinks_idmapped_mounts_in_userns
> ------------|-------------------------------------------------------
> io_uring    | io_uring io_uring_userns tcore_io_uring_idmapped_userns
>             | tcore_io_uring_idmapped_unmapped
>             | tcore_io_uring_idmapped_unmapped_userns
> ------------|-------------------------------------------------------
> mknod       | tcore_expected_uid_gid_idmapped_mounts
>
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Friendy Su <friendy.su@sony.com>
> ---
>  tests/generic/633 | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tests/generic/633 b/tests/generic/633
> index f58dbbf5..e19a2043 100755
> --- a/tests/generic/633
> +++ b/tests/generic/633
> @@ -13,6 +13,12 @@ _begin_fstest auto quick atime attr cap idmapped io_ur=
ing mount perms rw unlink
>  . ./common/filter
>
>  _require_idmapped_mounts

Please note that the requirement above is wrong:

https://lore.kernel.org/fstests/20250526175437.1528310-1-amir73il@gmail.com=
/

> +_require_hardlinks
> +_require_symlinks
> +_require_chown
> +_require_chmod
> +_require_io_uring
> +_require_mknod

I wonder if it makes more sense to have a collective check for all (or
most) of the above,
e.g. _require_vfstest, which is different than _require_idmapped_mounts,
so that we do not have to add all of these for tests running
other vfstests subtests in the future.

Thanks,
Amir.
