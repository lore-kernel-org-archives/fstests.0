Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D9B2FFDFB
	for <fstests@vger.kernel.org>; Tue, 14 Oct 2025 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452742; cv=none; b=Fxq0U7p1lOED9tCvLIjwGOMDHvLJ1VuVMcD4+8F52LTDcmhJrctX06X98p+K6kUecHhDf/d4m6gpQD+5nCmOG10whWiS1NvIX4c8ZNT2byquowagoxNxfnE+4QR09+ZupC/3p9zYxJE/igy309pkJonm2QfVWZVI1PBMOK84iZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452742; c=relaxed/simple;
	bh=gEk3t4S9waDtJgDByDPn4LtGM9xH0Oa/XbWa0erf0iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YWUDLsSfhtw/Gywd7pufrwKL/fnnkoe6gNqgn4r+1OyQeteiUOpXsoYGhk/nJx11LC7ky6+wbKS0H3aYTapiPe6R2IPomXMBFJGQ2FhJ4HwID6qadhuVOxREejw803UwVRrokf7pjvFzX+SzjdMLB5ODczhGuTN64cbYBYhNYRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csf7Mhwt; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csf7Mhwt"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2697899a202so42663745ad.0
        for <fstests@vger.kernel.org>; Tue, 14 Oct 2025 07:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760452740; x=1761057540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GqEDkib+N30KXArKpe7ewNMkywXK95kyiRz44nBvWWM=;
        b=csf7MhwtaocVoruSf6V9DDpVISfYKTvVspshQeFGQG3U4xOO+VNVnTpi7HHi20yomQ
         dfi54PbGenISskmZjSnZmUyo46scxUggc5BBfqYFPYKCsbYfAF5Q24Gfpa+Z/Z1N+fGL
         GF+mznGtYqYOFINEBRkkWeDN/OuckSiSNlM8bgR9ImIMN2vVhuLIIsnneI41veq/Kat0
         U/UQ96bW9556hEbDUX0mbhrog1yw8Y77OoD8x1Pi67DMBeTeZWPDAlOmL7S3n33WCaxy
         bcifj0Gd92dmrF60ilmn9R5EacATQZoJOOcDeKcn7ts9ZF21uxqWq123hQRjSklnurOi
         /sdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760452740; x=1761057540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GqEDkib+N30KXArKpe7ewNMkywXK95kyiRz44nBvWWM=;
        b=QXeYQD1OUJ3m+UysAfMLRiIs6hNRUJ2k3mnTrWK+PFu5TP9xyWjhzf7WfLNrOSPkba
         vY6xWkVAxx7N6rUj/VIdG2qvKATX10oLThAeCmfxU1yUi+khSMJH4WEvT9R77QlAkj6m
         THtD9b7EjGgXUORFO3C0n3p32AAKIDrevmyOhGTM4bEHI9gVZUhmDBx9y8WgtUMi/b9r
         feSu4qVaKYprZSwxFb4ROYb2FKs13TTKplLlOc1/U16XEabxaNazygfKhQsxHkg/79eE
         Rh3wa+JbNiqqOOJeqdAXXo38yfhONBmRdOGc6JSgHKpPIHJDi/6/hNRRaA5ajbCXZoZf
         Wrrg==
X-Forwarded-Encrypted: i=1; AJvYcCVwxaXCXSWl84XPH4Nlg/JMappcjs2pbYfmoVpMfUyDs26Nn7l2mPe11EF4BUAu21CgpRgM4Hfl@vger.kernel.org
X-Gm-Message-State: AOJu0YxX+bkfx1SAoUiBX/UBsmvqBVl/LT6Xm0vEfHlA80SQIF2eMA56
	QyGtqNEjm/QmvYCNAdqZA+B8e54Brz+s0Liz794W6AmQOIP5Y8ui+ASE
X-Gm-Gg: ASbGncvRjI5WwkBHEUgTa6HGeeaZBEMaPVphidtW7LE3WqZkpHrYbC8SUtILjvYDB4u
	xNHiEBfVL11kn3FsPI+c0ukQ5CcGsI5oPx0TG0yPeAstiGevg6Rp9K2lWrUMJty8SauWQWfCIO9
	39PxtGVccUXo+FQQ0dY/BHB9imGF4aaog8Bo1+hbWzghTtsagP5FmSYw23i3zTdy881oCxW96Si
	1bGIylFbhXQEkJgzBxvOOMjjoa+0+ljxje1zuGew13/IbQns97J5oAaO7oHjpnVABTem6mNaUU3
	o/JKLwRD3/MvrgetbqU+KivHrnyiGhlhPEW/7360GHbTxaRr+gf/yQ3BSDd2PD6iuczwRAi5tQX
	bNK3/GPiOQnvu/HkiRMfsUoLLX8kzGcOFzsK3RtWK43s3NzkSvlWzajbGpG1kR9EyeaJwtAqgJ9
	2NsgT90lr6YESdvOyvX3iPlTRc
X-Google-Smtp-Source: AGHT+IH9w7PaazGz7BQlcE2QlZOxdcMFUlkEfobVeM3DVC8y7AEtX5FV4nOl7zADROBVB9vnEIadbQ==
X-Received: by 2002:a17:902:e550:b0:265:f460:ab26 with SMTP id d9443c01a7336-28ec9c0c7d6mr378617155ad.3.1760452740152;
        Tue, 14 Oct 2025 07:39:00 -0700 (PDT)
Received: from [192.168.50.102] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df276b0sm12241194a12.23.2025.10.14.07.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 07:38:59 -0700 (PDT)
Message-ID: <fb51de17-1d18-4763-8eb4-454e6e6f55d9@gmail.com>
Date: Tue, 14 Oct 2025 22:38:55 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] generic: basic smoke for filesystems on zoned
 block devices
To: hch <hch@lst.de>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Zorro Lang <zlang@redhat.com>, Naohiro Aota <Naohiro.Aota@wdc.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 Hans Holmberg <Hans.Holmberg@wdc.com>,
 "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 Carlos Maiolino <cem@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>,
 Carlos Maiolino <cmaiolino@redhat.com>
References: <20251013080759.295348-1-johannes.thumshirn@wdc.com>
 <20251013080759.295348-4-johannes.thumshirn@wdc.com>
 <006ae40b-b2e6-441a-b2d3-296d1e166787@gmail.com>
 <4eeb481f-b94d-4c2f-909e-7c29ac2440b2@wdc.com>
 <97aece25-d146-4447-9756-f537acadace1@gmail.com>
 <20251014043000.GA30741@lst.de>
Content-Language: en-GB
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20251014043000.GA30741@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14-Oct-25 12:30 PM, hch wrote:
> On Mon, Oct 13, 2025 at 10:42:03PM +0800, Anand Jain wrote:
>>> So I /think/ you just validated that the skip if !CONFIG_BLK_DEV_ZONED
>>> && !CONFIG_XFS_RT check works.
>>>
>>
>> Ah, thanks for clarifying. Any idea if the redirect to seqres.full can be
>> fixed? It was missing the mkfs errors.
> 
> With "fixed" you mean not having the mkfs errors in $seqres.full?  It's
> kinda useful to have the messages there to see why the test wasn't run.
> What speaks against having the messages logged?
> 

Right now (v3) the errors are going to stdout instead
of $seqres.full. I was thinking it'd be cleaner if they
went to $seqres.full instead.

Now:
   _try_mkfs_dev $zloop 2>&1 >> $seqres.full ||

Suggested:
   _try_mkfs_dev $zloop >> $seqres.full 2>&1 ||

Best. Anand
