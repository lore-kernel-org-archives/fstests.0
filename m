Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3AC19F101
	for <fstests@vger.kernel.org>; Tue, 21 Jan 2025 05:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737436380; cv=none; b=dBVqJ+3c3ITpUTSDKLLP+AUjZzNRAqnHB7zWzmMjIgDdjMiKryRHgyzsonT3QhrKB6KLHQ1Fnt4WD0THdP6VWthhT5CPwVHOlmkypypvQquWZpwqfiO9j80BD4F+reGykMqRMDw9FZkIht51FiA7nFaArsKcGsvc2gzM2/gEw4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737436380; c=relaxed/simple;
	bh=R0dA0srL09CrO9+h7zLMCbftthXyhqaZa5oPNdUustI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4zXuDDjPPjlObT52jIIqVLNQjFG6mYMM6R9v8NZQD8N/3yFlQp6/63eDjnT0xfbMYJrYD3K64qefrVu2ZQ/EZJ8Zii+/OvcZCuQ6tv3i3XST1voZph3LoJ9ibzT5g+jBi1/knsCPd2OT2UP3+/XawowVM1B5gQDtqvuTGBMBRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SU0AeJqB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SU0AeJqB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737436378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=64PEcDr7tKSMbboC7W53OKVzaqIM/sWA6jUpK9q1TrM=;
	b=SU0AeJqBfTDf2eNIBaJNN8bigUPt0YTK5VPueSGasvEYMaPV7m7d9G9aY+dn6vatGHDEg+
	xXj0XQQDHIXX3klA/NUPxLlU+g3/wCYRdG5bsQTTijHLuIdNr4aYaesnZU4ceNgkarDMj+
	PqmkQ+x6KAkJHo7D8sU9rbvq7kXX/EU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-uO3t2ZnKNyyg9B3iu_JqwQ-1; Tue, 21 Jan 2025 00:12:56 -0500
X-MC-Unique: uO3t2ZnKNyyg9B3iu_JqwQ-1
X-Mimecast-MFC-AGG-ID: uO3t2ZnKNyyg9B3iu_JqwQ
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-216430a88b0so102596065ad.0
        for <fstests@vger.kernel.org>; Mon, 20 Jan 2025 21:12:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737436375; x=1738041175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64PEcDr7tKSMbboC7W53OKVzaqIM/sWA6jUpK9q1TrM=;
        b=J8gO/nPyHZUcer201qk8UYrcu2KCrzvCtNflhVxlyvi4H882KifCMBZvP+/wabhhPY
         97aE8s0/oA2FkHWI1TevFi/rQgISbjwA3wUI9s1cpKtnZYTqogUADvjquAtWio0V7kAb
         t6o5UAy9dLjt23ovhazGkv1gVR3eronJ644oPuq1LGtNUNiwm2X7Xjx8k3ZfeqT0rFnb
         aW+MFjfoFRmwbz4M5V1uR272T4no2RfiC5wAY2of80OF2ysoGqJlKTqIN5V2zd2tL2UE
         roi12gnDyzMHXMVaNKVl/Uf7AoaMxLTIkrk66bfrJ9Ti1kn//NlaQfnZrEE0rb+18RKd
         fBgA==
X-Gm-Message-State: AOJu0Yx/Z5gtdP2xcX87EuXXM2lZZXItWNX5tvzJjzn5bFGpitw6XpO4
	HfpeGtT6EF3zDP6Sh/q7034Q6Sr91Xlb6vaydxJNtUh2HF/IewpKfgsnE3qCvxRs1U+9xWPJlXK
	0g7CLwbAQ2uGplJcWYzTHHJOS/JQCQbXQEBdPAUoA4VtalU6rTEKo9JWMEEosyQC5PA==
X-Gm-Gg: ASbGnctznm+ctxlp7KKAxDH7at3CXYZ3OVlcFCHWGkwAkaGA2kAL04ITMZE2fkiz3H6
	XA3iiiU/ZF1LDywAIy/xUoPjE0/rwjlVwKJwg7ackTHVkLgUUwFD+79o6qqt9gsigCQKxKhw7E4
	DrHZZS793No81PCBh9YiHnLiM9UG0/ONznORYHOU1aopGgeOd0v7zM8dzEJRxC8kBz/amUCGZ4T
	7wdo8IUzdmPzZxPU5Ao9e3byAYezok2ix8i2oRao+RK3HFYwzDTBbnnpA9F/eJkWBmb7OagZzT7
	PimhIdpeWzv/O3Z/prES4VFVod9BHg0wpxg=
X-Received: by 2002:a17:902:cece:b0:215:a3e4:d251 with SMTP id d9443c01a7336-21c351bd44bmr221086955ad.6.1737436374845;
        Mon, 20 Jan 2025 21:12:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAGG25MP4JrvQPA/qjeCokfCjfq8kjkVk8934TSNMmQMtS/VD7Fw+eEWQb3dYZUMV+4qqhDw==
X-Received: by 2002:a17:902:cece:b0:215:a3e4:d251 with SMTP id d9443c01a7336-21c351bd44bmr221086705ad.6.1737436374499;
        Mon, 20 Jan 2025 21:12:54 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3acf50sm68981945ad.143.2025.01.20.21.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 21:12:54 -0800 (PST)
Date: Tue, 21 Jan 2025 13:12:51 +0800
From: Zorro Lang <zlang@redhat.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH -v2] xfs/32: fix test failure on kernels which don't
 support bs > ps
Message-ID: <20250121051251.ab4bl5xeet4bxa5s@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250117210202.GJ3557695@frogsfrogsfrogs>
 <20250120170109.3770633-1-tytso@mit.edu>
 <20250121023536.dz45c3ustuk3fddu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250121033356.GB3761769@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121033356.GB3761769@mit.edu>

On Mon, Jan 20, 2025 at 10:33:56PM -0500, Theodore Ts'o wrote:
> On Tue, Jan 21, 2025 at 10:35:36AM +0800, Zorro Lang wrote:
> > On Mon, Jan 20, 2025 at 12:01:09PM -0500, Theodore Ts'o wrote:
> > > When trying to mount a file system with a block size > page size on
> > > kernel which doesn't support this, suppress the error messages from
> > > showing up in the output file lest it cause test failures.
> > > 
> > > Fixes: 0b66f6efd669 ("xfs/032: try running on blocksize > pagesize filesystems")
> > > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > > ---
> > > v2:
> > >     As Darrick suggested redirect the output of mount(8) to $seqres.full
> > >     instead of /dev/null
> > 
> > Thanks for fixing it.
> > 
> > Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
> I just noticed just now that I screwed up the subject line / commit description.
> 
> xfs/32: ...
> 
> should be:
> 
> xfs/032: ...
> 
> Sorry for not noticing this earlier!

Never mind, I've changed that when I merge it :)

> 
> 					- Ted
> 

