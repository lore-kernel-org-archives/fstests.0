Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38B33D79E2
	for <fstests@vger.kernel.org>; Wed, 26 Aug 2026 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787755198; cv=none; b=Al92Z+6EtuXtRfcFMaN4dQSGk77SUE2IWmAdI3xzHf144t0Tc3347sPE8N0rc9efI74DsiyDhvJxvejSDlj/veXy9DBd06kYJco0LFXpZ7O6ocO9rllJpC4mddXYHGksZLGrwol43rPgq9HBpCAhBNhLYWxpuLzFnVcRb2lT+k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787755198; c=relaxed/simple;
	bh=bDJjKw4/xxeyJ59HOpwHh+jVkEXlWwxVkEkxpCae9hI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQGg99ZyEyfoNSty2INOM0MDy5TJzYJq/egAGvmJT5NUjiMkgMxsjBiBJeLp/cqQIlfneyR1imTR8s3sU/1TSho85J9JxK/7trlNLjlegacPk+UPHoC7XGXGtmyVnuMvKsEBLbHKxchfLjjRUM1TPiMv4ivB0g/PoMqAMd5SJCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QuBbb/ow; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QuBbb/ow"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a0de062db5so1844608a12.1
        for <fstests@vger.kernel.org>; Wed, 26 Aug 2026 07:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787755192; x=1788359992; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cEmQrKF7xg58/R5wZ0oPaRFVRUvzsKI8Tpt4pxHhnlI=;
        b=QuBbb/ow050AijMscsqZxgdakIt/f3Mkc5P2uEJY86ovjDtmKSSvCLxc5kp7p9U/yU
         IXGl59MnKMy3EJSAXJ03EbHDhDEGR1txaKdlqymnrJ1WEzR1ez5R84jTYHvSBProVukq
         8GmcOZgLN5Wkt+iFC7V0cZ9RgZXz9+ENPYYX0TPG+3j8oWhtvzn4FxEbuvY7DWs0Va5z
         yxiowDV3dg+s/+B8WreHHRR62eRRx35fKrE8EtyK04wokIGhNAtdZdHiEQLuFoVU/E2J
         JstnuR4WnMiTV61NqJv1ACFr/e5xqmNkCg6zgadMAecUy/XYQI3Ci36fV9lWnAi6h5Uf
         r41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787755192; x=1788359992;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cEmQrKF7xg58/R5wZ0oPaRFVRUvzsKI8Tpt4pxHhnlI=;
        b=HIRmpVQ+N+fHTdOionY5svADQkq1GdW19CUg3/wukp7AjRJ5rFoEbdpD+z2G4bTIn1
         RWjCxbcevEx7bm+hkPMDUY8kSV+9F9GBfc/RxMY+YrtlaxRzmWoOC+Yu5AODbHrXha/D
         lwPTtF85LUI8f1jOG8pkGM5/PoBvTOYDD5BU7E9JJwm2cywlGVTFL/j5f+J08Svw9SX2
         uV5mg62eai+5TrVwUHVqpMqdOVmeZ94Rqn36TVwldBlrVWMVkoQIg4hmo5k+qKgUTWmr
         uDQbwr2osAsiymhcEbVORTqlKg7gIkVE7KCe/sKq+WAfMyCtmDPaXnXgMmuM99C3nV5U
         Vudg==
X-Gm-Message-State: AFuF++lzv/7KQXp8KqkJn6IpRWaHh6cxpx6zoZ2Suo9lnpRbtxVBhECH
	/QRwsJLH8voiC4bJhexDoJ0mPSCBn/Ug7o5THpmh8p8vyv/im6Xdq4scLcdprlJeDBs=
X-Gm-Gg: AR+sD10UBry9MCWEUKdzcZH58mZBTnAdKpYaBDCb6xbSFwytI1EyptNdu9lydz6p+0y
	v/IfQF7Efl1Rcp9h+P8nmvuXnYBgBdPuBeHQ0WGOJQJl4AhAK/L86xjH1dTxaXWNiB87CMFicWW
	lR4i0KpDj+nqfppcWNUAv8qwjrOMLOq1WnSLzh//oETVL8Um/h5pnfHGfOAEgXm7EEUU3C3TnZA
	+/QdC73N+8fV2FJhX1m4JI/qFBkBVI9XnwyT9BnXYkg5U8n4uJvVJ7iMB5S+Ry4N4oCR9Lxji8z
	YJfHpaCif32kvA7DUBe+qlqrChNrw3sPyatxdGehiIh5kmtSTKNhyemk7+cSwk+GnTP0ZngSmrT
	NgZrVv2bZ6MNJFpaE4/XKDKomJV+lbSg8vqMDbTqDGAnaRjPjUJ56o34NMR+7htVlLGzDWdj1Q8
	uOseAAlKPZ9tN6tTJHlHqUji9zz2QN+8Xo+/Os+oCMeHYiE+JQWw3ppXqTANJVnWNPeXlBMDSCu
	nAppQ==
X-Received: by 2002:a05:6402:4510:b0:698:351c:979c with SMTP id 4fb4d7f45d1cf-6a5df5b0627mr12216450a12.2.1787755191938;
        Wed, 26 Aug 2026 07:39:51 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5deae5064sm5212340a12.27.2026.08.26.07.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 07:39:51 -0700 (PDT)
Message-ID: <a658f09d-0df6-4c15-bb6b-4e00d0be82cd@suse.com>
Date: Wed, 26 Aug 2026 16:39:51 +0200
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic/798: exclude nfs from cachestat dirty page
 reporting test
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, wqu@suse.com
References: <20260824151107.209027-1-avinesh.kumar@suse.com>
 <20260824161518.GP839663@frogsfrogsfrogs>
Content-Language: en-US
From: Avinesh Kumar <avinesh.kumar@suse.com>
In-Reply-To: <20260824161518.GP839663@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Darrick,


>> diff --git a/tests/generic/798 b/tests/generic/798
>> index 0fe37646..80b2acc9 100755
>> --- a/tests/generic/798
>> +++ b/tests/generic/798
>> @@ -16,6 +16,12 @@ _require_scratch
>>   _exclude_scratch_mount_option "dax"
>>   _exclude_scratch_mount_option "sync"
>>   
>> +# NFS flushes dirty data back to the server on close() as part of its
>> +# close-to-open cache consistency model, so a page written and closed in
>> +# one xfs_io invocation is no longer dirty by the time cachestat runs in
>> +# a later invocation.
>> +_exclude_fs nfs
> 
> Could you just chain all the xfs_io commands together into a single
> invocation?
> 
> $XFS_IO_PROG -f \
> 	-c "pwrite -b $pagesize 0 $size" \
> 	-c "cachestat 0 $size" \
> 	-c "fsync" \
> 	-c "cachestat 0 $size" \
> 	$SCRATCH_MNT/foobar
> 
> to solve this problem?
> 

Thanks for the review and this suggestion. Chaining all xfs_io commands
together seems to work, with also passing '-q' to pwrite to suppress
these lines -
     +wrote 4096/4096 bytes at offset 0
     +4 KiB, 1 ops; 0.0000 sec (355.114 MiB/sec and 90909.0909 ops/sec)

I am sending revised patch.

Regards,
Avinesh



