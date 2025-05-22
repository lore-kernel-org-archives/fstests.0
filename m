Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB506ADD
	for <fstests@vger.kernel.org>; Thu, 22 May 2025 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903015; cv=none; b=Zhkqo8A4O8qWF1taGBfbiX1h5RUehrUog+DGTdpRoM78QHi4ftzX7lrkvyn0Q/Tg+49qJUxDxitax2YnE0P77TrXhcGK1neUTviiJGOr9BmH9y9TYQEZ9ElODuUtheLEF5uqPQm07zYny/MHJ2UeXJpW/8Op9NiDGsTZgyQp1XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903015; c=relaxed/simple;
	bh=hL+6H9AaWWoIjAEaas77G354kMS7X6T9lSREDfs09+I=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dU5k7QgwDAtVGS3xj0aymLiZbxgkadELBAVGM5Hy8XdXc8yjMSRWdirfLTiWxx16HIgNEvMrHEOy7Lpw0UgmY1p4WRWESlEn+ql1GUUzYSqhOUlKnmsdUVBpS8hkDE8XKtCflR/AxH3MgsuHn6VEpX2H3JYA0X1dZbuWsCBbaAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQQGoeY3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQQGoeY3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7791C4CEE4;
	Thu, 22 May 2025 08:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747903014;
	bh=hL+6H9AaWWoIjAEaas77G354kMS7X6T9lSREDfs09+I=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=TQQGoeY3LpyZiuZn0KWdVEU+kWNSoElSz4ImZjatnYsFuvzo8nPRr1OXvnm/PZ4Ws
	 RrSDHRHWYnZNFA9iph0QXJVQahbAq+TiYp3MJbHQZ4/tdg3ROqCRiF3K/mbBBb7QbA
	 uhgJYWlKXQma5UFq0wFD0otLVwVc92Uca98FN+LIsNxfMRbiS6ZGu0/7DiUuWli5KG
	 t8Zox9BGVqYzmLbmMEcnxMEiP5ZyXAr3colcOvcYblUik7qz30ow6+PBj8vhm5s6uS
	 pk6ZiMjImIq4SgYtPV7h70btcIBIuNLN6O4yiy0xaoZ2GLu0UEGhv6PFt5ODwBHtDx
	 NiT9XfCBnUIyw==
Message-ID: <1b490dd3-3f08-4955-babd-42203d80cfa4@kernel.org>
Date: Thu, 22 May 2025 16:36:51 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs/014: test for missing 'trimmed' flag issue
To: Chunhai Guo <guochunhai@vivo.com>, zlang@kernel.org,
 fstests@vger.kernel.org
References: <20250522075706.1604641-1-guochunhai@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250522075706.1604641-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/25 15:57, Chunhai Guo wrote:
> This is a regression test case to verify whether the CP_TRIMMED_FLAG is
> properly set after performing the following steps:
> 1. mount the f2fs filesystem
> 2. create a file, write data to it, then delete the file
> 3. unmount the filesystem
> 4. verify that the 'trimmed' flag is set in the checkpoint state
> 
> We should apply the commit ("f2fs: fix missing discard for active
> segments") to resolve the issue where the 'trimmed' flag is missing.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
