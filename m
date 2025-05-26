Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD37F72601
	for <fstests@vger.kernel.org>; Mon, 26 May 2025 05:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748236463; cv=none; b=AUtS92w/V9oakKYDSOWbikaguVo8Xt548KD0/q4DRmDT4mVd1GRSI1or+UNqsRwuYFynl07TjA+zF0O/dGbPp2xdi9sgEHYmnzsdxoVCgu0fNjt8SmrLwfFOF9YeAwP8SfuFdVs4RFNsbgakqhC2IQi6oCFJ0+Qw33BkEeZFaNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748236463; c=relaxed/simple;
	bh=GJAtokZxKSmMEPcgGa19X4Z/7TNcatnyK+5eMx6GNKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLlEXq0pl2aYugQk+PuCsqhdUi8w3LNIdPOAeBivATZBae5v0k4yFZM5R02Ip296+9nuwjh9y9uhytDL53C0hIEEk1MO7cyWA8fScB53t1jCKFI6i3gmWt1Ja93tLX08V0AhV6sGPgVkcXyV+BZkLXyDh5zl+D6gOM0X4WMeujE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoxEQQ2J; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoxEQQ2J"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23278ce78efso9909955ad.2
        for <fstests@vger.kernel.org>; Sun, 25 May 2025 22:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748236458; x=1748841258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K2NWtvW+69716zF/2pgHyf6Jsgv7AmpN3S1nwiCCkrw=;
        b=WoxEQQ2JOf2ZHP1YmAlu4jA3cLtCS4u9nD6tddwIIJx2VunJyaIBlUDD2mgkYA7gr6
         6XuXoQSFb9cZrjptbeuLdBCR93iSHgeu1DMuk6FOxiIMXUVeZDXv/H3sqHwifxwB8xyF
         ltcltQYnOsdpGIyeORQ4lAUNgSmCpExunBctK44cWccB8Ra5EkQzb85UFfvWrdO71PLD
         CSO3sWJpOeIyH2WUHlUi1k82Pfj+gfO+Bt/78xvTgeHJho13tIX3DEyYdlvHDhbxFQc9
         Fj/QEBfJlsjBPQRxcHjOLHBsxYOa5h5aIRY0jms3jBwGQq6JQLTCR3STXhCTV+4iDVuP
         s9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748236458; x=1748841258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2NWtvW+69716zF/2pgHyf6Jsgv7AmpN3S1nwiCCkrw=;
        b=KoLM4hvJUSFj+y/5+G4m/kuBBbgHnifLRBQsiovf7qqZaVjvo6sx+MsJRmAvcvJeCH
         vBTLb5gEu88y6TsT5ftCGPtjzEd/aEFK2zRIAHMInolIBqBh1avPID2im2OwNPAWb7XP
         SeMcBloa9gwZ0RvXDiGil200mkv0U2B30FF+L9ccD0SJNBBuWZ4snTIfaJZJs8vYJvLe
         ajolExpsMYzKCJAxXSffgwSX2vwDUJjANFOmQ8IgxfGWh24xYjuv6AjGGCWTq0s4gMwW
         OOF4aCUL8Y/QVZcsYRHm88IEjC97QbYKX+1WUraY0EgeFZvVjYXvvFTXAK+8MHsRwwii
         MyPQ==
X-Gm-Message-State: AOJu0YxNwaPu2vRwQj9c35/kQxIX0SRjf0zOeQVz2h9qgvwM6hBwsmCn
	/sUqtaMNiUDLKpzU49KXV+/Vd93jQ9DTlAAIIZN11fQ6phPT9819Xvj33Qj7Yg==
X-Gm-Gg: ASbGncuXVcprTQhmzKYJvz743iDhaqjVklj9vGQDSpMvaNP6wirZiXOdlHy1YVG6nSE
	uLU8D+NwhWvkFgDOMqrgcGbjjkwYPCtC0+VkdEVnChQmWhaKkbdSIt9lxgXV4FHkpyg4YL964km
	iaFfSfL+HpnQFwBCSSseSLp7z2ms4w2j9FDfGUvzgTuLWUUCbpQ+cEABFgEi9Q/Yy0h/S6+g4wV
	+demQKfTVdggeIlUp3FZ6YbX0VGJ+Cbq1RnW2Zt1UQ1PzShlbjCKcKokxOUjv72p0V6MwqIshTE
	kSoWHlpf9RjqR9dsC16iff5Xaa8jVNspTDc9ROgouyWyDrrFOkmXeo/lrxoLGw==
X-Google-Smtp-Source: AGHT+IGlTzD1kCyMMRWsUCe0rdEimlYeGmNxdt1OYi0vl5iJ4OewHKHspw29+uHNs4VVQ1dOf99B7g==
X-Received: by 2002:a17:903:946:b0:215:b9a6:5cb9 with SMTP id d9443c01a7336-23414f490bdmr132961535ad.5.1748236457848;
        Sun, 25 May 2025 22:14:17 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234488fde35sm16602745ad.225.2025.05.25.22.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 22:14:17 -0700 (PDT)
Message-ID: <7e8d7e21-215f-400f-a891-10eed06c53fc@gmail.com>
Date: Mon, 26 May 2025 10:44:14 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/28] fstests: remove support for non-numeric test names
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
References: <20250417031208.1852171-1-david@fromorbit.com>
 <20250417031208.1852171-2-david@fromorbit.com>
 <0b040e1d9f7157614067850ca662ee47f68872ca.camel@gmail.com>
 <aC08zjbjWxcAlQZd@dread.disaster.area>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <aC08zjbjWxcAlQZd@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/21/25 08:09, Dave Chinner wrote:
> On Wed, Apr 30, 2025 at 02:47:00PM +0530, Nirjhar Roy (IBM) wrote:
>> On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
>>> From: Dave Chinner <dchinner@redhat.com>
>>>
>>> We haven't had any tests using the "999-the-mark-of-fstests" name
>>> format for a long time. Th eonly test that used this format was
>>> xfs/191-input-validation, and that got removed in 2022 by commit
>>> c1941d6f5 ("xfs/191: remove broken test").
>>>
>>> However, the infrastructure for this naming convention still exists,
>>> so lets get rid of that dead code so we don't have to carry it
>>> anymore.
>> Any other reason why we are planning to remove this convention apart
>> from the fact that it is not being used for a long time?
> It hasn't been used because nobody has ever really seen much value in trying
> to describe the test in the test filename. It would be used if
> people valued it, right? Mostly, though, people complained about
> that one test with a weird name....
Yeah.
>
>> But yes,I
>> agree that only numeric names are easier to refer and we can also use
>> some one liner shell script tricks to run several tests - something
>> like
>> ./check xfs/{1...100} to run all the tests from xfs/1 xfs/2 ... xfs/100
>> (ofcourse assuming all these tests with these numbers exist).
> Right, that becomes more complex as soon as names have free-form
> components.
>
> If you want to know what all the tests do, use the lsqa.pl to
> extract the initial comment in the test that describes what the test
> is exercising.

Thanks. I wasn't aware of this. This is useful.

I feel this change is useful. Feel free to add

Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>

--NR

>
> -Dave.
>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore

