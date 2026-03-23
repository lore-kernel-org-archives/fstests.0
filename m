Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74422FE056
	for <fstests@vger.kernel.org>; Mon, 23 Mar 2026 09:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774257783; cv=none; b=oYbD5FlAARAFp9IzcUMPA1igFrAgdOSrfqnZwY7eBRIhrOzUrbqCzm66cWTzkGGBwZo1aFNIo4Od8LQfOM8LbyulfbxDhj1r++Cg9ZdjHJLkaRyC5KfJivvo64WmdP/NVcwJkyvtEvD38CNE36lHXSMsMcgd2ca/uMfuJA67Iz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774257783; c=relaxed/simple;
	bh=Md/3K/1YWnuoMAa6HdqNhhhC8PvYlXoK7J2Lf4KVoik=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SaMkJfIrPYou49axTTc23zf7mLJH/nU3WZq7Zup3SlNiLDFMyNmMeqHuugfMGG3bk2Tm+JKabl61pTnZ3q35oThVIfcmw+RyK5bQ7ImMMYjVJumUymHdPeyw4xT3nut+8QIVooP7L0/n8F0NonxAKOwKKZEYzDNwNGk08UaeC0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMU7Z+22; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMU7Z+22"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD8FC4CEF7;
	Mon, 23 Mar 2026 09:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774257783;
	bh=Md/3K/1YWnuoMAa6HdqNhhhC8PvYlXoK7J2Lf4KVoik=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=LMU7Z+221EIfAkbZfgbSgQA7A2fCtke6+OsvzifuwdN4YAV8K47mf/AFDlxmOkXZZ
	 tY6tB5yOM3uPjrdaSdsEHeDdVkVRSB8ibjHWPmnVkKT7ssxayHpMTtIKN7vdDmjj/Z
	 4GUN6775gPRWCySO6+riD8FrTBMYR/pPaiAePNZWs1TaCXLZHEiwLUJTzcvJ+L+8vm
	 UGQJtmswOQGjyPro2rsrirzEf5k/HUAJYx4/XIHddXN2Pei5jF62Yut7tJ7CKY7fDh
	 7FVqaFqNbJTwoS14bFe7h88kwND773nrCNsWGrPAyZyF1ZvryZ8j9ZHQxf5NsFpizH
	 0GrT5DVwuSGmg==
Message-ID: <c0e09f6d-ec4a-4bce-b27a-35af2be5b2de@kernel.org>
Date: Mon, 23 Mar 2026 17:22:59 +0800
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
Subject: Re: [PATCH 1/2] common/config: export F2FS_RESIZE_PROG
To: Yangyang Zang <zangyangyang66@gmail.com>, zlang@kernel.org
References: <20260319033519.3954784-1-zangyangyang1@xiaomi.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260319033519.3954784-1-zangyangyang1@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/26 11:35, Yangyang Zang wrote:
> export F2FS_RESIZE_PROG w/ resize.f2fs, it can be used for resize f2fs.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Chao Yu <chao@kernel.org>
> Signed-off-by: Yangyang Zang <zangyangyang1@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
