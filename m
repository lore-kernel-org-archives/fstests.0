Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41FA12836A
	for <fstests@vger.kernel.org>; Wed, 27 Mar 2024 18:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562797; cv=none; b=ZbTDBzf3kzO8Pf1yWLhLyEYLBMzPJ9qREPRaiZZoSPcVLCkkkkbumZ/0HKtsf0xqDI89GiiIlUNUznEu85lViP29e7MR40AJG3BeTONj+LfKN1VXAQuuYCq+TgAr2xRyQkI4NzF5E1+0hJPRfS+a/+xjA9PcPNb98Uz3UCMO3qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562797; c=relaxed/simple;
	bh=ilSMZOtYgOW43wnqNNfr8dlBwR3z7OGSoOEQHfBceS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i0wZh1rqNlnR9IJK11Lpe/Z+8n6hb+pMJdsn7HW1+LNyDLpnv+PqZ55Gr5D4QLNNIIpNxNmAeGsfFG1bF7NhNh6wSEagrSoGjZVOWRlpLhRvaQsX0AFAnUfT+PtHqNoHS6zidzIkYu9FQ+MQVRHlpQkCpZsu7XRyVaNyYCfzs0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=hkDoNKMy; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="hkDoNKMy"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4V4ZNy3vTvz9sm6;
	Wed, 27 Mar 2024 19:06:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1711562786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jp958lDmEhCrrR4MVcTl/BLYEtBym5+I6Fu9rpujd+s=;
	b=hkDoNKMyDHlhngPnAL/7OkA7IFew9KrYc2ZXMmKDoo3CIPS7ItTfE/TUxrl4iGyhvdj1Au
	za74u03PSY22rUbkLQKCIrATyW9CmUMQUEYD9YV3s/T94GtGlUp7DvkSDOAsAVaaxhlU9h
	/srsrn7g/3AX7eIKsEieJPxjR0HN0+rY7DCriwNLJAYYBUvkAZd5eOsGbkHq84OVbPguBc
	jyR2AQro7qi2xMqn6NoKEHmqKYPWOuhQkvhJYu8TlMePZZ+RT6pIZRFGTX/xTcferjDCJJ
	F12zGWO8YM43w9jDP8W+FeC0nw7QS0iDrlr3JvPGc7VWz8H1g52RcL0Q+DHZbw==
Message-ID: <4c020072-b7b2-4519-b9ff-b80ba50a6419@pankajraghav.com>
Date: Wed, 27 Mar 2024 19:06:23 +0100
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] xfs/558: scale blk IO size based on the filesystem blksz
Content-Language: en-US
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, djwong@kernel.org, gost.dev@samsung.com,
 mcgrof@kernel.org
References: <CGME20240313203828eucas1p22e2b127e8597e2e72397f26370c54b42@eucas1p2.samsung.com>
 <20240313203818.2361119-1-kernel@pankajraghav.com>
 <7f1c749d-069d-4a42-8b87-637f2dfa6f5d@pankajraghav.com>
 <20240327133731.f36a5wtz7hoe7r5b@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <20240327133731.f36a5wtz7hoe7r5b@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4V4ZNy3vTvz9sm6

>>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>>> Tested-by: Darrick J. Wong <djwong@kernel.org>
>>> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
>>> ---
>>
>> Hi Zorro,
>>   I checked xfstests/for-next and didn't see this patch queued up. Do I need
>> to do something or will it get queued up for the next release?
> 
> Oh sorry, due to this patch was in a patchset with:
> 
>   [PATCH 2/2] xfs/161: adapt the test case for LBS filesystem
> 
> So I don't know if you'd like to have them both together, or merge
> this one (with RVB) at first:)
> 

The other patch needs some more discussion I think. Please feel
free to merge this one in as it already has RVB :)

> If you hope to have this one at first, I'll merge it in patches-in-queue branch,
> then have it in next branch.
> 
> Thanks,
> Zorro
> 
>>
>>>  tests/xfs/558 | 7 ++++++-
>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tests/xfs/558 b/tests/xfs/558
>>> index 9e9b3be8..270f458c 100755
>>> --- a/tests/xfs/558
>>> +++ b/tests/xfs/558
>>> @@ -127,7 +127,12 @@ _scratch_mount >> $seqres.full
>>>  $XFS_IO_PROG -c 'chattr -x' $SCRATCH_MNT &> $seqres.full
>>>  _require_pagecache_access $SCRATCH_MNT
>>>  
>>> -blksz=65536
>>> +min_blksz=65536
>>> +file_blksz=$(_get_file_block_size "$SCRATCH_MNT")
>>> +blksz=$(( 8 * $file_blksz ))
>>> +
>>> +blksz=$(( blksz > min_blksz ? blksz : min_blksz ))
>>> +
>>>  _require_congruent_file_oplen $SCRATCH_MNT $blksz
>>>  
>>>  # Make sure we have sufficient extent size to create speculative CoW
>>
> 
