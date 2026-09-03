Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2C73515F1
	for <fstests@vger.kernel.org>; Thu,  3 Sep 2026 23:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788478563; cv=none; b=H/W+Kd+Vi9bU2vMn++wQc7ppvrA1id7DHhBibEw4mHe9drYmUmaJ3Dn63uq5YBJO21nocBdPa/LEKF8cnPQsgPRyiFGexy0aCMEc3XdxM2JcI1W8pcgbIXauWCZy/MZt/3OT1C7IUGPcUwdJofYx/nP6xhS+dAPRqDvtKAe8xVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788478563; c=relaxed/simple;
	bh=xSLhElxkNeQ+qZ0QLRSZt1zez1/LxKPmc8sTAJA+Yqs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OttNvlSc4OP9hMCqBJgsifgTqD0KUaSrTutQ3OgJGLcMCcTZV6Z8FjoujzOwvQ5cjwxAt+rcLGdRV2qL/AL+p6F89mCGGFPAVhBjfx2qSAvdXIRLzOwjfLizgQaYVC8ILY7d4VhcFnlbY6t+R1x+9/3iHptCxpuNyvt3kFDpo+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJBsWWAg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJBsWWAg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79781F000E9;
	Thu,  3 Sep 2026 23:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788478561;
	bh=v8aIrl8FVNE6aDkNh/Sn9rVod9l059Np9k7ejf2G7Kg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=KJBsWWAgiY7bZAdczjlBKPK+A+g1bSw2Ltmet+yOfXViPWPT9nX85sPgD4susLSRB
	 SkF48OCrzoj+9cls+B1it4Mqr41KoGYgUuh4it0Ajm8fHW5HsEeWX7lwU/lQI31JMs
	 1+1AcLS0Jv1xgCN2wYbVnxZ5Z51nD9lCXt+YGJK9dLcrWXIfd05OhNjNlhpCurpKPH
	 JQ2i7XQ1uQd3psgHkQpCR6oW3CpWLddkm7jCG/cFpiZc79fZkynsA4Va3xTFrzVmSS
	 Sx9QmP2hQfxDeqTbqciEaufKQbVKcxgxSwQLS0VlSwUdEwL78ely9l6StNubupGunq
	 I+n9a1mBe7YGA==
Message-ID: <4875d343-78ed-4a44-a479-f96b3847e8bd@kernel.org>
Date: Fri, 4 Sep 2026 07:35:58 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs/024: add missing execute permission
To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>, fstests@vger.kernel.org
References: <20260831104142.2229-1-prabhakar.pujeri@dell.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260831104142.2229-1-prabhakar.pujeri@dell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/31/26 18:41, Prabhakar Pujeri via Linux-f2fs-devel wrote:
> The test script was committed with mode 100644 while all other test
> scripts are 100755, so check fails to execute it directly with
> "Permission denied".  Fix the file mode.
> 
> Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
