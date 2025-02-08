Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706A71A3157
	for <fstests@vger.kernel.org>; Sat,  8 Feb 2025 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739020321; cv=none; b=digLAye0Yj6SWQfsihgPT/x0YKUHA4ksjY7u9paDwabfxtMxWxniuuC4DUXAn2fqILMCky3jrXAZnmV6qWebIOy+w0gazjTq2Z4CdFgFBWA3FS1ZPRqm/6Qg57XwGgP36BqFhqaQM6eosa+aWpM5MLS+4iYsm1lxztcaogWwbLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739020321; c=relaxed/simple;
	bh=TpZIdh/oRniqtu/u0zzAckDO20j8sOJbNwKX9ta94PU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSeDV8cCwK2rZPWV9zVLZI32ax3o7/KeHnMCN9K3m6zVy0+z61uGrXtUBH7E8uYhstyCXbBnMQQM+RouSj9wyQHIzu3EHGz3vKscxNcxn/NH13j+yYmrxHpHyMqHmDYwpI83Kjqm02bVuhbbBxR75lGbsy3y/OCtbBlEy/904yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uA4mdFrQ; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uA4mdFrQ"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d1469adf26so3871305ab.0
        for <fstests@vger.kernel.org>; Sat, 08 Feb 2025 05:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739020317; x=1739625117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+7v0bkowFWvfhBTsrJADfWTuJWXEUD8x0CXocXFrCsA=;
        b=uA4mdFrQMnDdFrOUKuJ4M9KON53BpdDkSrjOCtEf+za2FDnLGe8mSKTBATve+3kh16
         OkgOyXcDccRIxEDg/P3+DuTKE0DkEy2LmK82SKKFTRnEm8YEqhlIyq0oOdGf+O//Ytpl
         pBYLgjyH0Os8WSvjvRORT2Wwt8m/UWnuKTyDFVR1Gv8AVcfTesUOI4tfaIjsPQmT042g
         B4F9R7i/dEqmtQskvHhIpM396L8LRkslVOrg4V2lSDD5UJi2hnheUgqHHKMrm1IXpvAF
         YNV6OzZXNR0Y1V3cXdzYLeiSJrW8MzP2MA2V04+1Zx4/9c1qK2NmgT3aWs8/UDlPqObY
         ZHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739020317; x=1739625117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+7v0bkowFWvfhBTsrJADfWTuJWXEUD8x0CXocXFrCsA=;
        b=L0EDgCQc7K38hkaTu1FHqsDGP0fcZ9bd7+hNwpqTxH06aQo2uawYFUH5I/xbUw+/B3
         zIu5uggSrNDdW7tnR4g4VvH/IO51IZjK8memzEhH8ISkz6n6CE455oGLrAlpoIrJRBin
         qJRTBIWCoa2hX/NOuIBf4e4ip+A6NyBSZqdeo2YJf81AHLPSj+dOGWFlvJlEVdaeu7Jv
         4RF/aOv2DBwfgWOqMJgN70ScJQ8Nk3jTTHNm7l4pU+YEqudT18g3NpPCZTm/uMOPppLt
         QwKD5GD4BElqNwPBUVVU5/qOIIFjNlllJ39enhhLH8mCtC3Z21nl3gT+OpxILx2DOKp1
         3muA==
X-Gm-Message-State: AOJu0YxSqU+Tagy6+WN76rqD5Uc2ybVyQ2yK03+/cs/M50tKsJXrbkuU
	ai3/euzHyPI+s0M6+riHpbT39xZkd/YHXROurw9b+RTDyL4CB2qJ7AilMXsFFKk=
X-Gm-Gg: ASbGnctUw1I4XQmWGtuW8xGBG1KbZ7MMo12T+2BL9oEqHxTYFJVooeRU+54gsYj4MSA
	2zUt6l1gmAWHk/LnkdBTlTZY8SrG6Lbg2OodXlT3XwMSmbJJhMDhhWi7PL4EGzotvUgU6ygrO4O
	NWwrA7FhD5Wb9ZKgBJ4KLxRB+y8vEeuBewdtKNY0ZWNC/LIXy0GKrd3l1pJKt6T5TrLWk0ADmjQ
	TQ5lIZzw2jOe68q+g++hyyIT8CLYhQPjNE8ewJ55gfQ7efM9Qb2ari7RkGgzoQSCX8tV1s+AfYl
	xeOSURRl3bCP
X-Google-Smtp-Source: AGHT+IEQt46Ydx/5PS0c5EBLFAjBkn4q8LMxJnBCqEtny0R498i7JFMWji3121uVqY1UAUxFF/164g==
X-Received: by 2002:a05:6e02:378b:b0:3d0:bd5:b863 with SMTP id e9e14a558f8ab-3d13df2c420mr55912735ab.20.1739020317210;
        Sat, 08 Feb 2025 05:11:57 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eccfacf5fcsm1225561173.100.2025.02.08.05.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2025 05:11:56 -0800 (PST)
Message-ID: <e760d88e-e9e9-4e59-be69-eab333977f45@kernel.dk>
Date: Sat, 8 Feb 2025 06:11:55 -0700
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Failed to compile due to missing <linux/blkdev.h> header with
 liburing-2.9?
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
References: <b7149d6f-2c1b-4c51-ac0c-0b2d7560330c@gmx.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <b7149d6f-2c1b-4c51-ac0c-0b2d7560330c@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/7/25 8:43 PM, Qu Wenruo wrote:
> Hi,
> 
> Just find out that fsstress no longer compiles on for-next (v2025.02.02)
> , patches-in-queue (a494849fb48dc6b276c2a1784d6ff66c731e5572) nor master
> branchs (8467552f09e1672a02712653b532a84bd46ea10e)
> All fails with the following error:
> 
> ```
> Building ltp
>     [CC]    fsstress
> In file included from /usr/include/liburing.h:17,
>                  from fsstress.c:30:
> /usr/include/liburing/compat.h:11:10: fatal error: linux/blkdev.h: No
> such file or directory
>    11 | #include <linux/blkdev.h>
>       |          ^~~~~~~~~~~~~~~~
> ```
> 
> This seems to be a change in the liburing headers, as v2.8 still
> compiles fine.
> 
> Is there something wrong with header change?

Are you on arch linux? They messed up their packaging.

-- 
Jens Axboe

