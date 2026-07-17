Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BE43CEBAA
	for <fstests@vger.kernel.org>; Fri, 17 Jul 2026 12:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784289865; cv=none; b=TcjAY8tujW7MPRSzGZ4GYSdOpVzSAmohMySNzynq8ExZ539ajT6Q0U3ZJkmXT7cl3MkkK0Fx3DYpeYFeQtfN+8xxeRDMMu0veQnfWSB2cq8g7mTHrFlaP6x7Be2dpXVyInoZqRmE7A6Fo/FCFN35bFQ/6PR2AX5JZaOvMzU/+ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784289865; c=relaxed/simple;
	bh=iQzX2N9ERjtVyNbTRivYLthX5j0B3TooXgqTIzwxLVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZIYt8mJZ5QE64vBXvbvFxVANWsRfXRhT+HHHeL++JTna8OFD00sQILsr+GDPLyzLDfgUtW8xvnA93gK1wE4OGosvStD7VjGLDfP0aIV5hQT2ZGs7bpyn+EpYy43b3+wVBKrRgw2atgfhe1P6URUK7bPioFvwdSEzyHk8Bjb+JMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d7w/uHuK; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d7w/uHuK"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47defd0c1c5so3462947f8f.3
        for <fstests@vger.kernel.org>; Fri, 17 Jul 2026 05:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784289862; x=1784894662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pf+GsaiLXl1dG+ZzD7foaIYNKnVSN9/J67lz0tqkkyw=;
        b=d7w/uHuKfM9vkseEmL3B6AWXNRzQvy+oczcHsDve4jI5hUpppnKi9XoJvuUl1fSIDh
         EH+rEYLp+pDZimRez3cDkrs8g2hJZEwzg8hX7EryqPk7JPvIkF6CFLssI8T/vEy1wirK
         wxWmLIhFKX/RA1jREdYhRgra4iDh0xfsDkDdhDf9tJ/HOcxK8K3Fa6eyn0yZpnEUpxlg
         mTC23zQrHb8ep2701SrJrIOBfl9Y4p4ZI1kAiAWagSaj3M3X3iyGlCpPKmjkcfU1d6iB
         eVXjDOd4XDjLAJRuFsrGLQ32EO0mBsFFloYzEjrCYvPQbFF6utcXOewb3GYDgYImA/kO
         685Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784289862; x=1784894662;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pf+GsaiLXl1dG+ZzD7foaIYNKnVSN9/J67lz0tqkkyw=;
        b=ZPKbnDdDZNBQLPrO1JurnE/j4OKWsMJnbukrlsiOua0I2ClV7J8V1AwUrhOB3HGi0Q
         vmw5Ivk5tXch3KoC0N+0pT+geFfG9iQY3P+sW3MsHpk7H0X7CUTPF/Z1OAaW/lTXuILs
         zzsFlCxJt3UGAUGNvEdp8aWXqNOpnwW9LdSJl/TKHs3yyQeaNZHclM+IX3JFCS4uPO6T
         thcXZE+VvNtwqDgN+YqW0lPU3ZpgbLIoc/5cdWBHohryJamATyVOllQQcirMskiqsXcP
         m4o670beK6KtGetnjE7nur9v3V75DXAfQiKBS2ZEs9paJHXrU2JvO+UmHWqDAAzO7i5r
         A28A==
X-Gm-Message-State: AOJu0YwIs0M29g3TWVLxJtMvBX+LmBFqRZkyNLLPUqA0SpoLTWA3Wqs0
	fjkcjjjHX/pzomgSVXR/91ojm8pZGWsLN3lxzYGhEveq+jyar9zkBgBeh3NX2jivot5X6cgPkuY
	PXfqtXkw=
X-Gm-Gg: AfdE7cmh+WKOiLXuvHf/7KfBw7VS8JILmuTyJaY3mdk8aFSzUP3tQaCTCI0Monjxbo5
	gW6KsXKQqSctJs1AD9igVDhytxbWUQUUwUAk4sSjAeGAo72Q8VZRha+0YjPDu9Se+mtEibAUC86
	5HxidZicg9UTuNnV6PWePNeEJeYWqDqXYqKGTcGiODVLf3GDWDudrUVtKi21RolfD4qs/gL3voF
	gSyr91OI67PpQzh0aKMdzgQQOg1MWHZat1Zh1HNEyH8u7qggsppO5rK+7uhvi9IxLfFZxWdXCVX
	WMhgKV23cy0zhyhASCnEdWNFW7QPgyq0vv7HyZStC8hvqeMA0rPM5oRFEXBt0h2kmL9VkGmGiTL
	0V78u3NRbwidZw7MfX4ATOhinWUesSIIiRnEYofzhMS4tr13KHi7/zi1xYhHeJqLruiCJnWElGw
	GpXVLXEkvwUezI7hpof7OJTXom8BoIZA==
