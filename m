Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888F638B122
	for <fstests@vger.kernel.org>; Sat,  9 May 2026 08:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778315522; cv=none; b=FgNtcaZlEGQGmNVuUUq3q6E2mr88obUh64eQJeiy8beyv0NqjBR8CmFW9LlA1PDY+rNZ/c9xh8KKa4v1nWt1Uaf4mbiuIsUH9NR6YqEA5zf5lBYXfyBAiyzXDL+03u8MAbHGBuAOaFjR6YTSPHn9F3BAbN79xhLyGzZ9zE6Kl2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778315522; c=relaxed/simple;
	bh=0bdQQ2wA5FedFLaMxTyI9ncfC/Fm4fJDrtT7xGwnJxM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J66qWpvRAi2umnd5+VcbSyENninA6+DtvjOi6ggCLeMxIaOCg+ehcV7A8DapxEdFmCHpYhv25evGnMYcZEF5n1o3x1nk37oHlUGOs4ErGiDRgpdIqdAjcIKuuj+hDaFrCoBMrXToOHVr4gjTepps/ntlL/H8nq2NiHWP4L/qLMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cmk0tDqg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cmk0tDqg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EDEC2BCB2;
	Sat,  9 May 2026 08:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778315522;
	bh=0bdQQ2wA5FedFLaMxTyI9ncfC/Fm4fJDrtT7xGwnJxM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Cmk0tDqgirLVPS3IYvDAHmbgHp/Oil3qwZygeoMmqb+YTjj+RkXh6I2TmUmz9/JtK
	 1Z9YvnoYQQVZnLENtLbkRBUUJww4G0C/VOogkxRvGWDcYycnD/YRrdCNGGtp2KjiFq
	 WeMQlmjgjPME8ye7v2NQhc0hy0HL7CsCbkqTqch3zPpDvvIDbGE2osFShjDBsp/0Z6
	 22Yos+i1679BjJ3xMH50pYAHsC4XD+TIG0+YTgxp0N3MlOE8RlgfubUDJKrA/Vcj/Q
	 OxdnQA4QMkgtBqC6jkXgBeT/e81JE59pumnFIbWChNsUaX5ieHfelRpZ+hiTcPubQj
	 SPes+efQ03gTg==
Message-ID: <c7717c73-550d-46d3-9c12-7826e55f73e7@kernel.org>
Date: Sat, 9 May 2026 16:31:57 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v1] f2fs/{022,023}: clear MOUNT_OPTIONS alongside
 MKFS_OPTIONS
To: Joanne Chang <joannechien@google.com>, Zorro Lang <zlang@kernel.org>,
 fstests@vger.kernel.org
References: <20260428022440.2481342-1-joannechien@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260428022440.2481342-1-joannechien@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/28/26 10:24, Joanne Chang wrote:
> Currently, f2fs/022 and f2fs/023 only clears MKFS_OPTIONS. This causes
> the tests to fail when leftover MOUNT_OPTIONS depend on unapplied
> MKFS_OPTIONS. So MOUNT_OPTIONS should also be cleared to ensure reliable
> mounting.
> 
> Signed-off-by: Joanne Chang <joannechien@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
