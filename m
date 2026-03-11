Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F5A33B6C4
	for <fstests@vger.kernel.org>; Wed, 11 Mar 2026 02:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773196343; cv=none; b=h2YGBJiDh2w+LezDPdqcGQM0BdHpPQMaQ7UnkLhs5PmNOm12783Nn3TjlVGZ2mnKn7s27R6MyDwb3HEYro3CrTBPN7LVwK7fhK1wlmiIUqWOcREiWTgAXzpBKWS1yp2ufy2b3cMyUwJzWLUkXw8qp7WRDTpZSakQ2x8un7485Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773196343; c=relaxed/simple;
	bh=2Y2qzvuPFdU5DMP+6rADIQVlTkbnE6vQUfOagnM8Itk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0Sfr10CD5xFy3AcZto/N1VLtZc+GuhUVWsXxMU+p5PaxuOZQteP0M1Y/TMhU1TPG4YelMmNyq+56hPOElKp8OBviYzh3nMtq06ohRSVPg2ybjAhYPfvMm5yELm2ZI2C26t3QGHBMpwEDNjpqcdylwBq5GnTQCB5zOklSHxWOGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZrB476i; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZrB476i"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ae5636ab04so102497515ad.3
        for <fstests@vger.kernel.org>; Tue, 10 Mar 2026 19:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773196342; x=1773801142; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OBSynOvi3xpXr30q7Fy487t9vRr0oTbMzF3rt3i3WIY=;
        b=mZrB476iV6v+UUhfHNu0Xc4xcpu23gRjWlMTM0YjNyXgIME00YM3SF3fD+obqq13Q+
         /Yh23eitCx8vLGMvo4zyBALew0QazOz+GVOI/IF93I2zr28wzPrN8kzJS52SszbPEgm9
         jMRQ2oUgmirvOR1kSPjYUGU7qozsAdOIHpBkS31uUEPtG7MxQ+3tUEkzYsJoWGwQo+rf
         OS7kjW4iiWTL8xQElAeJZwslGE9Y5ePm9x3u39tlEH+6xYubtXbrivoWns+D/tQMPQHL
         2VdK7xhGw7sjlC7wVt642PWMynXkfKpV10aMZtOVN9p3K1A3ssX3fqOPLFQF1ZU6Qagl
         vrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773196342; x=1773801142;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OBSynOvi3xpXr30q7Fy487t9vRr0oTbMzF3rt3i3WIY=;
        b=DJFEE3nWBc89xWRp1/NNXc66F5edNuaAByDvODQX+D3qGhtmrAlTLeaFnrrqaF0w+U
         yKOBFItkdPcWrVRuA9fUvEhXfJa8u+2H8yyBLS1r1dvgX95bVOL/jxpc+nsu7kSGPk4v
         nhE6GA0Cql7W7Ar4l3x/xHHU6jEoNIFvht4MsQgPi9UNYS5F/w66JgJfTgnSzW3LH3i+
         PgVg0YX/JMNCwDPhOith8TuROsfnuvNa8jYypwOXv4bv/DyFdBQOtOWdeCwuM2Q/r0ym
         ctIWSsjVI3Q5PzEbjQP7OEkCzNDoWcvMzVCKuEf6ZLFjgoDa8XU72QTke8OiszN/J5ZL
         nXHw==
X-Gm-Message-State: AOJu0YzEoxwmrLj+mCkvzIz62EirVhIqFcDwDeSEO8WY5ymDugLWdckc
	QeI3lZYH8KWvHMlsVZGmSWVpVtp8ZC26PtByE9MKScWVnir4bDzqvqOn
X-Gm-Gg: ATEYQzz+tnsgr9+wy65hQpuKnT68icC9/6W/4c/EP4N4prcBpqVw3h0JVOdbDf7xVum
	v1Jbu/4MfJI9PDmPCQU/3xPAtoozUlqO2mRZkpqJB0QkuiaI1WXUN1un1JoKubQxVnE+W7zuWJ7
	52S4OlhI9OwJkFcikAlGjn3c3//Oi+hgG+Pz/gbZ/2AdNSy7CCPXg459xwZPB+BfPA4NDZcXnBD
	yq5Y5kJafChaeGfBb9Yqd/H6+QOXUFFZv3+1fZ08bMmLUUhjhlgeMmkcRf6xRUfSrkMIF5ZOxRl
	Y+UaDOkVfSS81kR90vmgOY8t1F8Mp0YTkdGfjr3EgLXPAdRq77jySlklsXdViinQN1ii5KeSSVj
	AFsxEfS+2IapcANmIq+x79Rl6M3boJ4cnhlgdx5yCjqsqeejTDed6SW590m+RDPn4p3e5rDvRX9
	9XBHN7J6H1Bp4QC4RUVWhQ3Gr9DYE=
X-Received: by 2002:a17:903:2b0c:b0:2ad:d5ea:4c89 with SMTP id d9443c01a7336-2aeae7c04bcmr8516825ad.22.1773196341648;
        Tue, 10 Mar 2026 19:32:21 -0700 (PDT)
Received: from [192.168.50.90] ([116.87.14.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae0e61a9sm6442645ad.0.2026.03.10.19.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 19:32:21 -0700 (PDT)
Message-ID: <43710dd2-4282-4475-a29d-983295fab86f@gmail.com>
Date: Wed, 11 Mar 2026 10:32:18 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] fstests: add _mkfs_scratch_clone() helper
To: Zorro Lang <zlang@redhat.com>, Anand Jain <asj@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
References: <cover.1772095513.git.asj@kernel.org>
 <254fdd3e212f6618ea33207ef24db2b316d2d8fc.1772095513.git.asj@kernel.org>
 <20260309191317.vxcjvqfpoqdiycki@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20260309191317.vxcjvqfpoqdiycki@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


> What about if ${#devs[@]} > 2 ?

On purpose- so tests using _scratch_mkfs_sized_clone() don't
pick a random higher number. If a test needs more than two
devices, opens an opportunity to critically review this function.
>> +	fi
>> +
>> +	case "$FSTYP" in
>> +	"btrfs")
>> +		_scratch_mkfs_sized $size
>> +		_scratch_mount
>> +		$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/sv1
>> +		_scratch_unmount
>> +		;;
>> +	"xfs"|"ext4")
>> +		_scratch_mkfs_sized $size
>> +		;;
>> +	*)
>> +		_notrun "fstests clone op unsupported for FS $FSTYP"
>> +		;;
>> +	esac
>> +
>> +	# clone SCRATCH_DEV devs[0] to devs[1].
>> +	dd if=$SCRATCH_DEV of=${devs[1]} bs=$size status=none count=1 || \
>> +							_fail "Clone failed"
> 
> I'm wondering if we absolutely need to use SCRATCH_DEV_POOL for this test. Could we clone SCRATCH_DEV
> to an image file instead? Or would it be feasible to simply run the test using two image files?

Using a config file and testing directly on block devices lets
us cover a wider range of devices.

When I wrote this test case, I was also considering whether a
serial-number–based mount without extra mount option, would be
better in the kernel.

The downside is that xfs/ext4 testers now need to use
SCRATCH_DEV_POOL. Let me know what you prefer.




