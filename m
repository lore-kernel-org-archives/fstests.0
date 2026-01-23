Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379773033E0
	for <fstests@vger.kernel.org>; Fri, 23 Jan 2026 04:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769141294; cv=none; b=afK0LOc6vooi9bVCfR1j+82FiTzBE3jnmddd6RVDDMtai/P7XxP0j/rS0Rc9G3qFnIVvmNRMfmi9gwMRfXNFnhCKLFvgeKv2Z3g8qJDI6aSdqz1y+6K5XXK74HQ2AvsI/cBhPBeiLaYsr3sLbWeBxE7tZ3z25/3DQZtJpsoEebg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769141294; c=relaxed/simple;
	bh=T/HYvcY7VYFetxiMmPBkWe1rxWLD89ZdhJPfSk242Ik=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GFFY37pmItbIgihAwlb5UZXdJhUJgtFcPg6B9ZN3Cz5g6Uz9quXQNQ/LdMuA0VXZA+3UmntpD9YKr7cmVu48OzI2Br8pyvx9yYfmmC3Ta00n5sL2mhb8Q6xL0d5KwbgZiqu0qSu2zMkTtFf8mcPHjxkUeqlnq1I6nPQVT7hNsaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c15z6Qdu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c15z6Qdu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525D7C4CEF1;
	Fri, 23 Jan 2026 04:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769141293;
	bh=T/HYvcY7VYFetxiMmPBkWe1rxWLD89ZdhJPfSk242Ik=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=c15z6QdumavZYAnmXinL3OE/e6AbtEKRUaSuxjNH9u1G3E3WiofXkTDs4z7js+ow1
	 3DCiEE/zgh6lH4y9B84ZQ6d4GN551CdiIjzP45AUTpBaq6HK55RyTlm8FwisKGf6ZQ
	 LOaRByZclSk6tcvZq8f/eMiLpA73nK720axo2BJF6ltBOEjwSk5dSjyd3X29KruIu8
	 EGdCfFQDcEMTzTOXGV3mObH3csgkSwiTczrvKjXHKn6EeAY2pb4/U2L42YDTnqNNBp
	 vtGszcKPBszVfxwCYL+HO3pTwSiEG2v2mlsGDUNjFKdC9OO1WKRbck3VLsvlaIgimh
	 m8oRQ3aA4YDcQ==
Message-ID: <88894e46-f2e9-4d14-90c9-d6cda51abfcb@kernel.org>
Date: Fri, 23 Jan 2026 12:08:11 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3] common/rc: add _require_blocks_in_file helper
To: Joanne Chang <joannechien@google.com>, Zorro Lang <zlang@kernel.org>,
 fstests@vger.kernel.org
References: <20260108022501.754320-1-joannechien@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260108022501.754320-1-joannechien@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/2026 10:25 AM, Joanne Chang wrote:
> generic/735 attempts to create a file with nearly 2^32 blocks. However,
> some filesystems have a maximum file block limit below this threshold.
> For instance, F2FS is limited to approximately 2^30 blocks due to the
> capacity of the inode. So add _require_blocks_in_file helper to skip the
> test in such cases.
> 
> The helper uses a hardcoded constant instead of a programmatic method,
> so that bugs which affect the maximum file size are not masked.
> 
> Signed-off-by: Joanne Chang <joannechien@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
