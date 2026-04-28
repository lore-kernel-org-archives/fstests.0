Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75876338906
	for <fstests@vger.kernel.org>; Tue, 28 Apr 2026 06:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777358578; cv=none; b=D91WgKk2bS79GNSwLpxh2t6XAN7aBt4tXfqrwSdwxdGFtQcxa3cb0Xc22RfLtoN7XNKErZSPGKHsymEaxS4kpz04VbVgvh1cqrp+msIoKY961RcrVmZ8rX9NUcrYgHiMLjuqUpdJ3nOV73AvhN5X/R2LNg+6/O9mQe8E235dZeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777358578; c=relaxed/simple;
	bh=fYJ5mHq4QmSl4hLr4psYfYMsXpthq+yhOwVDuodRaIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmjpnH9xhXUpPr2zGDTf3muYKQK43aMPJ8/T7Ve7Vb4lxx7wbPGxVeZykirTlCDIyvKGKqkqQrenTQPCKrdZOFYcyzzcZN3RL0/+4UJw0AG226SbACDRdY+mR4PWRQB2M3iQQSKlBG/IivWRV+s2zWyRGkfEbu/MmmTWfIZp1NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tBHcnA/h; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBHcnA/h"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82d0b68837aso6607149b3a.2
        for <fstests@vger.kernel.org>; Mon, 27 Apr 2026 23:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777358576; x=1777963376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wJT0Q2+TNC0iQL2BZKm7PxCYejNErSFxDX4dcCZU2IY=;
        b=tBHcnA/hTkDN0WztdYUH4kvsFbM74MdUJDBMMWdZeygESyV2qZ5q4p9Up30kQ6dwyp
         XvACJHNVT/MLUWTkHORDbjN0rw4tOx23YJnV52/WHbyBK86N8PV9w96jmkNhiVrvT2Qz
         1+yPS3FX5il0WQjfcYA/AHcw1yKT6kakcGaEyS19OqV+jGoSdpVOltzEV+EJKlLdhJem
         WuVJcdmglXp8HN07xgUK+tKnPzlwWpZ6L+ti/SE7XqRIZlJnFjcnEG38j2DKHLfnFdvL
         ZaEyVM0WMngvP0vzBqWSrnx+kowZ3C1tnU7HX6ObZOnVKsx57QHssjB2lurLw+sLwN+r
         eKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777358576; x=1777963376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJT0Q2+TNC0iQL2BZKm7PxCYejNErSFxDX4dcCZU2IY=;
        b=EOX8nlaK6PHih7KZ1frPAcq6EtV7xsV23m8M/PltnERqBycDNfLKLU+7iTWEbp3SDT
         Lhv2J7vxTqVSCv7aJ9xDBjxFNvsRloKaz+fCdk9NYB544UYpWeWn2exJ9ZbdoGfHHgfc
         3BW9DW16W1QqTIP/a0XWBD8QDx1b0SDogArORbckbsyPZi/Gl5Ue4IxraJMji4wU6KQ6
         Z2qxPXitXZ9K/5tI53w/mQ0ahWhnZOY97/z7ABINH0j09cP/Yodm8szz8a3WvNcPYK5k
         M/xvQ/9D1WJeTD+MCIrZAwuEkPDeSs89GmzinVol1yldU1SWqW6hR8RPl6aXuorBLtK1
         WPDg==
X-Gm-Message-State: AOJu0YwtMsMfinSZnY/ND+SsFtxNFEe1wKxeWhcoHvehIA8ZBM2dGPm7
	I3p4r0yeycP15yQM3dTNoMmMZ70QvysGBZVEA5XbuBHNgG07TVNQ2AZr
X-Gm-Gg: AeBDiesOztyF8pbp/iKLlqvlEOC0Fg3MtvsTF4PofkETMRxzcddUIvnSlqRntqwqQQP
	sMRJezhGIai6C7ImzMfzAP+G6zbuqqSXPyJD09hZVkIojHMQZiYZAhFiMeNFIHj9NRL5MvBPP/G
	LWhJwuGRH2RATkgUih4EGo/pSvMq0tNNNjFr8yNvGvT3bMFWzBTm3rBPk4vQsyVrbBJyYCcvpe1
	scwGY7MumK1hUf3DZgTe1aIS/1Trbw4og0xyMkNcub4Bs//gE3Z0kr2bU7tPyK2/LqQ38kzCW/9
	AxnrJImSuvjG1MKmTrtJAVtcGninS9nsW7XsAhgFb4yGg26Qcv7b4bj4CO85c8dHBsri/t+ZwLU
	5Sbum7nNs8kTwsVglCqUpW+HlCDRWDwC1XkTUOZ0XsARLexF4Q6Qg7j8GCX8NubEst8olYrck1q
	lfexS4H622BOvkwUsUXsSQ4Q7I49DgElsl0KCOCA==
X-Received: by 2002:a05:6a00:12c1:b0:829:8c08:d1f4 with SMTP id d2e1a72fcca58-834ddbec0e6mr1846825b3a.39.1777358575700;
        Mon, 27 Apr 2026 23:42:55 -0700 (PDT)
Received: from [192.168.50.90] ([116.87.14.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834dae07945sm1904377b3a.9.2026.04.27.23.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 23:42:55 -0700 (PDT)
Message-ID: <71447b65-0390-47a6-b0ec-7727a3009256@gmail.com>
Date: Tue, 28 Apr 2026 14:42:51 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] fstests: add _loop_image_create_clone() helper
To: Amir Goldstein <amir73il@gmail.com>, Anand Jain <asj@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-f2fs@vger.kernel.org, zlang@redhat.com, hch@infradead.org
References: <cover.1777281778.git.asj@kernel.org>
 <05ace38b54ea49f462bcd6274c4a2528192e6949.1777281778.git.asj@kernel.org>
 <CAOQ4uxjEcHiqzB+JrnzDExMcBuTbLaPT5qQcEDX0GO0TX7hp=g@mail.gmail.com>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <CAOQ4uxjEcHiqzB+JrnzDExMcBuTbLaPT5qQcEDX0GO0TX7hp=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 28/4/26 02:31, Amir Goldstein wrote:
> On Mon, Apr 27, 2026 at 12:19 PM Anand Jain <asj@kernel.org> wrote:
>>
>> Introduce _loop_image_create_clone() and _loop_image_destroy() to mkfs an
>> image file and clone it to another image file, and attach a loop device to
>> them. And its destroy part.
>>
>> Signed-off-by: Anand Jain <asj@kernel.org>
>> ---
>>  common/rc | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 44 insertions(+)
>>
>> diff --git a/common/rc b/common/rc
>> index 9632b211b58f..0e7b7eb1d98f 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -1503,6 +1503,50 @@ _scratch_resvblks()
>>         esac
>>  }
>>
>> +_loop_image_create_clone()
>> +{
>> +       local -n _ret=$1
>> +       local pre_clone_tune_func=$2
>> +       local img_file=$TEST_DIR/${seq}.img
>> +       local img_file_clone=$TEST_DIR/${seq}_clone.img
>> +       local size=$(_small_fs_size_mb 128) # Smallest possible
>> +       local loop_devs
>> +
>> +       size=$((size * 1024 * 1024))
>> +       $XFS_IO_PROG -f -c "truncate $size" $img_file
>> +
>> +       loop_devs=$(_create_loop_device $img_file)
>> +       _ret=($loop_devs)
>> +
>> +       case $FSTYP in
>> +       xfs)
>> +               _mkfs_dev "-s size=4096" $img_file
>> +               ;;
>> +       btrfs)
>> +               _mkfs_dev $img_file
>> +               ;;
>> +       *)
>> +               _mkfs_dev $img_file
> 
> You making a wrong assumption that FSTYP can format the loop devices
> 
> You should add _require_block_device $SCRATCH_DEV
> to all your tests or maybe nicer, add:
> 
> _require_loop_mountable which requires loop and block dev fs
> and use this requirement instead of just _require_loop in all tests.
> 

Thanks. I've fixed this in v4 by adding
  _require_block_device $TEST_DEV
Since SCRATCH_DEV is not required.

I didn't create a new _require_loop_mountable() helper.
Both _require_loop() and _require_block_device() are
used both together across other existing tests;
I prefer not to deviate into cleaning that up in this
patch set.

v4 is in the ML for rvb.

Thanks, Anand


> Thanks,
> Amir.

