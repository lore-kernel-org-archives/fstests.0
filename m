Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E28430BB2
	for <fstests@vger.kernel.org>; Mon,  2 Mar 2026 13:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458225; cv=none; b=O6to/JjvP0gbZNlBx6SjgCYlBcUe5UVwatBSsMxJFFT3JLH+VJ8VNLxWi6qVX8iuZM4S8b6/+g0T+5KISVE29BQWBM446DNK8ZunHOoAbW7wpXrak+cpOsI/IO7UUgFVgEuxBeOslNNwpjZNvroqKqo/m1586lH/kql5lAUzOeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458225; c=relaxed/simple;
	bh=Rq7RfAq1tZwnyavsjnkK9wmAf48OHY+TrmeBnY75gVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNIxkMTDeuUy9Kardsf77zISKMHW+fBK3Ve0wuVmGLYAEGZ1ds0nr8mq3sXQVCaSXPNWAOEq3fEpANcawJpPJhZmnPoU0LNEYA0ZGTXLRYbL4TL9CGcqX0wP4eel9RRjhE42dU+nhLFtdDHxZyE/lYj5abLFuX5ghLbF6J9LYFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QliuqGlh; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QliuqGlh"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ae46b9c70dso5551645ad.1
        for <fstests@vger.kernel.org>; Mon, 02 Mar 2026 05:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772458220; x=1773063020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s24i19n8lKIqVIDIL0pIocUyXuHdTYTMYpJQeikEDx4=;
        b=QliuqGlhM72zAOFK2QwkQ1LbtSPrJdHcPPOCXJYqpUcpGXOCZJcRCbvBWdT8BUuq3v
         bUQx6IaUTLOfZeUkEgGSzREw56LuGVkdDUwOhkjPuEjO87GZNWEXTGzcm3FqJzUTSiEB
         hSUzGmc+N18g9cpKr86DaCf6/gLVfR1syAwTeH7odxYnUIQD0w6zQk9zKAyqNX7VGnS1
         6j+jhjCCLv7Z351U9BAWsWqYhNZoigqcOVIp0LO6probde+f95GaH8BF+NiVK06ulphS
         C2A+A6+ix2/DRDb63ftTR1A7znyW5Dej6xPIVEmaTGIivy8k+zZOTtowp3XM6wYdW+4Q
         kGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772458220; x=1773063020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s24i19n8lKIqVIDIL0pIocUyXuHdTYTMYpJQeikEDx4=;
        b=vhaVrCyNVcc3SRCNrM/ZxTdUBeXivkHuPyGS43UtMCNdnyDMEGytfxbvOy28+Hr0pr
         HLn8pDn7BiEDyRkZyuQQUdo4ZCl3sv1SNNZzKFHW2QGYxfSvtxiDb35i3NoQbImFwMus
         az2a6fsk/d7dD4avAA5eSVrS7+7P57Kk9B7LHrEKblgoT0j/Xe5cLoqkqPbt3fMtLfWe
         gWGQ6jhKHe+ap1v8assAbn1qtaVCdUuLXmO/VI2OmeAUFcA/FXjJ6Zmqn/BMGPzUvMGI
         ofgjuI2JWT1wRXIU0+HOkWKQnZCYl31hDKF1tSCAvY+YUZgS3Jvpk2YedV4ecxcpY1uK
         fDLg==
X-Gm-Message-State: AOJu0YxUwEqEKsm2zvUzSuhVP+OUBQdIUFj6Y3HH3+ch2xRFujsPoa46
	3ED9MuWOOZGZTgmSfJlo2GT2ZPklL42gBkIcFUkcQlUHAPK15PJNg+C0
X-Gm-Gg: ATEYQzxoZTg/xXUirCXDGjyuO6oaxBDrnUyDfg4Ez9IAEp62bo0alPcHksCUE1C+ID2
	OWyKPOhmVR7ZYyVfODbXfdEHxWYvX0nv27ypsNlHRgqm/2Y4KK3SdH5yLUQhgOZOvbAa4JiA09o
	xHJnMfri7mXNWK9wwaPqjt7YL/KKlQtuIFNux846dEzd2dbwViexcqZlHwSX3Ch/7jrG4lv+ste
	SHGjUE+GxEnkwHKN/uLKRPII4FQwMNSNNnrLPA32tu3ZIj3CyeN7xPuVW5W6rRKqyJE6XVbJMnT
	yNR/ZSSzRnEGvL1EIrAjYxJcvKxOGzeo1oh+15dA0bLSkyJ35M0rjuATAcxdLGgAfg+1tgnAQlF
	aGXWjSIQH5UZJ4bzRdtEFjuaNh46oWbznycrCGLNbxAlFrOU5jZs5xx3/a9K2OMwVF0+cSwZT+M
	3GC9aPwat0f3Yq2BNt2Ns31V32oa4/fJswid8GJA==
X-Received: by 2002:a17:903:19cf:b0:2ae:4ad5:b76c with SMTP id d9443c01a7336-2ae4ad5ba05mr48823935ad.10.1772458220205;
        Mon, 02 Mar 2026 05:30:20 -0800 (PST)
Received: from [192.168.50.90] ([116.87.14.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae45b5201fsm55018345ad.87.2026.03.02.05.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 05:30:19 -0800 (PST)
Message-ID: <cb136241-ca7f-4c64-a6b3-3f86688240f3@gmail.com>
Date: Mon, 2 Mar 2026 21:30:17 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] fstests: verify fanotify isolation on cloned
 filesystems
To: Amir Goldstein <amir73il@gmail.com>, Anand Jain <asj@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 Jan Kara <jack@suse.cz>
References: <cover.1772095513.git.asj@kernel.org>
 <b54dea5e72585db5f5c3d74ce399f9d839965821.1772095513.git.asj@kernel.org>
 <aaQ8CB7C4FjDuedR@amir-ThinkPad-T480>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <aaQ8CB7C4FjDuedR@amir-ThinkPad-T480>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


>> diff --git a/src/Makefile b/src/Makefile
>> index d0a4106e6be8..ff71cde936a7 100644
>> --- a/src/Makefile
>> +++ b/src/Makefile
>> @@ -36,7 +36,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>>  	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
>>  	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
>>  	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment \
>> -	rw_hint
>> +	rw_hint fanotify
> 
> Check if you already have fsnotifywait installed on your system
> most likely you do. It was added to inotify-tools quite some time ago.
> Could save you from adding a custom prog.
> Not 100% sure about fsnotifywait, but quite sure that
> fsnotifywatch --verbose prints the FSID of events.
> 

I missed that command. V2 switched to using fsnotifywait.
V2 is not sent yet, I'll wait for any further comments.

Thanks for the review.

Anand

> Thanks,
> Amir.
