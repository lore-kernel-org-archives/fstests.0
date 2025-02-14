Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343DB2F24
	for <fstests@vger.kernel.org>; Fri, 14 Feb 2025 03:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739503057; cv=none; b=IlL+xILI8CQ81Z741vG0mFEoLqODkRkZUe4VoyK0I3IQ3Jb4ExEvKga1UMlNsTzEhvmaSZ028axhRdT71LlFJR7NxSXdgz6stIjtHXS9CQ7wGWOfIBk9J6AerH51wt4Lkkb+AosuAoa4lAjuwNxGerk+K3LYwrga42VdfmIjmWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739503057; c=relaxed/simple;
	bh=LmLAeI0q1YgXh/aGYKuId3Q3uFsLzf98nbE9V7eTOF0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KY2hSg9jVUde3fZ88q1RLith/JfwPxJ+c8ORIQghKTVJDtbiP9bOlLx9mSs3B44+ODP5yYovzvpPmyVgrZfCdN2j7xQUR3cVC36+8NIcnjc+2JpSUUhi8bDPlbqcVDKr3HK5GZzyPOZ5K0MR2ag2iD4UfW+wQT0YEZotbq4oLkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LzzrSQfP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzzrSQfP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739503053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qi6gfvZqkg/0aqT+7ueP5EiizDyfVztJEjvwGC/KOvE=;
	b=LzzrSQfPGwkRvEHYuM8awoZA2ki0Xi6O5RPlh0SigrEGDGLizND0mQ5f0mbTg/baQSWEtd
	fyIPmAgREF78gd3QZxYY52/nr8qpCFvZrCJ5vlD7kzCD3Burt4sJUgwo+/xgnd6XLh4i/K
	x4Zpy+ZsM+9sMMvC6VBrd/Jgku9CvIw=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-LC0oZ1riP-qlQjWzAS2wlQ-1; Thu, 13 Feb 2025 22:17:31 -0500
X-MC-Unique: LC0oZ1riP-qlQjWzAS2wlQ-1
X-Mimecast-MFC-AGG-ID: LC0oZ1riP-qlQjWzAS2wlQ_1739503051
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d197e97959so10623675ab.3
        for <fstests@vger.kernel.org>; Thu, 13 Feb 2025 19:17:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739503050; x=1740107850;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qi6gfvZqkg/0aqT+7ueP5EiizDyfVztJEjvwGC/KOvE=;
        b=E6gIiyLbmlc11IhHlsCylCwN5WZYMDxu0J3r97tCHK6HVsKkhgoGzpim/PhwMAnv/4
         fpgrQOcrEk7960VWmP6aLoAMEyaAATUBXC5k10t6mjybg7XPedKzPZtRtdR8+8nz7Pvl
         GRPXgg/vwdz21IxJD1IQK68ty7AmEPhaDmAjd1/+qLMhLVpJkxG71VpgfmNCr3StmSbk
         80Ud9pHhLjc4NT29QBw7N1bDQFHLlFVTRw2I5bEaJBMWExKVASOYfoO5kRCrUWfTIgPp
         9lHBU2kglMgvCmh+5j4uM/nbcu7aK4wcXWFum1x3DJ4vTaWQf5uUU6rfLEbTu7skMUPa
         teog==
X-Gm-Message-State: AOJu0Ywry8bpLgHlKoU3DgJpddyaOzpz6R/QpvlnOXi9P6G4zL/Zylz/
	Q2kjyGiUWSEXY1sJQpAakdw8bXrXQ6fGzYXliasgQwshj/M4pdrIT5mkfEUw17zwzwqmESQo3Zy
	4gjJPlxlexoFigEjs5stGOW/JPBoGjtjC35UGAemJQeCNQj40DGJrQIfU0za8VxOVjw==
X-Gm-Gg: ASbGncvo83fZATQ3SS8g06VSKE65OqChHqiZiLqkhiNdw+S+uJOmDy0XYbs2jhzfTei
	9UeE2gtwzkk276Eku8hvv5zjs7wFsItkAtiVJPVmuKYsSsU3tyn6O1ddP84tKYRkPwjzdBWIG2o
	AHF4YM4feEZAIB/19BcmfSby01RHve36w6jE6f7IFQv6bK7C3TjjM9SmB3n9PvoHdRkb2RK6M7R
	e+RBAL3rdKwqrPilqcHLvJG9KVz/OaUldmOYbxfdeOuGPm9oD1EWZwr852j3P8zS3MgG+qQC6J7
	GqYSU2zyI9f4o0Mpo6VLIju7+7b9wAnEK1+5BxxRK/jZ
X-Received: by 2002:a05:6e02:1568:b0:3d0:e52:7d33 with SMTP id e9e14a558f8ab-3d17bff8332mr82334085ab.22.1739503050250;
        Thu, 13 Feb 2025 19:17:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQGwLQcJwkwUIeZ6B5k5n0wOBJtMgBfbyd7kpRAVg8SZ7BQZJ6U2wkuubItb/e1urk511H2A==
X-Received: by 2002:a05:6e02:1568:b0:3d0:e52:7d33 with SMTP id e9e14a558f8ab-3d17bff8332mr82334005ab.22.1739503050001;
        Thu, 13 Feb 2025 19:17:30 -0800 (PST)
Received: from [10.0.0.22] (97-116-166-216.mpls.qwest.net. [97.116.166.216])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d18fb682b9sm5068775ab.63.2025.02.13.19.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 19:17:29 -0800 (PST)
Message-ID: <f05f9875-1552-4d77-8403-7b191da24141@redhat.com>
Date: Thu, 13 Feb 2025 21:17:28 -0600
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic: test zero-byte writes to new file
From: Eric Sandeen <sandeen@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
 Namjae Jeon <linkinjeon@kernel.org>
References: <b4d76883-e58b-4db3-b7e4-7ddeb5ec7f42@redhat.com>
 <20250213195129.GZ21799@frogsfrogsfrogs>
 <e2240afa-2335-4462-81db-410d0b10737f@redhat.com>
Content-Language: en-US
In-Reply-To: <e2240afa-2335-4462-81db-410d0b10737f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/25 2:50 PM, Eric Sandeen wrote:
> On 2/13/25 1:51 PM, Darrick J. Wong wrote:

...

>>> +rm -f $TEST_DIR/testfile.$seq
>>> +$XFS_IO_PROG -f -c "pwrite 0 0" $TEST_DIR/testfile.$seq
>>> +test -f $TEST_DIR/testfile.$seq || _fail "file not created"
>>
>> When does the file not get created?
> 
> In some unknown error case? ;)
> There's probably no reason for that test, though of course
> it's still expected to pass.
> 
> In the various discussions of the exfat bug scattered around
> the internet people kept pointing out that "well, the file does
> get created" so I probably had that on my mind.

To put a finer point on it, because I can't tell for sure - are
you asking me to take that test out?

Thanks,
-Eric

