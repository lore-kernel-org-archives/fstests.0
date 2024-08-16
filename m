Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1131A01BF
	for <fstests@vger.kernel.org>; Fri, 16 Aug 2024 11:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723808576; cv=none; b=q1u+U50ERGLhHobsBO+4niN7mIb5y0AjFaGQAWvPTdT+2R547lMOpV3WfWVZrFrIojDeteoLpRhJbfRcOl8ZQSQeQW+MBciu5fvzmGlbZCKfA0sdaQ0+kungUJNCoJojUUAmxfPCcFQL5y1eOtuoHQygRMtg+i6wHfkj7FCDj3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723808576; c=relaxed/simple;
	bh=2mVTsqxNSKcFUF22bN7u9NeuSTPq+ny+GLfwgME3W/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIx8FuMcfledXqg1amG9ut0luCmRzoo6Bznzd/1A4FEqoRr8b8Lf+UMCFoFfvZVftiZzZteuUaJtvZXbMFhkTIIeT+a/+KCKIYx3Tin1NZV++VOtO4u5QKeHkMpKsmh2SelFSSdiSgsTG9bmzjMXwicbmcV+3dTgs5J6EGf+FsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h1i2+3NN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1i2+3NN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723808573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=59r0sawk1GsuglTZhsCX1OUeGQomXixjBhl57tHpsFo=;
	b=h1i2+3NNDjGZcFERiAbM4Y6o6ZnV1et5se58Q2VhFzoeg4XahDvrHPd+O1WfIeQIie3RCf
	tIN8ywpRyNOBlaL/9iYQ95EOpw4JXpoujmMfDT9yh0v6Vjurn/wugRDPIAr8adKdoT2DU/
	K7sV8VMWF5oRphedUUII0OedJUTJpSU=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-PbE8rv_lPF2PBhJOQPnkBw-1; Fri, 16 Aug 2024 07:42:50 -0400
X-MC-Unique: PbE8rv_lPF2PBhJOQPnkBw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-70d1df50db2so1442527b3a.0
        for <fstests@vger.kernel.org>; Fri, 16 Aug 2024 04:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723808570; x=1724413370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59r0sawk1GsuglTZhsCX1OUeGQomXixjBhl57tHpsFo=;
        b=GY11PdtDtSt4WdfaUdaiVDfMvzfh5E/YCxtpYRWylWtZQ7CoQHL7tyC7aK0A1YduDo
         laj+R5nf8QFSZk+Wdb6SeaMYwqOwI2eAm9iIovFjoGsogd+Bzi28Xu1AiivMmBzd8Ga6
         urTRZ7oYa91CmPRYPcP2XpjDxfWNGFMXXdmgpV3WaB0YPSFT39zecXRKq7NWt2JFaVEr
         TT3xhR6P3IUCnIoCMEceNo5stV+3/p/2O+qX9V+0pc/B3DNazr0C3xWzqpL3BNkXZFZB
         dDkXp0iJ3m3klCal+KolN5/KlYPz9ozCWNLwh+icDHfyYjvYKYGN+ZKZWBxh9uyHjSET
         u3eg==
X-Forwarded-Encrypted: i=1; AJvYcCXszKKNGUuoZ6urXPGnopwIiVMbz2naQ9MZDtTTnqBqMEmdSuUJVs09hRPM6TTRHBaRxy6DDETpjXxpSASZHb936StGig3aGQ==
X-Gm-Message-State: AOJu0YzB/CYUXXM7eSfkfPS2djwJSTXUiEwoaJYRcGtvgHtbQ6EwSZ+m
	tfIymRJJT13EFRIg6jBAI4yZJLO5vRrwvBAafZJjsMGfzgJxZWT4awqGCC/7/Cop07PduE/xfTM
	BHSK5QBt2Rd6plv1fqOhv24vU04VqxFll+KjLduCvnJyKFH4U66mgGc0=
X-Received: by 2002:a05:6a00:2e29:b0:708:41c4:8849 with SMTP id d2e1a72fcca58-713c666c435mr3505015b3a.9.1723808569393;
        Fri, 16 Aug 2024 04:42:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqMKUdSBtB+QUYrQ4lrRa7GmaVwYM1LO/AF82w524Y9KAd3uWV+nbBAxcFBZDZT/E8WXh3+Q==
X-Received: by 2002:a05:6a00:2e29:b0:708:41c4:8849 with SMTP id d2e1a72fcca58-713c666c435mr3504967b3a.9.1723808568779;
        Fri, 16 Aug 2024 04:42:48 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b6357b67sm2800873a12.72.2024.08.16.04.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 04:42:48 -0700 (PDT)
Date: Fri, 16 Aug 2024 19:42:45 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
	fstests@vger.kernel.org, fdmanana@kernel.org
Subject: Re: [PATCH] btrfs: test send clones extents with unaligned end
 offset ending at i_size
Message-ID: <20240816114245.mgugfp66skww72nu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <177f429d65afb5cc99a7f950779ba15b130cd581.1723470203.git.fdmanana@suse.com>
 <ffe34979-75bf-4cb4-ac66-d21bdc85578c@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffe34979-75bf-4cb4-ac66-d21bdc85578c@oracle.com>

On Fri, Aug 16, 2024 at 06:58:37PM +0800, Anand Jain wrote:
> On 12/8/24 9:51 pm, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > Test that a send operation will issue a clone operation for a shared
> > extent of a file if the extent ends at the i_size of the file and the
> > i_size is not sector size aligned.
> > 
> > This verifies an improvement to the btrfs send feature implemented by
> > the following kernel patch:
> > 
> >    "btrfs: send: allow cloning non-aligned extent if it ends at i_size"
> > 
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> 
> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
> Zorro,
> 
> Could you please add this to the patches in queue? Since this is the only
> patch pending, I will not be sending a PR this week

Sure, thanks Anand :)

> 
> Thx, Anand
> 

