Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5C934C98C
	for <fstests@vger.kernel.org>; Wed, 22 Jul 2026 01:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784683352; cv=none; b=dhWsrPPGKoowjc9U5s4NrF8c/vstM0WK0tT+vLEEUe6J8EdoV97C4Qb5xBPLWFdLcFuZjNKMtIp5NyjvemQd9ZMXbBeEM28ZGyssS8QD4zC7rOKu8S/wQBzYRCOBPkGaDvK753N4Np+bHnDvUfnz4iid/AdW4tf90U1A2MZ8JuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784683352; c=relaxed/simple;
	bh=/Z4kdgxKQCeiFsoamHKOWe6dtjkBnTbiGgCEPrpeogw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tHUQDQEdJijlGTpjQBipEicx+hDZFGuw2iFfSfJuErsNZGmqZu18E9m2U84+SP1kzqanusbrOTMc1i/eFtCgQ6tlyY39Ry66b2qz/AyllQ+VtMr08w6gf/6pHePS3s405bDuBHYdQy8MbLHA67qujVZL6ryeS5/WjZone0vrP1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMVRgGEq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMVRgGEq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258531F000E9;
	Wed, 22 Jul 2026 01:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784683349;
	bh=/mdT7jkMjc7sjvrquAnjFRY5QkVWbjefxRKNNQNYOUc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=GMVRgGEq0Ekm/HdYqrmx+Jd1ZvgwMvLyNrZUrhg31y4yrN6SqkrQz6bc3Z+b1Tfnw
	 mPdu4tEQ0m//1DN5Svt4iar52Lx3SAIwsRbuGSZfoekShzKy5hbk5wwF/LhPcjR2Qz
	 M/wD6s3PkmYBoKcNU58zTNt1H2kK3Z5jIz7jtgi0rxxdVpwBcjegWhVJyq/+FywIpv
	 ty8YcL2fVrgIc9by7g3lATAiZluiFM5OGByz77eTAbqVdQwhuoeygVy9ngOzIRg7pR
	 zBNfVdnk8ClWKMfjBX4n7JQSzQgkhA5COJ5e3sPUiHMi6YOx73odJUnGH2QCZEM1ji
	 jsdBhtIjAZlAw==
Message-ID: <d3500e74-6e7f-4535-baba-36c63f0601c8@kernel.org>
Date: Wed, 22 Jul 2026 09:22:26 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Christoph Hellwig <hch@infradead.org>,
 Jan Prusakowski <jprusakowski@google.com>,
 linux-f2fs-devel@lists.sourceforge.net, fstests@vger.kernel.org,
 jaegeuk@kernel.org
Subject: Re: [f2fs-dev] [PATCH] generic/064: allow 50 extents on F2FS after
 fcollapse
To: Zorro Lang <zlang@kernel.org>
References: <20260622070438.1542638-1-jprusakowski@google.com>
 <ajuLORVplOvEXvnI@infradead.org> <akKd2IImO7bRjVV2@zlang-mailbox>
 <e7a57c5e-62de-401d-8e39-f7409f398a84@kernel.org>
 <alyS3PRtALHIV5no@zlang-mailbox>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <alyS3PRtALHIV5no@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Zorro,

On 7/19/2026 5:24 PM, Zorro Lang wrote:
> On Tue, Jun 30, 2026 at 08:09:19PM +0800, Chao Yu wrote:
>> On 6/30/26 00:37, Zorro Lang via Linux-f2fs-devel wrote:
>>> On Wed, Jun 24, 2026 at 12:46:01AM -0700, Christoph Hellwig wrote:
>>>> This sounds odd.  The test allocates a contigous range and then just does
>>>> insert/collapse on it, which should not lead to any new data block
>>>> allocations.  Given that the test works fine on zoned XFS and btrfs
>>>> with strict out of place write policies we know it does not require
>>>> overwriting blocks to work as well.
>>>>
>>>> So I think something is fishy in f2fs if needs to allocate data blocks
>>>> here.
>>>
>>> I have the same question with Christoph. Shouldn't fcollapse in F2FS just
>>> remap the metadata instead of allocating new data blocks?
>>
>> Hi Christoph, Zorro,
>>
>> Let me explain it briefly, this is because f2fs has only one copy of reverse
>> mapping table (aka SSA), for any checkpointed data, we can not modify SSA info
>> directly during remap, otherwise, after sudden power-cut, we will suffer
>> inconsistent issue in between reverse mapping table and mapping table. So, f2fs
>> choose to rewrite for any checkpointed data.
> 
> Hi Chao,
> 
> Thank you for the detailed explanation. I now see why F2FS handles this
> differently.
> 
> Since this is by design for F2FS, I'd like to merge this fix to help f2fs
> avoid this test failure at first. As for the potential write amplification
> and performance overhead introduced by this rewrite strategy, that can be
> discussed further on the f2fs list if necessary.

It makes sense to me, we can discuss about the detailed implementation in f2fs
list if there is any concern.

> 
> I will merge the patch with some clarifying comments:
> 
> /*
>   * F2FS uses a rewrite strategy for fcollapse/finsert on checkpointed data.
>   * Since F2FS has only a single copy of the reverse mapping table (SSA),
>   * directly remapping checkpointed metadata could cause inconsistency
>   * issues after a sudden power-cut.
>   */
> 
> Is this ^^ good to you, or feel free to give me a proper comment to add into
> this patch.

Looks good, thanks for the help!

Thanks

> 
> Thanks,
> Zorro
> 
>>
>> Thanks,

