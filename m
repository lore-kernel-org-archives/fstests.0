Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B472918EB1
	for <fstests@vger.kernel.org>; Mon,  4 Nov 2024 21:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730756750; cv=none; b=gfYhqABe3GuoZlpE0lJNaM2rx7WzqQWjyuCMjwFKPy9Y2DS0/cli1OuZ4e5dhx33Ud7YmnZRG4c+iwq+3f2ScO13GroQ09NybZ28qyTvD9BRwZLdFaFagfKMn4tIOELEyStzpHJouDiobexLNgvY1bv1McYhLt0hFJxEgQTyybE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730756750; c=relaxed/simple;
	bh=3tGvk1YxnDYXmxqjcB/ra+AUPWGN240nMyzoH+9JZ60=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DyJHKo3NcqoDO2wrEMT9dsw3B1hRjOetN/+Jw+TQuFcYfdBCrgaBWMKevWGE60x1TC3Jxunf4hK1sIUHM+b0Zp2DUqbFFZ+h66hdWdVAaa64i/0YTF8Q+IEOuAfVpKUzXv2cslaiIuEjmdbtXAiDDkl+g1isW8kocZJP6nscHkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=DLCYBhuj; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="DLCYBhuj"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 317B9E0003;
	Mon,  4 Nov 2024 21:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1730756739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h97jrvVIsh63bn63xG3WyKX7BISRpAFQhrb9geFclyc=;
	b=DLCYBhujSJODOwQw1aK8Z8fjtCbNdLFwHUGVrw7tFr9NBiT5b+A0H94qD7RGGmFPLnOszF
	MIr/sYq1ie9dRCn4Muih7usUDQ6FRyhTOBxMSC4V91FK7F9UPLMqdiD4pEwfvvP7iHUi3n
	ZF9rCRWDY2Dgioj2/UtlPBsAk2dct9rqm5+EMYkWb/4nvdAEC64yqh2CRCg62XSxElNLH6
	39iX7hpvgk0n0SM7iWKXtH4MF6SvlR5oCNmWdnyrFAYZyic/ctb9PC3+OOkeqandVymLyE
	o79Zdxp2U2QZyDTSGOvW79CyehJBSpQDVB//pqznduwASNWu7ZLNNoIod5OhSQ==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: fstests@vger.kernel.org,  Zorro Lang <zlang@kernel.org>,
  kernel-dev@igalia.com,  Miklos Szeredi <mszeredi@redhat.com>,  Eryu Guan
 <guaneryu@gmail.com>,  "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2] common/casefold: Support for tmpfs casefold test
In-Reply-To: <20241104210636.38934-1-andrealmeid@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Mon, 4 Nov 2024 18:06:36 -0300")
References: <20241104210636.38934-1-andrealmeid@igalia.com>
Date: Mon, 04 Nov 2024 16:45:37 -0500
Message-ID: <875xp265by.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gabriel@krisman.be

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:


> @@ -67,6 +74,10 @@ _scratch_mkfs_casefold_strict()
>  	f2fs)
>  		_scratch_mkfs -C utf8:strict
>  		;;
> +	tmpfs)
> +		# there's no mkfs for tmpfs, so we just mount it
> +		mount -t tmpfs -o casefold,strict_encoding tmpfs $SCRATCH_MNT
> +		;;


This looks like a hack.  Why mount it here instead of _scratch_mount?
This should just be a nop for tmpfs.


>  	*)
>  		_notrun "Don't know how to mkfs with casefold-strict support on $FSTYP"
>  		;;
> diff --git a/common/rc b/common/rc
> index 2af26f23..2ee46e51 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -374,6 +374,9 @@ _scratch_unmount()
>  	btrfs)
>  		$UMOUNT_PROG $SCRATCH_MNT
>  		;;
> +	tmpfs)
> +		$UMOUNT_PROG $SCRATCH_MNT
> +		;;
>  	*)
>  		$UMOUNT_PROG $SCRATCH_DEV
>  		;;
> diff --git a/tests/generic/556 b/tests/generic/556
> index 51d2d482..78cdf1bf 100755
> --- a/tests/generic/556
> +++ b/tests/generic/556
> @@ -485,11 +485,20 @@ test_strict_mode_invalid_filename()
>=20=20
>  _scratch_mkfs_casefold >>$seqres.full 2>&1
>=20=20
> -_scratch_mount
> -
> -_check_dmesg_for \
> -	"\(${sdev}\): Using encoding defined by superblock: utf8" || \
> -	_fail "Could not mount with encoding: utf8"
> +# casefold tmpfs was already mounted in the mkfs step
> +if [ "$FSTYP" !=3D "tmpfs" ]; then
> +	_scratch_mount
> +fi

 can you fix _scratch_mount to correctly mount casefolded tmpfs?  if
not, provide a new local handler that will either call _scratch_mount
directly for !tmpfs or do the correct mount for tmpfs.

> +
> +if [ "$FSTYP" =3D=3D "tmpfs" ]; then
> +	_check_dmesg_for \
> +		"tmpfs: Using encoding" || \
> +		_fail "Could not mount with encoding: utf8"
> +else
> +	_check_dmesg_for \
> +		"\(${sdev}\): Using encoding defined by superblock: utf8" || \
> +		_fail "Could not mount with encoding: utf8"
> +fi

Ugh. the kernel message should have been the same. Much better
than special casing the test.

>=20=20
>  test_casefold_flag_basic
>  test_casefold_lookup
> @@ -517,7 +526,9 @@ _check_scratch_fs
>=20=20
>  # Test Strict Mode
>  _scratch_mkfs_casefold_strict >>$seqres.full 2>&1
> -_scratch_mount
> +if [ "$FSTYP" !=3D "tmpfs" ]; then
> +	_scratch_mount
> +fi
>=20=20
>  test_strict_mode_invalid_filename

--=20
Gabriel Krisman Bertazi
