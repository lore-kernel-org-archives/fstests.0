Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A4424466C
	for <fstests@vger.kernel.org>; Fri, 25 Apr 2025 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745581459; cv=none; b=XUNzkrD0RCx8c+f3G18TBxSxZs/ED19PZQqBwOwjsdJfYo+owT6OP7D8Db7r4ror9EdyI6wfOTBzIyIfBIw9ZkPFWtsv38zbWVVOS3bQNU9rfXfByPMccHjj0u6wV6dz/ncfuB20SP5w31A5zZcejFq3fl+RJ81kwgx8442Y9y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745581459; c=relaxed/simple;
	bh=IToxjMZYjvM9lNH3mw7yJTeT6jPRrkYp/rwx6SFhAEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fT55l7JBsSgaIL5WRsXvpAiYZ+0MC6LKogHv64Rnzyiy9zhMfhXOul1U2veCOs0TmOEfsbvI0eDnxOBNjcL83XsPILYFL7n30m5TDix2s7LsZKDPSvLty3+v82IogyWWQVmM0a2EuRzmLovR8lPsn+Ukv3FuG+pR9gr86VCBOT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EeIu7Tfx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EeIu7Tfx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745581455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AdrKxOfuyOBnEuSmdyhh/BphGoP5d55HS+klRx6Y7IU=;
	b=EeIu7Tfx8WbZ8gm/av6Yukur4o3SXlndoIjRrSC7xTs3MEQq7oWP8cx7prfll5tL5l+xRu
	cDDE5oA1+Y9tsuBa5VR7KutKgQHkH65Kv0lO9RqacSuMO9EDXRR/fm1Q41ahQK7d3bCvxJ
	ChrdTJX12WFjX5tcLSlyZY0HcWS9JgQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-j6yLL00xNBGEWkrHXKvCDA-1; Fri, 25 Apr 2025 07:44:12 -0400
X-MC-Unique: j6yLL00xNBGEWkrHXKvCDA-1
X-Mimecast-MFC-AGG-ID: j6yLL00xNBGEWkrHXKvCDA_1745581451
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-30870e7e4fcso1701749a91.0
        for <fstests@vger.kernel.org>; Fri, 25 Apr 2025 04:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745581451; x=1746186251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdrKxOfuyOBnEuSmdyhh/BphGoP5d55HS+klRx6Y7IU=;
        b=srPBNXSRmZxXIkrbjSQnKqdHDLaz6eL96RHAXGyzYtohB4MpUPTqe6OUAKOujoHlMp
         w7Vow4t6IMZeWPOfB2LK3txTRmBjjXccvE5JyxQqWeIoqb+YX7+j0Xa+zQG80LgbOamP
         KoPO5GF8Ez1GMz6nuJkj2nxzwu0ZGk/fpw4og9lF4KNOTPT+T6QZ6/ztQ8zA2Q9T3PhE
         ZCg387L8cIaZGQ1Tcs04e9fxtQ/y4ItWfWDz3jlH5IFRnRUjiJVtc7WoWZ927xDMnOW2
         VESrcrigJmTDTYwlntfKwBgfST11VZyonYkqgiN0Zvl6AXW12gNWHPY/AWMRjrJa1Wu0
         I6AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU34F8JMgXd1or0SnDJutIfIHUiTC81xyjwEH1z2NLRzHPCym3qX9A72kGHKC0yRFs/rwPQivK@vger.kernel.org
X-Gm-Message-State: AOJu0YwrQkBMEnFtMS0eG07lMRzTOHECif3jmljlhPJ1agxQAOMYjyHm
	kdi6iSsZ9FjQ487IQbM2HmkHh0A9a5WuI/juaVAzbfhH00ltoE92I3y7Yf7b2fxIUVgMeOr7Tg7
	NKOZFXB+2AWvyg1a4DsYnRcrA82Q05a5T9TXuXfw6TgfzUiD88a4VhqQ=