X-Received: by 2002:a05:600c:5493:b0:493:f80c:5455 with SMTP id 5b1f17b1804b1-4954a3d0cb1mr27613485e9.5.1784289861542;
        Fri, 17 Jul 2026 05:04:21 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954d384146sm8563155e9.14.2026.07.17.05.04.20
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 05:04:21 -0700 (PDT)
Message-ID: <bbcbd145-47eb-4336-b9e2-588b68cdb41b@suse.com>
Date: Fri, 17 Jul 2026 14:04:20 +0200
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] generic/062: filter setfattr --restore symlink-safety
 warning
To: fstests@vger.kernel.org
References: <20260706061102.90603-1-avinesh.kumar@suse.com>
 <20260706191326.122555-1-avinesh.kumar@suse.com>
 <alnu6gq9a1bJJF8b@zlang-mailbox>
Content-Language: en-US
From: Avinesh Kumar <avinesh.kumar@suse.com>
In-Reply-To: <alnu6gq9a1bJJF8b@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Zorro,

Thanks for the review.

On 7/17/26 11:22 AM, Zorro Lang wrote:
> On Mon, Jul 06, 2026 at 09:13:26PM +0200, Avinesh Kumar wrote:
>> From: Avinesh Kumar <avinesh.kumar@suse.com>
>>
>> attr 2.6.0 (CVE-2026-54371 fix)[0] makes "setfattr --restore" warn when
>> used without -P and the dump contains a symlink, which generic/062 does.
>> The warning leaks into the compared output via the setfattr() wrapper
>> and fails the test. Adding -P isn't portable (older attr doesn't have it),
>> so filter the warning in the wrapper instead.
>>
>> [0] https://cgit.git.savannah.nongnu.org/cgit/attr.git/commit/?id=3fb06b9ba314d37035d0877e6de313de754f1ac8
> 
> For generic/062, modifying the g/062 itself seems fine and logical, as
> _extend_test_bed() explicitly introduces complex symlink paths for
> testing purposes.
> 
> Have you run xfstests on XFS with attr 2.6.0? There are quite a few
> setfattr --restore invocations in common/populate. If those also trigger
> the new unsafe restore warnings, we might want to consider introducing
> a helper function, such as _setfattr or _setfattr_restore to handle to
> -h and -P things.
> 
> Reviewed-by: Zorro Lang <zlang@kernel.org>

I am sorry, I forgot to reply to my patch here. I got same feedback from
Darrick when I sent patch for xfs/083 for the same issue. So this is
being handled with a wrapper. Please review here and this patch can
be ignored -
https://lore.kernel.org/fstests/9b95ab03-34c0-4d2f-b4d7-fdb9c8cbb193@suse.com/T/#m3bef5e49d3ca17f845a3ccab8b6dea5b67c00d86


Regards,
Avinesh

> 
>>
>> Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
>> ---
>>   tests/generic/062 | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/generic/062 b/tests/generic/062
>> index 89659040..ddf0a478 100755
>> --- a/tests/generic/062
>> +++ b/tests/generic/062
>> @@ -30,7 +30,12 @@ getfattr()
>>   
>>   setfattr()
>>   {
>> -    $SETFATTR_PROG $@ 2>&1 | _filter_scratch
>> +    # attr >= 2.6.0 (CVE-2026-54371 fix) warns that "setfattr --restore" without
>> +    # -P/--physical is unsafe because it can traverse symlinks. Older attr does
>> +    # not accept -P, so just filter the warning to stay version-agnostic.
>> +    $SETFATTR_PROG $@ 2>&1 | \
>> +        sed -e '/^Warning: option --restore=file is unsafe without option/d' | \
>> +        _filter_scratch
>>   }
>>   
>>   _create_test_bed()
>> -- 
>> 2.54.0
>>

