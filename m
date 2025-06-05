Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4392815383A
	for <fstests@vger.kernel.org>; Thu,  5 Jun 2025 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749134145; cv=none; b=YlQd2Sp9i/pkuPDfCUQN2k6GKupW7bMNnZgWxEsEoakfKD+7UK6LasKHxT2L+fIMuqWFY0KDwZL9hhUShg1cYCjbW6iH5NsUOlqRMMd4YS9010HNiL/GJNazDHNkSBHYVWJvhiyQ1cAqE3f8H23CwVMMYhKfTo8iJosipRqY9u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749134145; c=relaxed/simple;
	bh=gLB2AJHOZ7gvxFO7e6RniXXgLI73qTcYmSg33p7Z4nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oooUrW48ZSUsv820XBE382mhOrFVj0UHwOGPetUd6f1/YktYPs0ptzHGtHqlN/luESrrksdWfZilQhSr/N5iecD9/iLWQqnDTmVMMlAL/wGxDIWr7llL4/8EXGPTXH/pC+OyIZV0YFLnYb1k5IusimcO0jolGnSTgtbPHRlNh4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KhdkEMK4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhdkEMK4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749134142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rz8/nytfLbOmrVfGKeIIHr/hpp6ULjo3E1Xcklp2S60=;
	b=KhdkEMK45Mlf2kyUptYrYKDH5kjBoS9uJfqpaUFYaw5teHpzeNTKtpmtuMiStQ/y0+8Ph/
	xqqd99YPDGKNXwQ+dS8lh2WL++aRVkA2UhQyqlDVlSfSiec+Y5e3BFj4ovFLu3qi0w/bzj
	w4GhICgsBRRAcceWMZnuuixOGvaDpMI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-VufbL6KmMx2EqApe3IySwQ-1; Thu, 05 Jun 2025 10:35:40 -0400
X-MC-Unique: VufbL6KmMx2EqApe3IySwQ-1
X-Mimecast-MFC-AGG-ID: VufbL6KmMx2EqApe3IySwQ_1749134138
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2354ba59eb6so15378495ad.1
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 07:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749134138; x=1749738938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rz8/nytfLbOmrVfGKeIIHr/hpp6ULjo3E1Xcklp2S60=;
        b=GoUGmyBuFa6AnlMI3H/fkLCIG53s1JIxqnwSitXBf2ACc8Jt5HyxE1z28o3elqTuPz
         iIe8OGMXLWGeifX4MNZzzu1EmfwyLGD2I9Bpy3QPHIJzW+mNaGHtatmKyVirGs0NngRf
         FmRu1cDMzr/HvhiOf1keJNh2c3Lnryxoh3BEFF9hhtwI683H9pT3CH0CpBoIbHpUftDF
         gbSVZlJSxWD9hTl0e5OYqkvbET8Eno6+KkdrOm8BEYULYsXbpGYtKI6XBsE5Hq96yRR7
         eVH5eNpFkET5DTPb362FaRWVYZyvnVUifYsHWhr8B2jdPICeOuMW3uT+PMNDqeK8HLrF
         oEvg==
X-Forwarded-Encrypted: i=1; AJvYcCUNjNLNwrT05lqqneOuk8PZs1yYjsGyXOHwuoS+3sSWzo4qh4/xroVP5Xbnya3kVaQjoXRs8pzi@vger.kernel.org
X-Gm-Message-State: AOJu0YwLngxvJduRm3sPHB3234KE/SPV6eKGjBFbdrK/awXg/ZBPYEVW
	qIba2kqkvb9LbiCPvnRzb/7rR+ckZW2xGHvGLar+cyJdR7OLtnYg1OQ5dURczIs+OPDG6aQsPtD
	omQ0PcD7O9sRwpkNUvUfA9e97h43ukiZ5tEORt26F2OSv4sbQPtBi9x5zkKG45cQOhss=
X-Gm-Gg: ASbGncui32Jo+WP/P4ddlOAFJ26V3balRHr1AAxuef+61UWx0RYYF8XjGrvmHZ0EQC9
	OqKC+Eq21q99/Q/eqTUAA5Hm+E8AW/nQgffUu8Sch0Yla8Gp3WqsyYo6C0rIxn3oo3cwiSaUVJV
	Okkhqyy60B954MwPGcuMqd5froAajEu4CKb57fmcXDJTF7nmH/T86iI/W1YmeQLYqXN7KvvJ/ps
	SaH+5txdCU6g7aN1Kp9O+/GpXWZBVbHJPXHR+ZxAdgH7h7UQqd1nvMiTkkhJZd5zqfXAq9Urr5u
	9k184gRyRIUuHHl+B2h9v2I0JJTemiaMNVscuKBBapalsXYzHS05
X-Received: by 2002:a17:903:278d:b0:235:ea29:28e4 with SMTP id d9443c01a7336-235ea292993mr51513885ad.31.1749134137587;
        Thu, 05 Jun 2025 07:35:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE484hqi94R5FRVog2r61ayntclZgWs8s5bhRjUw/9R4e2JvbF0l+osC95hT+674hMyxwG+6A==
X-Received: by 2002:a17:903:278d:b0:235:ea29:28e4 with SMTP id d9443c01a7336-235ea292993mr51513535ad.31.1749134137134;
        Thu, 05 Jun 2025 07:35:37 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc8612sm120309595ad.28.2025.06.05.07.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 07:35:36 -0700 (PDT)
Date: Thu, 5 Jun 2025 22:35:32 +0800
From: Zorro Lang <zlang@redhat.com>
To: Yuezhang Mo <Yuezhang.Mo@sony.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, friendy.su@sony.com
Subject: Re: [PATCH v1 6/7] generic/645: add _require_chown
Message-ID: <20250605143532.sbr67s7jb2oc3ob7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
 <20250528091530.1218188-7-Yuezhang.Mo@sony.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528091530.1218188-7-Yuezhang.Mo@sony.com>

On Wed, May 28, 2025 at 05:15:29PM +0800, Yuezhang Mo wrote:
> This test uses chown to set GID and UID, which requires chown
> support, so add _require_chown to check for chown support.
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Friendy Su <friendy.su@sony.com>
> ---
>  tests/generic/645 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/645 b/tests/generic/645
> index 068a46a9..d6eb75e6 100755
> --- a/tests/generic/645
> +++ b/tests/generic/645
> @@ -15,6 +15,7 @@ _begin_fstest auto quick idmapped mount
>  
>  _require_idmapped_mounts
>  _require_test
> +_require_chown

Yeah, I think this makes sense to me, due to I always hit the error as:
  +idmapped-mounts.c: 6599: nested_userns - Operation not permitted - failure: fchownat dir1/file1_1
  +vfstest.c: 2418: run_test - Operation not permitted - failure: test that nested user namespaces behave correctly when attached to idmapped mounts

when tests on exfat.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  _wants_kernel_commit dacfd001eaf2 \
>  	"fs/mnt_idmapping.c: Return -EINVAL when no map is written"
>  
> -- 
> 2.25.1
> 
> 

