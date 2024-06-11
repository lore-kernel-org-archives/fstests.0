Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CEC1EF01
	for <fstests@vger.kernel.org>; Tue, 11 Jun 2024 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718116022; cv=none; b=dMKdePcJhxZm1WyZsD5kZm+0AIWfGjsOVqcF+O3yXtwSNAHzmmJMMbDDO7htXTzCbwUwN7hzwlEGON2JKVjE67TbnMMnwvrhmpPitgufzptOCR9Yq8NGhhEpEnJof5ADClkryQ4hnbmsIhSQfpgEX46BgA1HxZS5F9wX+tjvmB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718116022; c=relaxed/simple;
	bh=TLloFvEbwJFVq7jQmKKbzeKIKRX3NXiLx6PksiwLPgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubAFkuelMsMITbWFgLJWXoInbgpMPJ9kIYQ2zu6H2k9n4rNntPUbifmxtz3Jmg1pgb+2TxN5g5HE2Zal5sGJFKDypi2FGYMC2mV3g/KChQTZ+52Yi2Kyo7TykomzqVMD6mD+MvM7PP/Np9fcCt2ds2ZpmkhVzL+LVkhaHNixhJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjRszY36; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjRszY36"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A848C2BD10;
	Tue, 11 Jun 2024 14:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718116021;
	bh=TLloFvEbwJFVq7jQmKKbzeKIKRX3NXiLx6PksiwLPgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gjRszY36oFqhzNZZuIqkCK2JtNHEnNONQKaQq58vSiN6IerJe03xNMc/+Cz1gScke
	 AhoYHCwLr77nUUjSEwHzezJ23O6aLDWaNuP/xT1L2eEAYNKNyXSg8jQsXSZbBvA8e9
	 LEhlGd/zo8eFWJ2Iuqd08uzq/ArIFEuoI1r7mtL8QPORncZIWwc3uIFCEB/mq3/bUg
	 l/IuMFvT1Cg1H7HcGMA57kSYUoWOHlZ1jKAKVb8odtoUJI41JmsddIRGBDYl4FIPEy
	 PZ7TkOU9SXkvHp/NgKXnWzOydDTg6uH0W+DXHwSRcKCqhFP6LulKYjgOilskBHZopi
	 oA5I5D6qZ3f0Q==
Date: Tue, 11 Jun 2024 07:27:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] generic/455: skip the test if the file system
 doesn't support journaling
Message-ID: <20240611142701.GE52977@frogsfrogsfrogs>
References: <20240611085853.200102-1-tytso@mit.edu>
 <20240611085853.200102-2-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611085853.200102-2-tytso@mit.edu>

On Tue, Jun 11, 2024 at 04:58:53AM -0400, Theodore Ts'o wrote:
> This test uses dm-log-writes to test power fail scenarios, so it won't
> work if the file system doesn't support metadata journaling.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  tests/generic/455 | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tests/generic/455 b/tests/generic/455
> index da803de08..75437b90d 100755
> --- a/tests/generic/455
> +++ b/tests/generic/455
> @@ -65,6 +65,13 @@ _log_writes_init $DMTHIN_VOL_DEV
>  
>  _log_writes_mkfs >> $seqres.full 2>&1
>  
> +# This test requires metadata journaling since it simulates a power failure
> +msg=$(_has_metadata_journaling "$LOGWRITES_DMDEV")
> +if [ -n "$msg" ]; then
> +    _log_writes_remove
> +    _notrun "$msg"
> +fi

_require_metadata_journaling $LOGWRITES_DMDEV ?

afaict the _cleanup() function will call _log_writes_cleanup ->
_log_writes_remove for you.

--D

> +
>  # Log writes emulates discard support, turn it on for maximum crying.
>  _log_writes_mount -o discard
>  
> -- 
> 2.43.0
> 
> 
