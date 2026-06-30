Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C0940863B
	for <fstests@vger.kernel.org>; Tue, 30 Jun 2026 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782821363; cv=none; b=X5Hl0kAsiRJ2aKmZo5qFdlu9K8RTnFVrJC2eqmkpikRyGjvLTKCSmfaoi5c8HTvZIYcyQ79tIOL+4QgVZ/DsZBmN+vBtTCIY74H7SZqMAcWKIqf0mri6WbaG/3n/R37ihCqjFPCl2AXg0iV0XbI+cWu4VJmS1oWmklwTwPX+aiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782821363; c=relaxed/simple;
	bh=Z9smw9cRozJ3Rz73XUfsgW4aJz1gTYPl+U9xxPU1lF8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rz7SeZW4IFsvGCyKe6TVJbySwlcnAdgkOmlD1QYc0dv6XuzFZyHY+QSeBX8mKhA9QuIfJAVMBRTWP6f5gUcYZ53j7syj43O4SZtAqaOfJk/1LKCFnMc0gV50ZvcHjSf1l7U0n4kBHj4Vf9d6mffceGatWRsRAChI4XL/UyL6P2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnVEi9ne; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnVEi9ne"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2BC1F000E9;
	Tue, 30 Jun 2026 12:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782821362;
	bh=DvHcNk1NdP2Vtsc0m0nKrmohuP/D6QozrKLzgnXVJjM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=SnVEi9ne4/qQxPRz9gcf2UXRrkNQO5dBIr6cufy1g98cDljoGdpwDebmpWCRHPP9c
	 ph9bEXTsQooGZ/MyNNu8dW3W58Mt7/pn7mwHAnNeUrouxwrCdbvX7EwhxeGH4vKeuB
	 kMCHOKh0Q80USqf/1ybeAaL8EhQXKbiMq6i9533ZFr+93KYuc37Yfk10b3lV5YOiZ+
	 8NVCk9TVcgec9H5eqzVfK4RStXfCY+1+Q9oOE4wfgJk3IHBxDP1w0WIgWC6hrcmMID
	 gZSzgRdN7gnuM8qvdyfrU+RuaUg4gY5cxLhsBFem9UMwJbEKLD0bNZlODxkmofH7z8
	 NAPNOWJXdJNQQ==
Message-ID: <e7a57c5e-62de-401d-8e39-f7409f398a84@kernel.org>
Date: Tue, 30 Jun 2026 20:09:19 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 fstests@vger.kernel.org, jaegeuk@kernel.org
Subject: Re: [f2fs-dev] [PATCH] generic/064: allow 50 extents on F2FS after
 fcollapse
To: Christoph Hellwig <hch@infradead.org>, Zorro Lang <zlang@kernel.org>,
 Jan Prusakowski <jprusakowski@google.com>
References: <20260622070438.1542638-1-jprusakowski@google.com>
 <ajuLORVplOvEXvnI@infradead.org> <akKd2IImO7bRjVV2@zlang-mailbox>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <akKd2IImO7bRjVV2@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/26 00:37, Zorro Lang via Linux-f2fs-devel wrote:
> On Wed, Jun 24, 2026 at 12:46:01AM -0700, Christoph Hellwig wrote:
>> This sounds odd.  The test allocates a contigous range and then just does
>> insert/collapse on it, which should not lead to any new data block
>> allocations.  Given that the test works fine on zoned XFS and btrfs
>> with strict out of place write policies we know it does not require
>> overwriting blocks to work as well.
>>
>> So I think something is fishy in f2fs if needs to allocate data blocks
>> here.
> 
> I have the same question with Christoph. Shouldn't fcollapse in F2FS just
> remap the metadata instead of allocating new data blocks?

Hi Christoph, Zorro,

Let me explain it briefly, this is because f2fs has only one copy of reverse
mapping table (aka SSA), for any checkpointed data, we can not modify SSA info
directly during remap, otherwise, after sudden power-cut, we will suffer
inconsistent issue in between reverse mapping table and mapping table. So, f2fs
choose to rewrite for any checkpointed data.

Thanks,
