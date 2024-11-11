Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133FF155327
	for <fstests@vger.kernel.org>; Mon, 11 Nov 2024 18:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350794; cv=none; b=ZSNKix7zXqew5gaeP7E2mS92Op+wAjzCN1fTulvYi3HNmLH04TvTaLo7f2LD/p6hJSPlmJ9QtOpS6X3V6iMDPw4SLst9H+p1IwxFC/k7uwEeL7Ct9EKB3PNSkCsx7ain+oPwx02lyCdyA2K1FXGsbBwl668SDxTHVgOoBSW+Twk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350794; c=relaxed/simple;
	bh=ZYkEW6GYtq3je9vZ2gnsmq0XML41gQejNkPtotx092k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NIIhhVFptxGYQ3TPndULV/07NuLTKOGxCv43bcrqIO5qR+hhc5RdEuQb3cDHAiHjzKHO+v85BP210abG6U6NGJcmDdyjyLMyCrSwfhKPNxPvNyHuYqZFsOSb4njK7AXU3u8jdwBcOnRP6rHA5+6WhGuY5uMjiISYgQB6Vnz304s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=V59ghRrG; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="V59ghRrG"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7999E1BF203;
	Mon, 11 Nov 2024 18:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1731350791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=noh60YmAYEQuBTrUuxbKQVkn574CX3VL+aDy7svr4Ns=;
	b=V59ghRrGQuGk5Ksu9aj/P1Qamj3+zv2KxA+Yj0TQKWGGpCC4/BYSV643C1YjTCL1WGQxeW
	lxAuWTQVKWhqajiwoheL6cJKyHma8GYB+1Kc0bMAhdN/t55vW2Tu+GdA0rDYdfe9r4aDA2
	tDMISH5Ckcn08XSPTOHOiY4M4GVwN0m1AXxsP+DSJ1dx5ZttEgvHzsSF0gtZzYaMTynsVT
	jhXda0toEOefdITbucbRyxJTK9LSxqODWyqd+w45jXNtbgDbHbPfTx9SxLdQs8FgaduXUq
	M664qlAB/RsBroSCCjsytp+ztpIlgmsE1JcA4UYc1dqDb+2hXoi5xPcNYnLFuA==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: fstests@vger.kernel.org,  Zorro Lang <zlang@kernel.org>,
  kernel-dev@igalia.com,  Miklos Szeredi <mszeredi@redhat.com>,  Eryu Guan
 <guaneryu@gmail.com>,  "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3] common/casefold: Support for tmpfs casefold test
In-Reply-To: <20241109234618.29262-1-andrealmeid@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Sat, 9 Nov 2024 20:46:18 -0300")
References: <20241109234618.29262-1-andrealmeid@igalia.com>
Date: Mon, 11 Nov 2024 13:46:28 -0500
Message-ID: <87o72lwquz.fsf@mailhost.krisman.be>
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

> Test casefold support for tmpfs.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  common/casefold   | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  common/rc         |  3 +++
>  tests/generic/556 | 12 ++++++++----
>  3 files changed, 57 insertions(+), 4 deletions(-)
>
> diff --git a/common/casefold b/common/casefold
> index d9126f4c..2aae5e5e 100644
> --- a/common/casefold
> +++ b/common/casefold
> @@ -12,6 +12,9 @@ _has_casefold_kernel_support()
>  	f2fs)
>  		test -f '/sys/fs/f2fs/features/casefold'
>  		;;
> +	tmpfs)
> +		test -f '/sys/fs/tmpfs/features/casefold'
> +		;;
>  	*)
>  		# defaults to unsupported
>  		false
> @@ -52,6 +55,9 @@ _scratch_mkfs_casefold()
>  	f2fs)
>  		_scratch_mkfs -C utf8 $*
>  		;;
> +	tmpfs)
> +		# there's no mkfs for tmpfs, just return
> +		;;
>  	*)
>  		_notrun "Don't know how to mkfs with casefold support on $FSTYP"
>  		;;
> @@ -67,12 +73,52 @@ _scratch_mkfs_casefold_strict()
>  	f2fs)
>  		_scratch_mkfs -C utf8:strict
>  		;;
> +	tmpfs)
> +		# there's no mkfs for tmpfs, just return
> +		;;
>  	*)
>  		_notrun "Don't know how to mkfs with casefold-strict support on $FSTYP"
>  		;;
>  	esac
>  }
>=20=20
> +_scratch_mount_casefold()
> +{
> +	case $FSTYP in
> +	ext4)
> +		_scratch_mount
> +		;;
> +	f2fs)
> +		_scratch_mount
> +		;;
> +	tmpfs)
> +		mount -t tmpfs -o casefold tmpfs $SCRATCH_MNT
> +		;;
> +	*)
> +		_notrun "Don't know how to mount with casefold support on $FSTYP"
> +		;;
> +	esac
> +}

> +
> +_scratch_mount_casefold_strict()
> +{
> +	case $FSTYP in
> +	ext4)
> +		_scratch_mount
> +		;;
> +	f2fs)
> +		_scratch_mount
> +		;;
> +	tmpfs)
> +		mount -t tmpfs -o casefold,strict_encoding tmpfs $SCRATCH_MNT
> +		;;
> +	*)
> +		_notrun "Don't know how to mount with casefold support on $FSTYP"
> +		;;
> +	esac
> +}
> +

Now, I noticed there is some infrastructure to provide mount options
through _scratch_mount_options that would be a better fit for this
instead of the custom handlers I previously suggested.

Either way, the test looks good to me:

Reviewed-by: Gabriel Krisman Bertazi <gabriel@krisman.be>

--=20
Gabriel Krisman Bertazi
