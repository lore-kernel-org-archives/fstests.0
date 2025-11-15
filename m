Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F611A9F93
	for <fstests@vger.kernel.org>; Sat, 15 Nov 2025 10:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763204229; cv=none; b=QpQWT7qIEBQvq0xH33gMu6TTy8BIPDFtGslCmsfB/Pxi97ThGv58pQ2HxZVJxAbJJiWqijqb9m31WBrRPllXy9zVBcB6j2kaLMKRx7jiiuEjUfDC/6RWwmzNx3pGemx/pmoh67YXyCFwMvKePI6ktR3cM0G+yGwRU1+WzQgT0vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763204229; c=relaxed/simple;
	bh=foFDEWy+bYzmTH4FnmNpv5DVW7vFXf1COv38tcbMWMQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OpOj6II+KnUGc8zou+8qlctdE1iJTkfF6mP9gjfWG4nVXLTafO6flo2IwYigQ/ML42iJJ+d9xqBAMl2lVArvAm+7G9K/nyOlQIvnRu22aIl8xadp1iw7wdxra6flTItrgSj7mZUd53OHvt2/ZKy/kH9Gp04oUIy8TAuMQa5u4Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsDgxk1q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsDgxk1q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49453C113D0;
	Sat, 15 Nov 2025 10:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763204229;
	bh=foFDEWy+bYzmTH4FnmNpv5DVW7vFXf1COv38tcbMWMQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=lsDgxk1qEQpdf7VQ2TdDAledI26/tY7jk0s/8Kcy+wGOFSmjoAlGns6+BmxBq/zo8
	 S8NkKxseZncyXmcfMB+jQPLm0qS+/cuj0wDBnHGDPQ2xJDROq1PjsdJR5MnhN9oh0C
	 vrOXda+dnh7/J22O3Ybbz1Vo4kBLOnvRXTqbn/85/OTYNSxwnVYANZrvGoh1Ewt0aR
	 kGTUISKS3jr9HPmZFjPvg3/syPTVEPVl/dyz4eECJIXIffB/HwOj3wVmaopBrHqTin
	 VO9eA/cwZpLuQUprczcn1Cme/4aqRWdtQQcWC9F6obJeEkY1l355qx67W/pgXyFbn1
	 J4owRTx67Xfuw==
Message-ID: <3b3d2564-434a-4220-b62d-7c97b0955781@kernel.org>
Date: Sat, 15 Nov 2025 18:57:04 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 Joanne Chang <joannechien@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v1 2/3] f2fs/016: add test cases for test_dummy_encryption
 mount option
To: Zorro Lang <zlang@redhat.com>
References: <20251112135223.3467852-1-joannechien@google.com>
 <20251112135223.3467852-2-joannechien@google.com>
 <98034c77-5e47-43ea-9c45-335e2cd51b68@kernel.org>
 <20251115064907.tfrm6d5p2zlpmf7u@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251115064907.tfrm6d5p2zlpmf7u@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/2025 2:49 PM, Zorro Lang wrote:
> On Fri, Nov 14, 2025 at 09:33:58AM +0800, Chao Yu wrote:
>> On 11/12/2025 9:52 PM, Joanne Chang wrote:
>>> Add test cases to verify f2fs's support for different versions of the
>>> "test_dummy_encryption" mount option.
>>>
>>> To ensure test robustness, the MKFS_OPTIONS and MOUNT_OPTIONS are
>>> cleared. This prevents additional options from interfereing with the
>>> test results.
>>>
>>> Signed-off-by: Joanne Chang <joannechien@google.com>
>>
>> To Zorro,
>>
>> The changes look good to me, though, still I want to confirm that whether
>> it is recommended or not to add new cases in old testcase.
> 
> Hi Chao,
> 
> I think this case isn't a regression test to uncover a known bug, it's a
> basic mount options test for f2fs. So that makes sense to me to add
> "test_dummy_encryption" into f2fs/016, especially if it doesn't need to
> bring in more _require_* restriction (right?) .

Zorro,

Thanks for the confirmation, I agree w/ that.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
> Thanks,
> Zorro
> 
>>
>> Thanks,
>>
> 

