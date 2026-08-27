Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F1246D0A9
	for <fstests@vger.kernel.org>; Thu, 27 Aug 2026 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843853; cv=none; b=VF+UKUDCfLktwiKY+n95/kHudH5XRnfp24AXp1bxKz/6wf1yiQwSvkOStqEh98CRCYx2u4+kJ80B0kBBLgegT79hQVe0SOJ2z7EHOBchUOCtUiL++4g6i7zMrRy+Qu+GuaeSyYV27Xd1sPIRLD67QL21+ZNYvQRNf6rnMNhXU78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843853; c=relaxed/simple;
	bh=DNat3AP/MxsPNDIjM3mUtaBmWjTUK6otvQv9E61XnQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0wJjppbwktPTtj+fIzbbTMdTTsSslxndzIgjx2dH4/c1PjRAm6p2BFcExluOb4bTMianWtmj388njemTC3/8toSuw7vo83jobmJmIDi+hWpWFoBbfB1c9DfQ+niHXi6LPw4KyTctPz9ra1WX1e27PNfr7lTLzQi7KRuswh1xhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l22ZIgHi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l22ZIgHi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01371F00A3A;
	Thu, 27 Aug 2026 15:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787843848;
	bh=TbhHoAsOmO9KTB5gVdg+5cGtOxEosHeCrTXOqxn2rfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l22ZIgHi4QVMj6egAB2YSunnBw5km6zSYzdu5nrWeXpSEvMdiXOn6VOdc6ZipWQLD
	 di9BZgEdjgZA1mqL19wSzOoZzbDJ3gHgfkh7grFrM+lqMiRpV3sJ/Z/4O4hWZTZJPs
	 QXdQWbfT7+OWhJWZQW93cuWvYwzAaEYbgd8FD4WXUhgtT6iTkh70RSxdGkeuok+V72
	 w6xVSSJwiRafo2SB82zngKtygiCzD+jOo8Ugh7zr+/NJqgqEDmnmABey4lGaOXE6BY
	 xDWisKUsjqZ7u3ax8MW3HiJ45R1YQ5ZSCoNQ8gXKaoil39BMUfr66BHvbNJKKzhTwT
	 bXPPvdy2e8TmQ==
Date: Thu, 27 Aug 2026 23:17:22 +0800
From: Zorro Lang <zlang@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 4/5] Add _require_hardlinks as needed
Message-ID: <apBUU2TiduWtpPrr@zlang-mailbox>
Mail-Followup-To: Eric Sandeen <sandeen@redhat.com>, 
	fstests@vger.kernel.org
References: <20260825001337.449670-1-sandeen@redhat.com>
 <20260825001337.449670-5-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825001337.449670-5-sandeen@redhat.com>

