Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC28C3C3F48
	for <fstests@vger.kernel.org>; Thu, 27 Aug 2026 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843885; cv=none; b=aAJ0fgI5mpFJWDVc6tdtbA46V1smHN7sNF4ratNYlZkFejc8vGLXUY+khJ1Zz/dcbLsEqw7ozwo4cHvV9yc5JfRloSTBSQni+oJSWwHPCNDGrtit6BKg3ci5lI5yhERj7DDszLg9c1kSWhLXfv2pfV1C/YPznkvUmiIUvozvlBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843885; c=relaxed/simple;
	bh=fTmopjl/+hxJOphhjs91y+eFZKgv3L3CF3CkxnyNp+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lYxRlGJNu/4QHBMb2i3tChAyBhJfPumNlg9hbLWRV+TO0bPwvd8KKWmT96PiKm92GUyHRRqVXr5TS7MgsvAFUpObv5mX4KjTl54uwGkXoJYajstl1cLkei8M4+1qYahLNfjyn2TAsMUS5o3hTXnGNOCkMjWLrL7RptwKYHuH53E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q06gwgaJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jn3h3NfV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q06gwgaJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jn3h3NfV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787843876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVjt8fWk3CfwHLjJAJBXATnZYYERN1eV1FSy3IIco5s=;
	b=Q06gwgaJhcFp9hlVRNX4Lnh9GU+wyJGUIw4R38L2BZ4IqJPlYC36XPUnhkxfqMSlqHW2uy
	t/cE03DsFwtsgiKs3/1lxvHRLlJ1cMorwv7U6/GIcdBab7lsCHqOl3QclpqChhD4oxwdTh
	pF+tT4zs7hNXF4lyErsD3kPIVc+nywI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-oFCEzWi2PhCTVdck108sNQ-1; Thu, 27 Aug 2026 11:17:54 -0400
X-MC-Unique: oFCEzWi2PhCTVdck108sNQ-1
X-Mimecast-MFC-AGG-ID: oFCEzWi2PhCTVdck108sNQ_1787843874
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90cbc64a91bso567726d6.1
        for <fstests@vger.kernel.org>; Thu, 27 Aug 2026 08:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787843874; x=1788448674; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RVjt8fWk3CfwHLjJAJBXATnZYYERN1eV1FSy3IIco5s=;
        b=Jn3h3NfVy3WV/4KVfNF4BSUmnIf3dRc4V+LEPHA1q8yElmgRvbbN7YCnMdo3BdeUkv
         JZ75gLZ8h6p7X0CdGQntURauC+LeBJgT8dFbkYLjPlvkdB1Hjna5GbAjm32s9l/ac4WB
         ihh7FVmm3GvP5+s1Gzs+AQXPVG1r9puLhLRXc1Vy6O0EyW+Zn2UrtgQKAmnPffRVdwXv
         CPTZwuiyH7FdViA0N5P0bUHCV75ErgtjQVNc2+m93iAKfV2iGJmAEZ0CyLG7hxloUeVu
         7YZFqH+Gv6e8/KMu8vjxIJqb6i7gWrMLsO+5eqP3kVlPtwd219NAcBT3RiuxEj/dMBgb
         YBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787843874; x=1788448674;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RVjt8fWk3CfwHLjJAJBXATnZYYERN1eV1FSy3IIco5s=;
        b=SgVLHCojIxI2JAMyQyvqDJGw83XFq0B62G8xs5f+xOiWgRYUYy9NzkP1T4v+6drjbh
         D5lHHx5YbgZ7yK3rmOsC3eKqNsoGPGKNWC/Jw8TfioSAg1itfERh2pxkltry30TrSKfV
         sDojSLM39DM/u2J1L0Mo3k4PYZ91JlRswUyGtZqfMoWeOvKwEkcVc2DNpwFCvVuq4TS2
         q4dd7gF3Fv5c5ny6E8+6j14xYJhVqT8jx/0i3JSyA+ffxh52Ig5791vxrmzxnqd4xV4q
         /Gozz2LWnmcLk1pvVxf0z7gnMAKsYJYY8SLCt7Y1W8lPzMaY2Nk+HlvRZIRpDaNQR3l4
         6fUA==
