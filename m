Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18334379C2A
	for <fstests@vger.kernel.org>; Wed, 27 May 2026 06:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863308; cv=none; b=nkYSHlQshmtBcdC9zZeQ0uVGIMm0ln1734Z3Cl8ALBi9+zPmtOZhMjsKzEkzLmjMzqkkatxitckahJbhlU+OZsgTpBonNv4krkTzIghfAKABTRd/qgVzDKhEo/KuuZ5co2wYmB+TLlKiv0agXaAaEkAbIil0C9xNCf7BUmpK/q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863308; c=relaxed/simple;
	bh=We6YWGS7Vshkh2dzgEtNCuoy5j1D2OYhS0q5NpjAujc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cP8n2Eme9tjx6hned+tTHPIMcd+eWq8niJx8fU6JuVNE1bOYK0WDFbVs8byArpgKCnOBARi+IngMC8oscV1vDNH5FuMjvYWAtjvmYphgT8dKwaSeu1woV1fBX6OoskhWt0m7wavGSNmJl8MfUO9h/sZwHJbPe+cGc5J4psCh8Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mzm0qycJ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mzm0qycJ"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c736261ee8dso5143399a12.1
        for <fstests@vger.kernel.org>; Tue, 26 May 2026 23:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779863302; x=1780468102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1B3JgvbLHdgt03H+AXy7jnDMjCMjXn58V4DlsX2a7Ms=;
        b=Mzm0qycJl9CHfMgSlgQHQXYW881o+Qo0mDuO/aijZlgINppzzS9lnG4zJt4PRBTle0
         eH9EuBT2jtkIZK9X7ti/tvfu+z2rRuchsYTpo+3Dtn/VPdbgesbO4DdNowZHOgwqaJTW
         Jb1NFyxxn5N9nh4W+tdeYwHJ7zZ7juK6k1PogR9USDnqwBqytW4VBO4ewYZqBNiQtzld
         mTdnOxus8ZwSs2kLjiM583C35EOiSr7Onfo6Y+kihiGmZC7xQ1aUZb9acGTt98OSAqQn
         mH9uszKLe/7XPwHmVTKKnRDMenEsy+6McShUeTkMopbRVrb2i49jtDDwwFcCj1EjMvpF
         6xzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779863302; x=1780468102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1B3JgvbLHdgt03H+AXy7jnDMjCMjXn58V4DlsX2a7Ms=;
        b=bBmNOb/ooy1xyCyp4olc99CUSal97wjgwiqi9R18YOn4p4MleL49uP2tqXs0KpFa+0
         B7Bg783IBt/PNRL004Sk7XamuJTV6tiUFvXAShQZR+ahv9Uoz7/w9g2Ey8OWmJqzSg/0
         j2TCR2aALP5tUVbv8wAlzWZsmut1wLptBlYMYD7OWlyzyQGFFh4C+RLyXH0LvtyUdBue
         TaOvo5Z3jgICMwedd1nJLqiXNnquj5OUl0jsHxaLi2V6brh4BoCKd4XLv71233u+3vyf
         Y4zTALcCmVwr29ELQJjW/7i641uZ0aVZEn+HqQ+el7DyBjER9DzRfx3zyuQybHXJpmEb
         uGPg==
X-Forwarded-Encrypted: i=1; AFNElJ91sbfA249I1Fu2BFVkgWO+6SUPsgncBUtSNmDYiGE+WH6nbupmwGd3w/kBxDe0k7EJYviO5Cf7@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw8UKFWwxjCPnf4Rdw2bhrrJek82S5PYnkCmAkGOIiGvYRMz90
	sAlxh9y1vQwS8DZ2qZ3R97VLmJWxdh7lgrYWmaTK1DrE0dTUaH327lKb
X-Gm-Gg: Acq92OHJFhD9rpHj5bmc/svubj8BmKLmztwXvd9GlwWRoL5w0UPUIS4sD8MhIiI3uC0
	6yT28nWh+06CtkDQFjQH3nIZiyP9Tu2E6dBYKmT6gjigGZ6TVf/gKQg7Md6sZ2TCgrcaTv1g6Go
	eY331Sb7Y9fQ/mCCq3qZRAI+dUrcnuXVIapzEtWNfFptFqre3YxIlyfFOTTxywD5hbL96jdJoU0
	BH8yknkMWISKYCUQp4qpjE1UHb8NWkghGyoPqLfjTQEOzvQumlK1Fjv1mBeMFSAec4/qZnJlU2e
	7MuNZSIg2qAhN8/PIdkRjEy/xJT8w3xU87kloKn0ZJfkDRq3OvXcNNH+7bsY3hzl4mOT7tTpP8o
	WKHStgBVbY7+gAqzeYgIH49inTwHqYd3YEppGpEr8a81iLlVaKooIX2lBICCKdAFu80ngmsdsA3
	0Gmm9sX9jSJ/UsROEKlbM6T6oU8+5bWKwSO1hjswjZPc/pDTko
X-Received: by 2002:a05:6a00:3c94:b0:82a:5d55:5807 with SMTP id d2e1a72fcca58-8415f580e4dmr21715172b3a.6.1779863301649;
        Tue, 26 May 2026 23:28:21 -0700 (PDT)
Received: from [192.168.50.90] ([116.87.14.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d7301bb3sm1215872b3a.54.2026.05.26.23.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 23:28:21 -0700 (PDT)
Message-ID: <e3dedd67-35d8-4088-8239-8ff145e70b8e@gmail.com>
Date: Wed, 27 May 2026 14:28:18 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] fstests: add test for inotify isolation on
 cloned devices
To: Christoph Hellwig <hch@infradead.org>
Cc: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, amir73il@gmail.com, zlang@redhat.com
References: <cover.1779367627.git.asj@kernel.org>
 <1c60be06ce79778404079c8b1c1d2e09f64cb38e.1779367627.git.asj@kernel.org>
 <ahP1tCc81ascjwxJ@infradead.org>
 <edadc872-5796-4cff-934b-cee66fde79d2@gmail.com>
 <ahU9hpwrXyZChw9X@infradead.org>
 <e8d0caf9-df8b-415e-9f89-bc71e73a0e32@gmail.com>
 <ahaOPOQYaE1wrbA6@infradead.org>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <ahaOPOQYaE1wrbA6@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 27/5/26 14:25, Christoph Hellwig wrote:
> On Tue, May 26, 2026 at 11:19:30PM +0800, Anand Jain wrote:
>>> fanotity and inotify use exactly the same backends, so I'm not sure
>>> why testing both matters. 
>>
>> I noticed that back then I decided to keep both.
>> Since fsnotifywait -F is only supported from kernel 5.1x.
>> inotifywait serves the legacy LTS kernels where required.
> 
> < 5.1x is pretty old these days, I would not add test just for that.
> 
>>> Not that I care very strongly, I'm just a
>>> bit confused.
>>
>> I am happy dropping inotifywait if unnecessary and confusing.
> 
> Not a major issue, but it felt weird.
> 

Okay, dropping the inotifywait test case in the reroll.

Thanks.
