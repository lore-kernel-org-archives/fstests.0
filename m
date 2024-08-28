Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD391143890
	for <fstests@vger.kernel.org>; Wed, 28 Aug 2024 05:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724821556; cv=none; b=GgD90fpZ2yRIoKWr2i5Aujy51ZtIV8jWdsYqgS8xI423eyHrtu8jQY7kaBWvBLWBu7dMuaWOjITiHoZGVkmMyyHU9FK06k4YvX9mvbmqK2GBY5qNIDr4ytqCtHz9D2IeCivVamWshRJmSHpxbqT+sncyVCne28Ol7+/lCG+2kp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724821556; c=relaxed/simple;
	bh=DFkjIqFzxP25YteHlap/6CaMoSqIWs/AWFsT7GU5gpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9iy4SyagN9Br1DfJSg25Qg0YIKOk1Shvzbfr4mEXKnjX461CaJiEWRA751rqd0NU2PRMup41nvC4aJ6Xer7poGeIBfg9GPmVX/rTXtSx2IjTNuBn/1YNOseaKpw1xdtw5TLrjJI0ml8mLPcKaFcvEIzopjVAPsTIRrOVL6Ty2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V3vsoidX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3vsoidX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724821553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qBQL0BddfH+kZ0cKiipxY4QCt26n2OX/jWUkKukRaTQ=;
	b=V3vsoidX8cRg83fis7ab3K7cwdR4eXVYQ//ssEKduSsgGDz2Z71ezZqxW6wiSa3wflWSCI
	+MuEVDfCDgbbj6xGBmSFKhT/unN7W0f0ectadpAE+fL1v0IuFv+TIhJ1D3RAPMxjLryNB2
	TNpJ5xBRz3iKglPdMk/MaqUU1yKi1r0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-RbYs0CiqOReZdVDxwv64MA-1; Wed, 28 Aug 2024 01:05:51 -0400
X-MC-Unique: RbYs0CiqOReZdVDxwv64MA-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7ad78c1a019so6101423a12.2
        for <fstests@vger.kernel.org>; Tue, 27 Aug 2024 22:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724821551; x=1725426351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBQL0BddfH+kZ0cKiipxY4QCt26n2OX/jWUkKukRaTQ=;
        b=WHHlc2iMBRsb/GKnVT/ps6dVNVSdA0qdary0+83Eco8L41kBmmgvOoodiTQdA1+smj
         8Dh+lHoTuMtkP7ypj8PgN94OdUlteN+IW2mh3V4qyOb16Cdup1zhLhJ9JVUEM2kqZc+e
         ZydXsMsKBDHfXxewUhUd6SYnUx4SPPvnasF0BXgJ2gtTgJ4u6Gcp16682l3EhllsV1yV
         7oKgGq3yWA5zxWgNtTYWEroyocKqOWU9p5anwJQnO2VDtzqKmm2BfsXHiL4vfbWSqIqv
         w9PPMKmkgghrFfQzBtcE7dNiRMPCLsTucSkWJO/ZNCk2OocgzlFvrfxF4HyFoKir3XkO
         wmNw==
X-Forwarded-Encrypted: i=1; AJvYcCW9iTnhQ2J09tiDpTh2T/eKLSLbvIFI7nZOgwzGQZrS+JSWu0q3JC3LLJyHWUXhzCo6KS4c9DVF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7EZYj0fdcRJ8AxS7fkiCNlQztdLIwu//Y20gzWjDwsDR1jGAL
	COZfsCzRBUuWIjb9noUJY0j18bliHMdsGwDGtukrVaJ4QBICdtOPDWbRCLqf4GhlsSo0NZUQCzy
	9bYI5ctPZlhrkonk5JySBhzYwS+jPnQqLYsMtVK+mSW1BX17pk9hPHf0=
X-Received: by 2002:a05:6a20:1721:b0:1cc:d5bd:786b with SMTP id adf61e73a8af0-1ccd5bd7a25mr321727637.29.1724821550752;
        Tue, 27 Aug 2024 22:05:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEFIR/JYUspmbqn+uXgyne5OJuKUo5hCa8srA4oTGGM3OHrxovBgoVaZYvyktiaMavpWw0rA==
X-Received: by 2002:a05:6a20:1721:b0:1cc:d5bd:786b with SMTP id adf61e73a8af0-1ccd5bd7a25mr321712637.29.1724821550130;
        Tue, 27 Aug 2024 22:05:50 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d844624dc7sm542977a91.30.2024.08.27.22.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 22:05:49 -0700 (PDT)
Date: Wed, 28 Aug 2024 13:05:45 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-block <linux-block@vger.kernel.org>, linux-scsi@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	fstests <fstests@vger.kernel.org>, xfs <linux-xfs@vger.kernel.org>
Subject: Re: regression on generic/351 in 6.11-rc5?
Message-ID: <20240828050545.jfpaeu7mqsanozi2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240827020714.GK6047@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827020714.GK6047@frogsfrogsfrogs>

On Mon, Aug 26, 2024 at 07:07:14PM -0700, Darrick J. Wong wrote:
> Hi everyone,
> 
> Has anyone else noticed the following regression in generic/351 between
> 6.11-rc4 and -rc5?

Hi Darrick,

The g/351 isn't in auto (default) group. So I think most of fstests users
don't run it regularly. So I think most of them didn't hit that.
How about add this case and more "fast and stable" cases to auto group?
Include some xfs_scrub and online repair test cases.

Thanks,
Zorro

> 
> --- /tmp/fstests/tests/generic/351.out	2024-02-28 16:20:24.224889046 -0800
> +++ /var/tmp/fstests/generic/351.out.bad	2024-08-26 00:03:35.701439178 -0700
> @@ -25,7 +25,7 @@ b83f9394092e15bdcda585cd8e776dc6  SCSI_D
>  Destroy device
>  Create w/o unmap or writesame and format
>  Zero punch, no fallback available
> -fallocate: Operation not supported
> +fallocate: Remote I/O error
>  Zero range, write fallback
>  Check contents
>  0fc6bc93cd0cd97e3cde5ea39ea1185d  SCSI_DEBUG_DEV
> 
> Just speculating here, but seeing as that test messes with lbpme in
> scsi-debug, that this might be a result of this patch:
> 
> https://lore.kernel.org/all/20240817005325.3319384-1-martin.petersen@oracle.com/
> 
> Will bisect in the morning...
> 
> --D
> 

