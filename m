Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837FB30BF60
	for <fstests@vger.kernel.org>; Mon, 15 Sep 2025 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946876; cv=none; b=DSM0yY1NLYmau4gKVUFCIWOk/YcA8tjNM3Ory+56ht3YQsWJ9+aPobEzXG0OOiH3fiUWIKj/cWIcX5xZ51qSoo4XMubPVmUvCXwa7iDTzeLiV4aJTE7oIJgS6gcartO3RCghNuYWK2ncv/SxTXF3e6QzIN+tbTrOO/qf4uHB56Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946876; c=relaxed/simple;
	bh=gpkBymIM0PotRRa+sl8Mo38/j8spjGtGIICmzaHvpi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUQe3rO0Rb5n4ptHPYhRHt3STQVOGhi/a8mnB6EJwzE5y2SXtVWW02JOwhZldApFFIHaWGPdC2vPOHelAJO0ujIvErA7Jvxu2VxCv8KlraIfXjyOxTm8OdtD4uW89m4ytCPnaNIROib8th44xWDKVt9hvZxdu40TIkE4d2aU0G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPaPXOyc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPaPXOyc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C3FC4CEF1;
	Mon, 15 Sep 2025 14:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757946876;
	bh=gpkBymIM0PotRRa+sl8Mo38/j8spjGtGIICmzaHvpi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZPaPXOycDJnkNwIUlcymPar2CNX/vPvjn4EaQM5bsCGBP8ZyGVaPcq8iIRLi15UfQ
	 RxgDjG5KN4/R4B5GUodqa18zyfS8xQshfoPKhhEFFybLZHMOZOyLjRjGFDIZ5z5aTl
	 9nvbenG0sPeA/Bp9ydKZJmW6nZvygqtCMEQeTwC9EK+cX1WTvL4I9F9C0bfgie2jrI
	 mLDftSL5L7I0Av8kMLMxmke/RGrNQ6/HImOFK0ZxWc+wvwfzKayjWIWoTYhk/Gq9mX
	 hz3MUFdIBhVal3LAkvYgZhJ/uddYUowVVtkgkGp3/wy8R1OSn3BjIimMt+5reQ+B/c
	 Zqxp0DuJITLtg==
Date: Mon, 15 Sep 2025 09:34:30 -0500
From: Eric Biggers <ebiggers@kernel.org>
To: Jan Prusakowski <jprusakowski@google.com>
Cc: Zorro Lang <zlang@kernel.org>, Chao Yu <chao@kernel.org>,
	fstests@vger.kernel.org, jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 0/1] Do not run
 _verify_ciphertext_for_encryption_policy on compressed FS
Message-ID: <20250915143430.GA1993@quark>
References: <20250915100451.810719-1-jprusakowski@google.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915100451.810719-1-jprusakowski@google.com>

On Mon, Sep 15, 2025 at 12:04:50PM +0200, Jan Prusakowski wrote:
> Changes in v2: (Thanks to Eric for the review)
> - Instead of disabling the test entirely when file compression is used
>   we now ensure that compression of the test file is disabled.
> 
> Jan Prusakowski (1):
>   common/encrypt: Do not run _verify_ciphertext_for_encryption_policy on
>     compressed FS
> 
>  common/encrypt | 7 +++++++
>  1 file changed, 7 insertions(+)

FYI: for a single patch, there's no need for a cover letter.  If a
changelog is needed, it should be in the patch itself, just below the
"---" line.

- Eric