On Mon, Aug 24, 2026 at 07:11:11PM -0500, Eric Sandeen wrote:
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  tests/generic/066 | 1 +
>  tests/generic/084 | 1 +
>  tests/generic/398 | 1 +
>  tests/generic/423 | 1 +
>  tests/generic/440 | 1 +
>  tests/generic/479 | 1 +
>  tests/generic/520 | 1 +
>  tests/generic/556 | 1 +
>  tests/generic/572 | 1 +
>  tests/generic/597 | 1 +
>  tests/generic/681 | 1 +
>  tests/generic/682 | 1 +
>  tests/generic/782 | 1 +
>  tests/generic/789 | 1 +
>  tests/generic/790 | 1 +
>  15 files changed, 15 insertions(+)
> 
> diff --git a/tests/generic/066 b/tests/generic/066
> index 98674cdf..98f23723 100755
> --- a/tests/generic/066
> +++ b/tests/generic/066
> @@ -34,6 +34,7 @@ _cleanup()
>  . ./common/attr
>  
>  _require_scratch
> +_require_hardlinks
>  _require_dm_target flakey
>  _require_attrs
>  
> diff --git a/tests/generic/084 b/tests/generic/084
> index fe758f11..05f2f4ba 100755
> --- a/tests/generic/084
> +++ b/tests/generic/084
> @@ -25,6 +25,7 @@ _cleanup()
>  . ./common/filter
>  
>  _require_scratch
> +_require_hardlinks
>  
>  link_unlink_storm()
>  {
> diff --git a/tests/generic/398 b/tests/generic/398
> index 40d7b6e3..a6939b22 100755
> --- a/tests/generic/398
> +++ b/tests/generic/398
> @@ -20,6 +20,7 @@ _begin_fstest auto quick encrypt
>  . ./common/renameat2
>  
>  _require_scratch_encryption
> +_require_hardlinks
>  _require_renameat2 exchange
>  
>  _init_session_keyring
> diff --git a/tests/generic/423 b/tests/generic/423
> index 9d41f7a8..36f8dccc 100755
> --- a/tests/generic/423
> +++ b/tests/generic/423
> @@ -27,6 +27,7 @@ _require_test_program "stat_test"
>  _require_test_program "af_unix"
>  _require_statx
>  _require_symlinks
> +_require_hardlinks
>  _require_mknod
>  
>  function check_stat () {
> diff --git a/tests/generic/440 b/tests/generic/440
> index 1c8e3e8f..9d80cf04 100755
> --- a/tests/generic/440
> +++ b/tests/generic/440
> @@ -20,6 +20,7 @@ _begin_fstest auto quick encrypt
>  
>  _require_scratch_encryption
>  _require_symlinks
> +_require_hardlinks
>  _require_command "$KEYCTL_PROG" keyctl
>  
>  # Set up an encryption-capable filesystem and an encryption key.
> diff --git a/tests/generic/479 b/tests/generic/479
> index f9661001..ceeaa754 100755
> --- a/tests/generic/479
> +++ b/tests/generic/479
> @@ -26,6 +26,7 @@ _cleanup()
>  
>  _require_scratch
>  _require_symlinks
> +_require_hardlinks
>  _require_mknod
>  _require_dm_target flakey
>  
> diff --git a/tests/generic/520 b/tests/generic/520
> index 3c7ae615..d03c726c 100755
> --- a/tests/generic/520
> +++ b/tests/generic/520
> @@ -28,6 +28,7 @@ _cleanup()
>  fssize=$((2**20 * 256))
>  
>  _require_scratch_nocheck
> +_require_hardlinks
>  _require_dm_target flakey
>  
>  # initialize scratch device
> diff --git a/tests/generic/556 b/tests/generic/556
> index 279ff58b..7c5d0371 100755
> --- a/tests/generic/556
> +++ b/tests/generic/556
> @@ -15,6 +15,7 @@ _begin_fstest auto quick casefold
>  _require_scratch_nocheck
>  _require_scratch_casefold
>  _require_symlinks
> +_require_hardlinks
>  _require_check_dmesg
>  _require_attrs
>  
> diff --git a/tests/generic/572 b/tests/generic/572
> index c3059eb2..97f99a53 100755
> --- a/tests/generic/572
> +++ b/tests/generic/572
> @@ -29,6 +29,7 @@ _cleanup()
>  _require_scratch_verity
>  _require_chmod
>  _require_chown
> +_require_hardlinks
>  _disable_fsverity_signatures
>  
>  _scratch_mkfs_verity &>> $seqres.full
> diff --git a/tests/generic/597 b/tests/generic/597
> index 3aef67a1..6256c4f4 100755
> --- a/tests/generic/597
> +++ b/tests/generic/597
> @@ -37,6 +37,7 @@ _require_group fsgqa2
>  _require_user fsgqa
>  _require_group fsgqa
>  _require_symlinks
> +_require_hardlinks
>  
>  OWNER=fsgqa2
>  OTHER=fsgqa
> diff --git a/tests/generic/681 b/tests/generic/681
> index 651ee157..14bc78bc 100755
> --- a/tests/generic/681
> +++ b/tests/generic/681
> @@ -24,6 +24,7 @@ _require_quota
>  _require_user
>  _require_scratch
>  _require_chown
> +_require_hardlinks
>  
>  _scratch_mkfs > "$seqres.full" 2>&1
>  _qmount_option usrquota
> diff --git a/tests/generic/682 b/tests/generic/682
> index 80846463..964200c7 100755
> --- a/tests/generic/682
> +++ b/tests/generic/682
> @@ -25,6 +25,7 @@ _require_user
>  _require_scratch
>  _require_chmod
>  _require_chown
> +_require_hardlinks
>  
>  _scratch_mkfs > "$seqres.full" 2>&1
>  _qmount_option usrquota
> diff --git a/tests/generic/782 b/tests/generic/782
> index f3298a70..ef6f6a8e 100755
> --- a/tests/generic/782
> +++ b/tests/generic/782
> @@ -23,6 +23,7 @@ _cleanup()
>  . ./common/dmflakey
>  
>  _require_scratch
> +_require_hardlinks
>  _require_dm_target flakey
>  
>  _fixed_by_fs_commit btrfs bfe3d755ef7c \
> diff --git a/tests/generic/789 b/tests/generic/789
> index 0e72966e..7cacf238 100755
> --- a/tests/generic/789
> +++ b/tests/generic/789
> @@ -22,6 +22,7 @@ _cleanup()
>  . ./common/dmflakey
>  
>  _require_scratch
> +_require_hardlinks
>  _require_dm_target flakey
>  
>  _fixed_by_fs_commit btrfs 5254d4181add \
> diff --git a/tests/generic/790 b/tests/generic/790
> index 28f7faa2..44de7bb8 100755
> --- a/tests/generic/790
> +++ b/tests/generic/790
> @@ -25,6 +25,7 @@ _cleanup()
>  . ./common/dmflakey
>  
>  _require_scratch
> +_require_hardlinks
>  _require_dm_target flakey
>  
>  _fixed_by_fs_commit btrfs 9573a365ff9f \
> -- 
> 2.55.0
> 
> 
