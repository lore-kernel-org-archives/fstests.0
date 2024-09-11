Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD587E0E8
	for <fstests@vger.kernel.org>; Wed, 11 Sep 2024 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049463; cv=none; b=evH5YM6X67/NdvvzGyOm+8VUAyCYubFqw+wLIOCXUQTfsqHTPNUvLM2vZnNJsrGk00uViX5MlfHaTOZw7XOczFrk/uc6NqmHj5HfZLtEQP6rHlV8eLPOeDtm+olBvTMAY8yZktD+fISa2f3iKRVQ8PIegjNeKsE/gYxam1P33jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049463; c=relaxed/simple;
	bh=jL5h4B5+mpGIPS82Roc6ZlySVDe+/+V8jrLLkwZJmi4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RTeobtw2VMwKNZspIcnMx6Ip38s0Kl4ho5qf7KMyA/URuQi8sVWMzOIxGcKjffqrWIR3t9hax5md01I8j5WxrJrcaF+rvFl3GS9a6AmW078QAfpvM+17hqhTB2i080/7ijbmbTueD88OGYlhNocIZkFg679fdE7TpbrneXp23z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnWBA3qf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnWBA3qf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43B4C4CEC5;
	Wed, 11 Sep 2024 10:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726049463;
	bh=jL5h4B5+mpGIPS82Roc6ZlySVDe+/+V8jrLLkwZJmi4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=fnWBA3qfsC7kUy7OszBuSV5ZLLkBCviGmdczsAdTZTZGaYlTL0sgizY1TmBCiCBeL
	 AX/E0Mr/d8+8po2HTYqub/jn+rqjJ+m45eQJ9oEH6csr2pVXygBtMXRpMcZ5vu7D1Z
	 JsjAPzkiQG5oth1M8pw2azqMtM/peZJxB1Yi9lewipJGqnN+ApTcnEKjXLoUIFdMCs
	 htNAJjFBIVEdYH9ZYu2JMtD0wes98PjYnRg3W75APh7SaXpPPzoUy796AdqNgb6lwG
	 AtYHwKw1T1P1NOYjdJRMlmm1Mc5+ktduZQW7PYIx/YJwbMDNsDrh91YzXLVh9xri6R
	 WBoNKWMWHCMKQ==
Message-ID: <648a1578-eccc-4c9d-8d27-2c87dbb71e06@kernel.org>
Date: Wed, 11 Sep 2024 18:10:59 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
 Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] src/min_dio_alignment: don't return invalid
 dio_offset_align
To: Christoph Hellwig <hch@lst.de>
References: <20240911035333.364961-1-chao@kernel.org>
 <20240911074641.GA5629@lst.de>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240911074641.GA5629@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/11 15:46, Christoph Hellwig wrote:
> although one day we might want to do something smarted with this
> information.  That being said a file system not supporting direct
> I/O is a bit silly these days.  What is running into this?

After applying commit 5c8764f8679e ("f2fs: fix to force buffered IO
on inline_data inode"), inline_data enabled tmpfile shows it doesn't
support DIO, then it results in deadloop of generic/465.