X-Gm-Gg: ASbGncsSOku3xohYQg82PSV90UWqaqt5rC4Nnk2RlkuOXB1xkKwoAlUf++hEI7OxD+9
	C8YX8OI4vvu1O8vDpZgCOJeFjEW3LtAzZNy6XFTdZJUAXZglnwujY2kLYOO1/3iEfG3jtL+Gevz
	FsqngW6DHIpBHK1tEtYZLocEr62PJuXdJJxz0FNJHTfmoNr//WGN0tcbvoj/cB7Z3MgMpnVuxMz
	q051ywQ1BorKV7YtRFnNTpf163LwtGzmMbksgjrPbKjgE5+W5k0SFm1H8L1Eb98dWqFrqpGewtW
	RUSPvIzGOxJkdXA6M0H4PfKFrye5iSjJEDS3Ttkfbq2QqhY1+Zvm
X-Received: by 2002:a17:90a:d603:b0:2fb:fe21:4841 with SMTP id 98e67ed59e1d1-309ee37cae3mr9834698a91.8.1745581451305;
        Fri, 25 Apr 2025 04:44:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEyQ03516MLicuEbsvFpC6tMOzPwTVFh2zMJJAA3nJDMBcj7+bnYTxQVxGkWGF1gSpnnClFQ==
X-Received: by 2002:a17:90a:d603:b0:2fb:fe21:4841 with SMTP id 98e67ed59e1d1-309ee37cae3mr9834679a91.8.1745581450840;
        Fri, 25 Apr 2025 04:44:10 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d76db1sm30033755ad.13.2025.04.25.04.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 04:44:10 -0700 (PDT)
Date: Fri, 25 Apr 2025 19:44:06 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH] generic/033: Check that the 'fzero' operations supports
 KEEP_SIZE
Message-ID: <20250425114406.nybdc6witc33kiae@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250424195730.342846-1-anna@kernel.org>
 <20250424213607.GF25667@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424213607.GF25667@frogsfrogsfrogs>

On Thu, Apr 24, 2025 at 02:36:07PM -0700, Darrick J. Wong wrote:
> On Thu, Apr 24, 2025 at 03:57:30PM -0400, Anna Schumaker wrote:
> > From: Anna Schumaker <anna.schumaker@oracle.com>
> > 
> > Otherwise this test will fail on filesystems that implement
> > FALLOC_FL_ZERO_RANGE but not the optional FALLOC_FL_KEEP_SIZE flag.
> > 
> > Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
> > ---
> >  tests/generic/033 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/generic/033 b/tests/generic/033
> > index a9a9ff5a3431..a33f6add67bf 100755
> > --- a/tests/generic/033
> > +++ b/tests/generic/033
> > @@ -20,7 +20,7 @@ _begin_fstest auto quick rw zero
> >  
> >  # Modify as appropriate.
> >  _require_scratch
> > -_require_xfs_io_command "fzero"
> > +_require_xfs_io_command "fzero" "-k"
> 
> I wonder, does this test even need KEEP_SIZE?  It writes 64MB to the
> file, then it fzeros every other 4k up to (64M-4k), then fzeroes
> everything else.  AFAICT the fzero commands never exceed the file
> size...though I could be wrong.

Hmm... I think you're right, the code logic is:

  bytes=$((64 * 1024))
  $XFS_IO_PROG -f -c "pwrite 0 $bytes" $file
  endoff=$((bytes - 4096))
  for i in $(seq 0 8192 $endoff); do
          $XFS_IO_PROG -c "fzero -k $i 4k" $file
  done
  for i in $(seq 4096 8192 $endoff); do
          $XFS_IO_PROG -c "fzero -k $i 4k" $file
  done

So looks like the offset+len isn't greater than the file size. So we
might can remove the "-k" directly. What do you think ?

Thanks,
Zorro

> 
> --D
> 
> >  
> >  _scratch_mkfs >/dev/null 2>&1
> >  _scratch_mount
> > -- 
> > 2.49.0
> > 
> > 
> 

