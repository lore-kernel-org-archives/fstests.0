Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466022D8798
	for <fstests@vger.kernel.org>; Thu, 18 Dec 2025 21:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766093265; cv=none; b=mBKnXa9uUimL/6aWxJII3hTTElacLG28UHgghqxIDv8Ha779oizHT7kD1fWL42MJo0cVCQ3/JlUXzdOwfWrXtXJ/l6fMGD9+QZXumAJy13vkd9A5uFf6HrY2Sp8A3dKmZTpqRZnL6ydHniRojciCVFUebFGUTQ7Q0bpERd2e89c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766093265; c=relaxed/simple;
	bh=ssp6MgaMGnnKdoqFisDTFr9/zz2YnKqd/trrmdIJETQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dt2F9xKTH+Gy/iu/yQ2gweJtEucOIJQMyrFKANqqmKV+9d+zTSSUy0wprPPxOWda+wxp1xrSlKvz6jWAaTNuidBjC7qvBkU8qtvCMkWqylshCNrhXM4wGinasgXlKEW43gIv+PZluWSI1JcGl9WT4iVNtBS9ZEhr0UWzJ/qCOoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpjYr05S; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpjYr05S"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a099233e8dso10554195ad.3
        for <fstests@vger.kernel.org>; Thu, 18 Dec 2025 13:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766093263; x=1766698063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mtKlcFT+8oac25TBdlE/6dhf/oQjmi8HEpnZr0zN7f8=;
        b=IpjYr05Sawiov8nyEBLLYIFxseaYcVcYw+kEAWNIRNBYXQnNs2xxUCG1Zr77hbk3uo
         mjbufBIrqT+dofy0t21RZAZJQSgXAxZbc7pgBx0kujOEHJKWkUARgbiPgFAcbtsYgmHR
         zfVGJaOcfMspIN9CY3ZayoO355IXWKcEQKzpY1I4R6CRwijqXR5WlY1CiJ2LGTYE6Q8G
         8HM0AMK6fygecu/1nw3jcCC9qWz5mJNJPlFhxNcGwi9sj2E3YMiFFCFCA8D8RhUXuaH8
         +FdtY3Xa1BkY/slmg/dtUKYydgIvtfJD3CEm86PjtTNWVR6O/wX/sgchkBdTMCluEIQx
         Xm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766093263; x=1766698063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtKlcFT+8oac25TBdlE/6dhf/oQjmi8HEpnZr0zN7f8=;
        b=oYr/+186ZNfZKIkqUv+SCst+FJkupRvFazg23yikbv6wBTzvvb5pZuAwR+T4/l0Cr6
         HxgEwyEhP5Y331OU1/98uQq3SOF2H7jW401IJHJxkJkRumeTHlnPt4YxwFyjnt7Ui4KQ
         l9On4nPhDoOsWMSabz1HCn4Q0O+sh4bAhO8Cn6SFlnnOfGSwtWLQd9EkOCbc8I/vlbfh
         Qe8A2ASyLIOrZc2mhS0A+D4wNerYNShWeeiHUwrUVm0C/MO7ivny9vdVULd9z2MP48Kq
         C5mUhtOxzQGk8O5l+cxbkUANEzqCW9wB+sCOJrdigNG+yWiWG1qmJk5E6LH0qd0WlGqp
         pObw==
X-Forwarded-Encrypted: i=1; AJvYcCWrx07dKVaDkdqZCUsryoFBw8V7H5ZX5lOv5t5KjbLe3pJDQu9OK2GDl1V43d7LmKk0CV56MDzS@vger.kernel.org
X-Gm-Message-State: AOJu0YzqyaGqCkob7/jExDrvmLLoVfzjSVDCboKldHoIdDm8c2/SNumR
	PMyx9+SwcQKCaHZldNSLH8lGXKc9dJmFL4Vodlv+KUeaqnqaxmLWswed
X-Gm-Gg: AY/fxX7HuV+IEcerF9w8tmP1LyZcDaaeW1AcjVFo1rk8s2z5VnpfnOmTXGL5Ax4Opxq
	t1IIeSk1KClHgS1sPMX2d3cjWvewVTnC2Fy2+YUFIlpSCOW3+zpaEj5IYv5eeHhIhkVJUHGGfyN
	K38yWpVq3A98q1KSzaIOX/EKb9gAQY028O/GvkFufhMN7xEbCwDNOfLmZPfdUqJ7Oxnxf0YWgFr
	uCTxLlOs0C5DgBC2zdbjsW3KoEASsIbUwF3mI4NETeHZR6FUl2PyVNQeRp7+eijd5F8rG21YroO
	h57lhUYVVblWINORYfJG2SgDfFGqw1oaJxAVQtvHiFt0XkQig/tO71Dh4ZAUi8JhfGg0727CzgY
	PlgEgotYBQ0wjk3tMpJyHAkc/Oo06lABomuQ3VgdBLm3rYmnCIZO0rA+16OV2CIViIxcWlQ/gqw
	hivRuLHjCmGS5dCMc=
X-Google-Smtp-Source: AGHT+IFy7ceREQxfkIyUxi+oyD4JXaH5EBPvU1D27q3jSDSQbKE1yT3afkwTKTiOeRnMobUoeH8j8g==
X-Received: by 2002:a17:903:2ac5:b0:2a1:3ee7:cc7a with SMTP id d9443c01a7336-2a2f2223616mr6333525ad.17.1766093263501;
        Thu, 18 Dec 2025 13:27:43 -0800 (PST)
Received: from [192.168.50.70] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d76ce3sm2079125ad.90.2025.12.18.13.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 13:27:43 -0800 (PST)
Message-ID: <3286164e-71b5-4111-8c63-c6f9856a9dd7@gmail.com>
Date: Fri, 19 Dec 2025 05:27:40 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] dmflakey: override SCRATCH_DEV in _init_flakey
To: Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <asj@kernel.org>, Filipe Manana <fdmanana@suse.com>,
 "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20251218073023.1547648-1-hch@lst.de>
 <20251218073023.1547648-2-hch@lst.de>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20251218073023.1547648-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/12/25 15:29, Christoph Hellwig wrote:
> _init_flakey already overrides SCRATCH_LOGDEV and SCRATCH_RTDEV so that
> the XFS-specific helpers work fine with external devices.  Do the same
> for SCRATCH_DEV itself, so that _scratch_mount and _scratch_unmount just
> work, and so that _check_scratch_fs does not need to override the main
> device.
> 
> This requires some small adjustments in how generic/741 checks that
> mounting the underlying device fails, but the new version actually is
> simpler than the old one, and in xfs/438 where we need to be careful
> where to create the custom dm table.
> 

Reviewed-by: Anand Jain <asj@kernel.org>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
