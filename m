Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412A3225A36
	for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600874; cv=none; b=aFjptyAEUVSG1KvinxPTjuqjFON/A9QEdY6f/JNPcTOdVxSv7ML5KA05cgLP5in0QNy1CzSdEjok+xIfW/walwjv+DgPgUZIpZhnHzAoGUugCbh3lBbEVQiDACdrZ8JGDdZMAR1Vk/T16xt5zaML1BTgFqAqm0qCtg3MMmERRn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600874; c=relaxed/simple;
	bh=yxIW1tjBz5YahV83vbyGET/8aw9Zwdt1unebbZkjrW8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nq5Weqg6Yl/JT69Fj/imjnA3A/vCIjMfxK7kGfin0raPQraXNpUwFzUfXklOZJTwOGPf1ZSzVZcFpGutGsqKfHvG3yn4CIsB8UmqL9FOlZqZK6vgJmuLqn84oV2/htNE+G7z8Hv5tQEw8oW5252Y/RDXW56xE5NLXYmxrWIRf94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZT0iZLd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZT0iZLd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641ACC4CEE5;
	Mon, 10 Mar 2025 10:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741600873;
	bh=yxIW1tjBz5YahV83vbyGET/8aw9Zwdt1unebbZkjrW8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=uZT0iZLd9XgScO7T2HSG0dSleYB6Nn5rhHPnuSa1uTF1g3w2zKGE9kPq3AQVA9XHE
	 cc7kyDH4CBSNBBNC4sWZhOLBPOvZmhi0zuVodYWbyLB7Fk3NeMJNxHReGlAa3O3nSS
	 8JpevIDeZltXao4gVcZaQirFDuk6ACxyy2I0sow+oEHtr5Jkivwp89k+Hw/HNBDP0i
	 U56u8xeXRZwAQaAvi0xbAjQiB9KxM+43CFEOHDynAABeOBG/PiHHWyC+bl/mce+9rK
	 kB1+v527He2Pok7IYj8VFBo5PtWnc+J8f8pQKw60v84IEelc3X1mgYa/uQvALxx2rS
	 Hd0ziEpVRZn7Q==
Message-ID: <822791c9-bf0d-425f-84e7-92abac31227b@kernel.org>
Date: Mon, 10 Mar 2025 18:01:10 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, David Disseldorp <ddiss@suse.de>,
 Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/4] common/config: remove redundant export of
 F2FS_IO_PROG
To: Zorro Lang <zlang@redhat.com>
References: <20250306081809.2397527-1-chao@kernel.org>
 <20250307145629.2b2c6e99.ddiss@suse.de>
 <20250310071636.gombdbhdfbqxwib5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250310080259.6ormkanynd7l2yrd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250310080259.6ormkanynd7l2yrd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/25 16:02, Zorro Lang wrote:
> On Mon, Mar 10, 2025 at 03:16:36PM +0800, Zorro Lang wrote:
>> On Fri, Mar 07, 2025 at 02:56:29PM +1100, David Disseldorp wrote:
>>> On Thu,  6 Mar 2025 16:18:06 +0800, Chao Yu wrote:
>>>
>>>> F2FS_IO_PROG was been exported twice, remove the redudant one.
>>>>
>>>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>>> ---
>>>>  common/config | 1 -
>>>>  1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/common/config b/common/config
>>>> index 2afbda14..8d3047a5 100644
>>>> --- a/common/config
>>>> +++ b/common/config
>>>> @@ -191,7 +191,6 @@ export XFS_COPY_PROG="$(type -P xfs_copy)"
>>>>  export FSTRIM_PROG="$(type -P fstrim)"
>>>>  export DUMPE2FS_PROG="$(type -P dumpe2fs)"
>>>>  export RESIZE2FS_PROG="$(type -P resize2fs)"
>>>> -export F2FS_IO_PROG="$(type -P f2fs_io)"
>>>>  export FIO_PROG="$(type -P fio)"
>>>>  export FILEFRAG_PROG="$(type -P filefrag)"
>>>>  export E4DEFRAG_PROG="$(type -P e4defrag)"
>>>
>>> Looks good. @Zorro, might as well squash in removal of the duplicate
>>> TIMEOUT_PROG export too.
>>
>> Sure, I roughly tried to find all duplication by:
>>
>>   $ for prog in `sed -n "/export/s/export \(.*_PROG\)=.*/\1/p" common/config `;do n=`grep -E "\b$prog=" common/config|wc -l`;if [ $n -gt 1 ];then grep "\b$prog=" common/config;fi;done
>>
>> Currently only found F2FS_IO_PROG and TIMEOUT_PROG. So I'll change this patch
>> commit to:
>>
>>   common/config: remove redundant export variables
>>
>>   F2FS_IO_PROG and TIMEOUT_PROG are exported twice, remove the
>>   redundant one.
> 
> Hi Chao,
> 
> As you need to change patch 4/4 more. I thought you might change others, so
> please change this patch refer to below:)

Zorro, yes, let me update all in v2, thank you!

Thanks,

> 
> Thanks,
> Zorro
> 
> Author: Chao Yu <chao@kernel.org>
> Date:   Thu Mar 6 16:18:06 2025 +0800
> 
>     common/config: remove redundant export variables
>     
>     F2FS_IO_PROG and TIMEOUT_PROG are exported twice, remove the redudant
>     one.
>     
>     Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>     Signed-off-by: Chao Yu <chao@kernel.org>
>     Reviewed-by: David Disseldorp <ddiss@suse.de>
> 
> 
> diff --git a/common/config b/common/config
> index 2afbda141..aa5258250 100644
> --- a/common/config
> +++ b/common/config
> @@ -191,7 +191,6 @@ export XFS_COPY_PROG="$(type -P xfs_copy)"
>  export FSTRIM_PROG="$(type -P fstrim)"
>  export DUMPE2FS_PROG="$(type -P dumpe2fs)"
>  export RESIZE2FS_PROG="$(type -P resize2fs)"
> -export F2FS_IO_PROG="$(type -P f2fs_io)"
>  export FIO_PROG="$(type -P fio)"
>  export FILEFRAG_PROG="$(type -P filefrag)"
>  export E4DEFRAG_PROG="$(type -P e4defrag)"
> @@ -220,7 +219,6 @@ export UBIUPDATEVOL_PROG="$(type -P ubiupdatevol)"
>  export THIN_CHECK_PROG="$(type -P thin_check)"
>  export PYTHON3_PROG="$(type -P python3)"
>  export SQLITE3_PROG="$(type -P sqlite3)"
> -export TIMEOUT_PROG="$(type -P timeout)"
>  export SETCAP_PROG="$(type -P setcap)"
>  export GETCAP_PROG="$(type -P getcap)"
>  export CAPSH_PROG="$(type -P capsh)"
> 
>>
>> Thanks,
>> Zorro
>>
>>>
>>> Reviewed-by: David Disseldorp <ddiss@suse.de>
>>>
> 

