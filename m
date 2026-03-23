Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB1E38552C
	for <fstests@vger.kernel.org>; Mon, 23 Mar 2026 09:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258509; cv=none; b=abeptA5ijh1D+bpYF+mXeDWEw3vCC9sWhYj58lx5RwO6czWrF2W6e2l66cyc8hT+gOdsU3jNQ1g0SgNIw3r3Uvc6v6cIwO54y/bds9PrslQogbB7z/+capc+7c5f6yJf4r916fGuumpqH78f98O37BwT+U3vU6rt65aw0BOoiPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258509; c=relaxed/simple;
	bh=845t7eLTgzrtGaH/BU6YRImwl/8UJP55LaAZ4SQ5z64=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eUCQJgDMZNahHUpczvufm9M9EwP7zjYsks87C167UqXbwH0NRRDyjteL3MYpZrOB7MnphnoagXKgHyx7IF17EKNchdVv7ujn9BiY0gpFwfwUzHiJiNNfp7r+wtX/htN1ZjfSKQgFEbARaooT46/V2E+mSY6865ulRqJ93a/kRrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrCb+c1M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrCb+c1M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C9AC4CEF7;
	Mon, 23 Mar 2026 09:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774258509;
	bh=845t7eLTgzrtGaH/BU6YRImwl/8UJP55LaAZ4SQ5z64=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=mrCb+c1M3VLvuCFGTL/FEQQgu4rKMd0bWFiZJvCyIoPAx7ptfn055XtELi1GuJOCv
	 1bI1OYWLexRKkltiKsiyKIjso/udWs6qtOEORdZCmf40vOUNWcatDk2dDpXzyj9W34
	 gBlaXLSR2IQcwYWp2lNgnBkbMceayYnDj5jJFfm+yuqReIujYiH9IbuNWdxnYieQwz
	 DxrfGP/7AzXAsyONNo6LQ/ngyaimPrDG4IAkBxWrrBl5FEudvd9TWkfCN7ljFyB6Z5
	 6xlbRZplGDRzHDPX8c/1S80CJB7qHTeY0XfuNnv3Nze0ntMYneGqM1AqxEyvz3ZuwP
	 OqO+jQtNE3LfQ==
Message-ID: <59040f8a-ee7d-4a56-8f98-0e7e1527bff0@kernel.org>
Date: Mon, 23 Mar 2026 17:35:04 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net,
 Yangyang Zang <zangyangyang1@xiaomi.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs/024: add testcase to check resize corrupting
 root inode
To: Yangyang Zang <zangyangyang66@gmail.com>, zlang@kernel.org
References: <20260319033519.3954784-1-zangyangyang1@xiaomi.com>
 <20260319033519.3954784-2-zangyangyang1@xiaomi.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260319033519.3954784-2-zangyangyang1@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/26 11:35, Yangyang Zang wrote:
> This is a regression test to check whether the f2fs root inode
> is corrupted after the resize operation.
> During the resize operation, SSA data blocks are migrated and
> zeroed. This process may incorrectly zero out the main area
> blocks, leading to root inode corruption.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Chao Yu <chao@kernel.org>
> Signed-off-by: Yangyang Zang <zangyangyang1@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
