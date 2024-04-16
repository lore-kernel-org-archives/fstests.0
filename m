Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2D1127B50
	for <fstests@vger.kernel.org>; Tue, 16 Apr 2024 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262801; cv=none; b=bRiaj7DIMduXIZFVqYQFT43r2f9XgKabuhUxQbMJk/gimHgdyaf3s7UIqAmDdOCMV9jqclOPalMQmUoWvRjHSjSqQi6u/2vfk9m8XXhUAC1tBBxcnRfllr9To5sNcMzYyICLjMazYOKJJqbDpV7mFdPrm7S33wVka0cUEM3I+/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262801; c=relaxed/simple;
	bh=F4FjHqN87UmanSyv65jjL7IOLPyOXqO0G1rKrueATwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AysNkZ+XrixqIcXMvB2Wyoq9cC/Vfksv3LWbmvMecxVt3W7OaAtcB5dKfmBpvF6JwAy31dL4M9AAzB9dlKXAHFMt3I6qMqWdcl4CUV+7FARWHmH+sBU93CX5J5n/Qy6Oz5vjkottLleD9nunPuSoAZXUQuHTzqmULcFIYOItH/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWfZ2HnC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWfZ2HnC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91EAC113CE;
	Tue, 16 Apr 2024 10:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713262801;
	bh=F4FjHqN87UmanSyv65jjL7IOLPyOXqO0G1rKrueATwg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JWfZ2HnCubyCMX64qleVofUf7ZROwCSdMDZOEDf9jCXg7uZ5tyrs5dyM07LYhV0FK
	 T2zo5/aIAoVSzjDGaIrVAS1D5vjE40tcLdYStB6046w75nidqrxvJOTjRbrspjuf3a
	 TkfZU/Qj4PPXecHgFWCyszrKZb4eThZ9gmo1FJbHzUooW8kGrue8HZ82kmw9UAw34d
	 mZOj8WQtsWLfL2T58BPAmyUkVKD9xJsmRk4bqxXWkNMkOWBIHSyAEANXQWsjQIeEGm
	 e70UNfSOPOHBFAeTwMs9o+VvsryvPlvGtLvCZHYV4/pO0lqAAHK5+i+0jxu7jqesOC
	 5B3u0QqSRYJ/A==
Message-ID: <1e6763f8-de07-4fc4-8d9d-ca948d66fdbc@kernel.org>
Date: Tue, 16 Apr 2024 18:19:57 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common/quota: fix keywords of quota feature in
 _require_prjquota() for f2fs
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20240416071819.5004-1-chao@kernel.org>
 <20240416084957.gyavejnhja6mofvo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240416084957.gyavejnhja6mofvo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/16 16:49, Zorro Lang wrote:
> On Tue, Apr 16, 2024 at 03:18:19PM +0800, Chao Yu wrote:
>> Previously, in f2fs, sysfile quota feature has different name:
>> - "quota" in mkfs.f2fs
>> - and "quota_ino" in dump.f2fs
>>
>> Now, it has unified the name to "quota" since commit 92cc5edeb7
>> ("f2fs-tools: reuse feature_table to clean up print_sb_state()").
>>
>> It needs to fix keywords in _require_prjquota() for f2fs, Otherwise,
>> quota testcase will fail.
>>
>> generic/383 1s ... [not run] quota sysfile not enabled in this device /dev/vdc
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   common/quota | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/common/quota b/common/quota
>> index 6b529bf4..cfe3276f 100644
>> --- a/common/quota
>> +++ b/common/quota
>> @@ -145,7 +145,7 @@ _require_prjquota()
>>       if [ "$FSTYP" == "f2fs" ]; then
>>   	dump.f2fs $_dev 2>&1 | grep -qw project_quota
>>   	[ $? -ne 0 ] && _notrun "Project quota not enabled in this device $_dev"
>> -	dump.f2fs $_dev 2>&1 | grep -qw quota_ino
>> +	dump.f2fs $_dev 2>&1 | grep -qw quota
> 
> This will _notrun on old f2fs-tools, due to `grep -w quota` doesn't match
> old "quota_ino". So how about grep -Eqw "quota|quota_ino", or any better idea
> you have.

Thanks for your suggestion, I fix this in v2, I've tested v2 w/ old f2fs-tools,
it works fine.

Thanks,

> 
> Thanks,
> Zorro
> 
>>   	[ $? -ne 0 ] && _notrun "quota sysfile not enabled in this device $_dev"
>>   	cat /sys/fs/f2fs/features/project_quota | grep -qw supported
>>   	[ $? -ne 0 ] && _notrun "Installed kernel does not support project quotas"
>> -- 
>> 2.40.1
>>
>>
> 
