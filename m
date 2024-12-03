Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1830A2E3EE
	for <fstests@vger.kernel.org>; Tue,  3 Dec 2024 11:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733225388; cv=none; b=cb97+zhkewZIEGCgU69aD72htFOpcM4yIr3klE+Ko6tsEIQXdd2U2SGSInQzWUt0FD7QXwSLPrj4xSxZG7tizqSkHVXlBWbTHkJH1y0IwKvqjfalJv27A1GgdwteMxoer5GFDCXZxOwp1XbN/CWAPLI1VvcDsCgtHfxOdly2MtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733225388; c=relaxed/simple;
	bh=X74TWF1ytlB9VTMizceG8lOApzyi9F37hg+n2wwuj7k=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rq2Ol4SgLbWrIiaeEbzXr3o/CNM0q7MNmjLoe5t9/1E9IS+jXH/lytSLdEPbRd07QBTCmbcSfOFL5BCtKCN6Nhxn8J0DoxdsVNKpqgnsc02MN7n26DIMYLkPuuj+Ed12m0ADwn+C1gFxjXtX2XBuMPnzP8J4x4/oYMjFXkjNumg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQUYTiJu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQUYTiJu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B2FC4CECF;
	Tue,  3 Dec 2024 11:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733225387;
	bh=X74TWF1ytlB9VTMizceG8lOApzyi9F37hg+n2wwuj7k=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=EQUYTiJuPE7WCmO1Beh8Iszq3oiA40aUpK7YYVeS9YLs1GbjYla+Kq6bBvS6iJSld
	 cUmcFyo9xy3K+EPbOx786HbZIHZ4I8cwr7IbFfj5jjKmpp4+azj6NAipccg8Avbbeq
	 Ah74uqf2x2M2ge+iF5bbCGg0mnqVByvCL9ICueQMccU4eNYr+GNXoysXPqsLskr5f2
	 bFNwW4l6O7kRChOWHEjM9gUM8xzbmEyI+2n3d4TAzZZUYs/BM3l7hkUm3M3PqnF2cL
	 e09HLuSsfxhtIszptBgU0R2Wd2uoAdRExTfxc3vWvlY0p9q5VHywq7Jml1xi1MfbiJ
	 REQPfr0v5quXA==
Message-ID: <0d23e561-65b9-4e9e-ad56-ae4e44bd91ed@kernel.org>
Date: Tue, 3 Dec 2024 19:29:46 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, Zorro Lang <zlang@kernel.org>,
 fstests@vger.kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/3] f2fs/005: update commit id in _fixed_by_kernel_commit
 line
To: Zorro Lang <zlang@redhat.com>
References: <20241202114149.2666-1-chao@kernel.org>
 <20241202192835.seditdylbigpxte5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
Autocrypt: addr=chao@kernel.org; keydata=
 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
In-Reply-To: <20241202192835.seditdylbigpxte5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/12/3 3:28, Zorro Lang wrote:
> On Mon, Dec 02, 2024 at 07:41:47PM +0800, Chao Yu wrote:
>> The bug related to this regression testcase has been fixed by commit
>> d5c367ef8287 ("f2fs: fix f2fs_bug_on when uninstalling filesystem call
>> f2fs_evict_inode."), let's update commit id in _fixed_by_kernel_commit
>> line.
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   tests/f2fs/005 | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/f2fs/005 b/tests/f2fs/005
>> index a817d51a..33d4fdb9 100755
>> --- a/tests/f2fs/005
>> +++ b/tests/f2fs/005
>> @@ -11,7 +11,7 @@
>>   . ./common/preamble
>>   _begin_fstest auto quick
>>   
>> -_fixed_by_kernel_commit xxxxxxxxxxxx \
>> +_fixed_by_kernel_commit d5c367ef8287 \
>>   	"f2fs: fix f2fs_bug_on when uninstalling filesystem call f2fs_evict_inode."
> 
> I think we don't need to use 3 patches. As you just add missed commit id number,
> just merge them into one and named "f2fs: add commit id to _fixed_by_kernel_commit".
> Or if you hope I can do that when I merge it, feel free to tell me :)

Zorro,

I've sent a new patch, can you please help to review it? thank you.

Thanks,

> 
> Others look good to me, with above change:
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
>>   
>>   _require_scratch
>> -- 
>> 2.40.1
>>
> 

