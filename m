Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D121AAE1C
	for <fstests@vger.kernel.org>; Wed, 11 Sep 2024 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066497; cv=none; b=NT6TFlVNaJ59mEYXrqrTEIjmeH3XAm13DLLY/fAsrEFgWFD5BgTgD/FR8B1WvHQLwcGbxEUwiPIVABAXjSI2cd49ketFU1nMNXVL2iFxUst5sQJOjH4lb6yieM4xOFLIlu+Koo1r9tPdmoWMp8K5nj6yCmhINI7AMzXhTRaZBgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066497; c=relaxed/simple;
	bh=0ZID5gMcWYIOJK+q78aKhpBptk9JRfKQDj8s0E1RsHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sigyZoKrQP8R9TfxtIb7wnzTqkmlJBhUqTQk46frs4budUzAyGc3kqh6Zr1LOUtstyTi6GnYFSfZCZcNSGbzp5WqpByMEfuRJr5vFhxkWqTET5R1xYU8GfdJeSBO2PNjuHo8UswctCIgTcWWEnO4bX8wao1Wb+gR7Bvf0xcBFCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=quXHroTg; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="quXHroTg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6rzpKmZ4IjyHobi545RZD97SLNleeiRevpGr3BkiWfE=; b=quXHroTg8oX6f44VxhxcpcmC7F
	cFprRhOc739gQMcYkAoSOtGGHrJURX35Czd6FuPubKmQhWvIAdv8O0ugu4Z8VwWfNbsZAw1pJzW4P
	7rbm8RyH9Zke6/ao66wwTZeH8mjDaIx8ykH59q1ks3uOrFEHwrHCp+uPhSqOg6kiaSQzr16ZZMXP7
	OiCtE+MTLX+vJqrdKu4uE9jvbtKen6fj6hO7tRA45XNCFIKBeTWYq1qGHTi1bCAqpQu42oymNr5wq
	cHnZ8f78O9qEqTzJvh3YUVB+XqRhuPw+fCtzMlAZBPfUXaaXUqwk92a9+i1nLkfyOk1+rSZ20PysV
	kLR7X19A==;
Received: from [177.172.122.98] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1soOk8-00CU8b-Pg; Wed, 11 Sep 2024 16:54:53 +0200
Message-ID: <80890a40-acc2-4947-885d-2064a35b47f6@igalia.com>
Date: Wed, 11 Sep 2024 11:54:49 -0300
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common/casefold: Support for tmpfs casefold test
To: fstests@vger.kernel.org
Cc: Zorro Lang <zlang@kernel.org>, kernel-dev@igalia.com, krisman@kernel.org
References: <20240823173008.280917-1-andrealmeid@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20240823173008.280917-1-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 23/08/2024 14:30, André Almeida escreveu:
> Test casefold support for tmpfs.
> 

Due to changes in the kernel side, this diff is required to run the 
tests. I will send a proper v2 when the kernel side gets approved.

diff --git a/tests/generic/556 b/tests/generic/556
index cbc0146b..78cdf1bf 100755
--- a/tests/generic/556
+++ b/tests/generic/556
@@ -492,7 +492,7 @@ fi

  if [ "$FSTYP" == "tmpfs" ]; then
  	_check_dmesg_for \
-		"tmpfs: Using encoding provided by mount options: utf8" || \
+		"tmpfs: Using encoding" || \
  		_fail "Could not mount with encoding: utf8"
  else
  	_check_dmesg_for \

> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
>   common/casefold   | 11 +++++++++++
>   common/rc         |  3 +++
>   tests/generic/556 | 23 +++++++++++++++++------
>   3 files changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/common/casefold b/common/casefold
> index d9126f4c..8a646ae6 100644
> --- a/common/casefold
> +++ b/common/casefold
> @@ -12,6 +12,9 @@ _has_casefold_kernel_support()
>   	f2fs)
>   		test -f '/sys/fs/f2fs/features/casefold'
>   		;;
> +	tmpfs)
> +		test -f '/sys/fs/tmpfs/features/casefold'
> +		;;
>   	*)
>   		# defaults to unsupported
>   		false
> @@ -52,6 +55,10 @@ _scratch_mkfs_casefold()
>   	f2fs)
>   		_scratch_mkfs -C utf8 $*
>   		;;
> +	tmpfs)
> +		# there's no mkfs for tmpfs, so we just mount it
> +		mount -t tmpfs -o casefold=utf8-12.1.0 tmpfs $SCRATCH_MNT
> +		;;
>   	*)
>   		_notrun "Don't know how to mkfs with casefold support on $FSTYP"
>   		;;
> @@ -67,6 +74,10 @@ _scratch_mkfs_casefold_strict()
>   	f2fs)
>   		_scratch_mkfs -C utf8:strict
>   		;;
> +	tmpfs)
> +		# there's no mkfs for tmpfs, so we just mount it
> +		mount -t tmpfs -o casefold=utf8-12.1.0,strict_encoding tmpfs $SCRATCH_MNT
> +		;;
>   	*)
>   		_notrun "Don't know how to mkfs with casefold-strict support on $FSTYP"
>   		;;
> diff --git a/common/rc b/common/rc
> index afc33bbc..e2f4e4eb 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -374,6 +374,9 @@ _scratch_unmount()
>   	btrfs)
>   		$UMOUNT_PROG $SCRATCH_MNT
>   		;;
> +	tmpfs)
> +		$UMOUNT_PROG $SCRATCH_MNT
> +		;;
>   	*)
>   		$UMOUNT_PROG $SCRATCH_DEV
>   		;;
> diff --git a/tests/generic/556 b/tests/generic/556
> index 51d2d482..cbc0146b 100755
> --- a/tests/generic/556
> +++ b/tests/generic/556
> @@ -485,11 +485,20 @@ test_strict_mode_invalid_filename()
>   
>   _scratch_mkfs_casefold >>$seqres.full 2>&1
>   
> -_scratch_mount
> -
> -_check_dmesg_for \
> -	"\(${sdev}\): Using encoding defined by superblock: utf8" || \
> -	_fail "Could not mount with encoding: utf8"
> +# casefold tmpfs was already mounted in the mkfs step
> +if [ "$FSTYP" != "tmpfs" ]; then
> +	_scratch_mount
> +fi
> +
> +if [ "$FSTYP" == "tmpfs" ]; then
> +	_check_dmesg_for \
> +		"tmpfs: Using encoding provided by mount options: utf8" || \
> +		_fail "Could not mount with encoding: utf8"
> +else
> +	_check_dmesg_for \
> +		"\(${sdev}\): Using encoding defined by superblock: utf8" || \
> +		_fail "Could not mount with encoding: utf8"
> +fi
>   
>   test_casefold_flag_basic
>   test_casefold_lookup
> @@ -517,7 +526,9 @@ _check_scratch_fs
>   
>   # Test Strict Mode
>   _scratch_mkfs_casefold_strict >>$seqres.full 2>&1
> -_scratch_mount
> +if [ "$FSTYP" != "tmpfs" ]; then
> +	_scratch_mount
> +fi
>   
>   test_strict_mode_invalid_filename
>   
