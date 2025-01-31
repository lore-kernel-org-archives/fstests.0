Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D5414B092
	for <fstests@vger.kernel.org>; Fri, 31 Jan 2025 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738337803; cv=none; b=q6X9fk+iYaizyF0HYcw7OAzNBeXSJZ3iwVDbbQTYKyNi0uhxjOrefF2yppNW4QvZyJvFHv0lhPRnzqI7pmSc54XR39URKmp3W60sxyBdl5B4mhgkgWT3Cf2phIME2+2FULLGOSlHw0FZSOg0d5cVlUfXXG34UFEeuiAXQERwcrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738337803; c=relaxed/simple;
	bh=+nK1MVrsQ+Mj1wKhIWqPrBHJEXEPId05G8ixPHv+6HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9/tDpAFJSCGrJlLea8MQ69V1saqdhOEJggjl89SjKzYxwGMuRtw0QJTFmL7PJoo/FAnDLe5TCdivSUHgaYO9d+m4xtho4u5BQO+RPHcrL9qV7XE5DEgHNSLmIqZEsuOp3BspMht8kD9Cka51xTO4JCe+nRuOqYn5QA4MvyZbxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GhseJ0nm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GhseJ0nm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738337800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kCHYGcqGImx66xYuS+Osxxrt0G9Xqdmj7rsHk+CBX4g=;
	b=GhseJ0nmJGWcVpbHzvLGBYt7t7bs2BtVhSNRVl5OKlCNfglbCuT+fNd7Yv1U/Lm8ANX/qS
	OUo9/qiyHkTWfbLjqA8F/mfE/pYUcfCnlKiB2s8+SfAfddjKro3/hBIq+iW++Id6G7E9bB
	LFF4+6x+SeJM1pINd8yQsnJVTn2NfgY=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-tXXsC-dVM9yLAva4LAOa0w-1; Fri, 31 Jan 2025 10:36:38 -0500
X-MC-Unique: tXXsC-dVM9yLAva4LAOa0w-1
X-Mimecast-MFC-AGG-ID: tXXsC-dVM9yLAva4LAOa0w
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3cfc08132adso29702395ab.3
        for <fstests@vger.kernel.org>; Fri, 31 Jan 2025 07:36:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738337798; x=1738942598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kCHYGcqGImx66xYuS+Osxxrt0G9Xqdmj7rsHk+CBX4g=;
        b=Qo47VEomplGxGJtEfUjvSm02orscZNiOh47mEm0keclTZfoZsT1tsQsMJ/lFos78k2
         +sqv1Jb4TuE7gjAKz/DFzQnuiYldRrLHQkfVBE/l99l2hQwxGMkI7PMFLK0UIwyWI4LK
         1Gxum4IiRvxs26sCjQ7P7A2B69nkrJw4HxZSOpRuflhVy9yIcULjkTAtTmQ2O4qKEbP9
         BrMAdZzYJABfDKc1j6TuSZ2VKHAgBh8LVky3QZieXBsNP57pGl/h+mG7OBQFhupe2wUA
         tWfbNIH3TgJ4FLSwFyznUK9K2MmrlnQzeuBedOXXAWmDrITsr4jIOBsf5Xz2qk79W+s/
         KfUQ==
X-Gm-Message-State: AOJu0YwEk9hfLQDmxoG+A6xIKFunwugcmm1+RiD2ZVjODhB/a6tJv779
	ab1kO4vX0MXfNoigmRZpW/e/yOnvry7aiit4EGE6oXcB1vO81PvynkI9WF4l4IIbVooi3MTFVgt
	ga0qUAGNIR16A+dXdn9N5BGmx3NlAlRMJPdTH2haDwpMmbqPZZiWfrVk=
X-Gm-Gg: ASbGncsnNdRqHHjVkOwA+w17sDhu8oGpHZAR5t7CK+BCpm5FzgdS7Lf2qzX6Yys2iiY
	xO9CfuI1qVWvwm87AYGAbW4UFSSMFUyIGQBXVEKubkmL4mWi6fa0WW64OtQl77rjQSetDxjAhY9
	baUptJM5SWpP0ZaMUDjbfXjxANeXWYbihVDivTFaWYeXUZxdGdoKKpuJnwqs7xs7/pRc2ESv2aw
	SitpIu+JpR6JQSo+KINojEfW8TXutwmNdC14hom5BaDrI9OvnMpr3txpd2ftO+dYTwGggrTXICh
	viOxE5if0yPVM553+eNlkH+8CCEKeGOgT+vQzN7DCPbA
X-Received: by 2002:a92:ca45:0:b0:3d0:10a6:99aa with SMTP id e9e14a558f8ab-3d010a69cfcmr43902145ab.4.1738337797184;
        Fri, 31 Jan 2025 07:36:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8mzTET5L9cmSAn4MkAf4+OtT/FA318fOWY2K2XU3aDe2n97vdi3JIxKt/AOUbY+aHWvJnvA==
X-Received: by 2002:a92:ca45:0:b0:3d0:10a6:99aa with SMTP id e9e14a558f8ab-3d010a69cfcmr43901985ab.4.1738337796855;
        Fri, 31 Jan 2025 07:36:36 -0800 (PST)
Received: from [10.0.0.48] (97-116-166-216.mpls.qwest.net. [97.116.166.216])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec8b535b3bsm126975173.104.2025.01.31.07.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 07:36:36 -0800 (PST)
Message-ID: <d31161ef-ab18-4963-adee-3a2608282630@redhat.com>
Date: Fri, 31 Jan 2025 09:36:35 -0600
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix vfs/utils.c for big-endian systems
To: Christoph Hellwig <hch@infradead.org>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>
References: <fb7ad928-bbe9-4488-a6b7-a2786782bccd@redhat.com>
 <Z5yFi6Ofr5_I75jL@infradead.org>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <Z5yFi6Ofr5_I75jL@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/31/25 2:10 AM, Christoph Hellwig wrote:
> On Mon, Jan 27, 2025 at 03:43:24PM -0600, Eric Sandeen wrote:
>> generic/633 was failing with EINVAL on the fsxgetattr call on s390.
>> Looks like this is due to a failure to properly endian swap the
>> arguments to the syscall, so fix that, and the magic_etc compare
>> in expected_dummy_vfs_caps_uid() as well while we're at it.
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Do we need to enable sparse builds for xfstests?  Or is this
> goign to create too much churn?

Yeah I wondered about that. I bet adding the infrastructure would be trivial
but the fallout might be a whole other thing. ;)

-Eric

