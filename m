Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0799222F77A
	for <fstests@vger.kernel.org>; Fri, 30 May 2025 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748609587; cv=none; b=MTN9oyh/Q3kQwptfu72/Hh6A6POYqM4VhS50kYvE0CSZVe52HVEe7CO5YYd2vE7DIMtVgeq+BzN+dpDI9iUuH0B3YSnyEdh7l+eyz4ivCO4oCLWBHi8/UaCJNxdkuunXrbLxyX2IqF7/UnheLe5V74Ez8vPMO0wv1xM8pJOsrEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748609587; c=relaxed/simple;
	bh=SEikAtc7gEUD30o/zg/MQXV7dFuimQdgUgpDmBrr7OE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BJUmxvjpuihDbyLFfINxm0+8V5L/60EnRmbP6K0k9I+NVvh1M/tirXQtBTV6D7RTo0Kgerbcxi4fjzdF/drk1MG38WOMC8ATTJxYmEllFcZVSOMLeYWlU3opukrMIFg1ZaoxG8zvdC9Do/UATGrNK8kDN1atmnSzjlV+kc2rwbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJjTNXGs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJjTNXGs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FFAC4CEEB;
	Fri, 30 May 2025 12:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748609586;
	bh=SEikAtc7gEUD30o/zg/MQXV7dFuimQdgUgpDmBrr7OE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=bJjTNXGsVjKoduYFHsYbRmQB84krmxxZ4lK3HWTQB/4KUA3KcpO6/8dUEmkS2qHQM
	 aAWMm55KQIBewZ57UUTOnd5XeGGnMTUkXT9ITm/InqOWc8lpy9yAZWbyqMlGMP1VHf
	 y2OzCc73rgBs7LcBJ1pl3lhj53TSMcIgY3AjxeiwdeCd2MTC/fIcUO0OESalfEjLEm
	 g0ERtqh0ZSVTYwyJA6LlutLWkeaO4vSb0PfZe43iaeCCMFvI32rSB8qsMcnG/c/qib
	 dyUmy1RtN2OGvzMcxNozmxCia/WG1xWxWebEb8YMfaCCur/pBNTKsaOmY53k2CmD3D
	 09wJwUtlbicBw==
Message-ID: <bd236bb4-ce45-47da-97da-4da12424a536@kernel.org>
Date: Fri, 30 May 2025 20:53:26 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v1] f2fs/004: avoid race condition in test
To: Jan Prusakowski <jprusakowski@google.com>, Zorro Lang <zlang@kernel.org>,
 fstests@vger.kernel.org
References: <20250530092349.3407742-1-jprusakowski@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250530092349.3407742-1-jprusakowski@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/5/30 17:23, Jan Prusakowski via Linux-f2fs-devel wrote:
> In current implementation the atomic write may not start before
> the direct write and the test fails.
> 
> The patch adds a delay after starting the atomic write process
> so it has a chance to actually start wrtiting data and set the
> internal state of the file correctly.
> 
> Signed-off-by: Jan Prusakowski <jprusakowski@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
