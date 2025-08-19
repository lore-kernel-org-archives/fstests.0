Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449E6353369
	for <fstests@vger.kernel.org>; Tue, 19 Aug 2025 22:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755641361; cv=none; b=f5QWphiOjHiEk8265rOkR++Ve57AviSxY90obnjJ9VnSZW8+ypON0FKvZxTP6PhTmX7QMAMo14BROttdvOUGZBRm/nANlGTWnjM7Peedp5YiBegB5QmHg8K1rgBbCo3fQtTgB6jgXDXx8HdDODwTzDQ/GZP16Sq3KA9zEWfQzVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755641361; c=relaxed/simple;
	bh=Mh7U1Ph4mesb6ZbW0KBPGaOxPXeWv9mno707B8frLKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWb2Td2SShX2JgZqAlcRkDYYOnBpvcPWw7Qg54lovspV2JJUx1hU0qIwVZbBxV/AeFNv0zIOzr6wQiSa7KRTekhVKMsXR0ljHyAYhNoqhk7ljPP8o8wsi24n4IYhAWxl5+LD0ERdmerl3buT87RJRGev83iE3g8Ims+vMFTzFLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GOJHHOgb; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GOJHHOgb"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9a342e8ffso216802f8f.0
        for <fstests@vger.kernel.org>; Tue, 19 Aug 2025 15:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755641355; x=1756246155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JgxRh/c+b5nT/D/RFJsZCD6VQEXP67nFCY2sQvI8rdo=;
        b=GOJHHOgbAe/ibxhDVhQMVTAsTQfbjHnPM+VHCl0s8rFF0XIKz1ps9QYyl40WoiqfD9
         UPaXXYAHOPUcAxgHigb8/nrhjSfhle9nU0b5fJ9re3+IJIX05kWujEsx7jJqZ0HSPdmt
         Jy+sT1w2YTDwEOzqP2neEzcV6bWyuYt0ZGjM7G+6lcCVS7LNzVtQKmmr50y/8UsQ6NXI
         PuZm9sqladKZZqavsR3dVSrvLvKVYGp71K9am0JACxz8gxpBuKWWFZfF467Gbx5GT+zq
         tvkrehZ4WsLe/kjSUuBXxczLeltFX8q/uDaRKQox7l1t2YQkpC8wYn4IzpUs68i6UMCi
         60QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755641355; x=1756246155;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgxRh/c+b5nT/D/RFJsZCD6VQEXP67nFCY2sQvI8rdo=;
        b=KXU7fS1vwQRUu+q8SDi5LHavrVTWSyWv1FmmIdmDAOwUEHUrHmxM0L3rXH2wCfMwgi
         ibrbAM8dbz3+T2dY6TYH2USf7tpvDJXXXOiWkjVc7HoNbOLQicFJ0fLgwEiV4dOOO/yl
         0QIsQbjT3GKBsClhUbfNuUt1PALQ6FA7UCoJtqq6qI7bHnIIWnAO14AAYt8O+4xya8LZ
         UsAkIVrG2j1i0izyMNPn/8KCnARKucs4DdvLxzg7/AIC8AhQPSxVL7MTzv8Edk7z4Evd
         1X6Yk7CtF7WsZLOKhfTtlB/1H473W9hm8sC2d9qmMs34X2e1ib1HPYlSmVgI2LIlQaK3
         gY9A==
X-Forwarded-Encrypted: i=1; AJvYcCWuJfFZGtatlcRGu8jUOSwsCoJmRrJH0FFV4CpB6OhARkjuciv7RwPJU8GJD5N7Exb22ob1H6iS@vger.kernel.org
X-Gm-Message-State: AOJu0YxdpO/WgiZ4FI9lZi2sSPRnM4JRMAG1CiwnOS+OcRrRaszakIGx
	6nf4rqUBd29xUFF1gnbKwmv1wC9nkrLvm5IunBxoyQbGxXIsgH0Yr2WkaHpBP5PhPGY=
X-Gm-Gg: ASbGnct6DIaF+DACwnvQDxPfPLw2uDz4rTMc2gMjDMVa+WS34Nxp5w7EG1/HaUiQ+u2
	dGlYAlEn941p4qBUS7nl2FDdOyunHUWPScZgjEgMGY1Vtlu/a1cz2T4fanD5X+QBZ34eXaHkJzn
	0V1PcZ37T6MpYEtDb7J9bfJWH6JYFD3spIGmD9KuqWtj/K9TLXtc6r6FI2xR2kxBlYWpvq7q3zv
	eCUjKyk/AmOy6jlFv3YJp3puC35BMSp/EBwa0z2B0rkuUvICE7TaofIeY3CA1ZokRSKTHAhyy4H
	u+boZxYA/H2DwTSG4N2SeO6yCwI1b9hEiFbcnnN5JgIWFvGmQ0eKAgXAtj8ryfCv0FhD/3z+gEj
	g06hcalLYJTJkK3xBi83bP4dWKzs68qppFJVtoS+ILGuR4cauVyM=
