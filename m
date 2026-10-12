Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4798637F319
	for <fstests@vger.kernel.org>; Mon, 12 Oct 2026 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791822784; cv=none; b=Jwa+JOh0QBcJ6ntwv5Lxmg2TJ0WxW5+nZJcELgQo7mkWRlO2H+YV+FcNLyCNhVnZpX9Em5MDXSFRRsleZANM22Yr6SzrPHDgyDsjUP6LFZDrLztuZs/5VjRgWfGcfDqB5HPO1JjgMy6WnEZV2rLj40m7IgibcmXpp8+V8T6PLM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791822784; c=relaxed/simple;
	bh=LMFg21ea/HRdvWr+H0MkJEaf5T9Sro/gkMGlzvdg1MQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ByIUCp7uBG5GDwyCYjGqouTTNIUM4pdVM5jqh9WbQf5GejEeYDqxOTLk4qiF73YjmAoe5GyNfkVnBzrIJS6+GuVocYL6qGLkUCExoSGDyro0pL+HOe0IkgtaGyGMFOAdat62U3cc8+vra4IuioONR/Pg3gLGTEi4GmLksthXj04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRtq0FcH; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRtq0FcH"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35834f72d94so3533036eec.0
        for <fstests@vger.kernel.org>; Mon, 12 Oct 2026 09:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791822782; x=1792427582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NRiPvD4kcSR893VSUB5l9+rGNh0y4KbElZYbWs0AB+s=;
        b=CRtq0FcHOhSNaMjTsS0MHnqfabWmh8BZ0EXnouz+y2UVt4UJTDG3l5b3Vx6DvGQsBd
         lP85KT+PZKqPDQAsPXr2Hsh86yHUpi/f3YSFRF/rlgEGLglFLMYsFNKrMRYN0O2PX/3f
         BJ8AmrFmD8Q7eKfS2V/MBkk5MeDM4HZYE+PknH9qonV2aKfjO2Vk6zU+T/lUnb42GuD9
         hd6KJZyyIrXIERNNc+8y0oMTKOaYNWO5SjPjHAX3oyK8YuZz+heBe/bL+8xBBBE2Lvb3
         nHZZaus0RqYO+13eWs2ZJli8/RieyTvYrropmQY7LsudwWHBANz1T8LWT7tr+R0rxIQT
         G+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791822782; x=1792427582;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NRiPvD4kcSR893VSUB5l9+rGNh0y4KbElZYbWs0AB+s=;
        b=bk/VHkNdzISsARjp/2vHODB5BC4FNLOce72gZI4bgYkAQOZDHwzm8QckuskNRzHg0r
         bNVPmtgAqF6A6LRY3rSmM0rkZCR3Cp9LLuGDvCCUcOtmgfzGzys24uQUnY+HHtns8Irz
         RHVDifFF6DENqXyYiHFdnOY4G40N7A+CC9EZMyPleiIOYo/OlURLXlp4YEeaoypxPmll
         nXPBXRA3kPYmMtFWWYqJwZMevC5x2BOYqNY3h1CMx43jVp1gIY4QzStTEEl23arv4C3F
         ykKv/q28Ic4PAon/UkLN6TwO1KSqYi+ji7b9pgCZtg2sN8qbYkg/Ld0Fp4gfPu/GdBTn
         K62g==
X-Forwarded-Encrypted: i=1; AKwUvBxlnHwBXiiADwK9J1Y3W06U/bh8i55RLyJPK9n6sQaI7OQVo5e0hQ45yAzyAX6QvJTx14Rhy4N4@vger.kernel.org
X-Gm-Message-State: AFq9FYLCGN+OFlKm/frAR9Ux7FHeOSkqhhggxe2J43i0bWddqqDkeTPm
	zI75VT7XUmH+ytPwmP7D2fj5x/pF/fyfXsSJcfv235kqKKUdCSZInsOY
X-Gm-Gg: AYBFou3FrWzAEjKcxThGVLWmBWvLAAVGA+UQhdTC3n6LL2I7oK9mSROAZI66EASnxa7
	yPo77NSRNwyT7v2Hndqsjd83r9c9fzdstxEj02gaq3NmbA4GtRabUnoHnKBfF92+XSpBXgqmnYd
	As4xqYIVwHzdsHQxdk9DN1/ZcpXfxfKmIwnhfcUQ47UgoS0ofNaY/xlv/r7Ey7kgjUQiqMU0nhU
	8ZO2UdBv/bNSccindeQX9MI/uc7BOIMTPN6Jul+cODTMk3L4lbBax08BIzk0PJF+6ewGYXocfsx
	+nLJbrWUG3Z6KYriquevdbMoSa4lF/VoddgXGrFhOCi+KnUvcfjx+SlBc6+I/l1Ex8jNUlQbyyg
	+dalXvPUA4Quyl+UehPGWpqGOoL0brIlViUCxZLzOzjZ5yW2ZfAw+d651XkaA0jMyVb67wO6s6p
	HW9QxAdH4jOD1OpsRWxqaGVvz18rKs6M+EAQvZQH0qc1zz+5XYcifLpr47OAEccRyxYUpQV6U1Z
	U91InBlAiaIVaHphwsSamn1HS37UJqk2ANInxjDdhcxA7odmKw9uxLafwqDK6V/vIcpWHfnTSAD
	n8pbSKOjqkgVB6E=
X-Received: by 2002:a05:7022:b0d4:b0:166:780c:60b6 with SMTP id a92af1059eb24-16a5fc91686mr13865643c88.9.1791822782053;
        Mon, 12 Oct 2026 09:33:02 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:97af:5038:b049:4f32:e620? ([2406:7400:56:97af:5038:b049:4f32:e620])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a32eb7ebsm36603339c88.12.2026.10.12.09.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 09:33:01 -0700 (PDT)
Message-ID: <75e589b7-9a03-4f23-938e-e1b9ce5bf01e@gmail.com>
Date: Mon, 12 Oct 2026 22:02:57 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fstests: generic: add a test case to check fsverity
 reads
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 fstests@vger.kernel.org
References: <20261011222613.10793-1-wqu@suse.com>
Content-Language: en-US
From: Dhruva G <goledhruva@gmail.com>
In-Reply-To: <20261011222613.10793-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12-10-2026 03:56, Qu Wenruo wrote:
> There is a bug report that with the recently enabled large folios
> support, fsverity enabled files on btrfs can trigger reproducible
> warnings about file corruption, but in the end no error is returned to
> user space.
> 
> It turns out to be a bug in the btrfs fsverity integration, where blocks
> not included in the read range are passed to be verified.
> 
> This is a long-standing bug where btrfs fsverity always assumed that one
> folio contains exactly one fs block, ignoring the fact that btrfs had
> block size < page size support before fsverity support was added.
> 
> Add a new regression test case for it. The workload is pretty simple:
> 
> - Create a 32M file
> 
> - Punch a 64K hole for every 128K
>   This will limit the read bio size to 64K, which is smaller than
>   a lot of large folios, and thus can trigger the btrfs bug.
> 
> - Enable fsverity digest and drop page cache
> 
> - Read that file
> 
> - Verify there is no "FILE CORRUPTED!" warning
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog
> v3:
> - Disable signature verification temporarily for the test
>   Pointed out by Dhruva, as it's a user configurable behavior that if
>   signature is required, reading the file without a signature will lead
>   to an EPERM error.

Thanks, looks good.

Tested-by: Dhruva Gole <goledhruva@gmail.com>
Reviewed-by: Dhruva Gole <goledhruva@gmail.com>


Regards,
Dhruva
