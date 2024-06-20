Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A172324B26
	for <fstests@vger.kernel.org>; Thu, 20 Jun 2024 19:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718910400; cv=none; b=QW4AW/ZsrI7MzeY7X+pwNs2dWTxWZRlQT+vlrwF0gw5tohOm+Jpqyttr+2deIS34lmNi7N6lQx9OZ5JAD/J+Lmd0OVrGSKL0dypJgxTKguP4xXa4Kz6X0ckuBfL3UUdpvjO+GHG5a0JTImv+b/L8SZyJb8+uenbgSUHF5tV1l9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718910400; c=relaxed/simple;
	bh=W2BNX/QqXofExpQf+EsIDOK5Tj4Rze/IXZZdtQxIkwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDMmEf0s4ozNXkpzdn1TvgAYA7FV8YTV1WDSjpQijApStfBh+yEyuKGFJcixxFgX17EVKfJSSo8C5dOh3o2RHLTCTH6PzlFpy3arLYpBzebrzWIbO2vEgfEMSZOk5GFpbbwcTHN1CEiLugLJnPrEi77oyO5CxULioh6jrg0sJr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PbP6TVO0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PbP6TVO0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718910396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SyD90obcJxtERC+T2A8QHf8d04Li934BZAFpY2pAcoQ=;
	b=PbP6TVO0PDvddfWYpk5lNg//GBcVBYZ6EU87gwXECUy1rWK3hPnVOypYU6sTfDvVD8wNUA
	mzpNCg9AZAOFK2hjj2s/MSjXhKPDOqtTxGL3hHJW70cXInjEkzTNUDsxphLUsnwK0jxM1y
	Tcp8G1tCbow7cVKB0kpYXGrnijNEiE8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-luVhtjYrMpu19m0GIsL6ug-1; Thu, 20 Jun 2024 15:06:34 -0400
X-MC-Unique: luVhtjYrMpu19m0GIsL6ug-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-715e59afb63so288876a12.2
        for <fstests@vger.kernel.org>; Thu, 20 Jun 2024 12:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718910393; x=1719515193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyD90obcJxtERC+T2A8QHf8d04Li934BZAFpY2pAcoQ=;
        b=UdcBAUHeRWXa6ZZwNtD+VCMdXNEp+ruWAkoRcrr8Fh9UpM/YxqQRcaEw/Sa+RAPXAV
         IrnMoIFWtDo8QZJShABwNSaqWuKmmzQShccFuhJutu/obcfZoFnh1G8x4h2vHIjbS8fA
         em7ElqVSkbF6EiOZNyPQFxpZDZV0AgMHFyuHt4LYG4suwzGHcW0JCeJknv5TJMlmuHuY
         Ufon1DEojtg6Wt0+HTc5OmK2X/2lw0gxxsQKq6EKOH9WpNAwQpIvx5BFWOVMFYeMpDMm
         hnJADtihzokQT0kgeXORewcpiT1n/xoFPVtGn9f47IAbKcVRJ2ZRXuHsfKRruHfc4t9S
         0r7g==
X-Forwarded-Encrypted: i=1; AJvYcCW1bll2Cjq3LKcf4Wmbn+vdX+AGZuS/hIs1/svJyk08X4rQFGV6FC/iFCJTvFQ34CrHn45nvSqPgDxwBsikYKxyzSLqR8B17A==
X-Gm-Message-State: AOJu0YyHJmeImdG0E5Mt+0ZPSY+pRRNOVyr9OScNR3rGiA1KisEbQXwf
	KdqO3nkM4VKuGp1KeJBwxld6Hz9bpUeLS1Y41DCecLsjJFHb5TxQ1i6oRf9WVu/kvICGfE3cocN
	bcDKIbe1wxre3b7wJl9XvmJa1c70YvvqU9ddICPY55B95/cn8zY5aHQs=
X-Received: by 2002:a05:6a20:491e:b0:1b4:772d:2885 with SMTP id adf61e73a8af0-1bcbb45643emr6236915637.3.1718910392909;
        Thu, 20 Jun 2024 12:06:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHFpIBjqoWni1c+H+7iH37bv/hAfCDh8m81xZBwdNAhmlCvGUP4NEddogAqNm+f1Sj2sqEDQ==
X-Received: by 2002:a05:6a20:491e:b0:1b4:772d:2885 with SMTP id adf61e73a8af0-1bcbb45643emr6236875637.3.1718910392390;
        Thu, 20 Jun 2024 12:06:32 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-70ee5be7e00sm4277120a12.25.2024.06.20.12.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 12:06:32 -0700 (PDT)
Date: Fri, 21 Jun 2024 03:06:28 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 03/10] generic/710: repurpose this for exchangerange vs.
 quota testing
Message-ID: <20240620190628.onmsffjtscuoa2ca@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <171867145284.793463.16426642605476089750.stgit@frogsfrogsfrogs>
 <171867145344.793463.2045134533110555641.stgit@frogsfrogsfrogs>
 <ZnJ15ZG1nWsCkxiG@infradead.org>
 <20240619172318.GR103034@frogsfrogsfrogs>
 <20240620165526.GW103034@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620165526.GW103034@frogsfrogsfrogs>

On Thu, Jun 20, 2024 at 09:55:26AM -0700, Darrick J. Wong wrote:
> On Wed, Jun 19, 2024 at 10:23:18AM -0700, Darrick J. Wong wrote:
> > On Tue, Jun 18, 2024 at 11:08:37PM -0700, Christoph Hellwig wrote:
> > > On Mon, Jun 17, 2024 at 05:47:32PM -0700, Darrick J. Wong wrote:
> > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > 
> > > > The exchange-range implementation is now completely separate from the
> > > > old swapext ioctl.  We're deprecating the old swapext ioctl, so let's
> > > > move this test to use exchangerange.
> > > 
> > > Do we really want to lost the swapext test coverage?  Even if it is
> > > deprecated, it will be with us for a long time.  My vote for copy and
> > > pasting this into a new test for exchrange.
> > 
> > Yeah, you're right that we should retain this test for the old swapext
> > ioctl.  I'll fork the test into two -- one for swapext, another for
> > exchangerange.
> 
> ...except that the swapext ioctl doesn't support swapping forks if quota
> is enabled and any of the user/group/project ids are different:
> 
> 
> 	/* User/group/project quota ids must match if quotas are enforced. */
> 	if (XFS_IS_QUOTA_ON(ip->i_mount) &&
> 	    (!uid_eq(VFS_I(ip)->i_uid, VFS_I(tip)->i_uid) ||
> 	     !gid_eq(VFS_I(ip)->i_gid, VFS_I(tip)->i_gid) ||
> 	     ip->i_projid != tip->i_projid))
> 		return -EINVAL;
> 
> I'll amend the commit message:
> 
> "There's no point in maintaining this test for the legacy swapext code
> because it returns EINVAL if any quota is enabled and the two files have
> different user/group/project ids.  Originally I had forward ported the
> old swapext ioctl to use commitrange as its backend, but that will be
> dropped in favor of porting xfs_fsr to use commitrange directly."

Hi Darrick,

I can help to change the patch [4/10] and [10/10] if you need. But for this
one, will you re-send this patch or the whole patchset?

Thanks,
Zorro

> 
> --D
> 