X-Gm-Message-State: AFuF++k6W0jm/s76b1EH6PGCUMofE0F2O8Ky1EUh1gpvgIiP6Th6JNu9
	1vuG9Z0KLe5oJyi9o7bv5nPBztCNra1t/mdOFhefb6YjU4QN5/HebDGTAiEDRrLEU8+uRDOg1mS
	QoyOmrPaj46Gz+wKM9kUzZYeMncWDz8cHFCHqNPfeCy6IhV+Q33Vj8sfRx9stsLuvxCZEukvvfG
	9FhthIvon1W/bA4IyDDRksdcoUvQu1zAjRBeU1gtGvMqmX
X-Gm-Gg: AR+sD12aFoU6DclTxqpcOYbhADdJpKNIinYaOqGrCU2XxXosBcTA9fEZYArhutErpc/
	B7gxSr7oNnPezzo8KmiNmkCK0H4yyv5eZuHvxOrGhduUoa+IQ1OFnSAtFB3cpRqA6+EYFXZi58W
	Oe/nv+l8Ijnh0Ejlhi5BLkkYsWqVG2nIq8Xb+xCYNPx+D68/spjybGFnjGMMYJxJu8XTy8O/zTZ
	4nukuZfYNbpdfIJx6s3Vrq2lcCNjsO9XuOvbhU81EbZffTXh5jYalsJ6AHBrW1pIvkr0PDS203J
	NhB/MH9vUZKc38geuClxxN1ncnS3mUgQ71RQE8D9NvzT2yIifU02qD6KWp7QcbmLBonDGwGEHO3
	o6+wJw4SCF8rMB2VmGpe1KysDOCnPx9QQhUzmp20S
X-Received: by 2002:a05:622a:550d:b0:52e:3cf7:2fa4 with SMTP id d75a77b69052e-52e423a723bmr184109271cf.29.1787843873599;
        Thu, 27 Aug 2026 08:17:53 -0700 (PDT)
X-Received: by 2002:a05:622a:550d:b0:52e:3cf7:2fa4 with SMTP id d75a77b69052e-52e423a723bmr184107681cf.29.1787843872896;
        Thu, 27 Aug 2026 08:17:52 -0700 (PDT)
Received: from [10.0.0.119] (97-127-68-83.mpls.qwest.net. [97.127.68.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e42570b1asm39264361cf.5.2026.08.27.08.17.52
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 08:17:52 -0700 (PDT)
Message-ID: <769954e6-20b4-4100-8c6c-99286993185d@redhat.com>
Date: Thu, 27 Aug 2026 10:17:51 -0500
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] Add _require_chown as needed
To: fstests@vger.kernel.org
References: <20260825001337.449670-1-sandeen@redhat.com>
 <20260825001337.449670-4-sandeen@redhat.com> <ao8dOPXMBJtSbTXv@zlang-mailbox>
 <ecf63a4a-2e6b-42cf-8a58-51780630b3fd@redhat.com>
 <apBHC5UVZYiHZzbw@zlang-mailbox>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <apBHC5UVZYiHZzbw@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/26 10:14 AM, Zorro Lang wrote:
> On Wed, Aug 26, 2026 at 02:56:42PM -0500, Eric Sandeen wrote:
>> On 8/26/26 12:52 PM, Zorro Lang wrote:
>>> On Mon, Aug 24, 2026 at 07:11:10PM -0500, Eric Sandeen wrote:
>>>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>>>> ---
>>> I doubt there's any filesystem that supports `chmod` but not `chown`.
>>>
>>> Reviewed-by: Zorro Lang <zlang@kernel.org>
>>
>> Yep, I'm not sure why we have both helpers, tbh ...
>>
>> hey, you asked for ful _requirel annotation so .... ;)
> 
> Haha, I just wanted to add the same _require_ to patches that were
> copy-pasted from the same template. I wasn't planning on updating all
> cases across the fstests. Generally, for test cases that are already
> merged, we usually don't add extra _require checks unless there's an
> obvious failure. Anyway, since you've already gone through and updated
> everything, the current changes look good to me:)
Ok, I will leave it up to you whether you want this series, or the
trivial targeted patch I sent first, which is the only one addressing
an observed problem. :)

-Eric

