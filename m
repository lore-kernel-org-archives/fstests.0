Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DAF1F5825
	for <fstests@vger.kernel.org>; Thu,  3 Sep 2026 23:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788478531; cv=none; b=GTUtnE/P5ACRDpZ28AVlwk+rQODa76K+lrL8MiBcx5TsJqhDBjMVW2GrIEwtbjlCKSRBhXldJhzA90AqXd1DxTlGgKb5ZB8j6eSgjJIfdtJ1wN1DGcuQjlLS0+3ARIFgIMDZWFAXXbig9TLvrxz4h3ga+sKxxJhNdTf2AhvH8pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788478531; c=relaxed/simple;
	bh=mPNOTBrSMAC4G2nHqXCDHNEPDdqs0fWJuCO6lmHy5P0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TUb4gAw2qZktviMewFa5yfyhGOp8Was1fUWqHTs44RdSS5XueLS0jRTL4XJ8WtEfc/VAT/WpZRcMNalzRLzNVptLn3bcUaH6Fiyqg6ga1B+sx3/yYdePCdpERwBU5CNowR7lf07TiqaXvR0GPfPk6FRN2c+aNFJxqa3yDWh9CHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erh43BEy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erh43BEy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931591F000E9;
	Thu,  3 Sep 2026 23:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788478529;
	bh=wgqEUxliYrFxQGsD1XhQ1lqH4ox71paP4RLruXC57lg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=erh43BEykPb8tfzknpnDINUwC5ogzKPZQJiMSdGQxgJRN2ebF81K+1sEYaUAGpAIj
	 lYXNnfX/jJgxeWLGJZoVsVrutlJksUdi6cvnHdehKxG7so2scFdpRAyiF16VmNV/CM
	 R4ZTML3LGfZLgrgudmVV64P3ETx7BObG7+4PQtoNewQdYa77NEXCc/SER/0SlfCMXs
	 SSMVQ/guDhXkrVpZt0iBx7G+wu5sf0AZZ37s+m1V2lJEjUYv9NppfZb9WCE10CA9YR
	 ADHJyR3+gXWLG/ZyHGgFOU9l2J4d6nFtSVvpwV7LS4OMNtntva+xIXkdi8CSwTEQxC
	 v+gr1MQToHeSA==
Message-ID: <c46d8ed3-3d3e-4ab1-81ba-4a2696daf410@kernel.org>
Date: Fri, 4 Sep 2026 07:35:26 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Zorro Lang <zlang@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v2 3/3] f2fs/015, 016: add missing
 _require_scratch checks
To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>, fstests@vger.kernel.org
References: <20260903035344.752-1-prabhakar.pujeri@dell.com>
 <20260903035344.752-4-prabhakar.pujeri@dell.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260903035344.752-4-prabhakar.pujeri@dell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/26 11:53, Prabhakar Pujeri via Linux-f2fs-devel wrote:
> Both tests run _scratch_mkfs in a loop without first requiring a
> scratch device, so they fail messily instead of skipping when no
> scratch device is configured.
> 
> Reviewed-by: Zorro Lang <zlang@kernel.org>
> Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
