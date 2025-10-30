Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3DA21ABAC
	for <fstests@vger.kernel.org>; Thu, 30 Oct 2025 06:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761807025; cv=none; b=asnIavIntNOm2QTC2nYXrwvDuijw07ENH6OuiZsROr06y0PKIPRTKLCe8cWlATy+/ft+FbH1CpFaOV0L9PCZa6zWTvuBfSNCMF2sfCWQEajdILvep+tEoS2jEAI40tz5shIF3hVQIpg7j7LihMY6euUEn+PpPeSlYoe3/anxIuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761807025; c=relaxed/simple;
	bh=ZDSDO4xje51D+u1Yg+tz6FNILft6gTJ2PTEcBB+My8k=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hd+Z8jr4RqQDgD11j6J32MaCPsneP/PyBBTVxQLS3VYy93OSkUks1xR50jvmDdOxi0xO/Qc53J5247QSwWbyycXI1HcgkVR+CZ3/mt8iAOPYoUFL/psBnTus48ocKOp5RIhVxhNtR/0BSSF+1zgRAPD0yyVJc+G6OJ5nepr/Odc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrmPvf6K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrmPvf6K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74A9C4CEF1;
	Thu, 30 Oct 2025 06:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761807025;
	bh=ZDSDO4xje51D+u1Yg+tz6FNILft6gTJ2PTEcBB+My8k=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=VrmPvf6Ksyp1U2rcKmNNDYTgxhfPDAsSEunNr7LzehBIafrn4mTSUdkI6RxIy9Es3
	 tdKIrg0RdgTUlQSM11muiarrBKYKBu4d0dreP01ctE+Sta7K1dQrwv24MSDrL9zSeL
	 orbAaBeRFhb/l1DqkfdH+Egf/GGFQKJxF5d1EGNj+sH2YQG0tuq4w7a+0ZuAhB+Soq
	 yOclCTTszwVoxnk66VZPRCUe/L/nmMmrnXZgXcmz3/sqtPmoYHsGEkwuOgOXgF96rP
	 ETb8CbHoJ8rN4ZRB9ivT/VSYZ28/mzfv2pqHZJk4G/DU8fJ/GJrU65CAJ33XVY/kdB
	 Hc/7XCNkYfBAA==
Message-ID: <010cc7fc-4d51-49b3-929a-06b1e408580c@kernel.org>
Date: Thu, 30 Oct 2025 14:50:21 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs/011: use random data to avoid file compression
To: Joanne Chang <joannechien@google.com>, Zorro Lang <zlang@kernel.org>,
 fstests@vger.kernel.org
References: <20251030054540.278518-1-joannechien@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251030054540.278518-1-joannechien@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/25 13:45, Joanne Chang wrote:
> Currently, the created files are filled with 0. When filesystem level
> compression is used, they take up much less space than expected. So
> the final fallocate does not show an error.
> 
> The created files are filled by /dev/urandom instead to ensure they
> are not compressed. This way the files take up the same space whether
> compression is used or not.
> 
> Signed-off-by: Joanne Chang <joannechien@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
