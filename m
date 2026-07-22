Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659E317A31C
	for <fstests@vger.kernel.org>; Wed, 22 Jul 2026 12:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784723533; cv=none; b=eCjaaiXtf1l73cGPyslH5Df6O8rZi+OdR+8KHwBmKRPgCu3Jcjo/+q9/0UkuXHcKqxlMnrUtZGK35bsyZInf/cB1GfM4xDufvS/76mujhVTeiapLeUPde6sKF33pT+II0RNVR24t8aLa/Fpc37tRwP++czJkb3meav2D1kue54g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784723533; c=relaxed/simple;
	bh=jnLXGNstkqRuoHWOTCDF9CoHad6kW6Ceje+jcy75Zkg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kal7aQ4Awq8jyRCTsw6kck5uZRpjQAABq0PEcDObZzX2iMJZT33L8+M0lOGPlUfix+7pq24MI5kg7gxWkNf7XD+lUQdqFisMafuDVSEPkIZlcnCHSU3ZB5AMSgbU8hjjrq/2kSJKbG8FtBli5dAnIpx90YPCfl1vSKWjdxCLVG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuIE2qi0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuIE2qi0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A621F000E9;
	Wed, 22 Jul 2026 12:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784723531;
	bh=m0Y/uZeBndZkCpocqFDwBTaWaybc7JyISltkIQHYis0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=VuIE2qi0+vWsykZPrA/2KblJrRVPhJfeAVYpOzPUdbDJJEWClHBH0Me/K874LbUfN
	 sLL7DdqRkhMNG0x2Cciz9zyYt28AQ3Ifi7kunPjIpAugBx2DzYnc67bRpIY/xmsxm3
	 uO8u/Dp5oVAsLZIMnvC3ZlT0Ow5ImFyojQZzmpyxV+g0lwZOCqMiZ87aCADg4f0Kdx
	 yeTfMMCWLpW9qlXgpC0dJ4Y8fgzlFEAlZ4nqxwIzX7ZcN3NrT3TA/M48HnfTqnUFNk
	 QAlCM0naof/Z3sueFTb8lMxy27fM5uAGdu+hvzuFBfbG8mwKCxIa6zJwJF7rVNNGpf
	 +D4O9UVrS3Dxg==
Message-ID: <ad610328-ed1d-480f-9148-07c9b7a34fe6@kernel.org>
Date: Wed, 22 Jul 2026 20:32:08 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@kernel.org>,
 Jan Prusakowski <jprusakowski@google.com>,
 linux-f2fs-devel@lists.sourceforge.net, fstests@vger.kernel.org,
 jaegeuk@kernel.org
Subject: Re: [f2fs-dev] [PATCH] generic/064: allow 50 extents on F2FS after
 fcollapse
To: Christoph Hellwig <hch@infradead.org>
References: <20260622070438.1542638-1-jprusakowski@google.com>
 <ajuLORVplOvEXvnI@infradead.org> <akKd2IImO7bRjVV2@zlang-mailbox>
 <e7a57c5e-62de-401d-8e39-f7409f398a84@kernel.org>
 <al3Wcz5pIujPdTrL@infradead.org>
 <1a0bb2ad-c175-4cae-9e3f-79fbf69ce735@kernel.org>
 <amCGfUHu6kI4CPND@infradead.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <amCGfUHu6kI4CPND@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/26 16:59, Christoph Hellwig wrote:
> Can you clarify what "non-checkpoint data" data means?  Older data?

It is newer data.

1. write data first, and then trigger checkpoint, after checkpoint, data will
become checkpointed one, for such case we can only collapse w/ data copying.
2. write data (data is non-checkpointed if there is no following checkpoint),
then we can collapse w/ metadata update.
