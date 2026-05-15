Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEE03D410B
	for <fstests@vger.kernel.org>; Fri, 15 May 2026 04:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778818889; cv=none; b=E98zOVMsv+xojYwUVHfds/6JSmtHSw+Y8kiVlC1EkS1EQlZm+0WI50W0mNrw2xT2JPSHu5R1rNI9nHNHpfeiJpfxTpnVIjp1qbG/gY7xOeyp1Tu4gmRjVC7qZk+QKgfljLlj4oz9nzQ8jV9FWbMQYAx4NNGX1G56uWm//pfytFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778818889; c=relaxed/simple;
	bh=1hwyYbJ/lx4eY+s7V6mdbavb6iE7LNxuin8WYSh1mqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yxy3nTtqKcaWNP/h9lRHe9sQkUZGmfE+ZlKERhHawOezGVAmhv7rrk9Zz5H5rEfWOQrn89bNQmwNUXrZpXvnGx/DWEtKR6rfj6cDfykVK5B+odclV/WEdJ9JBY4xJV7eFxJJhrq21MwqVRTtx0dNzcp/qZPPMwV9n8YVhB3+rQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCIV9X9e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCIV9X9e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163E2C2BCB0;
	Fri, 15 May 2026 04:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778818888;
	bh=1hwyYbJ/lx4eY+s7V6mdbavb6iE7LNxuin8WYSh1mqU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QCIV9X9efhsVIKh6BkXawkYENMqm3KVWLguYThz2jdXkzCY124o53dtmY+cQqW5jc
	 fg5YO7IcbFm05eRMzMiKcogWAFDegXnWbF9aiplGy1wytWEr4+iKRoecMPGcRI+p2Y
	 n6BSsZsbNdv5uNvGX1TK2B2s9+y6rfJHg2PsNHmajTdLt0HAqfhBqsCWM8KivLoTZI
	 hvMnGxSpcIaZA0HxYHHSyPmbvlsmN4fQb7cxOijXHIyWDv0ODcQvJ2y0uQDSGS0enT
	 9vmdjWyoO1Rn6Wtus7puG4bby35MbqI+O+wD+PCElh4qR7oTEf+a/SVCa2vSDdjEg/
	 SB+HIZm90HweA==
Message-ID: <5352628c-8c61-4df3-8460-ca44a4fcbb2e@kernel.org>
Date: Fri, 15 May 2026 04:21:26 +0000
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] f2fs/021: Fix mount syntax for disabling jquota
To: Joanne Chang <joannechien@google.com>, Zorro Lang <zlang@kernel.org>,
 fstests@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
References: <20260513032009.2300435-1-joannechien@google.com>
 <20260513032009.2300435-2-joannechien@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260513032009.2300435-2-joannechien@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/26 03:20, Joanne Chang wrote:
> F2FS has removed the trailing "=" in the mount options for disabling
> user journaled quotas. Update f2fs/021 to try the new syntax first and
> fall back to the legacy syntax if the initial mount attempt fails.
> 
> Signed-off-by: Joanne Chang <joannechien@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
