Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847372FCFEB
	for <fstests@vger.kernel.org>; Thu, 10 Jul 2025 18:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172019; cv=none; b=XalhVcKLQOfMQu7Ec2SiVF/ibLyLXc2+DPKoMkyVEzlI2191F6g07FaLsNyu5jt4LCib3cSV2yrNChQ4Cnl7jmbXxNV3qIsc9zFpTz5FIZiPfJ34Zq6M4jANWM3VsdODKphdhw44RefEUtVb4gCqmW5fpTpX+f9pO0ikZB8Lnw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172019; c=relaxed/simple;
	bh=iq+ZUqK++wkHXj6FNVn+ASkFWaDZawFdwTiSpzCvAjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I66npC5uUjrHo+gjtngS/OR0/RYgIva1AWakNmTqVw/QSmI8wJaggbQCpzxJSqzJnPViSLeTXMXVWFOupfJ12Wo+2a7fjtIA/+DK0UZPCx2oKMjmwZvJ+S1jQoDhQ2SQKJUrapZOfCKc0ebYSA+iOFXyPAuJbV1NHRpJKbR964A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KLybWWnf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLybWWnf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752172016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J348mQ9Ny7AZVltIJUdzXzLNg32fYYHhBKVgidGAgyE=;
	b=KLybWWnfDmK7t5Sa+R/MxajUyUlkdlMeANuqjjUtbM86PR8Kbc0WJ2LZ5MvSAA/TKSZDbd
	IDe3Wlu9UmaLtVSzI5GVzXHofJzGZX9ydKs3TezhVh6Jfp+dU2+Qm7wdYB2cUY4+KUlw5V
	mMOPSw0mLVzHsqqj57fxf1q7O+aPPLk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-Q6bHkp7cOgev31zQLy6haw-1; Thu, 10 Jul 2025 14:26:55 -0400
X-MC-Unique: Q6bHkp7cOgev31zQLy6haw-1
X-Mimecast-MFC-AGG-ID: Q6bHkp7cOgev31zQLy6haw_1752172014
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b31c38d4063so952636a12.3
        for <fstests@vger.kernel.org>; Thu, 10 Jul 2025 11:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752172014; x=1752776814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J348mQ9Ny7AZVltIJUdzXzLNg32fYYHhBKVgidGAgyE=;
        b=GHPamzj5bQ3YXTCabeeQo1T67IsiLDTVPQ/7HgKYO0qDyq/UzcmVPsten9P3+JAUt5
         qmVlzPKFPwi89TbJx8OPhjoXLrFSXvnqBRW7FdpoGv4dqYZGTzdzUzkl6ftHR+9MBjei
         YvO6ksLpCKGO521gaQHbmE8toen2iGdOw6Oq1kGnvd41ADwvcAUMTs5BhF3egdMf3j8J
         GaqAVFpk25yFPM//X5uZB4mk0QTy5B1STlUgyOFVQw+KZ67OzD9qYLz/wQbfzywkwDMl
         DLBvH6gV+Wo0mvqIxHEJ1/ZUB5xVEPvR2zloyuTVZP50eskksEZsOQW4i/f34Uuk/LIs
         rmKQ==
X-Gm-Message-State: AOJu0YzGwDVTV4/PuUw6rfq3C462a32ZAmLCTDyZTofNHk3ZvDlCLV2E
	GA2ZsLX1YV4STB82xc6zzyNZ140tSl7Bu8M31gaJXw8GjGdxgCvmK/DR0UxfJDyWvwBea0U9+xd
	2aZtN2caOaNwAeyx8rBshetWvwJlhW6LxkqBVlSCSEHjCahk+sVXKTCi+1iEt0fc5RfM=
X-Gm-Gg: ASbGncsR9n5G+hjNVgqk82/EZVsNe2l4ihl08BLrOdXqeq3XR9GPVJq28NB5O5PaCtc
	cHVmgM0Nl7KUR9gUbvvEvh1O40PN2Wso+yqH/B5qANHQClHqf2RFBu1UvQLhupfxwc5d8/2INJP
	mLuyon1wZCcsV94S8cR2r8qs+7s0LzdBZrrhBWyp+QFfDfC5OONUbQQ806rh2bl0QMwfgjWEyQn
	2ljMKgxXps26Gi45O+GoxtzwbTQSI/DscNUqBCSuxZGn6L5cHCorvZ8dYMPmDi6cFXZ/CrrKPb1
	9TXcmwqxFWhVMgZgMHM1vdD5ZFPuC0PqOCIl+i7nBMlDrtPbGchK8U90m3kes2I=
X-Received: by 2002:a17:90b:578f:b0:312:e731:5a6b with SMTP id 98e67ed59e1d1-31c4cd1933cmr598369a91.32.1752172013887;
        Thu, 10 Jul 2025 11:26:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaIbeIJkuybssjHpWeq+WMbUDmu4Y39zxjUXpLpZVMv05lVhzb/KVS9iaIa8uH1KUZlJFZnQ==
X-Received: by 2002:a17:90b:578f:b0:312:e731:5a6b with SMTP id 98e67ed59e1d1-31c4cd1933cmr598344a91.32.1752172013547;
        Thu, 10 Jul 2025 11:26:53 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3003faa6sm6109257a91.4.2025.07.10.11.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 11:26:53 -0700 (PDT)
Date: Fri, 11 Jul 2025 02:26:49 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCHSET 1/2] fstests: check new 6.15 behaviors
Message-ID: <20250710182649.qcj66vrx3njvkyw6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <174786719374.1398726.14706438540221180099.stgit@frogsfrogsfrogs>
 <20250710161610.GC2672039@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710161610.GC2672039@frogsfrogsfrogs>

On Thu, Jul 10, 2025 at 09:16:10AM -0700, Darrick J. Wong wrote:
> On Wed, May 21, 2025 at 03:40:53PM -0700, Darrick J. Wong wrote:
> > Hi all,
> > 
> > Adjust fstests to check for new behaviors introduced in 6.15.
> > 
> > If you're going to start using this code, I strongly recommend pulling
> > from my git trees, which are linked below.
> > 
> > With a bit of luck, this should all go splendidly.
> > Comments and questions are, as always, welcome.
> 
> Hrm, can we get the first two patches into for-next, please?
> 
> I'll work on the last two and repost when they're ready.

Sure Darrick :)

> 
> --D
> 
> > --D
> > 
> > fstests git tree:
> > https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=linux-6.15-sync
> > ---
> > Commits in this patchset:
> >  * xfs/273: fix test for internal zoned filesystems
> >  * xfs/259: drop the 512-byte fsblock logic from this test
> >  * xfs/259: try to force loop device block size
> >  * xfs/432: fix metadump loop device blocksize problems
> > ---
> >  common/metadump   |   12 ++++++++++--
> >  common/rc         |   29 +++++++++++++++++++++++++++++
> >  tests/generic/563 |    1 +
> >  tests/xfs/078     |    2 ++
> >  tests/xfs/259     |   25 +++++++++----------------
> >  tests/xfs/259.out |    7 -------
> >  tests/xfs/273     |    5 +++++
> >  tests/xfs/613     |    1 +
> >  8 files changed, 57 insertions(+), 25 deletions(-)
> > 
> > 
> 

