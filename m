Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F051123D7CF
	for <fstests@vger.kernel.org>; Sat,  6 Dec 2025 00:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764979273; cv=none; b=BFB1OHEoff0RNmZKygyY4lW8HLH/80pYbwg2CNbCKWAQlNEx1bIIVIpYzSsFbolVYa/AnkTNeXKYPuFpPObqAsbkqlEto1Sycx3eRzxEd/7bxqsLzJb2doIAM89Kdp+8igru/kuZZOy7KWqMpeS94bPeSmgokwl9Nf9LENqNr54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764979273; c=relaxed/simple;
	bh=+lN5wIwhDaDg72YXfRpNBVd+nbvyZo6XT1Ms4UmxTZk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BnEeqQ18RkaVA+azcAQ8G6QaANB9/ugXaOqcIunehEtu+zKZKihb45TXBjc1XvE7uiiKo3eK1F03zCfY6vKAcMPbSrOgWUSscIlHodiNhoR+RauEvcTOC0JX5LREV64AQwTqUOquQ1LKJeEPzKs5sndLtuQ+mZIyxoAkK4HkV0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WH3qo2gr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WH3qo2gr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D20C4CEF1;
	Sat,  6 Dec 2025 00:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764979272;
	bh=+lN5wIwhDaDg72YXfRpNBVd+nbvyZo6XT1Ms4UmxTZk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=WH3qo2grGzGNdZQpazdi/fiZ18tg3i97518c9uOJQbKqFgwe9GRpDMo0ibjAAZxR+
	 4z02JwmlXiqUjgwCyOVlQPepLi9wWd3Rt/D1ZpMTNxmWeYeYNEnAtLQC7vcYt59qzZ
	 dby3iDf1kAHIxXrz9uu1SR9ALqWYxnYy94jRHnLpa6YcdHQfOxqEs975yQoXOl+xGv
	 dI/XU4t6Yg2tkCRRE7isJ9BQrB/QX14Fx8BfFBIo01pDZIXeHstEQQkjiMVTh5YgNE
	 hGjYoMwXWdP7HSLvbq3FaJ7fubiwz1DQXPndEPro8P4W8RmQnkPFz0bmW/P+vk7rJH
	 WfxEmGTzMvJdA==
Message-ID: <aaee103e-c511-40a3-868f-6139df6e9c92@kernel.org>
Date: Fri, 5 Dec 2025 16:01:10 -0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] common/quota: fix to wait for all inodes been evicted in
 _check_quota_usage()
To: "Darrick J. Wong" <djwong@kernel.org>
References: <20251203193147.3320893-1-chao@kernel.org>
 <20251204215941.GF89454@frogsfrogsfrogs>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251204215941.GF89454@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/12/5 05:59, Darrick J. Wong wrote:
> On Thu, Dec 04, 2025 at 03:31:47AM +0800, Chao Yu wrote:
>> generic/233  3s ... - output mismatch (see /share/git/fstests/results//generic/233.out.bad)
>>      --- tests/generic/233.out   2025-01-12 21:57:40.259440359 +0800
>>      +++ /share/git/fstests/results//generic/233.out.bad 2025-12-04 03:02:26.000000000 +0800
>>      @@ -4,4 +4,12 @@
>>
>>       seed = S
>>       Comparing user usage
>>      +4c4
>>      +< #1000     --   31476   32000   32000            994  1000  1000
>>      +---
>>      +> #1000     --   31476   32000   32000            944  1000  1000
>>      ...
>>      (Run 'diff -u /share/git/fstests/tests/generic/233.out /share/git/fstests/results//generic/233.out.bad'  to see the entire diff)
>> Ran: generic/233
>> Failures: generic/233
>> Failed 1 of 1 tests
>>
>> Sometimes, generic/233 will fail due to it founds inode count is mismatched
>> in between in-memory one and on-disk one.
>>
>> The reason is cgroup v2 implementation requires to increase inode reference,
>> and then attach it to thread related cgroup writeback structure, once it
>> needs to switch once write owner changes of target inode, a kernel thread
>> will process it and then release inode reference via evict_inode().
>>
>> So, sync & drop_cache may not guarantee all inodes being evicted, as cgroup
>> has one more refernece on inodes during the time.
>>
>> If inode has not been evicted, dquot inode reference will not be release, it
>> will lead to inode quota mismatch.
>>
>> Let's add a delay to wait for cgroup switching completion before quota check.
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   common/quota | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/common/quota b/common/quota
>> index a51386b1..de7e84e8 100644
>> --- a/common/quota
>> +++ b/common/quota
>> @@ -333,6 +333,9 @@ _check_quota_usage()
>>   	# XXX: really need an ioctl instead of this big hammer
>>   	echo 3 > /proc/sys/vm/drop_caches
>>   
>> +	# wait for inode_switch_wbs_wor_fn() to release inodes
>> +	sleep 3
> 
> Odd -- I've never seen this problem crop up on ext4 or XFS.  What's
> different about f2fs such that writeback is still in progress?
> 
> Oh, XFS cycles the mount and ext4 does ... quotaoff???

f2fs does quotaoff like ext4 as well, but the difference ext4_quota_off() will call
sync_filesystem() before turning off quota, f2fs doesn't, not sure this is the key
to wait/speedup inode_switch_wbs_wor_fn() or not.

 > > Perhaps the sleep 3 thing should only be done for f2fs?

Yes, I think so, let me revise the patch.

> Or do you see it on other filesystems as well?

I tested ext4, it doesn't fail.

Thanks,

> 
> --D
> 
>> +
>>   	VFS_QUOTA=0
>>   	case $FSTYP in
>>   	ext2|ext3|ext4|f2fs|gfs2|bcachefs)
>> -- 
>> 2.49.0
>>
>>