X-Google-Smtp-Source: AGHT+IEmN3nKhF8Mrk7M5E/Z81JuZBtZeQPE3AfWildlCtiss6YpbOfwGCJDHLSQMY4sAjipouHo0w==
X-Received: by 2002:a5d:5f4c:0:b0:3b7:8ed8:1c80 with SMTP id ffacd0b85a97d-3c12a70e981mr3171593f8f.3.1755641354568;
        Tue, 19 Aug 2025 15:09:14 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4f6ea2sm3441602b3a.62.2025.08.19.15.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 15:09:14 -0700 (PDT)
Message-ID: <0a10a9b0-a55c-4607-be0b-7f7f01c2d729@suse.com>
Date: Wed, 20 Aug 2025 07:39:09 +0930
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] generic/274: Make the pwrite block sizes and
 offsets to 64k
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 fdmanana@kernel.org, quwenruo.btrfs@gmx.com
References: <cover.1755604735.git.nirjhar.roy.lists@gmail.com>
 <49bd135f95d50fd4b8db41593551b1958ed380a7.1755604735.git.nirjhar.roy.lists@gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <49bd135f95d50fd4b8db41593551b1958ed380a7.1755604735.git.nirjhar.roy.lists@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/19 21:30, Nirjhar Roy (IBM) 写道:
> This test was written with 4k block size in mind and it fails with
> 64k block size when tested with btrfs.
> The test first does pre-allocation, then fills up the
> filesystem. After that it tries to fragment and fill holes at offsets
> of 4k(i.e, 1 fsblock) - which works fine with 4k block size, but with
> 64k block size, the test tries to fragment and fill holes within
> 1 fsblock(of size 64k). This results in overwrite of 64k fsblocks
> and the write fails. The reason for this failure is that during
> overwrite, there is no more space available for COW.
> Fix this by changing the pwrite block size and offsets to 64k
> so that the test never tries to punch holes or overwrite within 1 fsblock
> and the test becomes compatible with all block sizes.
> 
> For non-COW filesystems/files, this test should work even if the
> underlying filesytem block size > 64k.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>

Overall looks good to me.

Although still a minor concern inlined below.

[...]>
>   # Fill the rest of the fs completely
>   # Note, this will show ENOSPC errors in $seqres.full, that's ok.
>   echo "Fill fs with 1M IOs; ENOSPC expected" >> $seqres.full
>   dd if=/dev/zero of=$SCRATCH_MNT/tmp1 bs=1M >>$seqres.full 2>&1
> -echo "Fill fs with 4K IOs; ENOSPC expected" >> $seqres.full
> -dd if=/dev/zero of=$SCRATCH_MNT/tmp2 bs=4K >>$seqres.full 2>&1
> +echo "Fill fs with 64K IOs; ENOSPC expected" >> $seqres.full
> +dd if=/dev/zero of=$SCRATCH_MNT/tmp2 bs=64K >>$seqres.full 2>&1

Not sure if using 64K block size to fill the fs is the correct way.

For example on a fs with 4K block size, but at end of filling there are 
only 60K left.

This will fail the filling as we can not reserve 64K data space anymore.
But it's not 100% filling the data space either.
This may not matter that much as in the preallocated filling stage, 
every operation is still in 64K block size though.

I'd prefer to keep the old 4K as block size (as it's the minimal support 
one), or use the fs block size for filling.
This will ensure we really use up all the data space.

Thanks,
Qu

>   _scratch_sync
>   # Last effort, use O_SYNC
> -echo "Fill fs with 4K DIOs; ENOSPC expected" >> $seqres.full
> -dd if=/dev/zero of=$SCRATCH_MNT/tmp3 bs=4K oflag=sync >>$seqres.full 2>&1
> +echo "Fill fs with 64K DIOs; ENOSPC expected" >> $seqres.full
> +dd if=/dev/zero of=$SCRATCH_MNT/tmp3 bs=64K oflag=sync >>$seqres.full 2>&1
>   # Save space usage info
>   echo "Post-fill space:" >> $seqres.full
>   df $SCRATCH_MNT >>$seqres.full 2>&1
> @@ -63,7 +63,7 @@ df $SCRATCH_MNT >>$seqres.full 2>&1
>   echo "Fill in prealloc space; fragment at offsets:" >> $seqres.full
>   for i in `seq 1 2 1023`; do
>   	echo -n "$i " >> $seqres.full
> -	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=4K count=1 conv=notrunc \
> +	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=64K count=1 conv=notrunc \
>   		>>$seqres.full 2>/dev/null || _fail "failed to write to test file"
>   done
>   _scratch_sync
> @@ -71,7 +71,7 @@ echo >> $seqres.full
>   echo "Fill in prealloc space; fill holes at offsets:" >> $seqres.full
>   for i in `seq 2 2 1023`; do
>   	echo -n "$i " >> $seqres.full
> -	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=4K count=1 conv=notrunc \
> +	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=64K count=1 conv=notrunc \
>   		>>$seqres.full 2>/dev/null || _fail "failed to fill test file"
>   done
>   _scratch_sync

