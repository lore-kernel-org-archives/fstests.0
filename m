Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E66198A1B
	for <fstests@vger.kernel.org>; Fri, 11 Oct 2024 06:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728628150; cv=none; b=UBjn5dNb7ZelDjjhioR5RpGe3HcgETq0Y/OybMgbZ+zaDcaE++7gqAOl1RxCzg+IbMLLtKu9KAD4RSXpp5ptbImH8Brik6BGeM2bmKP/4L9/pxaj3/6dbowCC9VvSb0bSm4EWnKtvNGIe2/Qqk/7sKkXXcwT07MWkiu2dhTstgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728628150; c=relaxed/simple;
	bh=S1uYo3WnGJi+Jm48AgUOswFGK5Q+oevpIGDBNBT2njk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYSx95rjsBobkOzoemNUzbICGk1dw+b944Q5wNlb94PXYZ98TdPoVZjuHNJSCU8xCtpjcgVd4eEbgd8drTgeBLvIHY6HiGTsIBn3avJcNAHlyo6L8NaXysEmX/wQCNwYZ5dc8e4gMnBFXzv7hYhpkfG9zZbLSnz9mlvAoKvfUT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hiSPeKPF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hiSPeKPF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728628147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tAX77JpkXj1IgOtJYAmPdVmTE+e6K2CbINuswBO6u2A=;
	b=hiSPeKPF4SX7rl5irYv7azPfpwUCyPnLqeDgCreTd3NtPz0atOAHPZuUP722qoB9t5bU9o
	M8GvYSbKxnJLq35AHe5sDTltCyhhMz5wjl3m3+EdNAYWZ/0zkF/ndpmEksnItNax8xJPjk
	VuuD2Rd7DSnEKVLZ2RIQqZkvhkfYPpw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-5xyR4bIzNxSwPca2Sz2HRA-1; Fri, 11 Oct 2024 02:29:05 -0400
X-MC-Unique: 5xyR4bIzNxSwPca2Sz2HRA-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-20c9673e8cdso9574445ad.3
        for <fstests@vger.kernel.org>; Thu, 10 Oct 2024 23:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728628144; x=1729232944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAX77JpkXj1IgOtJYAmPdVmTE+e6K2CbINuswBO6u2A=;
        b=nER/vU9ng0L4NOr8VjFyAS8dtHPUQkMLRej0jHgffa1LRnQG30mFCfnPgxvhD8uTSi
         zfnCoXt5zruL7rjgd0DLNTunLqPwUHiw6pmrIpqGRYB3om9Gt7YtmC3si5CTQ5H5VBna
         gwzO3i8nVl3cdgPJsyEhL5UgNQizErC9w8E6yVPmCXdqGaA7uhAFMRyhHRfWStBIHrQO
         4x7LOSfw5ZNAthRuGzXZJlSwtk1ib8Fa8IJMn4K/h2u6naTVi1C1n8S+HrcM4OOc+1Dz
         o8QR1L+M1yHda22uPTOlFp7qiBiJkR+t79/qw9+fYHgImi9hFMlqud0ZgXZ8c/8Bn8L+
         ixZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeBAjJDTkjdCBZ4oZVZZa5zfanADTI6OJIjLrBBo4ACVDHOkZvxSsfYkWgpozKqDdvCVE7Wz5E@vger.kernel.org
X-Gm-Message-State: AOJu0YyeLi7mi1uS16V0n9jVUCYH08CcnCc2ofayD8KPfMkyzIoDiQC6
	rodTusF4NNvqZ+lb0dzOCFZc10dJ/3oORHcUzSpb3nW3FBPuSulolCylFMV4rfmpWIzbv8QdVt3
	tD5ewgJgkfzAsE5o6W6KIGtAcUP77HChq+/VRKF/iw+aV1ZU7k3NqEuk=
X-Received: by 2002:a17:902:e5ca:b0:20b:bad4:5b6e with SMTP id d9443c01a7336-20ca16c34c3mr27422395ad.38.1728628144354;
        Thu, 10 Oct 2024 23:29:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJNnNXr7UM6hcRJCznLeV7hNtS79wfhSBqPzU6T1ga/7uC5Y2WiZKiDGCciCyZiVqLRbtqrA==
X-Received: by 2002:a17:902:e5ca:b0:20b:bad4:5b6e with SMTP id d9443c01a7336-20ca16c34c3mr27422135ad.38.1728628143999;
        Thu, 10 Oct 2024 23:29:03 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c311f3dsm18119745ad.234.2024.10.10.23.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 23:29:03 -0700 (PDT)
Date: Fri, 11 Oct 2024 14:28:58 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/2] xfs/122: add tests for commitrange structures
Message-ID: <20241011062858.p5tewpiewwgzpzbo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <172780126017.3586479.18209378224774919872.stgit@frogsfrogsfrogs>
 <172780126049.3586479.7813790327650448381.stgit@frogsfrogsfrogs>
 <ZvzeDhbIUPEHCP2D@infradead.org>
 <20241002224700.GG21853@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002224700.GG21853@frogsfrogsfrogs>

On Wed, Oct 02, 2024 at 03:47:00PM -0700, Darrick J. Wong wrote:
> On Tue, Oct 01, 2024 at 10:45:50PM -0700, Christoph Hellwig wrote:
> > On Tue, Oct 01, 2024 at 09:49:27AM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > Update this test to check the ioctl structure for XFS_IOC_COMMIT_RANGE.
> > 
> > Meh.  Can we please not add more to xfs/122, as that's alway just
> > a pain?  We can just static_assert the size in xfsprogs (or the
> > xfstests code using it) instead of this mess.
> 
> Oh right, we had a plan to autotranslate the xfs/122 stuff to
> xfs_ondisk.h didn't we... I'll put that back on my list.

Hi Darrick,

Do you want to have this patch at first, or just wait for your
next version which does the "autotranslate"?

Thanks,
Zorro

> 
> --D
> 

