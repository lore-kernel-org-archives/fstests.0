Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B6F1F4192;
	Wed, 18 Jun 2025 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750273177; cv=none; b=toSqFiRLW02LbHPlaeS7cyf9h1mEtJYJaQpAwb3T3sk7GLTVljG0Jq8AiAQxfEVnj95xLrv3qCm6MYCNK4CxVxXl0IBzoQcmB54AtPVx1fNyCqC/BC4ZLaJtpMtiM2g6Tpfj10CBGwng7R9UCW3smr7vJfFbPINv10gz4rMSe8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750273177; c=relaxed/simple;
	bh=qiQLJxl7h5T2ZLklfM8AjfZOPq6OO2w9se1+es+oDv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ag2KUhxLEw9oCX0PkhIO9JU062R9Ieek8Ck5b5+UMlChY6KMR/TgTnrrL+GVBP+Gwpp3Bgx6HFWmrL8l7IX5cddoj+mQPZs6VSURdGoezs3eV98K6tZzKqV3Qomxc7UxlZAoaJB0VWAOiY4MRIwZmAvkAH3JGrobYtXCXI5BWJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVblkuai; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVblkuai"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98036C4CEED;
	Wed, 18 Jun 2025 18:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750273177;
	bh=qiQLJxl7h5T2ZLklfM8AjfZOPq6OO2w9se1+es+oDv0=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DVblkuai8S3pWNKCTPY0Klk06+9KLa6UJ9s1BJzYgkkkZzx30IWlTAowSvNQzoasj
	 TQ6JVUqbBh8gO53buIkH3e1DAYnkBRagZ9NUr28FEE13ZiUvmSzRb2iFzb8OkV9cdw
	 AsXVJilo7BlIkGfNdG1egVGRuXj5aItNqjbXISpSj3nTfWcXyPKRzFYl197yx4y+dA
	 uwdgShD/nul6MwsOR+MzRHTYGbfzc+fvyoVBz8yUHvKQWWsKEbbbCUmQIda0WzgWx/
	 bUUJQfudh8yVmIzjUn/pBT96Hz1TgZJ3Q7UZatJoShlb7gtQFDSFy8LRUhgyVyQkC5
	 XuEudaPsFc2sw==
Message-ID: <bb6b7187-1671-4a90-bfc3-6e4100e615b0@kernel.org>
Date: Wed, 18 Jun 2025 20:59:33 +0200
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH] generic/551: prevent OOM when running on tmpfs with low
 memory
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, Hugh Dickins <hughd@google.com>,
 Luis Chamberlain <mcgrof@kernel.org>, kdevops@lists.linux.dev,
 Chuck Lever <chuck.lever@oracle.com>, gost.dev@samsung.com,
 Daniel Gomez <da.gomez@samsung.com>
References: <20250618-fix-tmpfs-generic-551-v1-1-271027c36dfc@samsung.com>
 <20250618184744.a7tzgv4dofrqheq6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250618184744.a7tzgv4dofrqheq6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>> diff --git a/tests/generic/551 b/tests/generic/551
>> index 4a7f0a638235e272ef55ffeb3b3e548707568379..6a7376d7a8e3580bee0a5c98eacdaf93c60c8d5c 100755
>> --- a/tests/generic/551
>> +++ b/tests/generic/551
>> @@ -38,6 +38,7 @@ do_test()
>>  	local truncsize
>>  	local total_size=0
>>  	local avail_mem=`_available_memory_bytes`
>> +	[ "$FSTYP" = "tmpfs" ] && avail_mem=$((avail_mem - free_size_k * 1024))
> 
> This makes sense to me. But better to have a comment for this. If you don't
> have more suggestions, I'll add below comment when I merge this patch.
> 
> # To avoid OOM on tmpfs, subtract the amount of available memory allocated
> # for the tmpfs

Looks good to me.

> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks
