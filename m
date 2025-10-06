Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816821A2547
	for <fstests@vger.kernel.org>; Mon,  6 Oct 2025 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759765525; cv=none; b=gmS3B6vYkiHvBxSCUoYN26eqblTF+9WEn3aXCQ2rbWCCX7UclbJEPETOpMvmzspl/BcpqlUh0Nf9E7RNIr8qE9DDpTiMRxjuIfmpD74VZz4k+zCpOfxm6uUpc8fk0ZDrfFiVXFpFdyTM8PuIGp2C/fXpRVkusOtsCA0YciCDc8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759765525; c=relaxed/simple;
	bh=ZCWd7FVJLQKznwNuy6v4DA8xIEx1VeEVA2yjWmyUQUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pD3dwkZ9dKt+rG80NtlTy7zV9GSq9Su0jpxltoRyQ1zUHTCa8mZ+d5qsmVv0Q3yRylNeLfLgFV3say2WnValBPtdhz3pUuwO3+AKTRNh901xRLivW75RmBhkcccuRxYxZqJJ5cux/IRQfL7G5DXxNTd6UBE56+w1H28Y2PDSs5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1STMmfk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1STMmfk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0783C4CEF5;
	Mon,  6 Oct 2025 15:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759765525;
	bh=ZCWd7FVJLQKznwNuy6v4DA8xIEx1VeEVA2yjWmyUQUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N1STMmfkqsitLRvr4uQFMq+zOGDhpoypKWBdx8cAFSTxmk3hPsCc26TubK9EipmGh
	 q8HmwpX3XC77ROd6mxfXZX9STpPS6wK8I3Q0W9Pp/VEDQPTMIuu1EkCAJL5t7Oc/og
	 4YfUbzUMzIwDiYTA1dW/Rk2S0jRwfxIGIQgMouxZrIW+EzB5Wn5n3EskpBhdBs29uk
	 AVnfcmHp6rmz29BT6Q9mgdHNdRdh1yjgsaK44fuUdDpMNk3Xfa/UybQSl1qSnPIaJ7
	 MTdVPO2NRX9UR6SZmHFVykkAA8hRu3bvDsPubIfFY2ezQZVCIIRPwuua5KP588qRxK
	 FmjXkqQgpDr5w==
Date: Mon, 6 Oct 2025 08:44:01 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jan Prusakowski <jprusakowski@google.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	Chao Yu <chao@kernel.org>, jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3] common/encrypt: Explicitly set the test file to
 uncompressed
Message-ID: <20251006154401.GA1637@sol>
References: <20251006095813.3497619-1-jprusakowski@google.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006095813.3497619-1-jprusakowski@google.com>

On Mon, Oct 06, 2025 at 11:58:13AM +0200, Jan Prusakowski wrote:
> verify_ciphertext_for_encryption_policy() checks if encryption works
> correctly by reading encrypted file's contents directly from a block device and
> comparing it to a known good ciphertext.
> 
> This, however, won't work if the test file is also compressed. So this patch
> adds a check if a test file is compressed and disables its compression in this
> case.
> 
> Signed-off-by: Jan Prusakowski <jprusakowski@google.com>

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric
